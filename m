Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/8] attrib-server: Attach attrib_channel in adapter clients list
Date: Tue, 20 Dec 2011 16:57:57 +0100
Message-Id: <1324396681-27276-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1324396681-27276-4-git-send-email-sancane@gmail.com>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
 <1324396681-27276-2-git-send-email-sancane@gmail.com>
 <1324396681-27276-3-git-send-email-sancane@gmail.com>
 <1324396681-27276-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch attaches attribute channels to the adapter list instead
of using the global client list. Furthermore, we use the default
adapter when attrib_channel_detach is invoked in order to keep
backward compatibility until the interface is updated to accept
the adapter too.
---
 src/attrib-server.c |   74 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index c9b7796..8681652 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -62,6 +62,7 @@ struct gatt_adapter {
 	uint32_t gatt_sdp_handle;
 	uint32_t gap_sdp_handle;
 	GSList *database;
+	GSList *clients;
 };
 
 struct gatt_channel {
@@ -72,6 +73,7 @@ struct gatt_channel {
 	gboolean le;
 	guint id;
 	gboolean encrypted;
+	struct gatt_adapter *gadapter;
 };
 
 struct group_elem {
@@ -82,7 +84,6 @@ struct group_elem {
 };
 
 static GIOChannel *le_io = NULL;
-static GSList *clients = NULL;
 
 /* GAP attribute handles */
 static uint16_t name_handle = 0x0000;
@@ -109,6 +110,13 @@ static void attrib_free(void *data)
 	g_free(a);
 }
 
+static void channel_free(struct gatt_channel *channel)
+{
+	g_attrib_unref(channel->attrib);
+
+	g_free(channel);
+}
+
 static void gatt_adapter_free(struct gatt_adapter *gadapter)
 {
 	g_slist_free_full(gadapter->database, attrib_free);
@@ -123,6 +131,8 @@ static void gatt_adapter_free(struct gatt_adapter *gadapter)
 		g_io_channel_shutdown(gadapter->le_io, FALSE, NULL);
 	}
 
+	g_slist_free_full(gadapter->clients, (GDestroyNotify) channel_free);
+
 	if (gadapter->gatt_sdp_handle > 0)
 		remove_record_from_server(gadapter->gatt_sdp_handle);
 
@@ -135,6 +145,17 @@ static void gatt_adapter_free(struct gatt_adapter *gadapter)
 	g_free(gadapter);
 }
 
+static gint adapter_cmp_addr(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_adapter *gadapter = a;
+	const bdaddr_t *bdaddr = b;
+	bdaddr_t src;
+
+	adapter_get_address(gadapter->adapter, &src);
+
+	return bacmp(&src, bdaddr);
+}
+
 static gint adapter_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_adapter *gatt_adapter = a;
@@ -146,6 +167,22 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static struct gatt_adapter *find_gatt_adapter(const bdaddr_t *bdaddr)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(adapters, bdaddr, adapter_cmp_addr);
+	if (l == NULL) {
+		char addr[18];
+
+		ba2str(bdaddr, addr);
+		error("Not GATT adapter found for address %s", addr);
+		return NULL;
+	}
+
+	return l->data;
+}
+
 static struct gatt_adapter *get_default_gatt_adapter(void)
 {
 	struct btd_adapter *adapter;
@@ -834,18 +871,12 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
-static void channel_free(struct gatt_channel *channel)
-{
-	g_attrib_unref(channel->attrib);
-
-	g_free(channel);
-}
-
 static void channel_disconnect(void *user_data)
 {
 	struct gatt_channel *channel = user_data;
 
-	clients = g_slist_remove(clients, channel);
+	channel->gadapter->clients = g_slist_remove(channel->gadapter->clients,
+								channel);
 	channel_free(channel);
 }
 
@@ -975,7 +1006,7 @@ done:
 
 guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 {
-	struct btd_adapter *adapter;
+	struct gatt_adapter *gadapter;
 	struct btd_device *device;
 	struct gatt_channel *channel;
 	GIOChannel *io;
@@ -1000,10 +1031,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		return 0;
 	}
 
-	adapter = manager_find_adapter(&channel->src);
+	gadapter = find_gatt_adapter(&channel->src);
+	if (gadapter == NULL)
+		return 0;
+
+	channel->gadapter = gadapter;
 
 	ba2str(&channel->dst, addr);
-	device = adapter_find_device(adapter, addr);
+	device = adapter_find_device(gadapter->adapter, addr);
 
 	if (device_is_bonded(device) == FALSE)
 		delete_device_ccc(&channel->src, &channel->dst);
@@ -1025,7 +1060,7 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		g_attrib_set_disconnect_function(channel->attrib,
 						channel_disconnect, channel);
 
-	clients = g_slist_append(clients, channel);
+	gadapter->clients = g_slist_append(gadapter->clients, channel);
 
 	return channel->id;
 }
@@ -1040,11 +1075,18 @@ static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
 
 gboolean attrib_channel_detach(guint id)
 {
+	struct gatt_adapter *gadapter;
 	struct gatt_channel *channel;
 	GSList *l;
 
-	l = g_slist_find_custom(clients, GUINT_TO_POINTER(id),
-						channel_id_cmp);
+	DBG("Deprecated function");
+
+	gadapter = get_default_gatt_adapter();
+	if (gadapter == NULL)
+		return FALSE;
+
+	l = g_slist_find_custom(gadapter->clients, GUINT_TO_POINTER(id),
+								channel_id_cmp);
 	if (!l)
 		return FALSE;
 
@@ -1215,8 +1257,6 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 	gatt_adapter_free(gadapter);
 
 	g_slist_free_full(database, attrib_free);
-
-	g_slist_free_full(clients, (GDestroyNotify) channel_free);
 }
 
 uint32_t attrib_create_sdp(uint16_t handle, const char *name)
-- 
1.7.8

