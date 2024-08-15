# Change USER1 in $sourceUser to source user's sAMAccountname
$sourceUser = "USER1"

# Change USER2 in $destinationUser to destination user's sAMAccountname
$destinationUser = "USER2"

# Change DOMAIN.CONTROLLER in $domainController to your full domain address 
# (not neccessary, use it if you have more than one domain controller)
$domainController = "DOMAIN.CONTROLLER"

# Receiving all of source user's policy groups
$groups = Get-ADPrincipalGroupMembership -Server "$domainController" -Identity $sourceUser

foreach ($group in $groups) {
    # Adding source user's to destination user
    Try {
        Add-ADGroupMember -Identity $group -Members $destinationUser -ErrorAction Stop
        Write-Host "User $destinationUser has been added in $($group.Name)."
        # Ignoring errors, if user already have policy groups from the list
    } Catch {
        Write-Host "Error: Can not add user $destinationUser in a group $($group.Name) - $_"
    }
}
