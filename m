Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 3/6] device: Clean up device_att_connect()
Date: Fri, 25 Jan 2013 00:07:04 -0300
Message-Id: <1359083227-13122-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

device_att_connect() is used to make an ATT connection to an LE device.

We clean it (and its associated callback) to have better error handling
and to respond the user with an error when it happens.

As it is only used for LE devices, we remove all the handling for non-LE
devices.
---
 src/device.c | 93 +++++++++++++++++++++++++-----------------------------------
 src/device.h |  3 +-
 2 files changed, 41 insertions(+), 55 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6c4455b..89df161 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3045,7 +3045,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	struct btd_device *device = attcb->user_data;
 	uint8_t io_cap;
 	GAttrib *attrib;
-	int err;
+	int err = 0;
 
 	g_io_channel_unref(device->att_io);
 	device->att_io = NULL;
@@ -3056,6 +3056,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		if (attcb->error)
 			attcb->error(gerr, user_data);
 
+		err = -ECONNABORTED;
 		goto done;
 	}
 
@@ -3079,10 +3080,10 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	else
 		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
 
-	/* this is a LE device during pairing */
 	err = adapter_create_bonding(device->adapter, &device->bdaddr,
 					device->bdaddr_type, io_cap);
-	if (err < 0) {
+done:
+	if (device->bonding && err < 0) {
 		DBusMessage *reply = btd_error_failed(device->bonding->msg,
 							strerror(-err));
 		g_dbus_send_message(dbus_conn, reply);
@@ -3090,7 +3091,6 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		bonding_request_free(device->bonding);
 	}
 
-done:
 	g_free(attcb);
 }
 
@@ -3120,80 +3120,65 @@ static void att_success_cb(gpointer user_data)
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
-GIOChannel *device_att_connect(gpointer user_data)
+GIOChannel *device_att_connect(struct btd_device *dev)
 {
-	struct btd_device *device = user_data;
-	struct btd_adapter *adapter = device->adapter;
+	struct btd_adapter *adapter = dev->adapter;
 	struct att_callbacks *attcb;
+	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	char addr[18];
 
-	ba2str(&device->bdaddr, addr);
+	/* There is one connection attempt going on */
+	if (dev->att_io)
+		return NULL;
+
+	ba2str(&dev->bdaddr, addr);
 
 	DBG("Connection attempt to: %s", addr);
 
 	attcb = g_new0(struct att_callbacks, 1);
 	attcb->error = att_error_cb;
 	attcb->success = att_success_cb;
-	attcb->user_data = device;
+	attcb->user_data = dev;
 
-	if (device_is_bredr(device)) {
-		io = bt_io_connect(att_connect_cb,
-					attcb, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR,
-					adapter_get_address(adapter),
-					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-					BT_IO_OPT_PSM, ATT_PSM,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-					BT_IO_OPT_INVALID);
-	} else if (device->bonding) {
-		/* this is a LE device during pairing, using low sec level */
-		io = bt_io_connect(att_connect_cb,
-				attcb, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(adapter),
-				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
-				BT_IO_OPT_CID, ATT_CID,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-				BT_IO_OPT_INVALID);
-		if (io == NULL) {
+	if (dev->paired)
+		sec_level = BT_IO_SEC_MEDIUM;
+	else
+		sec_level = BT_IO_SEC_LOW;
+
+	/*
+	 * This connection will help us catch any PDUs that comes before
+	 * pairing finishes
+	 */
+	io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, adapter_get_address(adapter),
+			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
+			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
+			BT_IO_OPT_CID, ATT_CID,
+			BT_IO_OPT_SEC_LEVEL, sec_level,
+			BT_IO_OPT_INVALID);
+
+	if (io == NULL) {
+		if (dev->bonding) {
 			DBusMessage *reply = btd_error_failed(
-					device->bonding->msg, gerr->message);
+					dev->bonding->msg, gerr->message);
+
 			g_dbus_send_message(dbus_conn, reply);
-			bonding_request_cancel(device->bonding);
-			bonding_request_free(device->bonding);
+			bonding_request_cancel(dev->bonding);
+			bonding_request_free(dev->bonding);
 		}
-	} else {
-		BtIOSecLevel sec_level;
 
-		if (device->paired)
-			sec_level = BT_IO_SEC_MEDIUM;
-		else
-			sec_level = BT_IO_SEC_LOW;
-
-		io = bt_io_connect(att_connect_cb,
-				attcb, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(adapter),
-				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
-				BT_IO_OPT_CID, ATT_CID,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-	}
-
-	if (io == NULL) {
 		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
 		g_error_free(gerr);
 		g_free(attcb);
 		return NULL;
 	}
 
-	device->att_io = io;
+	/* Keep this, so we can cancel the connection */
+	dev->att_io = g_io_channel_ref(io);
 
-	return g_io_channel_ref(io);
+	return io;
 }
 
 static void att_browse_error_cb(const GError *gerr, gpointer user_data)
diff --git a/src/device.h b/src/device.h
index 6c35ff3..5438b0d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -108,7 +108,8 @@ int device_unblock(struct btd_device *device, gboolean silent,
 							gboolean update_only);
 void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version);
-GIOChannel *device_att_connect(gpointer user_data);
+
+GIOChannel *device_att_connect(struct btd_device *dev);
 
 struct btd_profile;
 
-- 
1.8.1.1

