Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/10] android/hal-audio: Add audio_ipc_cmd
Date: Wed, 15 Jan 2014 10:59:48 +0100
Message-ID: <1389779996-9749-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

Add function to handle send/receive on audio_sk.
---
 android/Makefile.am |   1 +
 android/hal-audio.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/android/Makefile.am b/android/Makefile.am
index 7806f79..e09f967 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -120,6 +120,7 @@ android_android_tester_LDFLAGS = -pthread -ldl
 plugin_LTLIBRARIES += android/audio.a2dp.default.la
 
 android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
+					android/hal-msg.h \
 					android/hal-audio.c \
 					android/hardware/audio.h \
 					android/hardware/audio_effect.h \
diff --git a/android/hal-audio.c b/android/hal-audio.c
index c51b065..354c3cf 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -30,6 +30,7 @@
 
 #include "audio-msg.h"
 #include "hal-log.h"
+#include "hal-msg.h"
 
 static int listen_sk = -1;
 static int audio_sk = -1;
@@ -37,6 +38,7 @@ static bool close_thread = false;
 
 static pthread_t ipc_th = 0;
 static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 struct a2dp_audio_dev {
 	struct audio_hw_device dev;
@@ -51,6 +53,153 @@ static void audio_ipc_cleanup(void)
 	}
 }
 
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
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
-- 
1.8.5.2

