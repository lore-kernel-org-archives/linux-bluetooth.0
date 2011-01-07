Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Moving interactive code of Discover Primary to gatt.c
Date: Fri,  7 Jan 2011 20:00:04 -0300
Message-Id: <1294441204-31780-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1294441204-31780-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1294441204-31780-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial patch to move the shared code related to Discover All Primary
Services and Discover Primary Services by UUID to gatt.c.
---
 attrib/gatt.c     |  165 +++++++++++++++++++++++++++++++++++++--
 attrib/gatt.h     |    6 +-
 attrib/gatttool.c |   82 +++----------------
 src/device.c      |   59 ++++++++++++--
 src/glib-helper.c |  224 +++-------------------------------------------------
 src/glib-helper.h |    6 --
 6 files changed, 238 insertions(+), 304 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index ae33211..2e1b4b9 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -31,10 +31,24 @@
 #include "gattrib.h"
 #include "gatt.h"
 
-guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
-		uuid_t *uuid, GAttribResultFunc func, gpointer user_data)
+struct discover_primary {
+	GAttrib *attrib;
+	uuid_t uuid;
+	GSList *primaries;
+	gatt_primary_t cb;
+	void *user_data;
+};
+
+static void discover_primary_free(struct discover_primary *dp)
+{
+	g_slist_free(dp->primaries);
+	g_attrib_unref(dp->attrib);
+	g_free(dp);
+}
+
+static guint16 encode_discover_primary(uint16_t start, uint16_t end,
+					uuid_t *uuid, uint8_t *pdu, size_t len)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
 	uuid_t prim;
 	guint16 plen;
 	uint8_t op;
@@ -42,10 +56,9 @@ guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
 	sdp_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
 
 	if (uuid == NULL) {
-
 		/* Discover all primary services */
 		op = ATT_OP_READ_BY_GROUP_REQ;
-		plen = enc_read_by_grp_req(start, end, &prim, pdu, sizeof(pdu));
+		plen = enc_read_by_grp_req(start, end, &prim, pdu, len);
 	} else {
 		const void *value;
 		int vlen;
@@ -62,13 +75,151 @@ guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
 		}
 
 		plen = enc_find_by_type_req(start, end, &prim, value, vlen,
-							pdu, sizeof(pdu));
+								pdu, len);
+	}
+
+	return plen;
+}
+
+static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
+					guint16 iplen, gpointer user_data)
+
+{
+	struct discover_primary *dp = user_data;
+	GSList *ranges, *last;
+	struct att_range *range;
+	uint8_t opdu[ATT_DEFAULT_MTU];
+	guint16 oplen;
+	int err;
+
+	if (status) {
+		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		goto done;
+	}
+
+	ranges = dec_find_by_type_resp(ipdu, iplen);
+	if (ranges == NULL)
+		goto done;
+
+	dp->primaries = g_slist_concat(dp->primaries, ranges);
+
+	last = g_slist_last(ranges);
+	g_slist_free(ranges);
+	range = last->data;
+
+	if (range->end == 0xffff)
+		goto done;
+
+	oplen = encode_discover_primary(range->end + 1, 0xffff, &dp->uuid,
+							opdu, sizeof(opdu));
+
+	if (oplen == 0)
+		goto done;
+
+	g_attrib_send(dp->attrib, 0, opdu[0], opdu, oplen, primary_by_uuid_cb,
+								dp, NULL);
+	return;
+
+done:
+	dp->cb(dp->primaries, err, dp->user_data);
+	discover_primary_free(dp);
+}
+
+static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
+							gpointer user_data)
+{
+	struct discover_primary *dp = user_data;
+	struct att_data_list *list;
+	unsigned int i, err;
+	uint16_t start, end;
+
+	if (status) {
+		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		goto done;
+	}
+
+	list = dec_read_by_grp_resp(ipdu, iplen);
+	if (list == NULL) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	for (i = 0, end = 0; i < list->num; i++) {
+		const uint8_t *data = list->data[i];
+		struct att_primary *primary;
+		uuid_t u128, u16;
+
+		start = att_get_u16(&data[0]);
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
+		primary = g_try_new0(struct att_primary, 1);
+		if (!primary) {
+			err = ATT_ECODE_INSUFF_RESOURCES;
+			goto done;
+		}
+		primary->start = start;
+		primary->end = end;
+		sdp_uuid2strn(&u128, primary->uuid, sizeof(primary->uuid));
+		dp->primaries = g_slist_append(dp->primaries, primary);
+	}
+
+	att_data_list_free(list);
+	err = 0;
+
+	if (end != 0xffff) {
+		uint8_t opdu[ATT_DEFAULT_MTU];
+		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
+							opdu, sizeof(opdu));
+
+		g_attrib_send(dp->attrib, 0, opdu[0], opdu, oplen,
+						primary_all_cb, dp, NULL);
+
+		return;
 	}
 
