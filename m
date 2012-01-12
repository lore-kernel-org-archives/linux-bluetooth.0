Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Add missing "Legacy" property for LE devices
Date: Thu, 12 Jan 2012 14:59:41 -0400
Message-Id: <1326394781-465-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some UIs may assume that a device lacking the Legacy property is
pre 2.1. To be more consistent with BR/EDR devices, always set Legacy
property explicitly to False. This makes these UIs not ask for a PIN
code when doing Just Works pairing for LE devices.
---
 src/adapter.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e65780e..7e4bbb6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2671,11 +2671,14 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		else
 			broadcaster = TRUE;
 
+		dev->legacy = FALSE;
+
 		emit_device_found(adapter->path, paddr,
 				"Address", DBUS_TYPE_STRING, &paddr,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Alias", DBUS_TYPE_STRING, &alias,
+				"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
 				"Broadcaster", DBUS_TYPE_BOOLEAN, &broadcaster,
 				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
-- 
1.7.5.4

