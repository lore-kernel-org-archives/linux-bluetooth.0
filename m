Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 0/9] GATT API: Add Register Services Async
Date: Thu,  6 Mar 2014 10:44:18 -0300
Message-Id: <1394113467-24331-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBfVP_aYMDFdK+vqBxOKEZh2tdfasKkEks4v5H6h-ZXerw@mail.gmail.com>
References: <CAKT1EBfVP_aYMDFdK+vqBxOKEZh2tdfasKkEks4v5H6h-ZXerw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset is an extension of "[PATCH BlueZ v7 00/11] GATT API:
External Services". It adds the following features:
  * new gdbus helper to allow notifying the clients when
    GetManagedObjects() reply is received and all proxies reported to
    upper-layer.
  * reply for RegisterService() after validating fetched objects
  * adds the service declaration to the local GATT database

* Changes from v0 to v1:
  - renames g_dbus_client_set_proxies_ready_watch() to
    g_dbus_client_set_ready_watch()

Claudio Takahasi (9):
  gdbus: Add g_dbus_client_set_ready_watch()
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
 gdbus/client.c      |  17 ++++
 gdbus/gdbus.h       |   4 +-
 src/bluetooth.conf  |   1 +
 src/gatt-dbus.c     | 135 +++++++++++++++++++++++++-
 test/gatt-service.c | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 425 insertions(+), 5 deletions(-)
 create mode 100644 test/gatt-service.c

-- 
1.8.3.1

