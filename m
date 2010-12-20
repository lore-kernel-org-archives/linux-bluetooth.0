Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/3] Fix memory leaks in btio/btio.c
Date: Mon, 20 Dec 2010 00:29:06 -0400
Message-Id: <1292819346-27318-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The watches created by bt_io_* functions were not being removed from
main context, therefore the "destroy" function was never being called.
---
 btio/btio.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 btio/btio.h |    2 ++
 src/main.c  |    3 +++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d8439e0..0cd046e 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -65,12 +65,14 @@ struct connect {
 	BtIOConnect connect;
 	gpointer user_data;
 	GDestroyNotify destroy;
+	guint watch_id;
 };
 
 struct accept {
 	BtIOConnect connect;
 	gpointer user_data;
 	GDestroyNotify destroy;
+	guint watch_id;
 };
 
 struct server {
@@ -78,8 +80,11 @@ struct server {
 	BtIOConfirm confirm;
 	gpointer user_data;
 	GDestroyNotify destroy;
+	guint watch_id;
 };
 
+static GSList *servers = NULL, *accepts = NULL, *connects = NULL;
+
 static void server_remove(struct server *server)
 {
 	if (server->destroy)
@@ -215,8 +220,11 @@ static void server_add(GIOChannel *io, BtIOConnect connect,
 	server->destroy = destroy;
 
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, server_cb, server,
-					(GDestroyNotify) server_remove);
+	server->watch_id = g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond,
+						server_cb, server,
+						(GDestroyNotify) server_remove);
+
+	servers = g_slist_append(servers, server);
 }
 
 static void connect_add(GIOChannel *io, BtIOConnect connect,
@@ -231,8 +239,11 @@ static void connect_add(GIOChannel *io, BtIOConnect connect,
 	conn->destroy = destroy;
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb, conn,
+	conn->watch_id = g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond,
+					connect_cb, conn,
 					(GDestroyNotify) connect_remove);
+
+	connects = g_slist_append(connects, conn);
 }
 
 static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_data,
@@ -247,8 +258,11 @@ static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 	accept->destroy = destroy;
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, accept_cb, accept,
-					(GDestroyNotify) accept_remove);
+	accept->watch_id = g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond,
+						accept_cb, accept,
+						(GDestroyNotify) accept_remove);
+
+	accepts = g_slist_append(accepts, accept);
 }
 
 static int l2cap_bind(int sock, const bdaddr_t *src, uint16_t psm,
@@ -1313,6 +1327,38 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 	return io;
 }
 
+void bt_io_destroy(void)
+{
+	GSList *l;
+
+	for (l = servers; l != NULL; l = g_slist_next(l)) {
+		struct server *server = l->data;
+
+		if (server->watch_id > 0)
+			g_source_remove(server->watch_id);
+	}
+	g_slist_free(servers);
+	servers = NULL;
+
+	for (l = connects; l != NULL; l = g_slist_next(l)) {
+		struct connect *conn = l->data;
+
+		if (conn->watch_id > 0)
+			g_source_remove(conn->watch_id);
+	}
+	g_slist_free(connects);
+	connects = NULL;
+
+	for (l = connects; l != NULL; l = g_slist_next(l)) {
+		struct accept *accept = l->data;
+
+		if (accept->watch_id > 0)
+			g_source_remove(accept->watch_id);
+	}
+	g_slist_free(accepts);
+	accepts = NULL;
+}
+
 GQuark bt_io_error_quark(void)
 {
 	return g_quark_from_static_string("bt-io-error-quark");
diff --git a/btio/btio.h b/btio/btio.h
index 53e8eaa..87e722f 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -95,4 +95,6 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 				GDestroyNotify destroy, GError **err,
 				BtIOOption opt1, ...);
 
+void bt_io_destroy(void);
+
 #endif
diff --git a/src/main.c b/src/main.c
index 1aaa181..1b7ff40 100644
--- a/src/main.c
+++ b/src/main.c
@@ -56,6 +56,7 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "manager.h"
+#include "btio.h"
 
 #ifdef HAVE_CAPNG
 #include <cap-ng.h>
@@ -495,6 +496,8 @@ int main(int argc, char *argv[])
 
 	agent_exit();
 
+	bt_io_destroy();
+
 	g_main_loop_unref(event_loop);
 
 	if (config)
-- 
1.7.0.4

