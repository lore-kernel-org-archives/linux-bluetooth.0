Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Kanak Gupta <kanak.gupta@stericsson.com>,
	Anurag Gupta <anurag.gupta@stericsson.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Subject: [PATCH 1/2] audio/PCM: Handle BT_ERROR messages correctly
Date: Mon, 28 May 2012 13:41:58 +0200
Message-ID: <1338205318-32013-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an issue that the error code returned with a
BT_ERROR message type is sometimes not read and an incorrect
error code is used.
The error is caused by some audio response messages being smaller
than an error response.
---
 audio/pcm_bluetooth.c |   56 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index b9da805..299a393 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1559,12 +1559,28 @@ static int audioservice_recv(int sk, bt_audio_msg_header_t *inmsg)
 	ssize_t ret;
 	const char *type, *name;
 	uint16_t length;
+	uint16_t rec_len;
+	bt_audio_error_t error_rsp;
+	bt_audio_msg_header_t *rsp;
 
 	length = inmsg->length ? inmsg->length : BT_SUGGESTED_BUFFER_SIZE;
 
+	/*
+	 * We must always be ready to receive an error message.
+	 * If input buffer is smaller than an error message receive it
+	 * in an error message structure instead.
+	 */
+	if (length >= sizeof(error_rsp)) {
+		rec_len = length;
+		rsp = inmsg;
+	} else {
+		rsp = (bt_audio_msg_header_t*)&error_rsp;
+		rec_len = sizeof(error_rsp);
+	}
+
 	DBG("trying to receive msg from audio service...");
 
-	ret = recv(sk, inmsg, length, 0);
+	ret = recv(sk, rsp, rec_len, 0);
 	if (ret < 0) {
 		err = -errno;
 		SNDERR("Error receiving IPC data from bluetoothd: %s (%d)",
@@ -1572,9 +1588,22 @@ static int audioservice_recv(int sk, bt_audio_msg_header_t *inmsg)
 	} else if ((size_t) ret < sizeof(bt_audio_msg_header_t)) {
 		SNDERR("Too short (%d bytes) IPC packet from bluetoothd", ret);
 		err = -EINVAL;
+	} else if (rsp->type == BT_ERROR) {
+		bt_audio_error_t *error = (bt_audio_error_t*)rsp;
+		if (ret < (ssize_t)sizeof(*error)) {
+			SNDERR("Received too few bytes (%d) for BT_ERROR packet for %s",
+					ret, bt_audio_strname(rsp->name));
+			err = -EINVAL;
+			goto finished;
+		}
+		SNDERR("%s failed : %s(%d)",
+				bt_audio_strname(rsp->name),
+				strerror(error->posix_errno),
+				error->posix_errno);
+		err = -error->posix_errno;
 	} else {
-		type = bt_audio_strtype(inmsg->type);
-		name = bt_audio_strname(inmsg->name);
+		type = bt_audio_strtype(rsp->type);
+		name = bt_audio_strname(rsp->name);
 		if (type && name) {
 			DBG("Received %s - %s", type, name);
 			err = 0;
@@ -1582,18 +1611,24 @@ static int audioservice_recv(int sk, bt_audio_msg_header_t *inmsg)
 			err = -EINVAL;
 			SNDERR("Bogus message type %d - name %d"
 					" received from audio service",
-					inmsg->type, inmsg->name);
+					rsp->type, rsp->name);
 		}
-
 	}
 
+finished:
+	/*
+	 * Now copy the data over to inmsg if data was received in
+	 * error structure.
+	 */
+	if (rsp != inmsg)
+		memcpy(inmsg, rsp, length);
+
 	return err;
 }
 
 static int audioservice_expect(int sk, bt_audio_msg_header_t *rsp,
 							int expected_name)
 {
-	bt_audio_error_t *error;
 	int err = audioservice_recv(sk, rsp);
 
 	if (err != 0)
@@ -1606,15 +1641,6 @@ static int audioservice_expect(int sk, bt_audio_msg_header_t *rsp,
 				bt_audio_strname(expected_name));
 	}
 
-	if (rsp->type == BT_ERROR) {
-		error = (void *) rsp;
-		SNDERR("%s failed : %s(%d)",
-					bt_audio_strname(rsp->name),
-					strerror(error->posix_errno),
-					error->posix_errno);
-		return -error->posix_errno;
-	}
-
 	return err;
 }
 
-- 
1.7.10

