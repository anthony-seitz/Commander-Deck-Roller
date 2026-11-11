# Minimal static file server for local preview: powershell -File serve.ps1
$port = 8765
$root = $PSScriptRoot
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving $root at http://localhost:$port/"
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $path = $ctx.Request.Url.AbsolutePath.TrimStart('/')
  if ($path -eq '') { $path = 'index.html' }
  $file = Join-Path $root $path
  if (Test-Path $file -PathType Leaf) {
    $bytes = [System.IO.File]::ReadAllBytes($file)
    switch -Wildcard ($file) {
      '*.html' { $ctx.Response.ContentType = 'text/html; charset=utf-8' }
      '*.css'  { $ctx.Response.ContentType = 'text/css; charset=utf-8' }
      '*.txt'  { $ctx.Response.ContentType = 'text/plain; charset=utf-8' }
    }
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else { $ctx.Response.StatusCode = 404 }
  $ctx.Response.Close()
}
