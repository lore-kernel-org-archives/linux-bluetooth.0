Return-Path: <cyrus@holtmann.org>
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>
Subject: [PATCH] attrib-server: Fix multiple channels detaching mix-up
Date: Tue, 29 May 2012 23:20:08 +0300
Message-Id: <1338322808-15503-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The identifier returned by g_attrib_register is not unique across
different channels. Since attrib_channel_detach assumes this identifier
to be unique, it may end up detaching the wrong channel when a device
disconnects.

Fix this by using the channel's pointer as a unique identifier for
detaching the channel. The identifier returned from g_attrib_register
will still be used to find the relevant event structure.
---
 src/attrib-server.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index dd1bba4..39085de 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -72,7 +72,7 @@ struct gatt_channel {
 	GAttrib *attrib;
 	guint mtu;
 	gboolean le;
-	guint id;
+	guint event_id;
 	gboolean encrypted;
 	struct gatt_server *server;
 	guint cleanup_id;
@@ -1077,8 +1077,8 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 
 	channel->attrib = g_attrib_ref(attrib);
-	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
-					channel_handler, channel, NULL);
+	channel->event_id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
+						channel_handler, channel, NULL);
 
 	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
 								channel);
@@ -1087,15 +1087,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 	server->clients = g_slist_append(server->clients, channel);
 
-	return channel->id;
-}
-
-static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
-{
-	const struct gatt_channel *channel = data;
-	guint id = GPOINTER_TO_UINT(user_data);
-
-	return channel->id - id;
+	return GPOINTER_TO_UINT(channel);
 }
 
 gboolean attrib_channel_detach(GAttrib *attrib, guint id)
@@ -1122,14 +1114,14 @@ gboolean attrib_channel_detach(GAttrib *attrib, guint id)
 	if (server == NULL)
 		return FALSE;
 
-	l = g_slist_find_custom(server->clients, GUINT_TO_POINTER(id),
-								channel_id_cmp);
+	/* Make sure the channel was not already freed */
+	l = g_slist_find(server->clients, GUINT_TO_POINTER(id));
 	if (!l)
 		return FALSE;
 
 	channel = l->data;
 
-	g_attrib_unregister(channel->attrib, channel->id);
+	g_attrib_unregister(channel->attrib, channel->event_id);
 	channel_remove(channel);
 
 	return TRUE;
-- 
1.7.7.6

