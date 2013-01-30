Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 4/4] btiotest: Add option for SCO socket mode
Date: Wed, 30 Jan 2013 18:03:04 +0100
Message-Id: <1359565384-4656-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btiotest.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 7a77bb7..853d6d4 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -436,7 +436,8 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 	g_io_channel_unref(rc_srv);
 }
 
-static void sco_connect(const char *src, const char *dst, gint disconn)
+static void sco_connect(const char *src, const char *dst, gint disconn,
+								gint mode)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -451,12 +452,14 @@ static void sco_connect(const char *src, const char *dst, gint disconn)
 						&err,
 						BT_IO_OPT_SOURCE, src,
 						BT_IO_OPT_DEST, dst,
+						BT_IO_OPT_SCO_MODE, mode,
 						BT_IO_OPT_INVALID);
 	else
 		data->io = bt_io_connect(connect_cb, data,
 						(GDestroyNotify) io_data_unref,
 						&err,
 						BT_IO_OPT_DEST, dst,
+						BT_IO_OPT_SCO_MODE, mode,
 						BT_IO_OPT_INVALID);
 
 	if (!data->io) {
@@ -467,7 +470,7 @@ static void sco_connect(const char *src, const char *dst, gint disconn)
 }
 
 static void sco_listen(const char *src, gboolean defer, gint reject,
-				gint disconn, gint accept)
+				gint disconn, gint accept, gint mode)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -492,11 +495,14 @@ static void sco_listen(const char *src, gboolean defer, gint reject,
 					(GDestroyNotify) io_data_unref,
 					&err,
 					BT_IO_OPT_SOURCE, src,
+					BT_IO_OPT_SCO_MODE, mode,
 					BT_IO_OPT_INVALID);
 	else
 		sco_srv = bt_io_listen(conn, cfm, data,
 					(GDestroyNotify) io_data_unref,
-					&err, BT_IO_OPT_INVALID);
+					&err,
+					BT_IO_OPT_SCO_MODE, mode,
+					BT_IO_OPT_INVALID);
 
 	if (!sco_srv) {
 		printf("Listening failed: %s\n", err->message);
@@ -511,6 +517,7 @@ static gint opt_channel = -1;
 static gint opt_psm = 0;
 static gboolean opt_sco = FALSE;
 static gboolean opt_defer = FALSE;
+static gint opt_mode = 0;
 static char *opt_dev = NULL;
 static gint opt_reject = -1;
 static gint opt_disconn = -1;
@@ -537,6 +544,8 @@ static GOptionEntry options[] = {
 				"Use SCO" },
 	{ "defer", 'd', 0, G_OPTION_ARG_NONE, &opt_defer,
 				"Use DEFER_SETUP for incoming connections" },
+	{ "mode", 'M', 0, G_OPTION_ARG_NONE, &opt_mode,
+				"Use specified mode (0 CVSD, 1 Transparent)" },
 	{ "sec-level", 'S', 0, G_OPTION_ARG_INT, &opt_sec,
 				"Security level" },
 	{ "update-sec-level", 'U', 0, G_OPTION_ARG_INT, &opt_update_sec,
@@ -602,10 +611,10 @@ int main(int argc, char *argv[])
 
 	if (opt_sco) {
 		if (argc > 1)
-			sco_connect(opt_dev, argv[1], opt_disconn);
+			sco_connect(opt_dev, argv[1], opt_disconn, opt_mode);
 		else
 			sco_listen(opt_dev, opt_defer, opt_reject,
-					opt_disconn, opt_accept);
+					opt_disconn, opt_accept, opt_mode);
 	}
 
 	signal(SIGTERM, sig_term);
-- 
1.7.9.5

