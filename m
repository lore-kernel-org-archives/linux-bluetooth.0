Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v8 00/10] Implement LE Advertisement D-Bus API
Date: Wed,  1 Apr 2015 14:09:52 -0700
Message-Id: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
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

Michael Janssen (10):
  shared: add bt_ad structure
  core/advertising: use bt_ad
  core/advertising: Parse ServiceUUIDs
  core/advertising: Parse SolicitUUIDs
  core/advertising: Parse ManufacturerSpecificData
  core/advertising: Parse ServiceData
  Update TODO for LE Advertising
  shared/ad: implement bt_ad_generate
  core/advertising: Add and Remove AD using MGMT
  test: improvements to advertising-example

 Makefile.am                |   1 +
 TODO                       |  20 +-
 src/advertising.c          | 310 +++++++++++++++++++++++-
 src/eir.h                  |  12 +
 src/shared/ad.c            | 584 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h            |  60 +++++
 test/example-advertisement |  12 +-
 7 files changed, 972 insertions(+), 27 deletions(-)
 create mode 100644 src/shared/ad.c
 create mode 100644 src/shared/ad.h

-- 
2.2.0.rc0.207.ga3a616c

