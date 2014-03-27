Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 0/5] Add GATT Characteristic Flags
Date: Thu, 27 Mar 2014 10:21:10 -0300
Message-Id: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds GattCharacteristic1 "Flags" property.

Extended properties are not supported yet.

Alvaro Silva (1):
  test: Add permissions for Alert Level of gatt-service

Claudio Takahasi (4):
  gatt: Add parsing GattCharacteristic1 Flags
  gatt: Set read and write callbacks based on Flags
  gatt: Make Characteristic Flags optional
  doc: Remove Core SPEC page number from gatt-api.txt

 doc/gatt-api.txt     | 13 ++++----
 src/gatt-dbus.c      | 93 +++++++++++++++++++++++++++++++++++++++++++++++++---
 tools/gatt-service.c | 43 ++++++++++++++++++++----
 3 files changed, 131 insertions(+), 18 deletions(-)

-- 
1.8.3.1

