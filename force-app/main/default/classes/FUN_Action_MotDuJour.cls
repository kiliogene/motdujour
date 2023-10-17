/**
 *  Nicolas Corcelle (Kiliogene) - 2023.10.17 - v1.0
 *      • Création de l'action
 * 
 *  Récupération d'un mot de vocabulaire aléatoire depuis le site Dicoriginaux
 *  et extraction de la définition associée
**/
public with sharing class ZZZ_Action {
    
    // Attributs envoyés par le Flow
    global class Requests {
        
        @InvocableVariable(label='DescriptionInput')
        global String input;
        
    }
    
    // Attributs renvoyés au Flow
    global class Results {
        
        @InvocableVariable 
        global Boolean isError;
        
        @InvocableVariable
        global String errorMessage;
        
        @InvocableVariable
        global String log;
        
        @InvocableVariable
        global List<Account> outputCollection;
        
    }
    
    // Gestion des exceptions standard
    global class InvocableActionException extends Exception {}
    
    // Exposer l'action au Flow
    @InvocableMethod(label='DescriptionAction')
    global static List<Results> action(List<Requests> requestList) {
        
        // Préparation de la réponse
        Results response = new Results();
        List<Results> responseWrapper = new List<Results>();
        
        // Prise en compte de la gestion en Bulk (plusieurs demandes simultanées)
        for (Requests req : requestList) {

            //--- Initialisation des variables

            // Variables de sortie
            Boolean errorFlag = false;
            String errMsg = '';
            String log = '';
            // Variables d'entrée
            String input = req.input;

            // Vérification des valeurs d'entrée (optionnel)
            if (input == null) {
                throw new InvocableActionException('Flow Action - Erreur d\'input : DescriptionErreur.');
            }


            //--- Validation des règles de gestion

            //===============================================================
            //    1 - RG
            //===============================================================

            log += ' 1.1 - '+ input +'\n';
            log += '\n';



            // Valeurs de sortie
            response.isError = errorFlag;
            response.errorMessage = errMsg;
            response.log = log;
            outputCollection.add(input);
            responseWrapper.add(response);
        }

        // Renvoyer les réponses au Flow
        return responseWrapper;
    }
}