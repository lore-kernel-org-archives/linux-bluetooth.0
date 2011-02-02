Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Fix possible crash on AVDTP Suspend req timeout
Date: Wed,  2 Feb 2011 09:42:17 +0200
Message-Id: <1296632538-2784-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes possible bluetoothd crash on AVDTP Suspend request timeout
if A2DP client was destroyed after the request was sent but before its
timeout handled.

If Suspend request times out due to any reason, then references to A2DP
session and stream are cleared in unix_client. Therefore, callback cannot
be removed when unix_client is destroyed (e.g. on incomming call).

After that, consequent Abort request is sent. If the request times out
as well, than stream_state_changed callback is invoked to change AVDTP
state to Idle, which causes crash due to NULL dereferencing.

Therefore, it is important to keep references to AVDTP session and stream
in unix_client until it is destroyed.
---
 audio/unix.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index a4b92f4..3c47510 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -836,7 +836,6 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_stop_stream_rsp *rsp = (void *) buf;
-	struct a2dp_data *a2dp = &client->d.a2dp;
 
 	if (err)
 		goto failed;
@@ -854,15 +853,6 @@ failed:
 	error("suspend failed");
 
 	unix_ipc_error(client, BT_STOP_STREAM, EIO);
-
-	if (a2dp->sep) {
-		a2dp_sep_unlock(a2dp->sep, a2dp->session);
-		a2dp->sep = NULL;
-	}
-
-	avdtp_unref(a2dp->session);
-	a2dp->session = NULL;
-	a2dp->stream = NULL;
 }
 
 static void start_discovery(struct audio_device *dev, struct unix_client *client)
@@ -1272,9 +1262,11 @@ static void start_close(struct audio_device *dev, struct unix_client *client,
 	case TYPE_SINK:
 		a2dp = &client->d.a2dp;
 
-		if (client->cb_id > 0)
+		if (client->cb_id > 0) {
 			avdtp_stream_remove_cb(a2dp->session, a2dp->stream,
 								client->cb_id);
+			client->cb_id = 0;
+		}
 		if (a2dp->sep) {
 			a2dp_sep_unlock(a2dp->sep, a2dp->session);
 			a2dp->sep = NULL;
@@ -1283,6 +1275,7 @@ static void start_close(struct audio_device *dev, struct unix_client *client,
 			avdtp_unref(a2dp->session);
 			a2dp->session = NULL;
 		}
+		a2dp->stream = NULL;
 		break;
 	default:
 		error("No known services for device");
-- 
1.7.0.4

