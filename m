Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/5] Implements primary service search when creating a device
Date: Wed, 24 Nov 2010 00:30:43 -0200
Message-Id: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discover primary services implemented inside the device entity to allow
proper integration of attribute plugin. Implements a single entry point
to the attribute plugin no matter the transport(BR/EDR or LE), the device
probe callback is called for both types.

Add a new function to discover all primary services without additional
calls to fetch the remaining primary services, sub-procedure iterations
is handled inside this function.

The next action are: clean the attribute client removing implicity service
and characteristics discovery, issue the Discover Primary Service based on
the remote properties and fetch the characteristic on demand.
---
 attrib/manager.c  |   27 +++-------
 src/device.c      |  106 +++++++++++++++++++++++++++++++-------
 src/glib-helper.c |  147 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/glib-helper.h |    5 ++
 4 files changed, 246 insertions(+), 39 deletions(-)

diff --git a/attrib/manager.c b/attrib/manager.c
index 9bd1774..9b06c8c 100644
--- a/attrib/manager.c
+++ b/attrib/manager.c
@@ -45,26 +45,17 @@ static int client_probe(struct btd_device *device, GSList *uuids)
 {
 	const sdp_record_t *rec;
 	sdp_list_t *list;
-	int psm;
-
-	/*
-	 * Entry point for BR/EDR GATT probe. LE scanning and primary service
-	 * search will be handled temporaly inside the gatt plugin. For the
-	 * final solution all LE operations should be moved to the "core",
-	 * otherwise it will not be possible serialize/schedule BR/EDR device
-	 * discovery and LE scanning.
-	 */
+	int psm = -1;
 
 	rec = btd_device_get_record(device, GATT_UUID);
-	if (!rec)
-		return -1;
-
-	if (sdp_get_access_protos(rec, &list) < 0)
-		return -1;
-
-	psm = sdp_get_proto_port(list, L2CAP_UUID);
-	if (psm < 0)
-		return -1;
+	if (rec) {
+		if (sdp_get_access_protos(rec, &list) < 0)
+			return -1;
+
+		psm = sdp_get_proto_port(list, L2CAP_UUID);
+		if (psm < 0)
+			return -1;
+	}
 
 	return attrib_client_register(device, psm);
 }
diff --git a/src/device.c b/src/device.c
index 7c421e3..f236b29 100644
--- a/src/device.c
+++ b/src/device.c
@@ -111,6 +111,7 @@ struct browse_req {
 
 struct btd_device {
 	bdaddr_t	bdaddr;
+	gboolean	le;
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
@@ -215,7 +216,8 @@ static void browse_request_cancel(struct browse_req *req)
 
 	adapter_get_address(adapter, &src);
 
-	bt_cancel_discovery(&src, &device->bdaddr);
+	if (device->le == FALSE)
+		bt_cancel_discovery(&src, &device->bdaddr);
 
 	device->browse = NULL;
 	browse_request_free(req);
@@ -1557,29 +1559,67 @@ static void init_browse(struct browse_req *req, gboolean reverse)
 						l->data);
 }
 
-int device_browse(struct btd_device *device, DBusConnection *conn,
-			DBusMessage *msg, uuid_t *search, gboolean reverse)
+static void primary_cb(GSList *services, int err, gpointer user_data)
+{
+	struct browse_req *req = user_data;
+	struct btd_device *device = req->device;
+
+	if (err) {
+		error_failed_errno(req->conn, req->msg, -err);
+		goto done;
+	}
+
+	services_changed(req->device);
+	device_set_temporary(req->device, FALSE);
+	device_probe_drivers(req->device, services);
+
+	create_device_reply(req->device, req);
+
+done:
+	device->browse = NULL;
+	browse_request_free(req);
+}
+
+static struct browse_req *browse_primary(struct btd_device *device, int *err)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 	bdaddr_t src;
-	uuid_t uuid;
-	bt_callback_t cb;
-	int err;
+	int ret;
 
-	if (device->browse)
-		return -EBUSY;
+	req = g_new0(struct browse_req, 1);
+	req->device = btd_device_ref(device);
 
 	adapter_get_address(adapter, &src);
 