+done:
+	dp->cb(dp->primaries, err, dp->user_data);
+	discover_primary_free(dp);
+}
+
+guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_primary_t func,
+							gpointer user_data)
+{
+	struct discover_primary *dp;
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	GAttribResultFunc cb;
+	guint16 plen;
+
+	plen = encode_discover_primary(0x0001, 0xffff, uuid, pdu, sizeof(pdu));
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, op, pdu, plen, func, user_data, NULL);
+	dp = g_try_new0(struct discover_primary, 1);
+	if (dp == NULL)
+		return 0;
+
+	dp->attrib = g_attrib_ref(attrib);
+	dp->cb = func;
+	dp->user_data = user_data;
+
+	if (uuid) {
+		memcpy(&dp->uuid, uuid, sizeof(uuid_t));
+		cb = primary_by_uuid_cb;
+	} else
+		cb = primary_all_cb;
+
+	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, cb, dp, NULL);
 }
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 1e1e628..936c592 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -24,8 +24,10 @@
 
 #define GATT_CID 4
 
-guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
-		uuid_t *uuid, GAttribResultFunc func, gpointer user_data);
+typedef void (*gatt_primary_t) (GSList *l, guint8 status, gpointer user_data);
+
+guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_primary_t func,
+							gpointer user_data);
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index a6f92db..ad0216b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -145,76 +145,30 @@ static GIOChannel *do_connect(gboolean le)
 	return chan;
 }
 
