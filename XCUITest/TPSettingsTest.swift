/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class TrackingProtectionSettings: BaseTestCase {
    func testInactiveSettings() {
        // Go to in-app settings
        // Check the new options in TP Settings menu
        dismissURLBarFocused()
        waitForExistence(app.buttons["HomeView.settingsButton"], timeout: 10)
        // Set search engine to Google
        app.buttons["HomeView.settingsButton"].tap()
        app.tables.cells["icon_settings"].tap()

        waitForExistence(app.staticTexts["Ad trackers.Subtitle"])
        XCTAssertEqual(app.staticTexts["Ad trackers.Subtitle"].label, "0")

        waitForExistence(app.staticTexts["Analytic trackers.Subtitle"])
        XCTAssertEqual(app.staticTexts["Analytic trackers.Subtitle"].label, "0")

        waitForExistence(app.staticTexts["Social trackers.Subtitle"])
        XCTAssertEqual(app.staticTexts["Social trackers.Subtitle"].label, "0")

        waitForExistence(app.staticTexts["Content trackers.Subtitle"])
        XCTAssertEqual(app.staticTexts["Content trackers.Subtitle"].label, "0")

        // Close the menu
        if iPad() {
            app.otherElements["PopoverDismissRegion"].tap()
        }
        else {
            waitForExistence(app.buttons["PhotonMenu.close"])
            app.buttons["PhotonMenu.close"].tap()
        }

        waitForExistence(app.navigationBars["Tracking Protection"])
        // Verify trackers and scripts to block switches
        let switchAdvertisingValue = app.switches["BlockerToggle.BlockAds"].value!
        let switchAnalyticsValue = app.switches["BlockerToggle.BlockAnalytics"].value!
        let switchSocialValue = app.switches["BlockerToggle.BlockSocial"].value!
        let switchOtherValue = app.switches["BlockerToggle.BlockOther"].value!

        XCTAssertEqual(switchAdvertisingValue as! String, "1")
        XCTAssertEqual(switchAnalyticsValue as! String, "1")
        XCTAssertEqual(switchSocialValue as! String, "1")
        XCTAssertEqual(switchOtherValue as! String, "0")

        app.staticTexts["More Settings"].tap()
        waitForExistence(app.navigationBars["Settings"])
    }
}
