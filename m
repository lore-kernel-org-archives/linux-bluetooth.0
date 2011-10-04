Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/4] Minor cleanup in attrib server channel disconnect
Date: Tue,  4 Oct 2011 14:52:23 -0300
Message-Id: <1317750743-22632-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1316438402-9982-4-git-send-email-claudio.takahasi@openbossa.org>
References: <1316438402-9982-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5a50ade..95efd9f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -783,12 +783,8 @@ static void attrib_free(void *data)
 	g_free(a);
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
 	g_slist_free_full(channel->configs, attrib_free);
@@ -797,6 +793,14 @@ static void channel_disconnect(void *user_data)
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
@@ -1173,8 +1177,6 @@ failed:
 
 void attrib_server_exit(void)
 {
-	GSList *l;
-
 	g_slist_free_full(database, attrib_free);
 
 	if (l2cap_io) {
@@ -1187,18 +1189,7 @@ void attrib_server_exit(void)
 		g_io_channel_shutdown(le_io, FALSE, NULL);
 	}
 
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
-		g_slist_free(channel->notify);
-		g_slist_free(channel->indicate);
-		g_slist_free_full(channel->configs, attrib_free);
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
1.7.7

