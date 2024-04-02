Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475D1598FE
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076198; cv=pass; b=VfmKDFYUfnIlcj24eK99QC68FtItxDgb3ranvEmmegzDvkYke3FsdB7tvnuDl/VsUr0hrxCCoQGzJoypoayKHHBUkJHuTN367T0ELsgvC0cdL97HrDlNOK+16wiTe3ze54Z6vgVdkvtNml2qnEqAP+WcGihWZsfLAvFe+6/NO5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076198; c=relaxed/simple;
	bh=t8mZoABsYat898l5IvKQOi2rSOhkqftcalWGPvIniRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmcn0ics5PqUCZHKWwOp/BBF7Vz65Ds2weCtlnDCU1aumf50EHqOSfbtLRLPWk2adKZPs/FUi47CKCd87zywPktgUyi0I6L470ZfBhsG6QYqpnJidBpE7RyDVF7mIiN9RCmanj4QKJPle24LQPNP/PCJk8u3c8MfAPC3UW3SD4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Cq+9PXkq; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Cq+9PXkq"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DG80Z7gz102X;
	Tue,  2 Apr 2024 19:43:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jam6wyhJEGdcq9xW0ZNDbg/U6xHYkFB5s+KfC6a8eCo=;
	b=Cq+9PXkqo+hPnNRTM9w/Vc6uTU37UvaxgH241l+5RHb/AeHrBSXG8Ci+5Q22fsviZF7fRZ
	xRCQRblbSqk1gFS4e597S3bnrLhjdcVSeXTGp1svGLrXTmAVo8BqBdC94kRR37t8xMVLag
	TRrbLHpvZJAbDJdwu9FbZnjfaQ+XPg8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076192; a=rsa-sha256; cv=none;
	b=drj5JR/a1P0P7Rh6p0CyHTaJnHBQi42gtLW5+toZ6h0KYOGPLOdB/qcQLyRWFVbtuM1V0k
	XFhEgbPVUzyeWC1w52+CABXNJyLWUDh8rwDkkXIH5VHvQUELXPMHK7TFA7LqABoHypHv16
	EElhYLb8ob6nX8AXDm54Y1U0PZLzLz0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jam6wyhJEGdcq9xW0ZNDbg/U6xHYkFB5s+KfC6a8eCo=;
	b=n3OyHd3FsP1e8UBMiuLEqv1qkWVi0mwKvt8N4KNI/4aRvGGzctuyxqXT91dqSH/gkVWX3v
	m1bATiSbWJO8DR1gTpolfWad7BFx8DORB64ZJEJeasd1UvpmJSeZjXgTI8ksMlJnA60RxU
	0Tdxwd8ITM16p7Iip69LuYvJcgeYHPA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/8] iso-tester: Add tests for TX timestamping
Date: Tue,  2 Apr 2024 19:42:59 +0300
Message-ID: <f40c875abeb7a777812666741a3b4a18ddb498fe.1712076170.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712076170.git.pav@iki.fi>
References: <cover.1712076170.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TX timestamping test utilities in new tester-utils.h, so that they
can be shared between testers.

Add tests:

ISO Send - TX Timestamping
ISO Send - TX Sched Timestamping
ISO Send - TX Msg Timestamping
---
 tools/iso-tester.c   | 169 ++++++++++++++++++++++++++++++++++++++++---
 tools/tester-utils.h | 163 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 322 insertions(+), 10 deletions(-)
 create mode 100644 tools/tester-utils.h

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 60afef301..c12675a18 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -18,6 +18,9 @@
 #include <poll.h>
 #include <stdbool.h>
 
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+
 #include <glib.h>
 
 #include "lib/bluetooth.h"
@@ -34,6 +37,8 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 
+#include "tester-utils.h"
+
 #define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
 { \
 	.interval = _interval, \
@@ -462,11 +467,12 @@ struct test_data {
 	uint16_t handle;
 	uint16_t acl_handle;
 	struct queue *io_queue;
-	unsigned int io_id[2];
+	unsigned int io_id[3];
 	uint8_t client_num;
 	int step;
 	bool reconnect;
 	bool suspending;
+	struct tx_tstamp_data tx_ts;
 };
 
 struct iso_client_data {
@@ -487,6 +493,10 @@ struct iso_client_data {
 	size_t base_len;
 	bool listen_bind;
 	bool pa_bind;
+	uint32_t so_timestamping;
+	bool msg_timestamping;
+	unsigned int send_extra;
+	unsigned int send_extra_pre_ts;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
@@ -677,15 +687,14 @@ static void io_free(void *data)
 static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
+	unsigned int i;
 
 	if (data->io_queue)
 		queue_destroy(data->io_queue, io_free);
 
-	if (data->io_id[0] > 0)
-		g_source_remove(data->io_id[0]);
-
-	if (data->io_id[1] > 0)
-		g_source_remove(data->io_id[1]);
+	for (i = 0; i < ARRAY_SIZE(data->io_id); ++i)
+		if (data->io_id[i] > 0)
+			g_source_remove(data->io_id[i]);
 
 	free(data);
 }
@@ -987,6 +996,38 @@ static const struct iso_client_data connect_16_2_1_send = {
 	.send = &send_16_2_1,
 };
 
+static const struct iso_client_data connect_send_tx_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.send_extra = 1,
+	.send_extra_pre_ts = 2,
+};
+
+static const struct iso_client_data connect_send_tx_sched_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_TSONLY |
+					SOF_TIMESTAMPING_TX_SCHED),
+	.send_extra = 1,
+};
+
+static const struct iso_client_data connect_send_tx_msg_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.send_extra = 1,
+	.msg_timestamping = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1410,14 +1451,17 @@ static void bthost_recv_data(const void *buf, uint16_t len, void *user_data)
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
 
