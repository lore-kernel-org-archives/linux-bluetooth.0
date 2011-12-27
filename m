Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 8/8] attrib-server: Add Gattrib in attrib_channel_detach function
Date: Tue, 27 Dec 2011 10:29:42 +0100
Message-Id: <1324978182-5707-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1324978182-5707-8-git-send-email-sancane@gmail.com>
References: <1324978182-5707-1-git-send-email-sancane@gmail.com>
 <1324978182-5707-2-git-send-email-sancane@gmail.com>
 <1324978182-5707-3-git-send-email-sancane@gmail.com>
 <1324978182-5707-4-git-send-email-sancane@gmail.com>
 <1324978182-5707-5-git-send-email-sancane@gmail.com>
 <1324978182-5707-6-git-send-email-sancane@gmail.com>
 <1324978182-5707-7-git-send-email-sancane@gmail.com>
 <1324978182-5707-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   39 +++++++++++++++------------------------
 src/attrib-server.h |    2 +-
 src/device.c        |    6 +++---
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 929a505..8cdb5b7 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -180,27 +180,6 @@ static struct gatt_adapter *find_gatt_adapter(const bdaddr_t *bdaddr)
 	return l->data;
 }
 
-static struct gatt_adapter *get_default_gatt_adapter(void)
-{
-	struct btd_adapter *adapter;
-	GSList *l;
-
-	adapter = manager_get_default_adapter();
-	if (adapter == NULL) {
-		error("Can't get default adapter");
-		return NULL;
-	}
-
-	l = g_slist_find_custom(adapters, adapter, adapter_cmp);
-	if (l == NULL) {
-		error("Not GATT server initialized on adapter %s",
-						adapter_get_path(adapter));
-		return NULL;
-	}
-
-	return l->data;
-}
-
 static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
@@ -1080,15 +1059,27 @@ static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
 	return channel->id - id;
 }
 
-gboolean attrib_channel_detach(guint id)
+gboolean attrib_channel_detach(GAttrib *attrib, guint id)
 {
 	struct gatt_adapter *gadapter;
 	struct gatt_channel *channel;
+	GError *gerr = NULL;
+	GIOChannel *io;
+	bdaddr_t src;
 	GSList *l;
 
-	DBG("Deprecated function");
+	io = g_attrib_get_channel(attrib);
+
+	bt_io_get(io, BT_IO_L2CAP, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+							BT_IO_OPT_INVALID);
+
+	if (gerr != NULL) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		return FALSE;
+	}
 
-	gadapter = get_default_gatt_adapter();
+	gadapter = find_gatt_adapter(&src);
 	if (gadapter == NULL)
 		return FALSE;
 
diff --git a/src/attrib-server.h b/src/attrib-server.h
index dc08bfb..2c6f428 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -36,4 +36,4 @@ uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 							const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
 guint attrib_channel_attach(GAttrib *attrib, gboolean out);
-gboolean attrib_channel_detach(guint id);
+gboolean attrib_channel_detach(GAttrib *attrib, guint id);
diff --git a/src/device.c b/src/device.c
index bb97089..5be3fc5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1725,7 +1725,7 @@ static void attrib_disconnected(gpointer user_data)
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
-	attrib_channel_detach(device->attachid);
+	attrib_channel_detach(device->attrib, device->attachid);
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
 
@@ -1774,7 +1774,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_probe_drivers(device, uuids);
 
 	if (device->attios == NULL && device->attios_offline == NULL) {
-		attrib_channel_detach(device->attachid);
+		attrib_channel_detach(device->attrib, device->attachid);
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
 	} else
@@ -2869,7 +2869,7 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 		return TRUE;
 
 	if (device->attachid) {
-		attrib_channel_detach(device->attachid);
+		attrib_channel_detach(device->attrib, device->attachid);
 		device->attachid = 0;
 	}
 
-- 
1.7.8.1

