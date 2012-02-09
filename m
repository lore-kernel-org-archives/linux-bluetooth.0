Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/7] attrib-server: Remove GAttrib disconnect callback
Date: Thu,  9 Feb 2012 12:56:06 -0300
Message-Id: <1328802969-20244-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the usage of GAttrib disconnection callback by
GIOChannel watch to track ATTIO channel disconnection aiming to achieve
less dependencies between attrib server, device and GAttrib.
---
 src/attrib-server.c |   30 +++++++++++++++++++-----------
 src/attrib-server.h |    2 +-
 src/device.c        |    2 +-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 93a7b4f..5137bdc 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -75,6 +75,7 @@ struct gatt_channel {
 	guint id;
 	gboolean encrypted;
 	struct gatt_server *server;
+	guint cleanup_id;
 };
 
 struct group_elem {
@@ -107,8 +108,11 @@ static void attrib_free(void *data)
 
 static void channel_free(struct gatt_channel *channel)
 {
-	g_attrib_unref(channel->attrib);
 
+	if (channel->cleanup_id)
+		g_source_remove(channel->cleanup_id);
+
+	g_attrib_unref(channel->attrib);
 	g_free(channel);
 }
 
@@ -859,15 +863,21 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
-static void channel_disconnect(void *user_data)
+static void channel_remove(struct gatt_channel *channel)
 {
-	struct gatt_channel *channel = user_data;
-
 	channel->server->clients = g_slist_remove(channel->server->clients,
 								channel);
 	channel_free(channel);
 }
 
+static gboolean channel_watch_cb(GIOChannel *io, GIOCondition cond,
+						gpointer user_data)
+{
+	channel_remove(user_data);
+
+	return FALSE;
+}
+
 static void channel_handler(const uint8_t *ipdu, uint16_t len,
 							gpointer user_data)
 {
@@ -992,7 +1002,7 @@ done:
 							NULL, NULL, NULL);
 }
 
-guint attrib_channel_attach(GAttrib *attrib, gboolean out)
+guint attrib_channel_attach(GAttrib *attrib)
 {
 	struct gatt_server *server;
 	struct btd_device *device;
@@ -1050,9 +1060,8 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
 					channel_handler, channel, NULL);
 
-	if (out == FALSE)
-		g_attrib_set_disconnect_function(channel->attrib,
-						channel_disconnect, channel);
+	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
+								channel);
 
 	server->clients = g_slist_append(server->clients, channel);
 
@@ -1099,8 +1108,7 @@ gboolean attrib_channel_detach(GAttrib *attrib, guint id)
 	channel = l->data;
 
 	g_attrib_unregister(channel->attrib, channel->id);
-
-	channel_disconnect(channel);
+	channel_remove(channel);
 
 	return TRUE;
 }
@@ -1115,7 +1123,7 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 	}
 
 	attrib = g_attrib_new(io);
-	attrib_channel_attach(attrib, FALSE);
+	attrib_channel_attach(attrib);
 	g_io_channel_unref(io);
 	g_attrib_unref(attrib);
 }
diff --git a/src/attrib-server.h b/src/attrib-server.h
index fb4637c..7af0cfa 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -36,5 +36,5 @@ int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 							const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
-guint attrib_channel_attach(GAttrib *attrib, gboolean out);
+guint attrib_channel_attach(GAttrib *attrib);
 gboolean attrib_channel_detach(GAttrib *attrib, guint id);
diff --git a/src/device.c b/src/device.c
index 2502906..288d327 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1835,7 +1835,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	attrib = g_attrib_new(io);
-	device->attachid = attrib_channel_attach(attrib, TRUE);
+	device->attachid = attrib_channel_attach(attrib);
 	if (device->attachid == 0)
 		error("Attribute server attach failure!");
 
-- 
1.7.8.4

