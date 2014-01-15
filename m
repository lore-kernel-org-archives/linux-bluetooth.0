Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 03/11] android/hal-audio: Add support to unregister audio endpoints
Date: Wed, 15 Jan 2014 19:03:49 +0100
Message-ID: <1389809037-11575-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 6aad002..13ae056 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -359,6 +359,21 @@ static int ipc_open_cmd(const struct audio_codec *codec)
 	return rsp.id;
 }
 
+static int ipc_close_cmd(uint8_t endpoint_id)
+{
+	struct audio_cmd_close cmd;
+	int result;
+
+	DBG("");
+
+	cmd.id = endpoint_id;
+
+	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_CLOSE,
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	return result;
+}
+
 static int register_endpoints(void)
 {
 	struct audio_endpoint *ep = &audio_endpoints[0];
@@ -380,6 +395,20 @@ static int register_endpoints(void)
 	return AUDIO_STATUS_SUCCESS;
 }
 
+static void unregister_endpoints(void)
+{
+	size_t i;
+
+	for (i = 0; i < MAX_AUDIO_ENDPOINTS; i++) {
+		struct audio_endpoint *ep = &audio_endpoints[i];
+
+		if (ep->id) {
+			ipc_close_cmd(ep->id);
+			memset(ep, 0, sizeof(*ep));
+		}
+	}
+}
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
@@ -775,6 +804,8 @@ static void *ipc_handler(void *data)
 		if (register_endpoints() != AUDIO_STATUS_SUCCESS) {
 			error("audio: Failed to register endpoints");
 
+			unregister_endpoints();
+
 			shutdown(audio_sk, SHUT_RDWR);
 			continue;
 		}
@@ -798,6 +829,8 @@ static void *ipc_handler(void *data)
 		pthread_mutex_unlock(&close_mutex);
 	}
 
+	unregister_endpoints();
+
 	info("Closing Audio IPC thread");
 	return NULL;
 }
-- 
1.8.5.2

