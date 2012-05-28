Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Kanak Gupta <kanak.gupta@stericsson.com>,
	Anurag Gupta <anurag.gupta@stericsson.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Subject: [PATCH 2/2] audio: Keep AVDTP POSIX error codes
Date: Mon, 28 May 2012 13:43:21 +0200
Message-ID: <1338205401-32054-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds functionality to prevent constant use of the EIO POSIX
error code for AVDTP responses. The POSIX error codes generated
by AVDTP are now kept.
---
 audio/unix.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index 9a10764..b304655 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -192,6 +192,14 @@ static void unix_ipc_error(struct unix_client *client, uint8_t name, int err)
 	unix_ipc_sendmsg(client, &rsp->h);
 }
 
+static int unix_avdtp2posix_error_code(struct avdtp_error *err)
+{
+	if (err->category == AVDTP_ERRNO)
+		return err->err.posix_errno;
+	else
+		return EIO;
+}
+
 static service_type_t select_service(struct audio_device *dev, const char *interface)
 {
 	if (!interface) {
@@ -701,7 +709,8 @@ static void a2dp_discovery_complete(struct avdtp *session, GSList *seps,
 
 failed:
 	error("discovery failed");
-	unix_ipc_error(client, BT_GET_CAPABILITIES, EIO);
+	unix_ipc_error(client, BT_GET_CAPABILITIES,
+			unix_avdtp2posix_error_code(err));
 
 	if (a2dp->sep) {
 		a2dp_sep_unlock(a2dp->sep, a2dp->session);
@@ -765,7 +774,8 @@ static void a2dp_config_complete(struct avdtp *session, struct a2dp_sep *sep,
 failed:
 	error("config failed");
 
-	unix_ipc_error(client, BT_SET_CONFIGURATION, EIO);
+	unix_ipc_error(client, BT_SET_CONFIGURATION,
+			unix_avdtp2posix_error_code(err));
 
 	avdtp_unref(a2dp->session);
 
@@ -810,7 +820,8 @@ static void a2dp_resume_complete(struct avdtp *session,
 failed:
 	error("resume failed");
 
-	unix_ipc_error(client, BT_START_STREAM, EIO);
+	unix_ipc_error(client, BT_START_STREAM,
+			unix_avdtp2posix_error_code(err));
 
 	if (client->cb_id > 0) {
 		avdtp_stream_remove_cb(a2dp->session, a2dp->stream,
@@ -850,7 +861,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 failed:
 	error("suspend failed");
 
-	unix_ipc_error(client, BT_STOP_STREAM, EIO);
+	unix_ipc_error(client, BT_STOP_STREAM, unix_avdtp2posix_error_code(err));
 }
 
 static void start_discovery(struct audio_device *dev, struct unix_client *client)
-- 
1.7.10

