Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 05/12] android/hal-sco: Implement Audio IPC on Audio HAL
Date: Thu,  8 May 2014 11:01:36 +0300
Message-Id: <1399536103-19052-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 320 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 319 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index bc7d987..669389c 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -16,13 +16,20 @@
  */
 
 #include <errno.h>
+#include <pthread.h>
+#include <poll.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
 
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
 
+#include "sco-msg.h"
+#include "ipc-common.h"
 #include "hal-log.h"
 
 #define AUDIO_STREAM_DEFAULT_RATE	44100
@@ -30,15 +37,24 @@
 
 #define OUT_BUFFER_SIZE			2560
 
+static int listen_sk = -1;
+static int audio_sk = -1;
+
+static pthread_t ipc_th = 0;
+static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 struct hsp_audio_config {
 	uint32_t rate;
 	uint32_t channels;
+	uint16_t mtu;
 	audio_format_t format;
 };
 
 struct hsp_stream_out {
 	struct audio_stream_out stream;
+
 	struct hsp_audio_config cfg;
+	int fd;
 };
 
 struct hsp_audio_dev {
@@ -46,13 +62,186 @@ struct hsp_audio_dev {
 	struct hsp_stream_out *out;
 };
 
+/* Audio IPC functions */
+
+static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
+			void *param, size_t *rsp_len, void *rsp, int *fd)
+{
+	ssize_t ret;
+	struct msghdr msg;
+	struct iovec iv[2];
+	struct ipc_hdr cmd;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	struct ipc_status s;
+	size_t s_len = sizeof(s);
+
+	pthread_mutex_lock(&sk_mutex);
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
+	ret = sendmsg(audio_sk, &msg, 0);
+	if (ret < 0) {
+		error("audio: Sending command failed:%s", strerror(errno));
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
+		goto failed;
+	}
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
+		struct ipc_status *s = rsp;
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
+		pthread_mutex_unlock(&sk_mutex);
+
+		return s->code;
+	}
+
+	pthread_mutex_unlock(&sk_mutex);
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
+
+		if (*fd < 0)
+			goto failed;
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
+	pthread_mutex_unlock(&sk_mutex);
+
+	return AUDIO_STATUS_FAILED;
+}
+
+static int ipc_connect_sco(int *fd, uint16_t *mtu)
+{
+	struct audio_rsp_connect_sco rsp;
+	size_t rsp_len = sizeof(rsp);
+	int ret;
+
+	DBG("");
+
+	ret = audio_ipc_cmd(AUDIO_SERVICE_SCO_ID, AUDIO_OP_CONNECT_SCO, 0,
+						NULL, &rsp_len, &rsp, fd);
+
+	*mtu = rsp.mtu;
+
+	return ret;
+}
+
 /* Audio stream functions */
 
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
+	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
+
 	/* write data */
 
+	DBG("write to fd %d bytes %zu", out->fd, bytes);
+
 	return bytes;
 }
 
@@ -182,9 +371,18 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 {
 	struct hsp_audio_dev *adev = (struct hsp_audio_dev *) dev;
 	struct hsp_stream_out *out;
+	int fd = -1;
+	uint16_t mtu;
 
 	DBG("");
 
+	if (ipc_connect_sco(&fd, &mtu) != AUDIO_STATUS_SUCCESS) {
+		error("audio: cannot get fd");
+		return -EIO;
+	}
+
+	DBG("got sco fd %d mtu %u", fd, mtu);
+
 	out = calloc(1, sizeof(struct hsp_stream_out));
 	if (!out)
 		return -ENOMEM;
@@ -209,9 +407,11 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	out->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
 	out->cfg.channels = AUDIO_CHANNEL_OUT_MONO;
 	out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
+	out->cfg.mtu = mtu;
 
 	*stream_out = &out->stream;
 	adev->out = out;
+	out->fd = fd;
 
 	return 0;
 }
@@ -219,9 +419,17 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 static void audio_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream_out)
 {
-	DBG("");
+	struct hsp_audio_dev *hsp_dev = (struct hsp_audio_dev *) dev;
+
+	DBG("dev %p stream %p fd %d", dev, stream_out, hsp_dev->out->fd);
+
+	if (hsp_dev->out && hsp_dev->out->fd) {
+		close(hsp_dev->out->fd);
+		hsp_dev->out->fd = -1;
+	}
 
 	free(stream_out);
+	hsp_dev->out = NULL;
 }
 
 static int audio_set_parameters(struct audio_hw_device *dev,
@@ -325,10 +533,116 @@ static int audio_close(hw_device_t *device)
 	return 0;
 }
 
+static void *ipc_handler(void *data)
+{
+	bool done = false;
+	struct pollfd pfd;
+	int sk;
+
+	DBG("");
+
+	while (!done) {
+		DBG("Waiting for connection ...");
+
+		sk = accept(listen_sk, NULL, NULL);
+		if (sk < 0) {
+			int err = errno;
+
+			if (err == EINTR)
+				continue;
+
+			if (err != ECONNABORTED && err != EINVAL)
+				error("audio: Failed to accept socket: %d (%s)",
+							err, strerror(err));
+
+			break;
+		}
+
+		pthread_mutex_lock(&sk_mutex);
+		audio_sk = sk;
+		pthread_mutex_unlock(&sk_mutex);
+
+		DBG("Audio IPC: Connected");
+
+		memset(&pfd, 0, sizeof(pfd));
+		pfd.fd = audio_sk;
+		pfd.events = POLLHUP | POLLERR | POLLNVAL;
+
+		/* Check if socket is still alive. Empty while loop.*/
+		while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
+
+		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
+			info("Audio HAL: Socket closed");
+
+			pthread_mutex_lock(&sk_mutex);
+			close(audio_sk);
+			audio_sk = -1;
+			pthread_mutex_unlock(&sk_mutex);
+		}
+	}
+
+	info("Closing Audio IPC thread");
+	return NULL;
+}
+
+static int audio_ipc_init(void)
+{
+	struct sockaddr_un addr;
+	int err;
+	int sk;
+
+	DBG("");
+
+	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		err = -errno;
+		error("audio: Failed to create socket: %d (%s)", -err,
+								strerror(-err));
+		return err;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	memcpy(addr.sun_path, BLUEZ_SCO_SK_PATH, sizeof(BLUEZ_SCO_SK_PATH));
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = -errno;
+		error("audio: Failed to bind socket: %d (%s)", -err,
+								strerror(-err));
+		goto failed;
+	}
+
+	if (listen(sk, 1) < 0) {
+		err = -errno;
+		error("audio: Failed to listen on the socket: %d (%s)", -err,
+								strerror(-err));
+		goto failed;
+	}
+
+	listen_sk = sk;
+
+	err = pthread_create(&ipc_th, NULL, ipc_handler, NULL);
+	if (err) {
+		err = -err;
+		ipc_th = 0;
+		error("audio: Failed to start Audio IPC thread: %d (%s)",
+							-err, strerror(-err));
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	close(sk);
+	return err;
+}
+
 static int audio_open(const hw_module_t *module, const char *name,
 							hw_device_t **device)
 {
 	struct hsp_audio_dev *adev;
+	int err;
 
 	DBG("");
 
@@ -338,6 +652,10 @@ static int audio_open(const hw_module_t *module, const char *name,
 		return -EINVAL;
 	}
 
+	err = audio_ipc_init();
+	if (err < 0)
+		return err;
+
 	adev = calloc(1, sizeof(struct hsp_audio_dev));
 	if (!adev)
 		return -ENOMEM;
-- 
1.8.3.2