-	req = g_new0(struct browse_req, 1);
+	ret = bt_discover_primary(&src, &device->bdaddr, -1, primary_cb, req,
+									NULL);
 
-	if (conn == NULL)
-		conn = get_dbus_connection();
+	if (ret < 0) {
+		browse_request_free(req);
+		if (err)
+			*err = ret;
 
-	req->conn = dbus_connection_ref(conn);
-	req->device = btd_device_ref(device);
+		return NULL;
+	}
+
+	return req;
+}
+
+static struct browse_req *browse_sdp(struct btd_device *device, uuid_t *search,
+						gboolean reverse, int *err)
+{
+	struct btd_adapter *adapter = device->adapter;
+	struct browse_req *req;
+	bt_callback_t cb;
+	bdaddr_t src;
+	uuid_t uuid;
+	int ret;
 
+	adapter_get_address(adapter, &src);
+
+	req = g_new0(struct browse_req, 1);
+	req->device = btd_device_ref(device);
 	if (search) {
 		memcpy(&uuid, search, sizeof(uuid_t));
 		cb = search_cb;
@@ -1589,6 +1629,39 @@ int device_browse(struct btd_device *device, DBusConnection *conn,
 		cb = browse_cb;
 	}
 
+	ret = bt_search_service(&src, &device->bdaddr, &uuid, cb, req, NULL);
+	if (ret < 0) {
+		browse_request_free(req);
+		if (err)
+			*err = ret;
+
+		return NULL;
+	}
+
+	return req;
+}
+
+int device_browse(struct btd_device *device, DBusConnection *conn,
+			DBusMessage *msg, uuid_t *search, gboolean reverse)
+{
+	struct browse_req *req;
+	int err = 0;
+
+	if (device->browse)
+		return -EBUSY;
+
+	if (device->le)
+		req = browse_primary(device, &err);
+	else
+		req = browse_sdp(device, search, reverse, &err);
+
+	if (req == NULL)
+		return err;
+
+	if (conn == NULL)
+		conn = get_dbus_connection();
+
+	req->conn = dbus_connection_ref(conn);
 	device->browse = req;
 
 	if (msg) {
@@ -1603,13 +1676,6 @@ int device_browse(struct btd_device *device, DBusConnection *conn,
 						req, NULL);
 	}
 
-	err = bt_search_service(&src, &device->bdaddr,
-				&uuid, cb, req, NULL);
-	if (err < 0) {
-		device->browse = NULL;
-		browse_request_free(req);
-	}
-
 	return err;
 }
 
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 4941d99..f0689d5 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -42,12 +42,26 @@
 
 #include <glib.h>
 
-#include "glib-helper.h"
+#include "btio.h"
+#include "gattrib.h"
+#include "att.h"
+#include "gatt.h"
 #include "sdpd.h"
+#include "glib-helper.h"
 
 /* Number of seconds to keep a sdp_session_t in the cache */
 #define CACHE_TIMEOUT 2
 
+struct gattrib_context {
+	bdaddr_t src;
+	bdaddr_t dst;
+	GAttrib *attrib;
+	bt_primary_t cb;
+	bt_destroy_t destroy;
+	gpointer user_data;
+	GSList *uuids;
+};
+
 struct cached_sdp_session {
 	bdaddr_t src;
 	bdaddr_t dst;
@@ -57,6 +71,17 @@ struct cached_sdp_session {
 
 static GSList *cached_sdp_sessions = NULL;
 
+static void gattrib_context_free(struct gattrib_context *ctxt)
+{
+	if (ctxt->destroy)
+		ctxt->destroy(ctxt->user_data);
+
+	g_slist_foreach(ctxt->uuids, (GFunc) g_free, NULL);
+	g_slist_free(ctxt->uuids);
+	g_attrib_unref(ctxt->attrib);
+	g_free(ctxt);
+}
+
 static gboolean cached_session_expired(gpointer user_data)
 {
 	struct cached_sdp_session *cached = user_data;
@@ -118,6 +143,7 @@ struct search_context {
 	bdaddr_t		dst;
 	sdp_session_t		*session;
 	bt_callback_t		cb;
+	bt_primary_t		prim_cb;
 	bt_destroy_t		destroy;
 	gpointer		user_data;
 	uuid_t			uuid;
@@ -378,6 +404,125 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
 	return 0;
 }
 
+static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gattrib_context *ctxt = user_data;
+	struct att_data_list *list;
+	unsigned int i, err;
+	uint16_t end;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		err = 0;
+		goto done;
+	}
+
+	if (status != 0) {
+		err = -EIO;
+		goto done;
+	}
+
+	list = dec_read_by_grp_resp(pdu, plen);
+	if (list == NULL) {
+		err = -EPROTO;
+		goto done;
+	}
+
+	for (i = 0, end = 0; i < list->num; i++) {
+		const uint8_t *data = list->data[i];
+		char *prim;
+		uuid_t u128, u16;
+
+		end = att_get_u16(&data[2]);
+
+		if (list->len == 6) {
+			sdp_uuid16_create(&u16,
+					att_get_u16(&data[4]));
+			sdp_uuid16_to_uuid128(&u128, &u16);
+
+		} else if (list->len == 20)
+			sdp_uuid128_create(&u128, &data[4]);
+		else
+			/* Skipping invalid data */
+			continue;
+
+		prim = bt_uuid2string(&u128);
+		ctxt->uuids = g_slist_append(ctxt->uuids, prim);
+	}
+
+	att_data_list_free(list);
+	err = 0;
+
+	if (end != 0xffff) {
+		gatt_discover_primary(ctxt->attrib, end + 1, 0xffff, NULL,
+							primary_cb, ctxt);
+		return;
+	}
+
+done:
+	ctxt->cb(ctxt->uuids, err, ctxt->user_data);
+	gattrib_context_free(ctxt);
+}
+
+static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	struct gattrib_context *ctxt = user_data;
+
+	if (gerr) {
+		ctxt->cb(NULL, -EIO, ctxt->user_data);
+		gattrib_context_free(ctxt);
+		return;
+	}
+
+	gatt_discover_primary(ctxt->attrib, 0x0001, 0xffff, NULL, primary_cb,
+									ctxt);
+}
+
+int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
+					bt_primary_t cb, void *user_data,
+					bt_destroy_t destroy)
+{
+	struct gattrib_context *ctxt;
+	GIOChannel *io;
+	GError *gerr = NULL;
+
+	ctxt = g_try_malloc0(sizeof(struct gattrib_context));
+	if (ctxt == NULL)
+		return -ENOMEM;
+
+	bacpy(&ctxt->src, src);
+	bacpy(&ctxt->dst, dst);
+	ctxt->user_data = user_data;
+	ctxt->cb = cb;
+	ctxt->destroy = destroy;
+
+	if (psm < 0)
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_CID, GATT_CID,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	else
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_PSM, psm,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+
+	if (io == NULL) {
+		gattrib_context_free(ctxt);
+		return -EIO;
+	}
+
+	ctxt->attrib = g_attrib_new(io);
+
+	g_io_channel_unref(io);
+
+	return 0;
+}
+
 char *bt_uuid2string(uuid_t *uuid)
 {
 	gchar *str;
diff --git a/src/glib-helper.h b/src/glib-helper.h
index dfe4123..018ff92 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -22,6 +22,7 @@
  */
 
 typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
+typedef void (*bt_primary_t) (GSList *l, int err, gpointer user_data);
 typedef void (*bt_destroy_t) (gpointer user_data);
 
 int bt_discover_services(const bdaddr_t *src, const bdaddr_t *dst,
@@ -32,6 +33,10 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			bt_destroy_t destroy);
 int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst);
 
+int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
+					bt_primary_t cb, void *user_data,
+					bt_destroy_t destroy);
+
 gchar *bt_uuid2string(uuid_t *uuid);
 uint16_t bt_name2class(const char *string);
 char *bt_name2string(const char *string);
-- 
1.7.3.2