-static void primary_all_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 {
-	GAttrib *attrib = user_data;
-	struct att_data_list *list;
-	unsigned int i;
-	uint16_t end;
+	GSList *l;
 
-	if (status == ATT_ECODE_ATTR_NOT_FOUND)
-		goto done;
-
-	if (status != 0) {
+	if (status) {
 		g_printerr("Discover all primary services failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
 
-	list = dec_read_by_grp_resp(pdu, plen);
-	if (list == NULL)
-		goto done;
-
-	for (i = 0, end = 0; i < list->num; i++) {
-		char uuidstr[MAX_LEN_UUID_STR];
-		uint8_t *value = list->data[i];
-		uint8_t length;
-		uint16_t start;
-		uuid_t uuid;
-
-		/* Each element contains: attribute handle, end group handle
-		 * and attribute value */
-		length = list->len - 2 * sizeof(uint16_t);
-		start = att_get_u16(value);
-		end = att_get_u16(&value[2]);
-
-		g_print("attr handle = 0x%04x, end grp handle = 0x%04x, ",
-								start, end);
-		if (length == 2)
-			sdp_uuid16_create(&uuid, att_get_u16(&value[4]));
-		else
-			sdp_uuid128_create(&uuid, value + 4);
-
-		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		g_print("attr value (UUID) = %s\n", uuidstr);
+	for (l = services; l; l = l->next) {
+		struct att_primary *prim = l->data;
+		g_print("attr handle = 0x%04x, end grp handle = 0x%04x "
+			"uuid: %s\n", prim->start, prim->end, prim->uuid);
 	}
 
-	att_data_list_free(list);
-
-	/* Don't go beyond the maximum handle value */
-	if (end == 0xffff)
-		goto done;
-
-	/*
-	 * Discover all primary services sub-procedure shall send another
-	 * Read by Group Type Request until Error Response is received and
-	 * the Error Code is set to Attribute Not Found.
-	 */
-
-	gatt_discover_primary(attrib, end + 1, opt_end, NULL, primary_all_cb,
-								attrib);
-	return;
-
 done:
-	if (opt_listen == FALSE)
-		g_main_loop_quit(event_loop);
+	g_main_loop_quit(event_loop);
 }
 
-static void primary_by_uuid_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 							gpointer user_data)
 {
-	GSList *ranges, *l;
+	GSList *l;
 
 	if (status != 0) {
 		g_printerr("Discover primary services by UUID failed: %s\n",
@@ -222,21 +176,12 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto done;
 	}
 
-	ranges = dec_find_by_type_resp(pdu, plen);
-	if (ranges == NULL) {
-		g_printerr("Protocol error!\n");
-		goto done;
-	}
-
 	for (l = ranges; l; l = l->next) {
 		struct att_range *range = l->data;
 		g_print("Starting handle: %04x Ending handle: %04x\n",
 						range->start, range->end);
 	}
 
-	g_slist_foreach(ranges, (GFunc) g_free, NULL);
-	g_slist_free(ranges);
-
 done:
 	g_main_loop_quit(event_loop);
 }
@@ -292,11 +237,10 @@ static gboolean primary(gpointer user_data)
 	GAttrib *attrib = user_data;
 
 	if (opt_uuid)
-		gatt_discover_primary(attrib, opt_start, opt_end, opt_uuid,
-						primary_by_uuid_cb, attrib);
+		gatt_discover_primary(attrib, opt_uuid, primary_by_uuid_cb,
+									NULL);
 	else
-		gatt_discover_primary(attrib, opt_start, opt_end, NULL,
-						primary_all_cb, attrib);
+		gatt_discover_primary(attrib, NULL, primary_all_cb, NULL);
 
 	return FALSE;
 }
diff --git a/src/device.c b/src/device.c
index 4d53228..b7b9a98 100644
--- a/src/device.c
+++ b/src/device.c
@@ -53,6 +53,8 @@
 #include "event.h"
 #include "error.h"
 #include "glib-helper.h"
+#include "gattrib.h"
+#include "gatt.h"
 #include "agent.h"
 #include "sdp-xml.h"
 #include "storage.h"
@@ -95,6 +97,8 @@ struct authentication_req {
 struct browse_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
+	GAttrib *attrib;
+	GIOChannel *io;
 	struct btd_device *device;
 	GSList *match_uuids;
 	GSList *profiles_added;
@@ -170,6 +174,13 @@ static void browse_request_free(struct browse_req *req)
 	g_slist_free(req->profiles_removed);
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
+
+	if (req->io) {
+		g_attrib_unref(req->attrib);
+		g_io_channel_unref(req->io);
+		g_io_channel_shutdown(req->io, FALSE, NULL);
+	}
+
 	g_free(req);
 }
 
@@ -1559,7 +1570,7 @@ static char *primary_list_to_string(GSList *primary_list)
 	return g_string_free(services, FALSE);
 }
 
-static void primary_cb(GSList *services, int err, gpointer user_data)
+static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
@@ -1568,9 +1579,9 @@ static void primary_cb(GSList *services, int err, gpointer user_data)
 	bdaddr_t dba, sba;
 	char *str;
 
-	if (err) {
+	if (status) {
 		DBusMessage *reply;
-		reply = btd_error_failed(req->msg, strerror(-err));
+		reply = btd_error_failed(req->msg, att_ecode2str(status));
 		g_dbus_send_message(req->conn, reply);
 		goto done;
 	}
@@ -1603,13 +1614,36 @@ done:
 	browse_request_free(req);
 }
 
+static void gatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	struct browse_req *req = user_data;
+	struct btd_device *device = req->device;
+
+	if (gerr) {
+		DBusMessage *reply;
+
+		DBG("%s", gerr->message);
+
+		reply = btd_error_failed(req->msg, gerr->message);
+		g_dbus_send_message(req->conn, reply);
+
+		device->browse = NULL;
+		browse_request_free(req);
+
+		return;
+	}
+
+	req->attrib = g_attrib_new(io);
+	gatt_discover_primary(req->attrib, NULL, primary_cb, req);
+}
+
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				DBusMessage *msg, gboolean secure)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
+	BtIOSecLevel sec_level;
 	bdaddr_t src;
-	int err;
 
 	if (device->browse)
 		return -EBUSY;
@@ -1619,11 +1653,18 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	adapter_get_address(adapter, &src);
 
-	err = bt_discover_primary(&src, &device->bdaddr, -1, primary_cb, req,
-							secure, NULL);
-	if (err < 0) {
+	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
+
+	req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+				BT_IO_OPT_CID, GATT_CID,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_INVALID);
+
+	if (req->io == NULL ) {
 		browse_request_free(req);
-		return err;
+		return -EIO;
 	}
 
 	if (conn == NULL)
