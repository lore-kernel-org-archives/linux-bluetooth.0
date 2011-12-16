Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 04/11] attrib-server: Attach attrib_channel in adapter clients list
Date: Fri, 16 Dec 2011 17:09:52 +0100
Message-Id: <1324051799-21439-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-4-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch attaches attribute channels to the adapter list instead
of using the global client list.
---
 src/attrib-server.c |   44 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index b2f0edb..751091e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -146,6 +146,17 @@ static void free_gatt_adapter(struct gatt_adapter *gatt_adapter)
 	g_free(gatt_adapter);
 }
 
+static gint adapter_cmp_addr(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_adapter *gatt_adapter = a;
+	const bdaddr_t *bdaddr = b;
+	bdaddr_t src;
+
+	adapter_get_address(gatt_adapter->adapter, &src);
+
+	return bacmp(&src, bdaddr);
+}
+
 static gint adapter_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_adapter *gatt_adapter = a;
@@ -157,6 +168,22 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
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
 	struct gatt_adapter *gatt_adapter;
@@ -852,8 +879,13 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 static void channel_disconnect(void *user_data)
 {
 	struct gatt_channel *channel = user_data;
+	struct gatt_adapter *gatt_adapter;
+
+	gatt_adapter = find_gatt_adapter(&channel->src);
+	if (gatt_adapter == NULL)
+		return;
 
-	clients = g_slist_remove(clients, channel);
+	gatt_adapter->clients = g_slist_remove(gatt_adapter->clients, channel);
 	channel_free(channel);
 }
 
@@ -983,7 +1015,7 @@ done:
 
 guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 {
-	struct btd_adapter *adapter;
+	struct gatt_adapter *gatt_adapter;
 	struct btd_device *device;
 	struct gatt_channel *channel;
 	GIOChannel *io;
@@ -1008,10 +1040,12 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		return 0;
 	}
 
-	adapter = manager_find_adapter(&channel->src);
+	gatt_adapter = find_gatt_adapter(&channel->src);
+	if (gatt_adapter == NULL)
+		return 0;
 
 	ba2str(&channel->dst, addr);
-	device = adapter_find_device(adapter, addr);
+	device = adapter_find_device(gatt_adapter->adapter, addr);
 
 	if (device_is_bonded(device) == FALSE)
 		delete_device_ccc(&channel->src, &channel->dst);
@@ -1033,7 +1067,7 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		g_attrib_set_disconnect_function(channel->attrib,
 						channel_disconnect, channel);
 
-	clients = g_slist_append(clients, channel);
+	gatt_adapter->clients = g_slist_append(gatt_adapter->clients, channel);
 
 	return channel->id;
 }
-- 
1.7.8

