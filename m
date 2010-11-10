Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 7/7] Emit "DeviceFound" signal for LE devices
Date: Wed, 10 Nov 2010 13:51:27 -0400
Message-Id: <1289411487-6113-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The adapter_emit_device_found() function was modified to emit
DeviceFound signal for LE devices as well.
---
 src/adapter.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b263096..dab9087 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3102,6 +3102,27 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	if (device)
 		paired = device_is_paired(device);
 
+	/* Extract UUIDs from extended inquiry response if any */
+	dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
+	uuid_count = g_slist_length(dev->services);
+
+	if (dev->services)
+		uuids = strlist2array(dev->services);
+
+	if (dev->le) {
+		emit_device_found(adapter->path, paddr,
+				"Address", DBUS_TYPE_STRING, &paddr,
+				"RSSI", DBUS_TYPE_INT16, &rssi,
+				"Name", DBUS_TYPE_STRING, &dev->name,
+				"Paired", DBUS_TYPE_BOOLEAN, &paired,
+				"UUIDs", DBUS_TYPE_ARRAY, &uuids, uuid_count,
+				NULL);
+
+		g_strfreev(uuids);
+
+		return;
+	}
+
 	icon = class_to_icon(dev->class);
 
 	if (!dev->alias) {
@@ -3113,12 +3134,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
-	/* Extract UUIDs from extended inquiry response if any */
-	dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
-	uuid_count = g_slist_length(dev->services);
-
 	if (dev->services) {
-		uuids = strlist2array(dev->services);
 		g_slist_foreach(dev->services, (GFunc) g_free, NULL);
 		g_slist_free(dev->services);
 		dev->services = NULL;
@@ -3196,6 +3212,10 @@ void adapter_update_adv(struct btd_adapter *adapter, le_advertising_info *info)
 		if (tmp_name)
 			dev->name = tmp_name;
 	}
+
+	/* FIXME: check if other information was changed before emitting the
+	 * signal */
+	adapter_emit_device_found(adapter, dev, info->data, info->length);
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-- 
1.7.0.4

