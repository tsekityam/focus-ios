/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class RequestDesktopTest: BaseTestCase {
    func testLongPressReloadButton() {
        let urlBarTextField = app.textFields["URLBar.urlText"]

        loadWebPage("facebook.com")
        waitForExistence(app.buttons["BrowserToolset.stopReloadButton"])
        app.buttons["BrowserToolset.stopReloadButton"].press(forDuration: 1.0)

        if iPad() {
            waitForExistence(app.sheets.buttons["Request Mobile Site"])
            app.sheets.buttons["Request Mobile Site"].tap()
        } else {
            waitForExistence(app.sheets.buttons["Request Desktop Site"])
            app.sheets.buttons["Request Desktop Site"].tap()
        }

        waitForWebPageLoad()

        guard let text = urlBarTextField.value as? String else {
            XCTFail()
            return
        }

        if !iPad() {
            if text.contains("m.facebook") {
                XCTFail()
            }
        }
    }

    func testActivityMenuRequestDesktopItem() {
        let urlBarTextField = app.textFields["URLBar.urlText"]

        // Wait for existence rather than hittable because the textfield is technically disabled
        loadWebPage("facebook.com")

        waitForWebPageLoad()
        waitForExistence(app.buttons["HomeView.settingsButton"])
        app.buttons["HomeView.settingsButton"].tap()

        if iPad() {
            waitForExistence(app.tables.cells["request_mobile_site_activity"])
            app.tables.cells["request_mobile_site_activity"].tap()
        } else {
            waitForExistence(app.tables.cells["request_desktop_site_activity"])
            app.tables.cells["request_desktop_site_activity"].tap()
        }

        if !iPad() {
            if text.contains("m.facebook") {
                XCTFail()
            }
        }
    }
}
