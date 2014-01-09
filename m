Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <szymon.janc@tieto.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/4] android/audio: Add audio_ipc_cmd
Date: Thu, 9 Jan 2014 12:45:56 +0100
Message-ID: <1389267956-2297-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds function to handle send/receive on audio_sk

---
 android/Makefile.am |   1 +
 android/hal-audio.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 166 insertions(+), 2 deletions(-)

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
index 95efa89..e515f53 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -31,12 +31,14 @@
 
 #include "audio-msg.h"
 #include "hal-log.h"
+#include "hal-msg.h"
 
 static int audio_sk = -1;
 static bool close_thread = false;
 
 static pthread_t ipc_th = 0;
 static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 struct a2dp_audio_dev {
 	struct audio_hw_device dev;
@@ -412,13 +414,174 @@ static int audio_close(hw_device_t *device)
 	return 0;
 }
 
-static int open_endpoint_cmd(void)
+static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
+			void *param, size_t *rsp_len, void *rsp, int *fd)
 {
-	DBG("Not Implemented");
+	ssize_t ret;
+	struct msghdr msg;
+	struct iovec iv[2];
+	struct hal_hdr cmd;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	struct hal_status s;
+	size_t s_len = sizeof(s);
+
+	if (audio_sk < 0) {
+		error("a2dp: Invalid cmd socket passed to audio_sk");
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
+		error("a2dp: Sending command failed:%s", strerror(errno));
+		pthread_mutex_unlock(&sk_mutex);
+		goto failed;
+	}
+
+	/* socket was shutdown */
+	if (ret == 0) {
+		error("a2dp: Command socket closed");
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
+		error("a2dp: Receiving command response failed:%s",
+							strerror(errno));
+		pthread_mutex_unlock(&sk_mutex);
+		goto failed;
+	}
+
+	pthread_mutex_unlock(&sk_mutex);
+
+	if (ret < (ssize_t) sizeof(cmd)) {
+		error("a2dp: Too small response received(%zd bytes)", ret);
+		goto failed;
+	}
+
+	if (cmd.service_id != service_id) {
+		error("a2dp: Invalid service id (%u vs %u)", cmd.service_id,
+								service_id);
+		goto failed;
+	}
+
+	if (ret != (ssize_t) (sizeof(cmd) + cmd.len)) {
+		error("a2dp: Malformed response received(%zd bytes)", ret);
+		goto failed;
+	}
+
+	if (cmd.opcode != opcode && cmd.opcode != AUDIO_OP_STATUS) {
+		error("a2dp: Invalid opcode received (%u vs %u)",
+						cmd.opcode, opcode);
+		goto failed;
+	}
+
+	if (cmd.opcode == AUDIO_OP_STATUS) {
+		struct hal_status *s = rsp;
+
+		if (sizeof(*s) != cmd.len) {
+			error("a2dp: Invalid status length");
+			goto failed;
+		}
+
+		if (s->code == AUDIO_STATUS_SUCCESS) {
+			error("a2dp: Invalid success status response");
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
 
+	return AUDIO_STATUS_SUCCESS;
+
+failed:
+	/* Some serious issue happen on IPC - recover */
+	shutdown(audio_sk, SHUT_RDWR);
 	return AUDIO_STATUS_FAILED;
 }
 
+static int open_endpoint_cmd(void)
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
 static bool create_audio_ipc(void)
 {
 	struct sockaddr_un addr;
-- 
1.8.4

