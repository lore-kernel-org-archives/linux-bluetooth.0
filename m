Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/4] Minor cleanup in attrib server channel disconnect
Date: Mon, 19 Sep 2011 10:20:02 -0300
Message-Id: <1316438402-9982-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 1d96221..9c10467 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -776,12 +776,8 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
-static void channel_disconnect(void *user_data)
+static void channel_free(struct gatt_channel *channel)
 {
-	struct gatt_channel *channel = user_data;
-
-	clients = g_slist_remove(clients, channel);
-
 	g_slist_free(channel->notify);
 	g_slist_free(channel->indicate);
 	g_slist_free_full(channel->configs, g_free);
@@ -790,6 +786,14 @@ static void channel_disconnect(void *user_data)
 	g_free(channel);
 }
 
+static void channel_disconnect(void *user_data)
+{
+	struct gatt_channel *channel = user_data;
+
+	clients = g_slist_remove(clients, channel);
+	channel_free(channel);
+}
+
 static void channel_handler(const uint8_t *ipdu, uint16_t len,
 							gpointer user_data)
 {
@@ -1174,8 +1178,6 @@ static void attrib_free(void *data)
 
 void attrib_server_exit(void)
 {
-	GSList *l;
-
 	g_slist_free_full(database, attrib_free);
 
 	if (l2cap_io) {
@@ -1188,18 +1190,7 @@ void attrib_server_exit(void)
 		g_io_channel_shutdown(le_io, FALSE, NULL);
 	}
 
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
-		g_slist_free(channel->notify);
-		g_slist_free(channel->indicate);
-		g_slist_free_full(channel->configs, g_free);
-
-		g_attrib_unref(channel->attrib);
-		g_free(channel);
-	}
-
-	g_slist_free(clients);
+	g_slist_free_full(clients, (GDestroyNotify) channel_free);
 
 	if (gatt_sdp_handle)
 		remove_record_from_server(gatt_sdp_handle);
-- 
1.7.6.1

