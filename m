Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btiotest: Add option to update security level while connecting
Date: Fri,  2 Mar 2012 10:51:18 +0200
Message-Id: <1330678278-10357-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/btiotest.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index 03f026d..66a7dd2 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -33,6 +33,7 @@
 #include "btio.h"
 
 #define DEFAULT_ACCEPT_TIMEOUT 2
+static gint opt_update_sec = 0;
 
 struct io_data {
 	guint ref;
@@ -94,6 +95,32 @@ static gboolean disconn_timeout(gpointer user_data)
 	return FALSE;
 }
 
+static void update_sec_level(struct io_data *data)
+{
+	GError *err = NULL;
+	int sec_level;
+
+	if (!bt_io_get(data->io, data->type, &err,
+					BT_IO_OPT_SEC_LEVEL, &sec_level,
+					BT_IO_OPT_INVALID)) {
+		printf("bt_io_get(OPT_SEC_LEVEL): %s\n", err->message);
+		g_clear_error(&err);
+		return;
+	}
+
+	printf("sec_level=%d\n", sec_level);
+
+	if (opt_update_sec == sec_level)
+		return;
+
+	if (!bt_io_set(data->io, data->type, &err,
+					BT_IO_OPT_SEC_LEVEL, opt_update_sec,
+					BT_IO_OPT_INVALID)) {
+		printf("bt_io_set(OPT_SEC_LEVEL): %s\n", err->message);
+		g_clear_error(&err);
+	}
+}
+
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct io_data *data = user_data;
@@ -166,6 +193,10 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 
 	io_data_ref(data);
+
+	if (opt_update_sec > 0)
+		update_sec_level(data);
+
 	cond = G_IO_NVAL | G_IO_HUP | G_IO_ERR;
 	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, io_watch, data,
 					(GDestroyNotify) io_data_unref);
@@ -185,6 +216,9 @@ static gboolean confirm_timeout(gpointer user_data)
 
 	io_data_ref(data);
 
+	if (opt_update_sec > 0)
+		update_sec_level(data);
+
 	if (!bt_io_accept(data->io, connect_cb, data,
 				(GDestroyNotify) io_data_unref, NULL)) {
 		printf("bt_io_accept() failed\n");
@@ -502,6 +536,8 @@ static GOptionEntry options[] = {
 				"Use DEFER_SETUP for incoming connections" },
 	{ "sec-level", 'S', 0, G_OPTION_ARG_INT, &opt_sec,
 				"Security level" },
+	{ "update-sec-level", 'U', 0, G_OPTION_ARG_INT, &opt_update_sec,
+				"Update security level" },
 	{ "dev", 'i', 0, G_OPTION_ARG_STRING, &opt_dev,
 				"Which HCI device to use" },
 	{ "reject", 'r', 0, G_OPTION_ARG_INT, &opt_reject,
@@ -536,9 +572,9 @@ int main(int argc, char *argv[])
 
 	g_option_context_free(context);
 
-	printf("accept=%d, reject=%d, discon=%d, defer=%d, sec=%d, prio=%d\n",
-		opt_accept, opt_reject, opt_disconn, opt_defer, opt_sec,
-		opt_priority);
+	printf("accept=%d, reject=%d, discon=%d, defer=%d, sec=%d,"
+		" update_sec=%d, prio=%d\n", opt_accept, opt_reject,
+		opt_disconn, opt_defer, opt_sec, opt_update_sec, opt_priority);
 
 	if (opt_psm || opt_cid) {
 		if (argc > 1)
-- 
1.7.7.6

