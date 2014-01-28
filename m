Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 1/3] attrib-server: Remove unnecessary fields from struct gatt_channel
Date: Tue, 28 Jan 2014 11:51:36 -0400
Message-Id: <1390924298-13804-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These fields are only used internally by attrib_channel_attach(). The
"No GATT server found..." error message was also removed as it is also
displayed by find_gatt_server().
---
 src/attrib-server.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 1c088df..13b86e1 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -71,8 +71,6 @@ struct gatt_server {
 };
 
 struct gatt_channel {
-	bdaddr_t src;
-	bdaddr_t dst;
 	GAttrib *attrib;
 	guint mtu;
 	gboolean le;
@@ -1107,6 +1105,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 	struct gatt_server *server;
 	struct btd_device *device;
 	struct gatt_channel *channel;
+	bdaddr_t src, dst;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	uint16_t cid;
@@ -1114,34 +1113,26 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 	io = g_attrib_get_channel(attrib);
 
-	channel = g_new0(struct gatt_channel, 1);
-
 	bt_io_get(io, &gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &channel->src,
-			BT_IO_OPT_DEST_BDADDR, &channel->dst,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_CID, &cid,
 			BT_IO_OPT_IMTU, &mtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
 		g_error_free(gerr);
-		g_free(channel);
 		return 0;
 	}
 
-	server = find_gatt_server(&channel->src);
-	if (server == NULL) {
-		char src[18];
-
-		ba2str(&channel->src, src);
-		error("No GATT server found in %s", src);
-		g_free(channel);
+	server = find_gatt_server(&src);
+	if (server == NULL)
 		return 0;
-	}
 
+	channel = g_new0(struct gatt_channel, 1);
 	channel->server = server;
 
-	device = btd_adapter_find_device(server->adapter, &channel->dst);
+	device = btd_adapter_find_device(server->adapter, &dst);
 	if (device == NULL) {
 		error("Device object not found for attrib server");
 		g_free(channel);
-- 
1.8.3.2

