Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add Broadcaster property in DeviceFound signal
Date: Thu, 23 Dec 2010 16:33:07 -0500
Message-Id: <1293139987-17536-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Broadcaster property is required to distinguish the device role. If the remote
is sending an advertising event, two possible roles are possible: Peripheral or
Broadcaster.

This change is required to pass on qualification tests which require filtering
Broadcasting devices during General Discovery Procedure.
---
 doc/adapter-api.txt |    3 ++-
 src/adapter.c       |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index f287f29..5272d74 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -185,7 +185,8 @@ Signals		PropertyChanged(string name, variant value)
 			The dictionary can contain basically the same values
 			that are returned by the GetProperties method
 			from the org.bluez.Device interface. In addition there
-			can be values for the RSSI and the TX power level.
+			can be values for the RSSI, the TX power level and
+			Broadcaster role.
 
 		DeviceDisappeared(string address)
 
diff --git a/src/adapter.c b/src/adapter.c
index bf92211..fddf0ad 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2829,12 +2829,20 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	}
 
 	if (dev->le) {
+		gboolean broadcaster;
+
+		if (dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
+			broadcaster = FALSE;
+		else
+			broadcaster = TRUE;
+
 		emit_device_found(adapter->path, paddr,
 				"Address", DBUS_TYPE_STRING, &paddr,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
 				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids,
+				"Broadcaster", DBUS_TYPE_BOOLEAN, &broadcaster,
 				dev->uuid_count, NULL);
 		return;
 	}
-- 
1.7.3.2

