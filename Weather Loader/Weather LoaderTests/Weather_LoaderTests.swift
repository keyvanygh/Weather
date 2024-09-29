//
//  Weather_LoaderTests.swift
//  Weather LoaderTests
//
//  Created by Keyvan Yaghoubian on 9/29/24.
//

import XCTest
import HttpClient
import Weather_Loader

protocol WeatherLoader {
    
}

class RemoteWeatherLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

final class RemoteWeatherLoaderTests: XCTestCase {

    func test_init_doseNotLoad() {
        let (sut, client) = makeSUT()
        
        XCTAssertEqual(client.requstedURLs, [])
    }
    
    private func makeSUT() -> (RemoteWeatherLoader, HTTPClientSpy) {
        let client: HTTPClientSpy = HTTPClientSpy()
        return (RemoteWeatherLoader(client: client), client)
    }
}

class HTTPClientSpy: HTTPClient {
    public var requstedURLs: [URL] = []
    
    public func request(
        _ httpMethod: HttpMethod,
        to url: URL,
        header: [String : String]?,
        body: Data?
    ) async throws -> HTTPClient.Result {
        requstedURLs.append(url)
        throw NSError()
    }
}
