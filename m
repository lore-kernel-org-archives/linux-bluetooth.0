Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 05/10] device: Use only one entry point for LE connections
Date: Fri,  1 Mar 2013 20:22:28 -0300
Message-Id: <1362180153-11133-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now, two functions were used for establishing LE connections,
device_connect_le() and device_browse_primary().

This commit changes the behaviour of device_browse_primary() to expect the
conenction to be already established, and if not to call device_connect_le().
This simplification allows for the 'att_callbacks' mechanism to be removed.
---
 src/device.c | 178 +++++++++++++++++------------------------------------------
 1 file changed, 50 insertions(+), 128 deletions(-)

diff --git a/src/device.c b/src/device.c
index bfc60fa..f2abcff 100644
--- a/src/device.c
+++ b/src/device.c
@@ -141,12 +141,6 @@ struct svc_callback {
 typedef void (*attio_error_cb) (const GError *gerr, gpointer user_data);
 typedef void (*attio_success_cb) (gpointer user_data);
 
-struct att_callbacks {
-	attio_error_cb error;		/* Callback for error */
-	attio_success_cb success;	/* Callback for success */
-	gpointer user_data;
-};
-
 struct btd_device {
 	int ref_count;
 
@@ -214,8 +208,7 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
-static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
-							gboolean secure);
+static int device_browse_primary(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 							gboolean reverse);
 static void device_svc_resolved(struct btd_device *dev, DBusMessage *msg,
@@ -1185,7 +1178,7 @@ static int device_resolve_svc(struct btd_device *dev, DBusMessage *msg)
 	if (device_is_bredr(dev))
 		return device_browse_sdp(dev, msg, FALSE);
 	else
-		return device_browse_primary(dev, msg, FALSE);
+		return device_browse_primary(dev, msg);
 }
 
 static struct btd_profile *find_connectable_profile(struct btd_device *dev,
@@ -2838,14 +2831,14 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 						DEVICE_INTERFACE, "UUIDs");
 
 send_reply:
-	/* Browse has finished, some profiles may use device->browse to check
-	 * if browsing is still ongoing, so we mark it as finished, and free
+	/* Browse has finished, some code may use device->browse to check if
+	 * browsing is still ongoing, so we mark it as finished, and free
 	 * it later
 	 */
 	device->browse = NULL;
 
 	device_svc_resolved(device, req->msg, err);
-	req->msg = NULL; /* The reply was sent above */
+	req->msg = NULL; /* The reply was just sent */
 
 	if (!device->temporary)
 		store_device_info(device);
@@ -3173,10 +3166,35 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	find_included_services(device, services);
 }
 
+static void att_connect_error(struct btd_device *device, const GError *gerr)
+{
+	if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED))
+		return;
+
+	if (device_get_auto_connect(device)) {
+		DBG("Enabling automatic connections");
+		adapter_connect_list_add(device->adapter, device);
+	}
+}
+
+static void att_connect_success(struct btd_device *device)
+{
+	if (device->attios == NULL)
+		return;
+
+	/*
+	 * Remove the device from the connect_list and give the passive
+	 * scanning another chance to be restarted in case there are
+	 * other devices in the connect_list.
+	 */
+	adapter_connect_list_remove(device->adapter, device);
+
+	g_slist_foreach(device->attios, attio_connected, device->attrib);
+}
+
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
-	struct att_callbacks *attcb = user_data;
-	struct btd_device *device = attcb->user_data;
+	struct btd_device *device = user_data;
 	DBusMessage *reply;
 	uint8_t io_cap;
 	GAttrib *attrib;
@@ -3188,8 +3206,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (gerr) {
 		DBG("%s", gerr->message);
 
-		if (attcb->error)
-			attcb->error(gerr, attcb->user_data);
+		att_connect_error(device, gerr);
 
 		err = -ECONNABORTED;
 		goto done;
@@ -3204,8 +3221,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	device->cleanup_id = g_io_add_watch(io, G_IO_HUP,
 					attrib_disconnected_cb, device);
 
-	if (attcb->success)
-		attcb->success(user_data);
+	att_connect_success(device);
 
 	if (!device->bonding)
 		goto done;
@@ -3225,10 +3241,12 @@ done:
 		bonding_request_free(device->bonding);
 	}
 
