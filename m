Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] btio: Replace void * with gpointer
Date: Thu, 19 Aug 2010 22:21:12 +0800
Message-Id: <1282227676-15381-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TO make it consistent with bluez btio.c.
---
 btio/btio.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 92a5a41..c4bd527 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -56,20 +56,20 @@ struct set_opts {
 
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
 
@@ -109,7 +109,7 @@ static gboolean check_nval(GIOChannel *io)
 }
 
 static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
-							void *user_data)
+							gpointer user_data)
 {
 	struct accept *accept = user_data;
 	GError *err = NULL;
@@ -130,7 +130,7 @@ static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
 }
 
 static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
-							void *user_data)
+							gpointer user_data)
 {
 	struct connect *conn = user_data;
 	GError *gerr = NULL;
@@ -163,7 +163,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 }
 
 static gboolean server_cb(GIOChannel *io, GIOCondition cond,
-							void *user_data)
+							gpointer user_data)
 {
 	struct server *server = user_data;
 	int srv_sock, cli_sock;
@@ -195,7 +195,7 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 }
 
 static void server_add(GIOChannel *io, BtIOConnect connect,
-				BtIOConfirm confirm, void *user_data,
+				BtIOConfirm confirm, gpointer user_data,
 				GDestroyNotify destroy)
 {
 	struct server *server;
@@ -213,7 +213,7 @@ static void server_add(GIOChannel *io, BtIOConnect connect,
 }
 
 static void connect_add(GIOChannel *io, BtIOConnect connect,
-				void *user_data, GDestroyNotify destroy)
+				gpointer user_data, GDestroyNotify destroy)
 {
 	struct connect *conn;
 	GIOCondition cond;
@@ -228,7 +228,7 @@ static void connect_add(GIOChannel *io, BtIOConnect connect,
 					(GDestroyNotify) connect_remove);
 }
 
-static void accept_add(GIOChannel *io, BtIOConnect connect, void *user_data,
+static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 							GDestroyNotify destroy)
 {
 	struct accept *accept;
@@ -897,7 +897,7 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 	return FALSE;
 }
 
-gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, void *user_data,
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 					GDestroyNotify destroy, GError **err)
 {
 	int sock;
@@ -1023,7 +1023,7 @@ failed:
 }
 
 GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
-				void *user_data, GDestroyNotify destroy,
+				gpointer user_data, GDestroyNotify destroy,
 				GError **gerr, BtIOOption opt1, ...)
 {
 	GIOChannel *io;
@@ -1071,7 +1071,7 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 }
 
 GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
-				BtIOConfirm confirm, void *user_data,
+				BtIOConfirm confirm, gpointer user_data,
 				GDestroyNotify destroy, GError **err,
 				BtIOOption opt1, ...)
 {
-- 
1.7.0.4

