Return-Path: <cyrus@holtmann.org>
From: bruna.moreira@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 1/3] adapter: Remove unused Broadcaster property
Date: Thu, 26 Jul 2012 13:37:26 -0400
Message-Id: <50117f05.0a4bec0a.04ec.ffffcfe2@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Applications that want to be Observers of certain Advertising data type
(e.g. Manufacturer Specific Data or Service Data) will use new Observer
D-Bus API to monitor these AD types. Therefore, the old Broadcaster
device property is unnecessary.
---
 doc/adapter-api.txt |    3 +--
 src/adapter.c       |    7 -------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 5d993cd..23f0a2f 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -187,8 +187,7 @@ Signals		PropertyChanged(string name, variant value)
 			The dictionary can contain basically the same values
 			that are returned by the GetProperties method
 			from the org.bluez.Device interface. In addition there
-			can be values for the RSSI, the TX power level and
-			Broadcaster role.
+			can be values for the RSSI and the TX power level.
 
 		DeviceDisappeared(string address)
 
diff --git a/src/adapter.c b/src/adapter.c
index 8820e27..b05a030 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2688,14 +2688,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		alias = g_strdup(dev->alias);
 
 	if (dev->bdaddr_type != BDADDR_BREDR) {
-		gboolean broadcaster;
 		uint16_t app;
 
-		if (dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
-			broadcaster = FALSE;
-		else
-			broadcaster = TRUE;
-
 		dev->legacy = FALSE;
 
 		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
@@ -2713,7 +2707,6 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				"Alias", DBUS_TYPE_STRING, &alias,
 				"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
-				"Broadcaster", DBUS_TYPE_BOOLEAN, &broadcaster,
 				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
 				NULL);
 	} else {
-- 
1.7.9.5

