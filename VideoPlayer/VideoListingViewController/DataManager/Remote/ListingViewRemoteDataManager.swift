//
//  ListingViewRemoteDataManager.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation
import Alamofire

class ListingViewRemoteDataManager: ListingViewRemoteDataManagerInputProtocol{
    
    // Request Handler sends the response back to Interactor
    var requestHandler: ListingViewRemoteDataManagerOutputProtocol?
    
    func retriveVideoList(request: ListRequestModel) {
//        Alamofire
//            .request(EndPoints.listingAPI.url, method: .get, parameters: request.paramaters)
//            .validate()
//            .responseListResponseModel { response in
//                switch response.result{
//                case .success(let listResponseModel):
//                    #warning("we could check here the response of api, by compairing status code and status message.")
//                    if let currentPage = listResponseModel.currentPage,
//                        currentPage > 1{
//                        self.requestHandler?.onPaginatedVideoListReterived(model: listResponseModel)
//                    }else{
//                        self.requestHandler?.onVideoListRetrieved(model: listResponseModel)
//                    }
//                case .failure(let error):
//                    self.requestHandler?.onError(message: error.localizedDescription)
//                }
//        }
        self.requestHandler?.onVideoListRetrieved(model: self.getlistResponseModelForDemoPurpose())
    }
}

extension ListingViewRemoteDataManager{
    
    private func getlistResponseModelForDemoPurpose() -> ListResponseModel{
        
        var listResponseData = [ListResponseData]()
        let names = ["jumpIntoWater", "pexels", "rollerCoasters", "kitchen"]
        let titles = ["Jump Into Water", "Pexels", "Roller Coaster", "Kitchen"]
        let uploadedOn = ["2018-07-23 8:00:00","2018-07-23 8:00:00","2018-07-23 8:00:00","2018-07-23 8:00:00"]
        let uploader = ["anonymous", "SH", "SH", "anonymous"]
        
        for(index, name) in names.enumerated(){
            let videoUrl = Bundle.main.path(forResource: name, ofType: "mp4")!
            let thumbnailUrl = Bundle.main.path(forResource: name, ofType: "png")!
            let uploaderUrl = Bundle.main.path(forResource: uploader[index], ofType: "png")!
            
            
            let video = ListResponseData(id: index, title: titles[index], source: videoUrl, thumbnail: thumbnailUrl, views: (index+1) * 27, uploaderImage: uploaderUrl, uploadedBy: uploader[index], uploadedOn: uploadedOn[index])
            listResponseData.append(video)
        }
        
        let listResponseModel = ListResponseModel(total: 4, perPage: 10, currentPage: 1, lastPage: 1, nextPageURL: nil, prevPageURL: nil, from: 1, to: 4, data: listResponseData)
        
        return listResponseModel
    }
}
