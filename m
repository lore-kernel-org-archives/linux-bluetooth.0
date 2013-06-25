Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 05/16] input: Use btd_server userdata for input_server
Date: Tue, 25 Jun 2013 18:24:38 +0200
Message-Id: <1372177489-6858-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Avoid maintaining an internal list of probed adapters and use instead
the userdata pointer provided by btd_server.
---
 profiles/input/server.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 077429c..e1dbfba 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -48,7 +48,6 @@
 #include "device.h"
 #include "server.h"
 
-static GSList *servers = NULL;
 struct input_server {
 	bdaddr_t src;
 	GIOChannel *ctrl;
@@ -56,14 +55,6 @@ struct input_server {
 	GIOChannel *confirm;
 };
 
-static int server_cmp(gconstpointer s, gconstpointer user_data)
-{
-	const struct input_server *server = s;
-	const bdaddr_t *src = user_data;
-
-	return bacmp(&server->src, src);
-}
-
 static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	uint16_t psm;
@@ -231,23 +222,14 @@ int hid_server_probe(struct btd_server *btd_server)
 		return -1;
 	}
 
-	servers = g_slist_append(servers, server);
+	btd_server_set_user_data(btd_server, server);
 
 	return 0;
 }
 
 void hid_server_remove(struct btd_server *btd_server)
 {
-	struct btd_adapter *adapter = btd_server_get_adapter(btd_server);
-	const bdaddr_t *src = adapter_get_address(adapter);
-	struct input_server *server;
-	GSList *l;
-
-	l = g_slist_find_custom(servers, src, server_cmp);
-	if (!l)
-		return;
-
-	server = l->data;
+	struct input_server *server = btd_server_get_user_data(btd_server);
 
 	g_io_channel_shutdown(server->intr, TRUE, NULL);
 	g_io_channel_unref(server->intr);
@@ -255,6 +237,5 @@ void hid_server_remove(struct btd_server *btd_server)
 	g_io_channel_shutdown(server->ctrl, TRUE, NULL);
 	g_io_channel_unref(server->ctrl);
 
-	servers = g_slist_remove(servers, server);
 	g_free(server);
 }
-- 
1.8.1.4

