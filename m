Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v10 00/12] Implement LE Advertisement D-Bus API
Date: Fri,  3 Apr 2015 15:02:00 -0700
Message-Id: <1428098532-5257-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implementation of the LE Advertisement D-Bus API.

Things that are missing still:
 * Semantics for multiple Advertisements (currently any more than one will fail)
 * TX Power property parsing / interface
 * Setting other Flags in the advertisement.

v1 -> v2:
 * Cleanup based on comments from Arman
 * Add g_dbus_proxy_set_read_watch function to avoid ObjectManager dependency
 * Consolidate script updates into single test script

v2 -> v3:
 * Change "ManufacturerSpecificData" to "ManufacturerData"
 * Add advertisement-api.txt to EXTRA_DIST
 * Add Release() callback to org.bluez.LEAdvertisement1
 * Remove IncludePower from the LEAdvertisement1 API

v3 -> v4:
 * Rename "g_dbus_proxy_set_read_watch" to "g_dbus_proxy_set_ready_watch"

v4 -> v5:
 * Rebase
 * Use g_dbus_client_set_proxy_handlers instead of g_dbus_proxy_set_ready_watch
 * Add MGMT interface calls to actually advertise.

v5 -> v6:
 * Minor patch cruft cleanup
 * Rename btd_advertising_manager to btd_advertising and fix filename change.

v6 -> v7:
 * Rebase for included patches
 * Rename ad structure to bt_ad
 * Fixes for bt_ad_generate bugs
 * Correctly error for invalid length
 * Improvements so advertisement-example works out of the box

v7 -> v8:
 * Rebase
 * Use eir.h constants instead of local constants
 * Rename internal structures for brevity
 * Add null checks
 * Check for queue_* failures
 * Address misc other comments

v8 -> v9:
 * Rebase
 * Rephrase example-advertisement patch message
 * Don't try to start LEAdvertisingManager when not in experimental
 * Set MGMT flags correctly for peripheral vs. broadcast
 * Fix memory leaks in refresh_advertisement

v9 -> v10:
 * Rebase
 * Add length checks to bt_ad_add_service_data and bt_ad_add_manufacturer_data
 * Use size_t where appropriate to avoid overflows

Michael Janssen (12):
  shared: add bt_ad structure
  core/advertising: use bt_ad
  core/advertising: Parse ServiceUUIDs
  core/advertising: Parse SolicitUUIDs
  core/advertising: Parse ManufacturerSpecificData
  core/advertising: Parse ServiceData
  Update TODO for LE Advertising
  shared/ad: implement bt_ad_generate
  core/advertising: Add and Remove AD using MGMT
  test: improvements to example-advertisement
  gdbus: Add g_dbus_get_flags function
  core: Only start Advertising Manager when experimental

 Makefile.am                |   1 +
 TODO                       |  20 +-
 gdbus/gdbus.h              |   1 +
 gdbus/object.c             |   5 +
 src/adapter.c              |  18 +-
 src/advertising.c          | 325 ++++++++++++++++++++++++-
 src/eir.h                  |  12 +
 src/shared/ad.c            | 589 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h            |  60 +++++
 test/example-advertisement |  12 +-
 10 files changed, 1006 insertions(+), 37 deletions(-)
 create mode 100644 src/shared/ad.c
 create mode 100644 src/shared/ad.h

-- 
2.2.0.rc0.207.ga3a616c

