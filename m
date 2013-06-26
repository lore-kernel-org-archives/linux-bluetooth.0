Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 3/5] btiotest: Add option for SCO voice setting
Date: Wed, 26 Jun 2013 19:32:10 +0200
Message-Id: <1372267932-10965-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1372267932-10965-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1372267932-10965-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btiotest.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 2c77fb3..0c056f2 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -445,7 +445,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 	g_io_channel_unref(rc_srv);
 }
 
-static void sco_connect(const char *src, const char *dst, int disconn)
+static void sco_connect(const char *src, const char *dst, int disconn, int voice)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -460,12 +460,14 @@ static void sco_connect(const char *src, const char *dst, int disconn)
 						&err,
 						BT_IO_OPT_SOURCE, src,
 						BT_IO_OPT_DEST, dst,
+						BT_IO_OPT_SCO_VOICE, voice,
 						BT_IO_OPT_INVALID);
 	else
 		data->io = bt_io_connect(connect_cb, data,
 						(GDestroyNotify) io_data_unref,
 						&err,
 						BT_IO_OPT_DEST, dst,
+						BT_IO_OPT_SCO_VOICE, voice,
 						BT_IO_OPT_INVALID);
 
 	if (!data->io) {
@@ -476,7 +478,7 @@ static void sco_connect(const char *src, const char *dst, int disconn)
 }
 
 static void sco_listen(const char *src, gboolean defer, int reject,
-				int disconn, int accept)
+				int disconn, int accept, int voice)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -501,11 +503,14 @@ static void sco_listen(const char *src, gboolean defer, int reject,
 					(GDestroyNotify) io_data_unref,
 					&err,
 					BT_IO_OPT_SOURCE, src,
+					BT_IO_OPT_SCO_VOICE, voice,
 					BT_IO_OPT_INVALID);
 	else
 		sco_srv = bt_io_listen(conn, cfm, data,
 					(GDestroyNotify) io_data_unref,
-					&err, BT_IO_OPT_INVALID);
+					&err,
+					BT_IO_OPT_SCO_VOICE, voice,
+					BT_IO_OPT_INVALID);
 
 	if (!sco_srv) {
 		printf("Listening failed: %s\n", err->message);
@@ -520,6 +525,7 @@ static int opt_channel = -1;
 static int opt_psm = 0;
 static gboolean opt_sco = FALSE;
 static gboolean opt_defer = FALSE;
+static gint opt_voice = 0;
 static char *opt_dev = NULL;
 static int opt_reject = -1;
 static int opt_disconn = -1;
@@ -546,6 +552,8 @@ static GOptionEntry options[] = {
 				"Use SCO" },
 	{ "defer", 'd', 0, G_OPTION_ARG_NONE, &opt_defer,
 				"Use DEFER_SETUP for incoming connections" },
+	{ "voice", 'V', 0, G_OPTION_ARG_INT, &opt_voice,
+				"Which voice setting to use (0x0060 CVSD, 0x0003 Transparent)" },
 	{ "sec-level", 'S', 0, G_OPTION_ARG_INT, &opt_sec,
 				"Security level" },
 	{ "update-sec-level", 'U', 0, G_OPTION_ARG_INT, &opt_update_sec,
@@ -611,10 +619,10 @@ int main(int argc, char *argv[])
 
 	if (opt_sco) {
 		if (argc > 1)
-			sco_connect(opt_dev, argv[1], opt_disconn);
+			sco_connect(opt_dev, argv[1], opt_disconn, opt_voice);
 		else
 			sco_listen(opt_dev, opt_defer, opt_reject,
-					opt_disconn, opt_accept);
+					opt_disconn, opt_accept, opt_voice);
 	}
 
 	signal(SIGTERM, sig_term);
-- 
1.7.9.5

