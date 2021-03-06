@{
    RootModule = 'BuildDocs.psm1'
    ModuleVersion = '1.0.0'
    GUID = '8c857042-3d68-423f-81f3-92cca581b91a'
    Author = 'Mark Kraus'
    Copyright = '2017'
    Description = 'Module for the Classy PlatyPS'
    FunctionsToExport = @(
        'ClassText'
        'ConstructorHeading'
        'ConvertFrom-MarkDown'
        'ConvertTo-MarkDown'
        'EnumText'
        'MethodHeading'
        'Update-ClassMarkdown'
        'Update-EnumMarkdown'
    )
}

