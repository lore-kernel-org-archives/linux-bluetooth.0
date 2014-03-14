Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ v1 0/2] Initial D-Bus GATT client API implementation.
Date: Fri, 14 Mar 2014 16:30:09 -0700
Message-Id: <1394839811-5746-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reroll 1: Mostly fixed style issues. Additional changes from v0:
  - Added the EXPERIMENTAL flag to properties in GattService1 and
    GattCharacteristic1.
  - Removed the change in src/device.c to when a connect call initiates
    GATT service discovery.
  - Removed the logic that skips GAP and GATT when registering the D-Bus
    services. 

Arman Uguray (2):
  gatt-dbus: Add remote GATT service objects.
  gatt-dbus: Add remote GATT characteristic objects.

 src/device.c    |  35 +++++++
 src/gatt-dbus.c | 283 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/gatt-dbus.h |  24 +++++
 3 files changed, 339 insertions(+), 3 deletions(-)

-- 
1.9.0.279.gdc9e3eb

