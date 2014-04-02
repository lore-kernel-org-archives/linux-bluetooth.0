Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 0/7] Add removing GATT services
Date: Wed,  2 Apr 2014 15:30:19 -0300
Message-Id: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements GattManager1.UnregisterService(), and low-level
functions to remove service declarations (and its attributes) from the
attribute database.

Andre Guedes (1):
  gatt: Add helper for removing GATT services

Claudio Takahasi (6):
  gdbus: Avoid reporting GDBusClient disconnect twice
  gatt: Rename external_app to external_service
  gatt: Add GattManager1.UnregisterService()
  gatt: Add removing service from the database
  gatt: Fix possibly lost block when bluetoothd exits
  doc: Add InvalidArguments to UnregisterService() errors

 doc/gatt-api.txt |   3 +-
 gdbus/client.c   |  14 ++++-
 src/gatt-dbus.c  | 162 ++++++++++++++++++++++++++++++++++---------------------
 src/gatt.c       |  42 +++++++++++++++
 src/gatt.h       |   7 +++
 5 files changed, 165 insertions(+), 63 deletions(-)

-- 
1.8.3.1

