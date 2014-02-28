Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 0/9] GATT API: Add Register Services Async
Date: Fri, 28 Feb 2014 14:05:27 -0300
Message-Id: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset is an extension of "[PATCH BlueZ v7 00/11] GATT API:
External Services". It adds the following features:
  * new gdbus helper to allow notifying the clients when
    GetManagedObjects() reply is received and all proxies reported.
  * reply for RegisterService() after validating the fetched objects
  * adds the service declaration to the local GATT database

Claudio Takahasi (9):
  gdbus: Add g_dbus_client_set_proxies_ready_watch()
  gatt: Add proxy added handler
  gatt: Add proxy removed handler
  gatt: Add GATT service to the local database
  gatt: Make RegisterService() async
  test: Add external service GATT skeleton
  test: Add signal handling for gatt-service
  test: Add registering external service
  bluetooth.conf: Add ObjectManager interface

 .gitignore          |   1 +
 Makefile.tools      |   5 +
 gdbus/client.c      |  18 ++++
 gdbus/gdbus.h       |   4 +
 src/bluetooth.conf  |   1 +
 src/gatt-dbus.c     | 135 +++++++++++++++++++++++++-
 test/gatt-service.c | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 427 insertions(+), 4 deletions(-)
 create mode 100644 test/gatt-service.c

-- 
1.8.3.1

