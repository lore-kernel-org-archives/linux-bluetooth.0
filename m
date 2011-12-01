Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Use alias for LE devices
Date: Thu,  1 Dec 2011 16:01:48 -0300
Message-Id: <1322766108-7308-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As in BR/EDR, use alias for LE devices or, if there is no alias, set
it to either the name or to the device address.
---
 src/adapter.c |   50 +++++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 84e33a7..1a701a4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2773,6 +2773,15 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		dev->uuid_count = uuid_count;
 	}
 
+	if (!dev->alias) {
+		if (!dev->name) {
+			alias = g_strdup(peer_addr);
+			g_strdelimit(alias, ":", '-');
+		} else
+			alias = g_strdup(dev->name);
+	} else
+		alias = g_strdup(dev->alias);
+
 	if (dev->le) {
 		gboolean broadcaster;
 
@@ -2785,36 +2794,27 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				"Address", DBUS_TYPE_STRING, &paddr,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
+				"Alias", DBUS_TYPE_STRING, &alias,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
 				"Broadcaster", DBUS_TYPE_BOOLEAN, &broadcaster,
 				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
 				NULL);
-		return;
-	}
-
-	icon = class_to_icon(dev->class);
-
-	if (!dev->alias) {
-		if (!dev->name) {
-			alias = g_strdup(peer_addr);
-			g_strdelimit(alias, ":", '-');
-		} else
-			alias = g_strdup(dev->name);
-	} else
-		alias = g_strdup(dev->alias);
+	} else {
+		icon = class_to_icon(dev->class);
 
-	emit_device_found(adapter->path, paddr,
-			"Address", DBUS_TYPE_STRING, &paddr,
-			"Class", DBUS_TYPE_UINT32, &dev->class,
-			"Icon", DBUS_TYPE_STRING, &icon,
-			"RSSI", DBUS_TYPE_INT16, &rssi,
-			"Name", DBUS_TYPE_STRING, &dev->name,
-			"Alias", DBUS_TYPE_STRING, &alias,
-			"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
-			"Paired", DBUS_TYPE_BOOLEAN, &paired,
-			"Trusted", DBUS_TYPE_BOOLEAN, &trusted,
-			"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
-			NULL);
+		emit_device_found(adapter->path, paddr,
+				"Address", DBUS_TYPE_STRING, &paddr,
+				"Class", DBUS_TYPE_UINT32, &dev->class,
+				"Icon", DBUS_TYPE_STRING, &icon,
+				"RSSI", DBUS_TYPE_INT16, &rssi,
+				"Name", DBUS_TYPE_STRING, &dev->name,
+				"Alias", DBUS_TYPE_STRING, &alias,
+				"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
+				"Paired", DBUS_TYPE_BOOLEAN, &paired,
+				"Trusted", DBUS_TYPE_BOOLEAN, &trusted,
+				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
+				NULL);
+	}
 
 	g_free(alias);
 }
-- 
1.7.4.1

