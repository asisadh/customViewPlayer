//
//  ListingViewWireFrame.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation
import UIKit

class ListingViewWireFrame: ListingViewWireFrameProtocol{
    
    static func createVideoListingViewModule() -> UIViewController {
//
        let storyBoard : UIStoryboard = UIStoryboard(name: "Video", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "VideoListNavigationView")
        
        let listingViewController = viewController.children.first as? ListingView
        
//        let listingViewController = ListingView.instantiate(from: .Video)
        
        if let view: ListingViewProtocol = listingViewController{
            let presenter: ListingViewPresenterProtocol & ListingViewInteractorOutputProtocol = ListingViewPresenter()
            let interactor: ListingViewInteractorInputProtocol & ListingViewRemoteDataManagerOutputProtocol = ListingViewInteractor()
            let remoteDataManager: ListingViewRemoteDataManagerInputProtocol = ListingViewRemoteDataManager()
            let wireFrame: ListingViewWireFrameProtocol = ListingViewWireFrame()
            
            view.presenter = presenter
            
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            
            remoteDataManager.requestHandler = interactor
        }
        return viewController
    }
   
    func presentVideoDetailScreen(from view: ListingViewProtocol, forVideo video: ListResponseData, videoList: [ListResponseData], delegate: VideoDetailViewDelegate) {
        let detailView = VideoDetailWireFrame.createVideoDetailViewModule(video: video, videoList: videoList, delegate: delegate)
        if let view = view as? UIViewController{
            view.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    func presentErrorScreen(from view: ListingViewProtocol, errorMessage message: String) {
        if let view = view as? UIViewController{
            showAlertWithMessage(view: view, message: message)
        }
    }
}