-	if (device->connect) {
-		if (!device->svc_resolved)
-			device_browse_primary(device, NULL, FALSE);
+	/* The connection was caused by a device_browse_primary() */
+	if (device->gatt_discov)
+		gatt_discover_primary(device->attrib, NULL, primary_cb,
+						btd_device_ref(device));
 
+	if (device->connect) {
 		if (err < 0)
 			reply = btd_error_failed(device->connect,
 							strerror(-err));
@@ -3239,45 +3257,11 @@ done:
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
 	}
-
-	g_free(attcb);
-}
-
-static void att_error_cb(const GError *gerr, gpointer user_data)
-{
-	struct btd_device *device = user_data;
-
-	if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED))
-		return;
-
-	if (device_get_auto_connect(device)) {
-		DBG("Enabling automatic connections");
-		adapter_connect_list_add(device->adapter, device);
-	}
-}
-
-static void att_success_cb(gpointer user_data)
-{
-	struct att_callbacks *attcb = user_data;
-	struct btd_device *device = attcb->user_data;
-
-	if (device->attios == NULL)
-		return;
-
-	/*
-	 * Remove the device from the connect_list and give the passive
-	 * scanning another chance to be restarted in case there are
-	 * other devices in the connect_list.
-	 */
-	adapter_connect_list_remove(device->adapter, device);
-
-	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
 int device_connect_le(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
-	struct att_callbacks *attcb;
 	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *gerr = NULL;
@@ -3291,11 +3275,6 @@ int device_connect_le(struct btd_device *dev)
 
 	DBG("Connection attempt to: %s", addr);
 
-	attcb = g_new0(struct att_callbacks, 1);
-	attcb->error = att_error_cb;
-	attcb->success = att_success_cb;
-	attcb->user_data = dev;
-
 	if (dev->paired)
 		sec_level = BT_IO_SEC_MEDIUM;
 	else
@@ -3305,7 +3284,7 @@ int device_connect_le(struct btd_device *dev)
 	 * This connection will help us catch any PDUs that comes before
 	 * pairing finishes
 	 */
-	io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
+	io = bt_io_connect(att_connect_cb, dev, NULL, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, adapter_get_address(adapter),
 			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
@@ -3325,7 +3304,6 @@ int device_connect_le(struct btd_device *dev)
 
 		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
 		g_error_free(gerr);
-		g_free(attcb);
 		return -EIO;
 	}
 
@@ -3335,78 +3313,16 @@ int device_connect_le(struct btd_device *dev)
 	return 0;
 }
 
-static void att_browse_error_cb(const GError *gerr, gpointer user_data)
-{
-	struct btd_device *device = user_data;
-	struct gatt_discovery *disc = device->gatt_discov;
-
-	if (disc->msg) {
-		DBusMessage *reply;
-
-		reply = btd_error_failed(disc->msg, gerr->message);
-		g_dbus_send_message(dbus_conn, reply);
-	}
-
-	device->gatt_discov = NULL;
-	gatt_discovery_free(disc);
-}
-
-static void att_browse_cb(gpointer user_data)
-{
-	struct att_callbacks *attcb = user_data;
-	struct btd_device *device = attcb->user_data;
-
-	gatt_discover_primary(device->attrib, NULL, primary_cb,
-							device->browse);
-}
-
-static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
-								gboolean secure)
+static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
 {
-	struct btd_adapter *adapter = device->adapter;
-	struct att_callbacks *attcb;
 	struct gatt_discovery *disc;
-	BtIOSecLevel sec_level;
 
 	if (device->gatt_discov)
 		return -EBUSY;
 
 	disc = g_new0(struct gatt_discovery, 1);
-
 	device->gatt_discov = disc;
 
-	if (device->attrib) {
-		gatt_discover_primary(device->attrib, NULL, primary_cb,
-						btd_device_ref(device));
-		goto done;
-	}
-
-	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
-
-	attcb = g_new0(struct att_callbacks, 1);
-	attcb->error = att_browse_error_cb;
-	attcb->success = att_browse_cb;
-	attcb->user_data = device;
-
-	device->att_io = bt_io_connect(att_connect_cb,
-				attcb, NULL, NULL,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(adapter),
-				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
-				BT_IO_OPT_CID, ATT_CID,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-
-	if (device->att_io == NULL) {
-		gatt_discovery_free(disc);
-		device->gatt_discov = NULL;
-		g_free(attcb);
-		return -EIO;
-	}
-
-done:
-
 	if (msg) {
 		const char *sender = dbus_message_get_sender(msg);
 
@@ -3418,6 +3334,12 @@ done:
 					device, NULL);
 	}
 
+	if (device->attrib == NULL)
+		return device_connect_le(device);
+
+	gatt_discover_primary(device->attrib, NULL, primary_cb,
+						btd_device_ref(device));
+
 	return 0;
 }
 
@@ -3615,7 +3537,7 @@ static gboolean start_discovery(gpointer user_data)
 	if (device_is_bredr(device))
 		device_browse_sdp(device, NULL, TRUE);
 	else
-		device_browse_primary(device, NULL, FALSE);
+		device_browse_primary(device, NULL);
 
 	device->discov_timer = 0;
 
@@ -3685,7 +3607,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 		if (device_is_bredr(device))
 			device_browse_sdp(device, bonding->msg, FALSE);
 		else
-			device_browse_primary(device, bonding->msg, FALSE);
+			device_browse_primary(device, bonding->msg);
 
 		bonding_request_free(bonding);
 	} else if (!device->svc_resolved) {
@@ -4109,7 +4031,7 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 			prim->changed = TRUE;
 	}
 
-	device_browse_primary(device, NULL, FALSE);
+	device_browse_primary(device, NULL);
 }
 
 void btd_device_add_uuid(struct btd_device *device, const char *uuid)
-- 
1.8.1.3

