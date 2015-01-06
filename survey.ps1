<#
   PowerShell �ő��ʌv�Z API �̈ꕔ�𗘗p���邽�߂̃X�N���v�g�ł��B
   API �T�[�o�𗘗p���邽�߂ɃC���^�[�l�b�g�ւ̐ڑ����K�v�ł��B

   Copyright(C) 2015 KMR-Zoar

   �ȉ��̏����𖞂�������A���R�ȕ����E�z�z�E�C���𖳐����ɋ�����
�E���ʌv�ZAPI���p�K��( http://vldb.gsi.go.jp/sokuchi/surveycalc/agreement.html )�ɓ��ӂ��邱��
�E��L�̒��쌠�\���Ɩ{���������A�\�t�g�E�F�A�̕����܂��͏d�v�ȕ����ɋL�ڂ��邱��
�E�{�\�t�g�E�F�A�͖��ۏ؂ł���B���ȐӔC�Ŏg�p���邱��
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