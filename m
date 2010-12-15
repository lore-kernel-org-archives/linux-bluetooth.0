Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/5] Implement cancel primary discovery session
Date: Wed, 15 Dec 2010 16:54:08 -0300
Message-Id: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extend bt_cancel_discovery function to cancel an ongoing Discover
All Primary Services procedure.
---
 src/device.c      |   11 +++----
 src/glib-helper.c |   73 ++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/src/device.c b/src/device.c
index cec2153..d20a6d4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -186,8 +186,7 @@ static void browse_request_cancel(struct browse_req *req)
 
 	adapter_get_address(adapter, &src);
 
-	if (device->type != DEVICE_TYPE_LE)
-		bt_cancel_discovery(&src, &device->bdaddr);
+	bt_cancel_discovery(&src, &device->bdaddr);
 
 	device->browse = NULL;
 	browse_request_free(req);
@@ -1530,11 +1529,11 @@ static void primary_cb(GSList *services, int err, gpointer user_data)
 		goto done;
 	}
 
-	services_changed(req->device);
-	device_set_temporary(req->device, FALSE);
-	device_probe_drivers(req->device, services);
+	services_changed(device);
+	device_set_temporary(device, FALSE);
+	device_probe_drivers(device, services);
 
-	create_device_reply(req->device, req);
+	create_device_reply(device, req);
 
 done:
 	device->browse = NULL;
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 8181f4d..6505249 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -51,12 +51,15 @@ struct gattrib_context {
 	bdaddr_t src;
 	bdaddr_t dst;
 	GAttrib *attrib;
+	GIOChannel *io;
 	bt_primary_t cb;
 	bt_destroy_t destroy;
 	gpointer user_data;
 	GSList *uuids;
 };
 
+static GSList *gattrib_list = NULL;
+
 struct cached_sdp_session {
 	bdaddr_t src;
 	bdaddr_t dst;
@@ -68,12 +71,18 @@ static GSList *cached_sdp_sessions = NULL;
 
 static void gattrib_context_free(struct gattrib_context *ctxt)
 {
+	gattrib_list = g_slist_remove(gattrib_list, ctxt);
 	if (ctxt->destroy)
 		ctxt->destroy(ctxt->user_data);
 
 	g_slist_foreach(ctxt->uuids, (GFunc) g_free, NULL);
 	g_slist_free(ctxt->uuids);
 	g_attrib_unref(ctxt->attrib);
+	if (ctxt->io) {
+		g_io_channel_unref(ctxt->io);
+		g_io_channel_shutdown(ctxt->io, FALSE, NULL);
+	}
+
 	g_free(ctxt);
 }
 
@@ -138,7 +147,6 @@ struct search_context {
 	bdaddr_t		dst;
 	sdp_session_t		*session;
 	bt_callback_t		cb;
-	bt_primary_t		prim_cb;
 	bt_destroy_t		destroy;
 	gpointer		user_data;
 	uuid_t			uuid;
@@ -373,21 +381,16 @@ static gint find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 					bacmp(&ctxt->src, &search->src));
 }
 
-int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
+static gint gattrib_find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 {
-	struct search_context search, *ctxt;
-	GSList *match;
+	const struct gattrib_context *ctxt = data, *search = user_data;
 
-	memset(&search, 0, sizeof(search));
-	bacpy(&search.src, src);
-	bacpy(&search.dst, dst);
-
-	/* Ongoing SDP Discovery */
-	match = g_slist_find_custom(context_list, &search, find_by_bdaddr);
-	if (!match)
-		return -ENODATA;
+	return (bacmp(&ctxt->dst, &search->dst) &&
+					bacmp(&ctxt->src, &search->src));
+}
 
-	ctxt = match->data;
+static int cancel_sdp(struct search_context *ctxt)
+{
 	if (!ctxt->session)
 		return -ENOTCONN;
 
@@ -398,9 +401,48 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
 		sdp_close(ctxt->session);
 
 	search_context_cleanup(ctxt);
+
+	return 0;
+}
+
+static int cancel_gattrib(struct gattrib_context *ctxt)
+{
+	if (ctxt->attrib)
+		g_attrib_cancel_all(ctxt->attrib);
+
+	gattrib_context_free(ctxt);
+
 	return 0;
 }
 
+int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
+{
+	struct search_context sdp_ctxt;
+	struct gattrib_context gatt_ctxt;
+	GSList *match;
+
+	memset(&sdp_ctxt, 0, sizeof(sdp_ctxt));
+	bacpy(&sdp_ctxt.src, src);
+	bacpy(&sdp_ctxt.dst, dst);
+
+	/* Ongoing SDP Discovery */
+	match = g_slist_find_custom(context_list, &sdp_ctxt, find_by_bdaddr);
+	if (match)
+		return cancel_sdp(match->data);
+
+	memset(&gatt_ctxt, 0, sizeof(gatt_ctxt));
+	bacpy(&gatt_ctxt.src, src);
+	bacpy(&gatt_ctxt.dst, dst);
+
+	/* Ongoing Discover All Primary Services */
+	match = g_slist_find_custom(gattrib_list, &gatt_ctxt,
+						gattrib_find_by_bdaddr);
+	if (match == NULL)
+		return -ENOTCONN;
+
+	return cancel_gattrib(match->data);
+}
+
 static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -471,6 +513,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		return;
 	}
 
+	ctxt->attrib = g_attrib_new(io);
 	gatt_discover_primary(ctxt->attrib, 0x0001, 0xffff, NULL, primary_cb,
 									ctxt);
 }
@@ -513,9 +556,9 @@ int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 		return -EIO;
 	}
 
-	ctxt->attrib = g_attrib_new(io);
+	ctxt->io = io;
 
-	g_io_channel_unref(io);
+	gattrib_list = g_slist_append(gattrib_list, ctxt);
 
 	return 0;
 }
-- 
1.7.3.3

