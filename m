Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] audio: Remove not needed NULL pointer checks
Date: Wed, 13 Jun 2012 21:53:19 +0200
Message-Id: <1339617199-5490-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_new0 always returns valid pointer and there is no need to check that.
---
 audio/a2dp.c  |    2 --
 audio/avctp.c |    2 --
 audio/avdtp.c |    2 --
 audio/avrcp.c |    2 --
 4 files changed, 8 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index cc8f139..5a560d4 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1480,8 +1480,6 @@ proceed:
 		int av_err;
 
 		server = g_new0(struct a2dp_server, 1);
-		if (!server)
-			return -ENOMEM;
 
 		av_err = avdtp_init(src, config, &server->version);
 		if (av_err < 0) {
diff --git a/audio/avctp.c b/audio/avctp.c
index ae3c04e..e3e5275 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -823,8 +823,6 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 	struct avctp_server *server;
 
 	server = g_new0(struct avctp_server, 1);
-	if (!server)
-		return -ENOMEM;
 
 	server->io = avctp_server_socket(src, master);
 	if (!server->io) {
diff --git a/audio/avdtp.c b/audio/avdtp.c
index eb3f213..138cc61 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3867,8 +3867,6 @@ int avdtp_init(const bdaddr_t *src, GKeyFile *config, uint16_t *version)
 
 proceed:
 	server = g_new0(struct avdtp_server, 1);
-	if (!server)
-		return -ENOMEM;
 
 	server->version = ver;
 
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 89ee112..7adf644 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1285,8 +1285,6 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	}
 
 	server = g_new0(struct avrcp_server, 1);
-	if (!server)
-		return -ENOMEM;
 
 	record = avrcp_tg_record();
 	if (!record) {
-- 
1.7.10.4


