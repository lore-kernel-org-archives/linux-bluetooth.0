Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] adapter: add Trusted to DeviceFound signal
Date: Thu, 18 Aug 2011 17:15:11 -0300
Message-Id: <1313698511-13365-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

doc says that this signal is has the same parameters as GetProperties
reply.
---

Not sure if this is really need. It at least could save a call to GetProperties

 src/adapter.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4c88a0e..a184d08 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2785,7 +2785,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
 	const char *icon, *paddr = peer_addr;
-	dbus_bool_t paired = FALSE;
+	dbus_bool_t paired = FALSE, trusted = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
 	size_t uuid_count;
@@ -2794,8 +2794,10 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	ba2str(&adapter->bdaddr, local_addr);
 
 	device = adapter_find_device(adapter, paddr);
-	if (device)
+	if (device) {
 		paired = device_is_paired(device);
+		trusted = device_is_trusted(device);
+	}
 
 	/* The uuids string array is updated only if necessary */
 	uuid_count = g_slist_length(dev->services);
@@ -2844,6 +2846,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 			"Alias", DBUS_TYPE_STRING, &alias,
 			"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
 			"Paired", DBUS_TYPE_BOOLEAN, &paired,
+			"Trusted", DBUS_TYPE_BOOLEAN, &trusted,
 			"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
 			NULL);
 
-- 
1.7.6

