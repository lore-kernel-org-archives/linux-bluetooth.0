Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 0/5] Add basic GATT descriptors
Date: Fri, 28 Mar 2014 11:19:05 -0300
Message-Id: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds the basic support for GATT descriptors (local GATT
services) implemented according to doc/gatt-api.txt

"UUID", and "Value" properties are implemented by this patchset.
"Characteristic" (parent) is still pending. "Permissions" support is
not defined yet.

Andre Guedes (1):
  gatt: Introduce helper for adding descriptors

Claudio Takahasi (4):
  gatt: Add descriptor to the database
  tools: Add testing descriptor for IAS Alert Level
  tools: Add Get/Set descriptor
  tools: Add emitting descriptor PropertiesChanged

 src/gatt-dbus.c      | 100 ++++++++++++++++++++++++++---------------
 src/gatt.c           |  54 +++++++++++++++++++---
 src/gatt.h           |  16 +++++++
 tools/gatt-service.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 245 insertions(+), 49 deletions(-)

-- 
1.8.3.1

