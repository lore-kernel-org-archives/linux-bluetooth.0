Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v5 00/13] Implement LE Advertisement D-Bus API
Date: Wed, 25 Mar 2015 16:00:48 -0700
Message-Id: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implementation of the LE Advertisement API.

Things that are missing still (and added to the TODO):
 * Semantics for multiple Advertisements (currently any more than one will fail)
 * TX Power property parsing / interface

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

Michael Janssen (13):
  core: advertising: add LEAdvertisingManager stubs
  core/advertising: Implement RegisterAdvertisement
  tools: Python script to test Advertisement API
  core/advertising: implement UnregisterAdvertisement
  shared: add advertising-data
  core/advertising: use advertising_data
  core/advertising: Parse ServiceUUIDs
  core/advertising: Parse SolicitUUIDs
  core/advertising: Parse ManufacturerSpecificData
  core/advertising: Parse ServiceData
  Update TODO for LE Advertising
  shared/advertising: implement advertising_data_generate
  core/advertising: Add and Remove AD using MGMT

 Makefile.am                   |   3 +
 TODO                          |  21 +-
 src/adapter.c                 |  19 ++
 src/advertising.c             | 666 ++++++++++++++++++++++++++++++++++++++++++
 src/advertising.h             |  25 ++
 src/shared/advertising-data.c | 585 +++++++++++++++++++++++++++++++++++++
 src/shared/advertising-data.h |  69 +++++
 tools/advertisement-example   | 170 +++++++++++
 8 files changed, 1548 insertions(+), 10 deletions(-)
 create mode 100644 src/advertising.c
 create mode 100644 src/advertising.h
 create mode 100644 src/shared/advertising-data.c
 create mode 100644 src/shared/advertising-data.h
 create mode 100644 tools/advertisement-example

-- 
2.2.0.rc0.207.ga3a616c

