Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 00/40] android/gatt: GATT server implementation
Date: Tue, 29 Apr 2014 18:46:49 +0200
Message-Id: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds major part of GATT server support for Android:
* GATT database extension to get, read and write data
* Handling GATT Server Android requests
* Create listening socket for BLE.
* Support GATT Service
* Support Device Information Service
* Support Service Changed (skeleton)
* some bugfixes

Still some improvements are needed.

Tested on PC and Nexus 5 as peripheral device.

v2:
* Handled comments from Johan
* Added complete callback to database requests
* some bugfixes found during tests with haltest
* Rebase on upstream

Grzegorz Kolodziejczyk (3):
  android/gatt: Add support for ATT read by type
  android/gatt: Add MTU request cmd handling
  android/gatt: Add Find info gatt server cmd handling

Jakub Tyszkowski (3):
  android/gatt: Remove redundant find function parameter
  android/gatt: Register device information service
  android/gatt: Register GATT service

Lukasz Rymanowski (24):
  android/gatt: Rename listen_clients to listen_apps
  android/gatt: Add listening socket for GATT
  android/gatt: Assume that each server wants waits for connection
  android/gatt: Add ATT msg handler
  shared: Use pointer for request data instead of int
  shared/gatt: Extend read callback with offset
  shared/gatt: Add complete command callback
  android/bluetooth: Add function for getting device Android name
  android/gatt: Add register GAP Service
  gatt: Add some characteristics uuids
  shared: Extend write callback with offset
  android/gatt: Add support for ATT read by group type
  shared/gatt: Add support to read from database
  android/gatt: Move struct req_data up in the file
  android/gatt: Add support to read request
  shared/gatt: Add support for write request
  android/gatt: Add support for write request
  android/gatt: Add support for execute write
  android/gatt: Move struct req_data upper in the file
  android/gatt: Add write_cb to GATT server
  android/gatt: Add read_cb for GATT Server
  android/hal-gatt-api: Fix IPC definition for send response
  android/gatt: Add support for GATT server send response
  android/gatt: Add support for send indication

Marcin Kraglak (10):
  android/gatt: Add service functionality
  android/gatt: Add implementation of delete service
  android/gatt: Add included service implementation
  android/gatt: Add characteristic implementation
  android/gatt: Add handling of start service command
  android/gatt: Add stop service command handling
  android/gatt: Add descriptor implementation
  shared/gatt: Add function to read by group type
  shared/gatt: Add function to find by type
  shared/gatt: Add function to read by type

 android/bluetooth.c  |    5 +
 android/bluetooth.h  |    1 +
 android/gatt.c       | 1254 +++++++++++++++++++++++++++++++++++++++++++++++---
 android/hal-gatt.c   |    7 +-
 android/hal-msg.h    |    3 +
 lib/uuid.h           |    7 +
 src/shared/gatt-db.c |  321 +++++++++++++
 src/shared/gatt-db.h |   69 ++-
 8 files changed, 1588 insertions(+), 79 deletions(-)

-- 
1.8.4

