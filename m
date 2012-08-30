Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH RFC] Add Generic Device Battery API
Date: Thu, 30 Aug 2012 14:26:19 +0300
Message-ID: <1346325980-11411-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

This API proposal allows exposing peer device battery information to the D-Bus
clients. Profiles supporting peer device battery information (such as AVRCP, 
LE Battery client) may use the internal API (next patch set) to register or
unregister batteries to be listed under the device object path. These batteries
have multiple read-only prpoerties that can be read by the D-Bus clients. In
addition, the new org.bluez.Battery interface allows sending PropertyChanged for
battery properties (such as Battery level).

Battery properties currently include the battery level, namespace and 
description (currently used by the LE battery client). More properties can be
added or removed as we see fit in the future.

Comments on this patch will be appreciated.

Chen Ganir (1):
  battery: Add generic device battery interface

 doc/battery-api.txt |   34 ++++++++++++++++++++++++++++++++++
 doc/device-api.txt  |    5 +++++
 2 files changed, 39 insertions(+)
 create mode 100644 doc/battery-api.txt

-- 
1.7.9.5

