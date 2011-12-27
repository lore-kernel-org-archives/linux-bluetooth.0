Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/8] attrib-server: Attach attrib_channel in adapter clients list
Date: Tue, 27 Dec 2011 15:33:15 +0100
Message-Id: <1324996399-20245-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1324996399-20245-4-git-send-email-sancane@gmail.com>
References: <1324996399-20245-1-git-send-email-sancane@gmail.com>
 <1324996399-20245-2-git-send-email-sancane@gmail.com>
 <1324996399-20245-3-git-send-email-sancane@gmail.com>
 <1324996399-20245-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch attaches attribute channels to the gatt server list
instead of using the global client list. Furthermore, we use the
GATT server started in the default adapter when attrib_channel_detach
is invoked in order to keep backward compatibility until the interface
is updated to accept the adapter too.
---
 src/attrib-server.c |   74 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2e3e6f2..a04964e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -62,6 +62,7 @@ struct gatt_server {
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
+	struct gatt_server *server;
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
 static void gatt_server_free(struct gatt_server *server)
 {
 	g_slist_free_full(server->database, attrib_free);
@@ -123,6 +131,8 @@ static void gatt_server_free(struct gatt_server *server)
 		g_io_channel_shutdown(server->le_io, FALSE, NULL);
 	}
 
+	g_slist_free_full(server->clients, (GDestroyNotify) channel_free);
+
 	if (server->gatt_sdp_handle > 0)
 		remove_record_from_server(server->gatt_sdp_handle);
 
@@ -135,6 +145,17 @@ static void gatt_server_free(struct gatt_server *server)
 	g_free(server);
 }
 
+static gint adapter_cmp_addr(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_server *server = a;
+	const bdaddr_t *bdaddr = b;
+	bdaddr_t src;
+
+	adapter_get_address(server->adapter, &src);
+
+	return bacmp(&src, bdaddr);
+}
+
 static gint adapter_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_server *server = a;
@@ -146,6 +167,22 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static struct gatt_server *find_gatt_server(const bdaddr_t *bdaddr)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(servers, bdaddr, adapter_cmp_addr);
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
 static struct gatt_server *get_default_gatt_server(void)
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
+	channel->server->clients = g_slist_remove(channel->server->clients,
+								channel);
 	channel_free(channel);
 }
 
@@ -975,7 +1006,7 @@ done:
 
 guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 {
-	struct btd_adapter *adapter;
+	struct gatt_server *server;
 	struct btd_device *device;
 	struct gatt_channel *channel;
 	GIOChannel *io;
@@ -1000,10 +1031,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		return 0;
 	}
 
-	adapter = manager_find_adapter(&channel->src);
+	server = find_gatt_server(&channel->src);
+	if (server == NULL)
+		return 0;
+
+	channel->server = server;
 
 	ba2str(&channel->dst, addr);
-	device = adapter_find_device(adapter, addr);
+	device = adapter_find_device(server->adapter, addr);
 
 	if (device_is_bonded(device) == FALSE)
 		delete_device_ccc(&channel->src, &channel->dst);
@@ -1025,7 +1060,7 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		g_attrib_set_disconnect_function(channel->attrib,
 						channel_disconnect, channel);
 
-	clients = g_slist_append(clients, channel);
+	server->clients = g_slist_append(server->clients, channel);
 
 	return channel->id;
 }
@@ -1040,11 +1075,18 @@ static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
 
 gboolean attrib_channel_detach(guint id)
 {
+	struct gatt_server *server;
 	struct gatt_channel *channel;
 	GSList *l;
 
-	l = g_slist_find_custom(clients, GUINT_TO_POINTER(id),
-						channel_id_cmp);
+	DBG("Deprecated function");
+
+	server = get_default_gatt_server();
+	if (server == NULL)
+		return FALSE;
+
+	l = g_slist_find_custom(server->clients, GUINT_TO_POINTER(id),
+								channel_id_cmp);
 	if (!l)
 		return FALSE;
 
@@ -1215,8 +1257,6 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 	gatt_server_free(server);
 
 	g_slist_free_full(database, attrib_free);
-
-	g_slist_free_full(clients, (GDestroyNotify) channel_free);
 }
 
 uint32_t attrib_create_sdp(uint16_t handle, const char *name)
-- 
1.7.8.1

