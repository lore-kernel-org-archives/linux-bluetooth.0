Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] test: Add support for passing address type to btiotest
Date: Wed, 10 Oct 2012 20:56:43 -0300
Message-Id: <1349913403-25606-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/btiotest.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index f090dd9..4cafcc3 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -254,9 +254,9 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 	}
 }
 
-static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
-						uint16_t cid, gint disconn,
-						gint sec, gint prio)
+static void l2cap_connect(const char *src, const char *dst, uint8_t addr_type,
+				uint16_t psm, uint16_t cid, gint disconn,
+				gint sec, gint prio)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -267,25 +267,27 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 
 	if (src)
 		data->io = bt_io_connect(connect_cb, data,
-						(GDestroyNotify) io_data_unref,
-						&err,
-						BT_IO_OPT_SOURCE, src,
-						BT_IO_OPT_DEST, dst,
-						BT_IO_OPT_PSM, psm,
-						BT_IO_OPT_CID, cid,
-						BT_IO_OPT_SEC_LEVEL, sec,
-						BT_IO_OPT_PRIORITY, prio,
-						BT_IO_OPT_INVALID);
+					(GDestroyNotify) io_data_unref,
+					&err,
+					BT_IO_OPT_SOURCE, src,
+					BT_IO_OPT_DEST, dst,
+					BT_IO_OPT_DEST_TYPE, addr_type,
+					BT_IO_OPT_PSM, psm,
+					BT_IO_OPT_CID, cid,
+					BT_IO_OPT_SEC_LEVEL, sec,
+					BT_IO_OPT_PRIORITY, prio,
+					BT_IO_OPT_INVALID);
 	else
 		data->io = bt_io_connect(connect_cb, data,
-						(GDestroyNotify) io_data_unref,
-						&err,
-						BT_IO_OPT_DEST, dst,
-						BT_IO_OPT_PSM, psm,
-						BT_IO_OPT_CID, cid,
-						BT_IO_OPT_SEC_LEVEL, sec,
-						BT_IO_OPT_PRIORITY, prio,
-						BT_IO_OPT_INVALID);
+					(GDestroyNotify) io_data_unref,
+					&err,
+					BT_IO_OPT_DEST, dst,
+					BT_IO_OPT_DEST_TYPE, addr_type,
+					BT_IO_OPT_PSM, psm,
+					BT_IO_OPT_CID, cid,
+					BT_IO_OPT_SEC_LEVEL, sec,
+					BT_IO_OPT_PRIORITY, prio,
+					BT_IO_OPT_INVALID);
 
 	if (!data->io) {
 		printf("Connecting to %s failed: %s\n", dst, err->message);
@@ -501,6 +503,7 @@ static gint opt_sec = 0;
 static gboolean opt_master = FALSE;
 static gint opt_priority = 0;
 static gint opt_cid = 0;
+static guint8 opt_addr_type = 0;
 
 static GMainLoop *main_loop;
 
@@ -511,6 +514,9 @@ static GOptionEntry options[] = {
 				"L2CAP PSM" },
 	{ "cid", 'j', 0, G_OPTION_ARG_INT, &opt_cid,
 				"L2CAP CID" },
+	{ "addr-type", 't', 0, G_OPTION_ARG_INT, &opt_addr_type,
+				"Address type "
+				"(0 BR/EDR 1 LE Public 2 LE Random" },
 	{ "sco", 's', 0, G_OPTION_ARG_NONE, &opt_sco,
 				"Use SCO" },
 	{ "defer", 'd', 0, G_OPTION_ARG_NONE, &opt_defer,
@@ -559,8 +565,9 @@ int main(int argc, char *argv[])
 
 	if (opt_psm || opt_cid) {
 		if (argc > 1)
-			l2cap_connect(opt_dev, argv[1], opt_psm, opt_cid,
-					opt_disconn, opt_sec, opt_priority);
+			l2cap_connect(opt_dev, argv[1], opt_addr_type,
+					opt_psm, opt_cid, opt_disconn,
+					opt_sec, opt_priority);
 		else
 			l2cap_listen(opt_dev, opt_psm, opt_defer, opt_reject,
 					opt_disconn, opt_accept, opt_sec,
-- 
1.7.12.3