+	--data->step;
+
 	tester_print("Client received %u bytes of data", len);
 
 	if (isodata->send && (isodata->send->iov_len != len ||
 			memcmp(isodata->send->iov_base, buf, len))) {
 		if (!isodata->recv->iov_base)
 			tester_test_failed();
-	} else
+	} else if (!data->step) {
 		tester_test_passed();
+	}
 }
 
 static void bthost_iso_disconnected(void *user_data)
@@ -2058,17 +2102,95 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
 
-static void iso_send(struct test_data *data, GIOChannel *io)
+static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
 {
+	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
-	ssize_t ret;
+	int sk = g_io_channel_unix_get_fd(io);
+	int err;
+
+	data->step--;
+
+	err = tx_tstamp_recv(&data->tx_ts, sk, isodata->send->iov_len);
+	if (err > 0)
+		return TRUE;
+	else if (!err && !data->step)
+		tester_test_passed();
+	else
+		tester_test_failed();
+
+	data->io_id[2] = 0;
+	return FALSE;
+}
+
+static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
+{
+	const struct iso_client_data *isodata = data->test_data;
+	struct so_timestamping so = {
+		.flags = isodata->so_timestamping,
+	};
 	int sk;
+	int err;
+	unsigned int count;
+
+	if (!(isodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+		return;
+
+	tester_print("Enabling TX timestamping");
+
+	tx_tstamp_init(&data->tx_ts, isodata->so_timestamping);
+
+	for (count = 0; count < isodata->send_extra + 1; ++count)
+		data->step += tx_tstamp_expect(&data->tx_ts);
 
 	sk = g_io_channel_unix_get_fd(io);
 
+	data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data);
+
+	if (isodata->msg_timestamping)
+		so.flags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
+
+	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
+	if (err < 0) {
+		tester_warn("setsockopt SO_TIMESTAMPING: %s (%d)",
+						strerror(errno), errno);
+		tester_test_failed();
+		return;
+	}
+}
+
+static void iso_send_data(struct test_data *data, GIOChannel *io)
+{
+	const struct iso_client_data *isodata = data->test_data;
+	char control[CMSG_SPACE(sizeof(uint32_t))];
+	struct msghdr msg = {
+		.msg_iov = (struct iovec *)isodata->send,
+		.msg_iovlen = 1,
+	};
+	struct cmsghdr *cmsg;
+	ssize_t ret;
+	int sk;
+
 	tester_print("Writing %zu bytes of data", isodata->send->iov_len);
 
-	ret = writev(sk, isodata->send, 1);
+	sk = g_io_channel_unix_get_fd(io);
+
+	if (isodata->msg_timestamping) {
+		memset(control, 0, sizeof(control));
+		msg.msg_control = control;
+		msg.msg_controllen = sizeof(control);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SO_TIMESTAMPING;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+
+		*((uint32_t *)CMSG_DATA(cmsg)) = (isodata->so_timestamping &
+					SOF_TIMESTAMPING_TX_RECORD_MASK);
+	}
+
+	ret = sendmsg(sk, &msg, 0);
 	if (ret < 0 || isodata->send->iov_len != (size_t) ret) {
 		tester_warn("Failed to write %zu bytes: %s (%d)",
 				isodata->send->iov_len, strerror(errno), errno);
@@ -2076,6 +2198,22 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 		return;
 	}
 
+	data->step++;
+}
+
+static void iso_send(struct test_data *data, GIOChannel *io)
+{
+	const struct iso_client_data *isodata = data->test_data;
+	unsigned int count;
+
+	for (count = 0; count < isodata->send_extra_pre_ts; ++count)
+		iso_send_data(data, io);
+
+	iso_tx_timestamping(data, io);
+
+	for (count = 0; count < isodata->send_extra + 1; ++count)
+		iso_send_data(data, io);
+
 	if (isodata->bcast) {
 		tester_test_passed();
 		return;
@@ -3197,6 +3335,17 @@ int main(int argc, char *argv[])
 	test_iso("ISO Send - Success", &connect_16_2_1_send, setup_powered,
 							test_connect);
 
+	test_iso("ISO Send - TX Timestamping", &connect_send_tx_timestamping,
+						setup_powered, test_connect);
+
+	test_iso("ISO Send - TX Sched Timestamping",
+			&connect_send_tx_sched_timestamping, setup_powered,
+			test_connect);
+
+	test_iso("ISO Send - TX Msg Timestamping",
+			&connect_send_tx_msg_timestamping, setup_powered,
+			test_connect);
+
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
diff --git a/tools/tester-utils.h b/tools/tester-utils.h
new file mode 100644
index 000000000..617de842e
--- /dev/null
+++ b/tools/tester-utils.h
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *
+ */
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <time.h>
+#include <sys/socket.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+
+#include <glib.h>
+
+#define SEC_NSEC(_t)  ((_t) * 1000000000LL)
+#define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
+
+struct tx_tstamp_data {
+	struct {
+		uint32_t id;
+		uint32_t type;
+	} expect[16];
+	unsigned int pos;
+	unsigned int count;
+	unsigned int sent;
+	uint32_t so_timestamping;
+};
+
+static inline void tx_tstamp_init(struct tx_tstamp_data *data,
+				uint32_t so_timestamping)
+{
+	memset(data, 0, sizeof(*data));
+	memset(data->expect, 0xff, sizeof(data->expect));
+
+	data->so_timestamping = so_timestamping;
+}
+
+static inline int tx_tstamp_expect(struct tx_tstamp_data *data)
+{
+	unsigned int pos = data->count;
+	int steps;
+
+	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SCHED) {
+		g_assert(pos < ARRAY_SIZE(data->expect));
+		data->expect[pos].type = SCM_TSTAMP_SCHED;
+		data->expect[pos].id = data->sent;
+		pos++;
+	}
+
+	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE) {
+		g_assert(pos < ARRAY_SIZE(data->expect));
+		data->expect[pos].type = SCM_TSTAMP_SND;
+		data->expect[pos].id = data->sent;
+		pos++;
+	}
+
+	data->sent++;
+
+	steps = pos - data->count;
+	data->count = pos;
+	return steps;
+}
+
+static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
+{
+	unsigned char control[512];
+	ssize_t ret;
+	char buf[1024];
+	struct msghdr msg;
+	struct iovec iov;
+	struct cmsghdr *cmsg;
+	struct scm_timestamping *tss = NULL;
+	struct sock_extended_err *serr = NULL;
+	struct timespec now;
+
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	ret = recvmsg(sk, &msg, MSG_ERRQUEUE);
+	if (ret < 0) {
+		tester_warn("Failed to read from errqueue: %s (%d)",
+							strerror(errno), errno);
+		return -EINVAL;
+	}
+
+	if (data->so_timestamping & SOF_TIMESTAMPING_OPT_TSONLY) {
+		if (ret != 0) {
+			tester_warn("Packet copied back to errqueue");
+			return -EINVAL;
+		}
+	} else if (len > ret) {
+		tester_warn("Packet not copied back to errqueue: %zd", ret);
+		return -EINVAL;
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+					cmsg->cmsg_type == SCM_TIMESTAMPING) {
+			tss = (void *)CMSG_DATA(cmsg);
+		} else if (cmsg->cmsg_level == SOL_BLUETOOTH &&
+					cmsg->cmsg_type == BT_SCM_ERROR) {
+			serr = (void *)CMSG_DATA(cmsg);
+		}
+	}
+
+	if (!tss) {
+		tester_warn("SCM_TIMESTAMPING not found");
+		return -EINVAL;
+	}
+
+	if (!serr) {
+		tester_warn("BT_SCM_ERROR not found");
+		return -EINVAL;
+	}
+
+	if (serr->ee_errno != ENOMSG ||
+				serr->ee_origin != SO_EE_ORIGIN_TIMESTAMPING) {
+		tester_warn("BT_SCM_ERROR wrong for timestamping");
+		return -EINVAL;
+	}
+
+	clock_gettime(CLOCK_REALTIME, &now);
+
+	if (TS_NSEC(&now) < TS_NSEC(tss->ts) ||
+			TS_NSEC(&now) > TS_NSEC(tss->ts) + SEC_NSEC(10)) {
+		tester_warn("nonsense in timestamp");
+		return -EINVAL;
+	}
+
+	if (data->pos >= data->count) {
+		tester_warn("Too many timestamps");
+		return -EINVAL;
+	}
+
+	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
+				serr->ee_data != data->expect[data->pos].id) {
+		tester_warn("Bad timestamp id %u", serr->ee_data);
+		return -EINVAL;
+	}
+
+	if (serr->ee_info != data->expect[data->pos].type) {
+		tester_warn("Bad timestamp type %u", serr->ee_info);
+		return -EINVAL;
+	}
+
+	tester_print("Got valid TX timestamp %u", data->pos);
+
+	++data->pos;
+
+	return data->count - data->pos;
+}
-- 
2.44.0

