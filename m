Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: fix not disabling local a2dp endpoints when unix socket is disabled
Date: Thu, 26 Jan 2012 23:39:02 +0200
Message-Id: <1327613942-23745-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Local endpoints can only be used when unix socket API is available
---
 audio/a2dp.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index c4cdc62..2eebe6b 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1441,9 +1441,9 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 
 int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 {
-	int sbc_srcs = 1, sbc_sinks = 1;
+	int sbc_srcs = 0, sbc_sinks = 0;
 	int mpeg12_srcs = 0, mpeg12_sinks = 0;
-	gboolean source = TRUE, sink = FALSE, socket = TRUE;
+	gboolean source = TRUE, sink = FALSE, socket = FALSE;
 	gboolean delay_reporting = FALSE;
 	char *str;
 	GError *err = NULL;
@@ -1463,6 +1463,8 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 			source = TRUE;
 		if (strstr(str, "Source"))
 			sink = TRUE;
+		if (strstr(str, "Socket"))
+			socket = TRUE;
 		g_free(str);
 	}
 
@@ -1482,18 +1484,14 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	}
 
 	/* Don't register any local sep if Socket is disabled */
-	if (socket == FALSE) {
-		sbc_srcs = 0;
-		sbc_sinks = 0;
-		mpeg12_srcs = 0;
-		mpeg12_sinks = 0;
+	if (socket == FALSE)
 		goto proceed;
-	}
 
 	str = g_key_file_get_string(config, "A2DP", "SBCSources", &err);
 	if (err) {
 		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
+		sbc_srcs = 1;
 	} else {
 		sbc_srcs = atoi(str);
 		g_free(str);
@@ -1512,6 +1510,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	if (err) {
 		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
+		sbc_sinks = 1;
 	} else {
 		sbc_sinks = atoi(str);
 		g_free(str);
-- 
1.7.7.6

