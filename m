Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 2/8] core: Attach gatt-server to bt_att
Date: Wed, 18 Feb 2015 00:18:33 -0800
Message-Id: <1424247519-21684-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1424247519-21684-1-git-send-email-armansito@chromium.org>
References: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, btd_device now creates a bt_gatt_server and attaches
it to the ATT transport which coexists with a bt_gatt_client.
---
 src/device.c        | 47 +++++++++++++++++++++++++++++++----------------
 src/gatt-database.c |  2 --
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/src/device.c b/src/device.c
index 05a4bd9..678a6ac 100644
--- a/src/device.c
+++ b/src/device.c
@@ -51,11 +51,13 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
 #include "btio/btio.h"
 #include "lib/mgmt.h"
 #include "attrib/att.h"
 #include "hcid.h"
 #include "adapter.h"
+#include "gatt-database.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
 #include "device.h"
@@ -211,7 +213,6 @@ struct btd_device {
 	GAttrib		*attrib;
 	GSList		*attios;
 	GSList		*attios_offline;
-	guint		attachid;		/* Attrib server attach */
 
 	struct bt_att *att;			/* The new ATT transport */
 	uint16_t att_mtu;			/* The ATT MTU */
@@ -224,6 +225,7 @@ struct btd_device {
 	 */
 	struct gatt_db *db;			/* GATT db cache */
 	struct bt_gatt_client *client;		/* GATT client instance */
+	struct bt_gatt_server *server;		/* GATT server instance */
 
 	struct btd_gatt_client *client_dbus;
 
@@ -538,6 +540,15 @@ static void gatt_client_cleanup(struct btd_device *device)
 		gatt_db_clear(device->db);
 }
 
+static void gatt_server_cleanup(struct btd_device *device)
+{
+	if (!device->server)
+		return;
+
+	bt_gatt_server_unref(device->server);
+	device->server = NULL;
+}
+
 static void attio_cleanup(struct btd_device *device)
 {
 	if (device->att_disconn_id)
@@ -551,6 +562,7 @@ static void attio_cleanup(struct btd_device *device)
 	}
 
 	gatt_client_cleanup(device);
+	gatt_server_cleanup(device);
 
 	if (device->att) {
 		bt_att_unref(device->att);
@@ -561,14 +573,6 @@ static void attio_cleanup(struct btd_device *device)
 		GAttrib *attrib = device->attrib;
 
 		device->attrib = NULL;
-
-		if (device->attachid) {
-			guint attachid = device->attachid;
-
-			device->attachid = 0;
-			attrib_channel_detach(attrib, attachid);
-		}
-
 		g_attrib_cancel_all(attrib);
 		g_attrib_unref(attrib);
 	}
@@ -4123,6 +4127,20 @@ static void gatt_client_init(struct btd_device *device)
 	}
 }
 
+static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
+{
+	if (!db) {
+		error("No local GATT database exists for this adapter");
+		return;
+	}
+
+	gatt_server_cleanup(device);
+
+	device->server = bt_gatt_server_new(db, device->att, device->att_mtu);
+	if (!device->server)
+		error("Failed to initialize bt_gatt_server");
+}
+
 bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 {
 	GError *gerr = NULL;
@@ -4130,6 +4148,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	BtIOSecLevel sec_level;
 	uint16_t mtu;
 	uint16_t cid;
+	struct btd_gatt_database *database;
 
 	bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
 						BT_IO_OPT_IMTU, &mtu,
@@ -4162,13 +4181,6 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
-	dev->attachid = attrib_channel_attach(attrib);
-	if (dev->attachid == 0) {
-		g_attrib_unref(attrib);
-		error("Attribute server attach failure!");
-		return false;
-	}
-
 	dev->attrib = attrib;
 	dev->att = g_attrib_get_att(attrib);
 
@@ -4178,7 +4190,10 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 						att_disconnected_cb, dev, NULL);
 	bt_att_set_close_on_unref(dev->att, true);
 
+	database = btd_adapter_get_database(dev->adapter);
+
 	gatt_client_init(dev);
+	gatt_server_init(dev, btd_gatt_database_get_db(database));
 
 	/*
 	 * Remove the device from the connect_list and give the passive
diff --git a/src/gatt-database.c b/src/gatt-database.c
index c69de15..1a77e6b 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -234,8 +234,6 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (!device)
 		return;
 
-	/* TODO: create bt_gatt_server instance */
-
 	device_attach_att(device, io);
 }
 
-- 
2.2.0.rc0.207.ga3a616c

