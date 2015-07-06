<#
    .SYNOPSIS 
      Transforms a Slic3r conig.ini file into a CSV file of your naming

    .EXAMPLE
     Add-Slic3rSetting -InputConfigFile "C:\config.ini" -OutputCSVFile "c:\Settings.csv"

    .DESCRIPTION
    If the OutputCSVFile does not exist, one will be created.  Otherwise a new data row will be added to the file.


  #>
Function Add-Slic3rSetting
(
    [string]$InputConfigFile = "C:\Users\Tim\OneDrive\3D Print Models\Test Patterns\config.ini",
    [string]$OutputCSVFile = "c:\temp\Settings.csv"
)




{
    $file = Get-Content $inputConfigFile 
    [System.Collections.ArrayList]$ReportInfo = New-Object System.Collections.ArrayList($null)




    write-host $file.count total lines read from file
    $setting = New-Object System.Object;
    $index=0;
    foreach ($line in $file)
    {

        if($index -eq 0){
            $setting | Add-Member -MemberType NoteProperty -Name 'Header Info' -Value $line;

        }else{
            $nameVal = $line.Split("=".ToCharArray());
            Write-Host "Reading: " $nameVal[0].Trim() "," $nameVal[1].Trim()
            $setting | Add-Member -MemberType NoteProperty -Name $nameVal[0] -Value $nameVal[1];
        }
   
       $index+=1;
   



    }
     $ReportInfo.Add($setting)  | Out-Null;

    Write-Host "Exporting CSV to :" outputCSVFile;
    $ReportInfo | Export-Csv  $outputCSVFile -NoTypeInformation -Encoding UTF8 -Delimiter ',' -Append -Force;

}