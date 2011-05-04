Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/3] Remove connectable checking when creating a device
Date: Wed,  4 May 2011 10:13:47 -0400
Message-Id: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Kernel advertising cache will be used to infer the LE address type
and if it is connectable. For kernels without cache patches, only
LE public address is supported and if the remote is non-connectable,
the connection will fail after the L2CAP timeout(~40s).

Note: currently, CreateDevice misbehaves when LE Create Connection
command times out for any reason (e.g. peer device left connectable
mode). This is being investigated and will be fixed in a separate patch.
---
 src/adapter.c |   30 +++---------------------------
 1 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8dbd62c..82002e7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -71,9 +71,6 @@
 #define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
 					    Device Capable (Host) */
 
-#define ADV_TYPE_IND		0x00
-#define ADV_TYPE_DIRECT_IND	0x01
-
 #define IO_CAPABILITY_DISPLAYONLY	0x00
 #define IO_CAPABILITY_DISPLAYYESNO	0x01
 #define IO_CAPABILITY_KEYBOARDONLY	0x02
@@ -1652,21 +1649,9 @@ static device_type_t flags2type(uint8_t flags)
 		return DEVICE_TYPE_DUALMODE;
 }
 
-static gboolean event_is_connectable(uint8_t type)
-{
-	switch (type) {
-	case ADV_TYPE_IND:
-	case ADV_TYPE_DIRECT_IND:
-		return TRUE;
-	default:
-		return FALSE;
-	}
-}
-
 static struct btd_device *create_device_internal(DBusConnection *conn,
 						struct btd_adapter *adapter,
-						const gchar *address,
-						gboolean force, int *err)
+						const gchar *address, int *err)
 {
 	struct remote_dev_info *dev, match;
 	struct btd_device *device;
@@ -1682,14 +1667,6 @@ static struct btd_device *create_device_internal(DBusConnection *conn,
 	else
 		type = DEVICE_TYPE_BREDR;
 
-	if (!force && type == DEVICE_TYPE_LE &&
-					!event_is_connectable(dev->evt_type)) {
-		if (err)
-			*err = -ENOTCONN;
-
-		return NULL;
-	}
-
 	device = adapter_create_device(conn, adapter, address, type);
 	if (!device && err)
 		*err = -ENOMEM;
@@ -1721,7 +1698,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 
 	DBG("%s", address);
 
-	device = create_device_internal(conn, adapter, address, TRUE, &err);
+	device = create_device_internal(conn, adapter, address, &err);
 	if (!device)
 		goto failed;
 
@@ -1802,8 +1779,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 
 	device = adapter_find_device(adapter, address);
 	if (!device) {
-		device = create_device_internal(conn, adapter, address,
-								FALSE, &err);
+		device = create_device_internal(conn, adapter, address, &err);
 		if (!device)
 			return btd_error_failed(msg, strerror(-err));
 	}
-- 
1.7.0.4

