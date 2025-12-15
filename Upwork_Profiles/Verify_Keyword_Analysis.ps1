# Upwork Profile Keyword Verification Script
# This script provides OBJECTIVE, VERIFIABLE metrics

$profiles = @(
    @{Path = "Upwork_Profiles\upwork prfile 01 All work\02_Profile_Enhanced_NEW.txt"; Name = "Profile 01 (.NET Focused)"},
    @{Path = "Upwork_Profiles\upwork prfile 02 Full Stack Developer\02_Profile_Enhanced_NEW.txt"; Name = "Profile 02 (React+Node)"},
    @{Path = "Upwork_Profiles\upwork prfile 03 AI Engineer\02_Profile_Enhanced_NEW.txt"; Name = "Profile 03 (AI/Python)"}
)

Write-Host "`n===================================================================" -ForegroundColor Cyan
Write-Host "     AUTOMATED KEYWORD VERIFICATION REPORT" -ForegroundColor Cyan
Write-Host "===================================================================" -ForegroundColor Cyan
Write-Host ""

foreach ($profile in $profiles) {
    if (Test-Path $profile.Path) {
        $content = Get-Content $profile.Path -Raw
        $length = $content.Length
        $firstLine = (Get-Content $profile.Path -First 1)
        
        Write-Host "Profile: $($profile.Name)" -ForegroundColor Yellow
        Write-Host "File: $($profile.Path)" -ForegroundColor Gray
        Write-Host "Character Count: $length" -ForegroundColor White
        Write-Host "First Line: $firstLine" -ForegroundColor Gray
        Write-Host ""
        
        # Define keywords to check based on profile
        if ($profile.Name -like "*NET*") {
            $keywords = @(".NET Developer", "Full Stack Developer", "Backend Developer", "API Developer", "C#", "ASP.NET Core", "React", "Microservices", "Event-Driven Architecture")
        } elseif ($profile.Name -like "*React*") {
            $keywords = @("Full Stack Developer", "React Developer", "Node Developer", "Next.js Developer", "TypeScript Developer", "React", "Node.js", "Microservices", "Event-Driven Architecture")
        } else {
            $keywords = @("AI Engineer", "AI Developer", "Python Engineer", "Machine Learning Engineer", "Python", "OpenAI GPT-4", "Machine Learning", "Microservices", "Event-Driven Architecture")
        }
        
        Write-Host "Keyword Counts (VERIFIABLE):" -ForegroundColor Cyan
        foreach ($keyword in $keywords) {
            $count = ([regex]::Matches($content, [regex]::Escape($keyword), "IgnoreCase")).Count
            $inFirstLine = $firstLine -match [regex]::Escape($keyword)
            $status = if ($count -gt 0) { "" } else { "" }
            $firstLineStatus = if ($inFirstLine) { " IN FIRST LINE" } else { "" }
            Write-Host "  $status $keyword : $count times $firstLineStatus" -ForegroundColor $(if ($count -gt 0) { "Green" } else { "Red" })
        }
        
        Write-Host ""
        Write-Host "Mandatory Keywords Check:" -ForegroundColor Cyan
        $mandatory = @("Microservices", "Event-Driven Architecture", "AWS", "Azure", "Workflow Orchestration")
        foreach ($mandatoryKeyword in $mandatory) {
            $count = ([regex]::Matches($content, [regex]::Escape($mandatoryKeyword), "IgnoreCase")).Count
            $status = if ($count -gt 0) { "" } else { "" }
            Write-Host "  $status $mandatoryKeyword : $count times" -ForegroundColor $(if ($count -gt 0) { "Green" } else { "Red" })
        }
        
        Write-Host ""
        Write-Host "===================================================================" -ForegroundColor Cyan
        Write-Host ""
    }
}

Write-Host "VERIFICATION COMPLETE" -ForegroundColor Green
Write-Host "All metrics above are OBJECTIVE and VERIFIABLE" -ForegroundColor Yellow
Write-Host "You can manually verify by using Ctrl+F in each profile file" -ForegroundColor Yellow
