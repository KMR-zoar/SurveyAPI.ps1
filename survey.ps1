<#
   PowerShell で測量計算 API の一部を利用するためのスクリプトです。
   API サーバを利用するためにインターネットへの接続が必要です。

   Copyright(C) 2015 KMR-Zoar

   以下の条件を満たす限り、自由な複製・配布・修正を無制限に許可する
・測量計算API利用規約( http://vldb.gsi.go.jp/sokuchi/surveycalc/agreement.html )に同意すること
・上記の著作権表示と本許諾書を、ソフトウェアの複製または重要な部分に記載すること
・本ソフトウェアは無保証であり。自己責任で使用すること
#>

function bl2xy{
   $lan = $ARGS[0]
   $lot = $ARGS[1]
   $zone = $ARGS[2]

   $url = "http://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/bl2xy.pl?outputType=json&refFrame=2&zone=$zone&latitude=$lan&longitude=$lot"

   $json = Invoke-WebRequest $url | select -ExpandProperty Content

   $err = ($json | ConvertFrom-Json).ExoprtData.ErrMsg

   if ( $err -eq $null ) {
      $json = ($json | ConvertFrom-Json).OutputData
      Write-Output $json
   } else {
      Write-Output @{publicX = $err; publicY = $err; gridConv = $err; scaleFactor = $err}
   }
}

function xy2bl{
   $CoordinateX = $ARGS[0]
   $CoordinateY = $ARGS[1]
   $zone = $ARGS[2]

   $url = "http://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/xy2bl.pl?outputType=json&refFrame=2&zone=$zone&publicX=$CoordinateX&publicY=$CoordinateY"

   $json = Invoke-WebRequest $url | select -ExpandProperty Content

   $err = ($json | ConvertFrom-Json).ExportData.ErrMsg

   if ( $err -eq $null ) {
      $json = ($json | ConvertFrom-Json).OutputData
      Write-Output $json
   } else {
      Write-Output @{latitude = $err; longitude = $err; gridConv = $err; scaleFactor = $err}
   }
}