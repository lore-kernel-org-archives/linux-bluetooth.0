Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 07/15] core: device: Use bt_att_register_disconnect.
Date: Mon,  8 Dec 2014 16:40:47 -0800
Message-Id: <1418085655-7304-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btd_device is now notified of ATT channel disconnections by registering
a disconnect handler with bt_att instead of setting up an io watch with
the GIOChannel.
---
 src/device.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index e9630ed..b31e98d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -46,6 +46,8 @@
 #include "log.h"
 
 #include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
 #include "btio/btio.h"
 #include "lib/uuid.h"
 #include "lib/mgmt.h"
@@ -203,6 +205,9 @@ struct btd_device {
 	GSList		*attios_offline;
 	guint		attachid;		/* Attrib server attach */
 
+	struct bt_att *att;	/* The new ATT transport */
+	unsigned int att_disconn_id;
+
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
 
@@ -221,7 +226,6 @@ struct btd_device {
 	int8_t		rssi;
 
 	GIOChannel	*att_io;
-	guint		cleanup_id;
 	guint		store_id;
 };
 
@@ -466,10 +470,9 @@ static void attio_cleanup(struct btd_device *device)
 		device->attachid = 0;
 	}
 
-	if (device->cleanup_id) {
-		g_source_remove(device->cleanup_id);
-		device->cleanup_id = 0;
-	}
+	if (device->att_disconn_id)
+		bt_att_unregister_disconnect(device->att,
+							device->att_disconn_id);
 
 	if (device->att_io) {
 		g_io_channel_shutdown(device->att_io, FALSE, NULL);
@@ -477,6 +480,11 @@ static void attio_cleanup(struct btd_device *device)
 		device->att_io = NULL;
 	}
 
+	if (device->att) {
+		bt_att_unref(device->att);
+		device->att = NULL;
+	}
+
 	if (device->attrib) {
 		GAttrib *attrib = device->attrib;
 		device->attrib = NULL;
@@ -3401,8 +3409,7 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
-static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void att_disconnected_cb(void *user_data)
 {
 	struct btd_device *device = user_data;
 	int sock, err = 0;
@@ -3413,7 +3420,7 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 	if (device->browse)
 		goto done;
 
-	sock = g_io_channel_unix_get_fd(io);
+	sock = bt_att_get_fd(device->att);
 	len = sizeof(err);
 	getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len);
 
@@ -3436,8 +3443,6 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 
 done:
 	attio_cleanup(device);
-
-	return FALSE;
 }
 
 static void register_all_services(struct browse_req *req, GSList *services)
@@ -3656,7 +3661,7 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 	}
 
 	if (cid == ATT_CID)
-		mtu = ATT_DEFAULT_LE_MTU;
+		mtu = BT_ATT_DEFAULT_LE_MTU;
 
 	attrib = g_attrib_new(io, mtu);
 	if (!attrib) {
@@ -3672,8 +3677,11 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 	}
 
 	dev->attrib = attrib;
-	dev->cleanup_id = g_io_add_watch(io, G_IO_HUP,
-					attrib_disconnected_cb, dev);
+	dev->att = bt_att_ref(g_attrib_get_att(attrib));
+
+	dev->att_disconn_id = bt_att_register_disconnect(dev->att,
+						att_disconnected_cb, dev, NULL);
+	bt_att_set_close_on_unref(dev->att, true);
 
 	/*
 	 * Remove the device from the connect_list and give the passive
-- 
2.2.0.rc0.207.ga3a616c

