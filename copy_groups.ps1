# Пользователь с которого берем группы
$sourceUser = "USER1"

# Пользователь которому эти группы даем
$destinationUser = "USER2"

# Прописываем контроллер домена
$domainController = "DOMAIN.CONTROLLER"

# Получение всех групп, к которым принадлежит исходный пользователь
$groups = Get-ADPrincipalGroupMembership -Server "$domainController" -Identity $sourceUser

foreach ($group in $groups) {
    # Добавление целевого пользователя ко всем группам исходного пользователя
    Try {
        Add-ADGroupMember -Identity $group -Members $destinationUser -ErrorAction Stop
        Write-Host "Пользователь $destinationUser добавлен в группу $($group.Name)."
        # Игнорирование ошибок, если пользователь уже состоит в группе
    } Catch {
        Write-Host "Ошибка: Не удалось добавить пользователя $destinationUser в группу $($group.Name) - $_"
    }
}