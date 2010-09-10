Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] btio: Replace void * with gpointer
Date: Fri, 10 Sep 2010 10:47:27 +0800
Message-Id: <1284086847-16429-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284086847-16429-1-git-send-email-zhenhua.zhang@intel.com>
References: <1284086847-16429-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TO make it consistent with bluez btio.c.
---
 btio/btio.c |   24 ++++++++++++------------
 btio/btio.h |   10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 42a3bcd..8b273ca 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -62,20 +62,20 @@ struct set_opts {
 
 struct connect {
 	BtIOConnect connect;
-	void *user_data;
+	gpointer user_data;
 	GDestroyNotify destroy;
 };
 
 struct accept {
 	BtIOConnect connect;
-	void *user_data;
+	gpointer user_data;
 	GDestroyNotify destroy;
 };
 
 struct server {
 	BtIOConnect connect;
 	BtIOConfirm confirm;
-	void *user_data;
+	gpointer user_data;
 	GDestroyNotify destroy;
 };
 
@@ -115,7 +115,7 @@ static gboolean check_nval(GIOChannel *io)
 }
 
 static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
-							void *user_data)
+							gpointer user_data)
 {
 	struct accept *accept = user_data;
 	GError *err = NULL;
@@ -136,7 +136,7 @@ static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
 }
 
 static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
-							void *user_data)
+							gpointer user_data)
 {
 	struct connect *conn = user_data;
 	GError *gerr = NULL;
@@ -169,7 +169,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 }
 
 static gboolean server_cb(GIOChannel *io, GIOCondition cond,
-							void *user_data)
+							gpointer user_data)
 {
 	struct server *server = user_data;
 	int srv_sock, cli_sock;
@@ -201,7 +201,7 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 }
 
 static void server_add(GIOChannel *io, BtIOConnect connect,
-				BtIOConfirm confirm, void *user_data,
+				BtIOConfirm confirm, gpointer user_data,
 				GDestroyNotify destroy)
 {
 	struct server *server;
@@ -219,7 +219,7 @@ static void server_add(GIOChannel *io, BtIOConnect connect,
 }
 
 static void connect_add(GIOChannel *io, BtIOConnect connect,
-				void *user_data, GDestroyNotify destroy)
+				gpointer user_data, GDestroyNotify destroy)
 {
 	struct connect *conn;
 	GIOCondition cond;
@@ -234,7 +234,7 @@ static void connect_add(GIOChannel *io, BtIOConnect connect,
 					(GDestroyNotify) connect_remove);
 }
 
-static void accept_add(GIOChannel *io, BtIOConnect connect, void *user_data,
+static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 							GDestroyNotify destroy)
 {
 	struct accept *accept;
@@ -1046,7 +1046,7 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 	return FALSE;
 }
 
-gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, void *user_data,
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 					GDestroyNotify destroy, GError **err)
 {
 	int sock;
@@ -1195,7 +1195,7 @@ failed:
 }
 
 GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
-				void *user_data, GDestroyNotify destroy,
+				gpointer user_data, GDestroyNotify destroy,
 				GError **gerr, BtIOOption opt1, ...)
 {
 	GIOChannel *io;
@@ -1249,7 +1249,7 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 }
 
 GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
-				BtIOConfirm confirm, void *user_data,
+				BtIOConfirm confirm, gpointer user_data,
 				GDestroyNotify destroy, GError **err,
 				BtIOOption opt1, ...)
 {
diff --git a/btio/btio.h b/btio/btio.h
index e9dcc9f..d373ed1 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -72,11 +72,11 @@ typedef enum {
 	BT_IO_SEC_HIGH,
 } BtIOSecLevel;
 
-typedef void (*BtIOConfirm)(GIOChannel *io, void *user_data);
+typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
 
-typedef void (*BtIOConnect)(GIOChannel *io, GError *err, void *user_data);
+typedef void (*BtIOConnect)(GIOChannel *io, GError *err, gpointer user_data);
 
-gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, void *user_data,
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 					GDestroyNotify destroy, GError **err);
 
 gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
@@ -86,11 +86,11 @@ gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
 						BtIOOption opt1, ...);
 
 GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
-				void *user_data, GDestroyNotify destroy,
+				gpointer user_data, GDestroyNotify destroy,
 				GError **err, BtIOOption opt1, ...);
 
 GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
-				BtIOConfirm confirm, void *user_data,
+				BtIOConfirm confirm, gpointer user_data,
 				GDestroyNotify destroy, GError **err,
 				BtIOOption opt1, ...);
 
-- 
1.7.0.4

