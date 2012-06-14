Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] audio: Remove local A2DP endpoints options
Date: Thu, 14 Jun 2012 16:41:09 +0300
Message-Id: <1339681270-24425-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
References: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The local endpoints are no use without the internal IPC.
---
 audio/a2dp.c     |   72 +-----------------------------------------------------
 audio/audio.conf |    5 ----
 2 files changed, 1 insertion(+), 76 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 96137e4..094476e 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1436,13 +1436,10 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 
 int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 {
-	int sbc_srcs = 0, sbc_sinks = 0;
-	int mpeg12_srcs = 0, mpeg12_sinks = 0;
-	gboolean source = TRUE, sink = FALSE, socket = FALSE;
+	gboolean source = TRUE, sink = FALSE;
 	gboolean delay_reporting = FALSE;
 	char *str;
 	GError *err = NULL;
-	int i;
 	struct a2dp_server *server;
 
 	if (!config)
@@ -1458,8 +1455,6 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 			source = TRUE;
 		if (strstr(str, "Source"))
 			sink = TRUE;
-		if (strstr(str, "Socket"))
-			socket = TRUE;
 		g_free(str);
 	}
 
@@ -1473,50 +1468,6 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 			source = FALSE;
 		if (strstr(str, "Source"))
 			sink = FALSE;
-		if (strstr(str, "Socket"))
-			socket = FALSE;
-		g_free(str);
-	}
-
-	/* Don't register any local sep if Socket is disabled */
-	if (socket == FALSE)
-		goto proceed;
-
-	str = g_key_file_get_string(config, "A2DP", "SBCSources", &err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-		sbc_srcs = 1;
-	} else {
-		sbc_srcs = atoi(str);
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(config, "A2DP", "MPEG12Sources", &err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else {
-		mpeg12_srcs = atoi(str);
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(config, "A2DP", "SBCSinks", &err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-		sbc_sinks = 1;
-	} else {
-		sbc_sinks = atoi(str);
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(config, "A2DP", "MPEG12Sinks", &err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else {
-		mpeg12_sinks = atoi(str);
 		g_free(str);
 	}
 
@@ -1552,29 +1503,8 @@ proceed:
 		server->version = 0x0102;
 
 	server->source_enabled = source;
-	if (source) {
-		for (i = 0; i < sbc_srcs; i++)
-			a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
-					A2DP_CODEC_SBC, delay_reporting,
-					NULL, NULL, NULL, NULL);
 
-		for (i = 0; i < mpeg12_srcs; i++)
-			a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
-					A2DP_CODEC_MPEG12, delay_reporting,
-					NULL, NULL, NULL, NULL);
-	}
 	server->sink_enabled = sink;
-	if (sink) {
-		for (i = 0; i < sbc_sinks; i++)
-			a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
-					A2DP_CODEC_SBC, delay_reporting,
-					NULL, NULL, NULL, NULL);
-
-		for (i = 0; i < mpeg12_sinks; i++)
-			a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
-					A2DP_CODEC_MPEG12, delay_reporting,
-					NULL, NULL, NULL, NULL);
-	}
 
 	return 0;
 }
diff --git a/audio/audio.conf b/audio/audio.conf
index df47418..290c36f 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -43,8 +43,3 @@ MaxConnected=1
 # scan type changed to interlaced. Such allows faster connection initiated
 # by a headset.
 FastConnectable=false
-
-# Just an example of potential config options for the other interfaces
-#[A2DP]
-#SBCSources=1
-#MPEG12Sources=0
-- 
1.7.10.2

