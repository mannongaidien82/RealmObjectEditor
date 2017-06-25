//
//  EntitiesContentGenerator.swift
//  Realm Object Editor
//
//  Created by Ahmed Ali on 1/20/15.
//  Copyright (c) 2015 Ahmed Ali. All rights reserved.
//

import Foundation
struct Static {
    static var onceToken : Int = 0
    static var instance : EntityFilesGenerator? = nil
}
class EntityFilesGenerator {
    private static var __once: () = {

            Static.instance = EntityFilesGenerator()

        }()

    /**
    Lazely load and return the singleton instance of the EntityGenerator
    */
    
    class var instance : EntityFilesGenerator {
       
        _ = EntityFilesGenerator.__once
        return Static.instance!
    }
    
    
    func entitiesToFiles(_ entities: [EntityDescriptor], lang: LangModel) -> [FileModel]
    {
        var files = [FileModel]()
        for entity in entities{
            let file = FileModel()
            file.fileName = entity.name
            file.fileExtension = lang.fileExtension
            file.fileContent = FileContentGenerator(entity: entity, lang: lang).getFileContent()
            files.append(file)
            if lang.implementation != nil{
                //This language also provides a seperate implementation file
                let implementationFile = FileModel()
                implementationFile.fileName = entity.name
                implementationFile.fileExtension = lang.implementation.fileExtension
                implementationFile.fileContent = ImplementationFileContentGenerator(entity: entity, lang: lang).getFileContent()
                files.append(implementationFile)
            }
        }
        return files
    }
    
    
    func fileContentForEntity(_ entity: EntityDescriptor, lang: LangModel) -> String
    {
        
        return FileContentGenerator(entity: entity, lang: lang).getFileContent()
    }
    
    func headerFileContentForEntity(_ entity: EntityDescriptor, lang: LangModel) -> String
    {
        return ""
    }
    
    
    
}