@@ -1644,7 +1685,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 						req, NULL);
 	}
 
-	return err;
+	return 0;
 }
 
 int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
diff --git a/src/glib-helper.c b/src/glib-helper.c
index b5f038d..22c14e7 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -38,28 +38,12 @@
 #include <glib.h>
 
 #include "btio.h"
-#include "gattrib.h"
-#include "att.h"
-#include "gatt.h"
 #include "sdpd.h"
 #include "glib-helper.h"
 
 /* Number of seconds to keep a sdp_session_t in the cache */
 #define CACHE_TIMEOUT 2
 
-struct gattrib_context {
-	bdaddr_t src;
-	bdaddr_t dst;
-	GAttrib *attrib;
-	GIOChannel *io;
-	bt_primary_t cb;
-	bt_destroy_t destroy;
-	gpointer user_data;
-	GSList *primaries;
-};
-
-static GSList *gattrib_list = NULL;
-
 struct cached_sdp_session {
 	bdaddr_t src;
 	bdaddr_t dst;
@@ -69,22 +53,6 @@ struct cached_sdp_session {
 
 static GSList *cached_sdp_sessions = NULL;
 
-static void gattrib_context_free(struct gattrib_context *ctxt)
-{
-	gattrib_list = g_slist_remove(gattrib_list, ctxt);
-	if (ctxt->destroy)
-		ctxt->destroy(ctxt->user_data);
-
-	g_slist_free(ctxt->primaries);
-	g_attrib_unref(ctxt->attrib);
-	if (ctxt->io) {
-		g_io_channel_unref(ctxt->io);
-		g_io_channel_shutdown(ctxt->io, FALSE, NULL);
-	}
-
-	g_free(ctxt);
-}
-
 static gboolean cached_session_expired(gpointer user_data)
 {
 	struct cached_sdp_session *cached = user_data;
@@ -370,16 +338,22 @@ static gint find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 					bacmp(&ctxt->src, &search->src));
 }
 
-static gint gattrib_find_by_bdaddr(gconstpointer data, gconstpointer user_data)
+int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
 {
-	const struct gattrib_context *ctxt = data, *search = user_data;
+	struct search_context match, *ctxt;
+	GSList *l;
 
-	return (bacmp(&ctxt->dst, &search->dst) &&
-					bacmp(&ctxt->src, &search->src));
-}
+	memset(&match, 0, sizeof(match));
+	bacpy(&match.src, src);
+	bacpy(&match.dst, dst);
+
+	/* Ongoing SDP Discovery */
+	l = g_slist_find_custom(context_list, &match, find_by_bdaddr);
+	if (l == NULL)
+		return -ENOENT;
+
+	ctxt = l->data;
 
-static int cancel_sdp(struct search_context *ctxt)
-{
 	if (!ctxt->session)
 		return -ENOTCONN;
 
@@ -394,178 +368,6 @@ static int cancel_sdp(struct search_context *ctxt)
 	return 0;
 }
 
-static int cancel_gattrib(struct gattrib_context *ctxt)
-{
-	if (ctxt->attrib)
-		g_attrib_cancel_all(ctxt->attrib);
-
-	gattrib_context_free(ctxt);
-
-	return 0;
-}
-
-int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
-{
-	struct search_context sdp_ctxt;
-	struct gattrib_context gatt_ctxt;
-	GSList *match;
-
-	memset(&sdp_ctxt, 0, sizeof(sdp_ctxt));
-	bacpy(&sdp_ctxt.src, src);
-	bacpy(&sdp_ctxt.dst, dst);
-
-	/* Ongoing SDP Discovery */
-	match = g_slist_find_custom(context_list, &sdp_ctxt, find_by_bdaddr);
-	if (match)
-		return cancel_sdp(match->data);
-
-	memset(&gatt_ctxt, 0, sizeof(gatt_ctxt));
-	bacpy(&gatt_ctxt.src, src);
-	bacpy(&gatt_ctxt.dst, dst);
-
-	/* Ongoing Discover All Primary Services */
-	match = g_slist_find_custom(gattrib_list, &gatt_ctxt,
-						gattrib_find_by_bdaddr);
-	if (match == NULL)
-		return -ENOTCONN;
-
-	return cancel_gattrib(match->data);
-}
-
-static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gattrib_context *ctxt = user_data;
-	struct att_data_list *list;
-	unsigned int i, err;
-	uint16_t start, end;
-
-	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
-		err = 0;
-		goto done;
-	}
-
-	if (status != 0) {
-		err = -EIO;
-		goto done;
-	}
-
-	list = dec_read_by_grp_resp(pdu, plen);
-	if (list == NULL) {
-		err = -EPROTO;
-		goto done;
-	}
-
-	for (i = 0, end = 0; i < list->num; i++) {
-		const uint8_t *data = list->data[i];
-		struct att_primary *primary;
-		uuid_t u128, u16;
-
-		start = att_get_u16(&data[0]);
-		end = att_get_u16(&data[2]);
-
-		if (list->len == 6) {
-			sdp_uuid16_create(&u16,
-					att_get_u16(&data[4]));
-			sdp_uuid16_to_uuid128(&u128, &u16);
-
-		} else if (list->len == 20)
-			sdp_uuid128_create(&u128, &data[4]);
-		else
-			/* Skipping invalid data */
-			continue;
-
-		primary = g_try_new0(struct att_primary, 1);
-		if (!primary) {
-			err = -ENOMEM;
-			goto done;
-		}
-		primary->start = start;
-		primary->end = end;
-		sdp_uuid2strn(&u128, primary->uuid, sizeof(primary->uuid));
-		ctxt->primaries = g_slist_append(ctxt->primaries, primary);
-	}
-
-	att_data_list_free(list);
-	err = 0;
-
-	if (end != 0xffff) {
-		gatt_discover_primary(ctxt->attrib, end + 1, 0xffff, NULL,
-							primary_cb, ctxt);
-		return;
-	}
-
-done:
-	ctxt->cb(ctxt->primaries, err, ctxt->user_data);
-	gattrib_context_free(ctxt);
-}
-
-static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
-{
-	struct gattrib_context *ctxt = user_data;
-
-	if (gerr) {
-		ctxt->cb(NULL, -EIO, ctxt->user_data);
-		gattrib_context_free(ctxt);
-		return;
-	}
-
-	ctxt->attrib = g_attrib_new(io);
-	gatt_discover_primary(ctxt->attrib, 0x0001, 0xffff, NULL, primary_cb,
-									ctxt);
-}
-
-int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
-					bt_primary_t cb, void *user_data,
-					gboolean secure,
-					bt_destroy_t destroy)
-{
-	struct gattrib_context *ctxt;
-	BtIOSecLevel sec_level;
-	GIOChannel *io;
-
-	ctxt = g_try_new0(struct gattrib_context, 1);
-	if (ctxt == NULL)
-		return -ENOMEM;
-
-	bacpy(&ctxt->src, src);
-	bacpy(&ctxt->dst, dst);
-	ctxt->user_data = user_data;
-	ctxt->cb = cb;
-	ctxt->destroy = destroy;
-
-	if (secure == TRUE)
-		sec_level = BT_IO_SEC_HIGH;
-	else
-		sec_level = BT_IO_SEC_LOW;
-
-	if (psm < 0)
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, NULL,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR, dst,
-				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-	else
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, NULL,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR, dst,
-				BT_IO_OPT_PSM, psm,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-
-	if (io == NULL) {
-		gattrib_context_free(ctxt);
-		return -EIO;
-	}
-
-	ctxt->io = io;
-
-	gattrib_list = g_slist_append(gattrib_list, ctxt);
-
-	return 0;
-}
-
 char *bt_uuid2string(uuid_t *uuid)
 {
 	gchar *str;
diff --git a/src/glib-helper.h b/src/glib-helper.h
index 25fe276..c83f5e2 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -22,7 +22,6 @@
  */
 
 typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
-typedef void (*bt_primary_t) (GSList *l, int err, gpointer user_data);
 typedef void (*bt_destroy_t) (gpointer user_data);
 
 int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
@@ -30,11 +29,6 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			bt_destroy_t destroy);
 int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst);
 
-int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
-					bt_primary_t cb, void *user_data,
-					gboolean secure,
-					bt_destroy_t destroy);
-
 gchar *bt_uuid2string(uuid_t *uuid);
 char *bt_name2string(const char *string);
 int bt_string2uuid(uuid_t *uuid, const char *string);
-- 
1.7.4.rc1

