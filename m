Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Add support for AVRCP control,target role conf
Date: Fri, 18 May 2012 17:54:13 +0900
Message-id: <1337331254-30749-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
References: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch adds logic for activating configured AVRCP role.
---
 audio/audio.conf |    2 +-
 audio/avrcp.c    |  107 ++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 1abdab9..75dad56 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -9,7 +9,7 @@
 
 # If we want to disable support for specific services
 # Defaults to supporting all implemented services
-#Disable=Gateway,Sink,Socket
+#Disable=Gateway,Sink,Control,Socket
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
 # Defaults to HCI
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 2e946c1..1b781a1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1183,57 +1183,94 @@ void avrcp_disconnect(struct audio_device *dev)
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 {
 	sdp_record_t *record;
-	gboolean tmp, master = TRUE;
+	gboolean tmp, master = TRUE, target = TRUE, control = FALSE;
+	char *str;
 	GError *err = NULL;
 	struct avrcp_server *server;
 
-	if (config) {
-		tmp = g_key_file_get_boolean(config, "General",
-							"Master", &err);
-		if (err) {
-			DBG("audio.conf: %s", err->message);
-			g_error_free(err);
-		} else
-			master = tmp;
+	if (!config)
+		goto proceed;
+
+	tmp = g_key_file_get_boolean(config, "General",
+			"Master", &err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else
+		master = tmp;
+
+	str = g_key_file_get_string(config, "General", "Enable", &err);
+
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		if (strstr(str, "Target"))
+			target = TRUE;
+		if (strstr(str, "Control"))
+			control = TRUE;
+		g_free(str);
 	}
 
+	str = g_key_file_get_string(config, "General", "Disable", &err);
+
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		if (strstr(str, "Target"))
+			target = FALSE;
+		if (strstr(str, "Control"))
+			control = FALSE;
+		g_free(str);
+	}
+
+
+proceed:
 	server = g_new0(struct avrcp_server, 1);
 	if (!server)
 		return -ENOMEM;
 
-	record = avrcp_tg_record();
-	if (!record) {
-		error("Unable to allocate new service record");
-		g_free(server);
-		return -1;
-	}
+	if (target) {
+		record = avrcp_tg_record();
+		if (!record) {
+			error("Unable to allocate new service record");
+			g_free(server);
+			return -1;
+		}
 
-	if (add_record_to_server(src, record) < 0) {
-		error("Unable to register AVRCP target service record");
-		g_free(server);
-		sdp_record_free(record);
-		return -1;
-	}
-	server->tg_record_id = record->handle;
+		if (add_record_to_server(src, record) < 0) {
+			error("Unable to register AVRCP target service record");
+			g_free(server);
+			sdp_record_free(record);
+			return -1;
+		}
+		server->tg_record_id = record->handle;
 
-	record = avrcp_ct_record();
-	if (!record) {
-		error("Unable to allocate new service record");
-		g_free(server);
-		return -1;
 	}
 
-	if (add_record_to_server(src, record) < 0) {
-		error("Unable to register AVRCP service record");
-		sdp_record_free(record);
-		g_free(server);
-		return -1;
+	if (control) {
+		record = avrcp_ct_record();
+		if (!record) {
+			error("Unable to allocate new service record");
+			g_free(server);
+			return -1;
+		}
+
+		if (add_record_to_server(src, record) < 0) {
+			error("Unable to register AVRCP service record");
+			sdp_record_free(record);
+			g_free(server);
+			return -1;
+		}
+		server->ct_record_id = record->handle;
 	}
-	server->ct_record_id = record->handle;
 
 	if (avctp_register(src, master) < 0) {
-		remove_record_from_server(server->ct_record_id);
-		remove_record_from_server(server->tg_record_id);
+		if (control)
+			remove_record_from_server(server->ct_record_id);
+		if (target)
+			remove_record_from_server(server->tg_record_id);
 		g_free(server);
 		return -1;
 	}
-- 
1.7.9.5

