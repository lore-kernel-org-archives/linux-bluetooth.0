Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 6/7] android/audio: Add audio_ipc_cmd
Date: Fri, 10 Jan 2014 02:24:27 +0100
Message-ID: <1389317068-12540-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds function to handle send/receive on audio_sk

Also moves ipc related functions on top of the file to avoid moving it
later on when implementing AudioFlinger functions.

---
 android/Makefile.am |   1 +
 android/hal-audio.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 172 insertions(+), 7 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 0a32a95..94e5329 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -117,6 +117,7 @@ android_android_tester_LDFLAGS = -pthread
 noinst_LTLIBRARIES += android/libaudio-internal.la
 
 android_libaudio_internal_la_SOURCES = android/audio-msg.h \
+					android/hal-msg.h \
 					android/hal-audio.c \
 					android/hardware/audio.h \
 					android/hardware/audio_effect.h \
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4c5a9d9..3b94e62 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -31,6 +31,7 @@
 
 #include "audio-msg.h"
 #include "hal-log.h"
+#include "hal-msg.h"
 
 static int listen_sk = -1;
 static int audio_sk = -1;
@@ -38,12 +39,182 @@ static bool close_thread = false;
 
 static pthread_t ipc_th = 0;
 static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 struct a2dp_audio_dev {
 	struct audio_hw_device dev;
 	struct audio_stream_out *out;
 };
 
+static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
+			void *param, size_t *rsp_len, void *rsp, int *fd)
+{
+	ssize_t ret;
+	struct msghdr msg;
+	struct iovec iv[2];
+	struct hal_hdr cmd;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	struct hal_status s;
+	size_t s_len = sizeof(s);
+
+	if (audio_sk < 0) {
+		error("audio: Invalid cmd socket passed to audio_ipc_cmd");
+		goto failed;
+	}
+
+	if (!rsp || !rsp_len) {
+		memset(&s, 0, s_len);
+		rsp_len = &s_len;
+		rsp = &s;
+	}
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.service_id = service_id;
+	cmd.opcode = opcode;
+	cmd.len = len;
+
+	iv[0].iov_base = &cmd;
+	iv[0].iov_len = sizeof(cmd);
+
+	iv[1].iov_base = param;
+	iv[1].iov_len = len;
+
+	msg.msg_iov = iv;
+	msg.msg_iovlen = 2;
+
+	pthread_mutex_lock(&sk_mutex);
+
+	ret = sendmsg(audio_sk, &msg, 0);
+	if (ret < 0) {
+		error("audio: Sending command failed:%s", strerror(errno));
+		pthread_mutex_unlock(&sk_mutex);
+		goto failed;
+	}
+
+	/* socket was shutdown */
+	if (ret == 0) {
+		error("audio: Command socket closed");
+		goto failed;
+	}
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&cmd, 0, sizeof(cmd));
+
+	iv[0].iov_base = &cmd;
+	iv[0].iov_len = sizeof(cmd);
+
+	iv[1].iov_base = rsp;
+	iv[1].iov_len = *rsp_len;
+
+	msg.msg_iov = iv;
+	msg.msg_iovlen = 2;
+
+	if (fd) {
+		memset(cmsgbuf, 0, sizeof(cmsgbuf));
+		msg.msg_control = cmsgbuf;
+		msg.msg_controllen = sizeof(cmsgbuf);
+	}
+
+	ret = recvmsg(audio_sk, &msg, 0);
+	if (ret < 0) {
+		error("audio: Receiving command response failed:%s",
+							strerror(errno));
+		pthread_mutex_unlock(&sk_mutex);
+		goto failed;
+	}
+
+	pthread_mutex_unlock(&sk_mutex);
+
+	if (ret < (ssize_t) sizeof(cmd)) {
+		error("audio: Too small response received(%zd bytes)", ret);
+		goto failed;
+	}
+
+	if (cmd.service_id != service_id) {
+		error("audio: Invalid service id (%u vs %u)", cmd.service_id,
+								service_id);
+		goto failed;
+	}
+
+	if (ret != (ssize_t) (sizeof(cmd) + cmd.len)) {
+		error("audio: Malformed response received(%zd bytes)", ret);
+		goto failed;
+	}
+
+	if (cmd.opcode != opcode && cmd.opcode != AUDIO_OP_STATUS) {
+		error("audio: Invalid opcode received (%u vs %u)",
+						cmd.opcode, opcode);
+		goto failed;
+	}
+
+	if (cmd.opcode == AUDIO_OP_STATUS) {
+		struct hal_status *s = rsp;
+
+		if (sizeof(*s) != cmd.len) {
+			error("audio: Invalid status length");
+			goto failed;
+		}
+
+		if (s->code == AUDIO_STATUS_SUCCESS) {
+			error("audio: Invalid success status response");
+			goto failed;
+		}
+
+		return s->code;
+	}
+
+	/* Receive auxiliary data in msg */
+	if (fd) {
+		struct cmsghdr *cmsg;
+
+		*fd = -1;
+
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			if (cmsg->cmsg_level == SOL_SOCKET
+					&& cmsg->cmsg_type == SCM_RIGHTS) {
+				memcpy(fd, CMSG_DATA(cmsg), sizeof(int));
+				break;
+			}
+		}
+	}
+
+	if (rsp_len)
+		*rsp_len = cmd.len;
+
+	return AUDIO_STATUS_SUCCESS;
+
+failed:
+	/* Some serious issue happen on IPC - recover */
+	shutdown(audio_sk, SHUT_RDWR);
+	audio_sk = -1;
+	return AUDIO_STATUS_FAILED;
+}
+
+static int ipc_open_cmd(void)
+{
+	struct audio_rsp_open rsp;
+	uint8_t buf[sizeof(struct audio_cmd_open) +
+						sizeof(struct audio_preset)];
+	size_t rsp_len = sizeof(rsp);
+	int result;
+
+	DBG("");
+
+	memset(&buf, 0, sizeof(buf));
+
+	/* TODO: Fill in buf here with smth */
+
+	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN, sizeof(buf), buf,
+							&rsp_len, &rsp, NULL);
+
+	/*TODO: Read response and store endoint id */
+
+	return result;
+}
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
@@ -417,13 +588,6 @@ static int audio_close(hw_device_t *device)
 	return 0;
 }
 
-static int ipc_open_cmd(void)
-{
-	DBG("Not Implemented");
-
-	return AUDIO_STATUS_FAILED;
-}
-
 static void *ipc_handler(void *data)
 {
 	bool done = false;
-- 
1.8.4

