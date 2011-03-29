Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix uninitialized variable warning
Date: Tue, 29 Mar 2011 14:36:53 +0300
Message-Id: <1301398615-16283-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

audio/unix.c: In function ‘client_cb’:
audio/unix.c:1078:20: error: ‘a2dp’ may be used uninitialized in this function
audio/unix.c:1154:20: error: ‘a2dp’ may be used uninitialized in this function
make[1]: *** [audio/unix.o] Error 1
---
 audio/unix.c |   51 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index 3c47510..37c772d 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1075,31 +1075,30 @@ failed:
 
 static void start_resume(struct audio_device *dev, struct unix_client *client)
 {
-	struct a2dp_data *a2dp;
+	struct a2dp_data *a2dp = NULL;
 	struct headset_data *hs;
 	unsigned int id;
-	gboolean unref_avdtp_on_fail = FALSE;
+	struct avdtp *session = NULL;
 
 	switch (client->type) {
 	case TYPE_SINK:
 	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
-		if (!a2dp->session) {
-			a2dp->session = avdtp_get(&dev->src, &dev->dst);
-			unref_avdtp_on_fail = TRUE;
-		}
-
-		if (!a2dp->session) {
-			error("Unable to get a session");
-			goto failed;
-		}
-
 		if (!a2dp->sep) {
 			error("seid not opened");
 			goto failed;
 		}
 
+		if (!a2dp->session) {
+			session = avdtp_get(&dev->src, &dev->dst);
+			if (!session) {
+				error("Unable to get a session");
+				goto failed;
+			}
+			a2dp->session = session;
+		}
+
 		id = a2dp_resume(a2dp->session, a2dp->sep, a2dp_resume_complete,
 					client);
 		client->cancel = a2dp_cancel;
@@ -1142,33 +1141,38 @@ static void start_resume(struct audio_device *dev, struct unix_client *client)
 	return;
 
 failed:
-	if (unref_avdtp_on_fail && a2dp->session) {
-		avdtp_unref(a2dp->session);
+	if (session) {
+		avdtp_unref(session);
 		a2dp->session = NULL;
 	}
+
 	unix_ipc_error(client, BT_START_STREAM, EIO);
 }
 
 static void start_suspend(struct audio_device *dev, struct unix_client *client)
 {
-	struct a2dp_data *a2dp;
+	struct a2dp_data *a2dp = NULL;
 	struct headset_data *hs;
 	unsigned int id;
-	gboolean unref_avdtp_on_fail = FALSE;
+	struct avdtp *session = NULL;
 
 	switch (client->type) {
 	case TYPE_SINK:
 	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
-		if (!a2dp->session) {
-			a2dp->session = avdtp_get(&dev->src, &dev->dst);
-			unref_avdtp_on_fail = TRUE;
+		if (!a2dp->sep) {
+			error("seid not opened");
+			goto failed;
 		}
 
 		if (!a2dp->session) {
-			error("Unable to get a session");
-			goto failed;
+			session = avdtp_get(&dev->src, &dev->dst);
+			if (!session) {
+				error("Unable to get a session");
+				goto failed;
+			}
+			a2dp->session = session;
 		}
 
 		if (!a2dp->sep) {
@@ -1214,10 +1218,11 @@ static void start_suspend(struct audio_device *dev, struct unix_client *client)
 	return;
 
 failed:
-	if (unref_avdtp_on_fail && a2dp->session) {
-		avdtp_unref(a2dp->session);
+	if (session) {
+		avdtp_unref(session);
 		a2dp->session = NULL;
 	}
+
 	unix_ipc_error(client, BT_STOP_STREAM, EIO);
 }
 
-- 
1.7.4.1

