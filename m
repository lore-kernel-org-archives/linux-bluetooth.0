Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 7/7] android/audio: Add audio_ipc_cleanup function
Date: Fri, 10 Jan 2014 02:24:28 +0100
Message-ID: <1389317068-12540-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 3b94e62..49cc375 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -46,6 +46,14 @@ struct a2dp_audio_dev {
 	struct audio_stream_out *out;
 };
 
+static void audio_ipc_cleanup(void)
+{
+	if (audio_sk >= 0) {
+		shutdown(audio_sk, SHUT_RDWR);
+		audio_sk = -1;
+	}
+}
+
 static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			void *param, size_t *rsp_len, void *rsp, int *fd)
 {
@@ -188,8 +196,7 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 
 failed:
 	/* Some serious issue happen on IPC - recover */
-	shutdown(audio_sk, SHUT_RDWR);
-	audio_sk = -1;
+	audio_ipc_cleanup();
 	return AUDIO_STATUS_FAILED;
 }
 
@@ -575,7 +582,7 @@ static int audio_close(hw_device_t *device)
 	DBG("");
 
 	pthread_mutex_lock(&close_mutex);
-	shutdown(audio_sk, SHUT_RDWR);
+	audio_ipc_cleanup();
 	close_thread = true;
 	pthread_mutex_unlock(&close_mutex);
 
@@ -609,7 +616,7 @@ static void *ipc_handler(void *data)
 
 		if (ipc_open_cmd() == AUDIO_STATUS_FAILED) {
 			error("audio: Failed to open endpoint, recover");
-			shutdown(audio_sk, SHUT_RDWR);
+			audio_ipc_cleanup();
 			continue;
 		}
 
-- 
1.8.4

