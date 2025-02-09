Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30EC13A3F2
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097607; cv=pass; b=VMJsaFWhF0d/mHjmR61qb2cCiKiaSx5uGFTaoBY55eW5T46eFtKI6DGdXMhqvxrKcbRa7MLyU79oFDcsF8SqZG53LrfILlx/B1YAcbMPzqPvF/6tMUy9vwburMJsqP4RodxsqFxbgbbrfZMrFgIbWdzJCoH5WVJQDICdKxB2W3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097607; c=relaxed/simple;
	bh=aEu26T2gIfTuIY1iNjKJAyXDXc0KMCOJRqSg18UgE5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTArBRWF5FmGCRY5VkmV/eigKm2kWFVaMCd8wF8mq6I+RYR3CW+RoRfWKUVvSmCZNF8FyPBoEfuVCRfnKEqeGd1U/udrJF65rXhUCBfFZvIZw8CK6n3NdJxLaJKCYl0mLPgy6HL4roYvD2/bpWVEyq6Jwq/uEy7g0iXX9jqTQtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VwuxnMSk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VwuxnMSk"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPNg2jzBz49Q6m;
	Sun,  9 Feb 2025 12:40:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjY9XXScNL7xvOLdXD/zlErhPo7jr7n8peDpvsMGN3s=;
	b=VwuxnMSkgMHyRjlRYa8yD3M+oVV1yLbiztXO8xk08SPvzuYua36tuXjYbBhiJdmgq25VKr
	e58cT7mQDEQ0NNYLHQCce9VCZzGtiL7E7A++MPWLsEoV70ae8UPY/zZSzysuAeE6SmFwb0
	srwtLRhTxWAcaAkc5L0b/+LTnMypsW3sa9Dk7SBfZl4Wg6+KDOQy/OAscMBC/FtvpAOrI4
	k2lgsNMNdosHKE7+MzShZ4UiJK5vUZ8JZWfrlg0G29LJgDAZetktWUnlg7AcRW7ivUppiB
	I02C+3ZBW5105/VaRXmqH91U/AcocLY/dgISLykedwOxs4SBGaJM0q84MgyAfg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097604; a=rsa-sha256;
	cv=none;
	b=Wyf5w3qqXTfnAOM4/Kk0RdKOpHjCQbXpZD8OGdDxBFULlH2b4c3kK1lIQa0GsjGYo9ffOK
	iz1R0peIIoLjioLoHWyXI9WD8woAXnYJhFPicXhCk8lmmJNLg6Jxt5rf29ekDY7wZP19X8
	d/oTLneJAgOrXAZW34cFnH0ccjSc11OIg7bx0xtFhL6zCyOOSJDM5gecXVijWKyvAMYnyD
	RRUmxwrefRBFfY97r8z1FFMioTNUuQQ6u3w4+EFZIz0iTSdHNaXBNZKm26XFFk0WL1qOm4
	FO+rCK8trMpCAo5/RDRUBNUsmy8YzVZQ3PHjIpkvhVVgePQx+4QFcloyuNaUQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjY9XXScNL7xvOLdXD/zlErhPo7jr7n8peDpvsMGN3s=;
	b=AJQ30u4nPFnZByOQWTgmcBAQ6v+NWt11lQ+htGdVPi8kmR6brF+sqn6nvJb7ittcAPMRtQ
	ILpeefvH7ZbT4/8oFFSVcUpTdZ6Cjr6I3JqMRR8l2XbDVSOPEkeoejvxherfu0DUEzH5S1
	X0N4x9ytTeVzRR53EzRGfmTtTMnzNYGv95doXhvYB8a/jOvnZx2+x4aY+ddbtDhvVjCw+F
	2tvLGO+Eio71ZleNd13FU7w1LiipnjwBmmidQssvNEYDsrNQUeobVcXR09XRjUev3SAT4h
	pnxkCQuRwO+/Kd2VjBtbDwBrf/NggdxstS/QpGI7i7r7Hjw+AeZ+4g7ixISKpA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] tools/tester: test COMPLETION timestamps
Date: Sun,  9 Feb 2025 12:39:55 +0200
Message-ID: <4449644d9883f313fc6ad883f56fe07420815bf1.1739026302.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739026302.git.pav@iki.fi>
References: <cover.1739026302.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SOF_TIMESTAMPING_TX_COMPLETION also in cases where
errqueue.h is old and doesn't define it.

Support timestamps of different types arriving out of order, as multiple
SND may well arrive before COMPLETION.  Also allow TX timestamp arriving
before bthost receives data, as that may well happen.

Remove tests SCHED timestamps, as those won't be generated for now.

Don't test COMPLETION for SCO, since it's not supported now either.
---
 configure.ac         |  7 +++++++
 tools/iso-tester.c   | 36 +++++++++++-------------------------
 tools/l2cap-tester.c | 14 ++++++++------
 tools/sco-tester.c   |  8 ++++----
 tools/tester.h       | 42 +++++++++++++++++++++++++++++++++++-------
 5 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6a19487f6..75841e4c9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -389,6 +389,13 @@ AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable-testing],
 					[enable_testing=${enableval}])
 AM_CONDITIONAL(TESTING, test "${enable_testing}" = "yes")
 
+if (test "${enable_testing}" = "yes"); then
+   AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLETION],
+	[], [], [[#include <time.h>
+		#include <linux/errqueue.h>
+		#include <linux/net_tstamp.h>]])
+fi
+
 AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
 			[enable experimental tools]),
 					[enable_experimental=${enableval}])
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index c30c44ce9..b5e638808 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1066,20 +1066,10 @@ static const struct iso_client_data connect_send_tx_timestamping = {
 	.send = &send_16_2_1,
 	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_OPT_ID |
-					SOF_TIMESTAMPING_TX_SOFTWARE),
-	.repeat_send = 1,
-	.repeat_send_pre_ts = 2,
-};
-
-static const struct iso_client_data connect_send_tx_sched_timestamping = {
-	.qos = QOS_16_2_1,
-	.expect_err = 0,
-	.send = &send_16_2_1,
-	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_OPT_TSONLY |
-					SOF_TIMESTAMPING_TX_SCHED),
+					SOF_TIMESTAMPING_TX_COMPLETION),
 	.repeat_send = 1,
+	.repeat_send_pre_ts = 2,
 };
 
 static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
@@ -1087,7 +1077,8 @@ static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
-					SOF_TIMESTAMPING_TX_SOFTWARE),
+					SOF_TIMESTAMPING_OPT_TSONLY |
+					SOF_TIMESTAMPING_TX_COMPLETION),
 	.repeat_send = 1,
 	.cmsg_timestamping = true,
 };
@@ -1097,7 +1088,7 @@ static const struct iso_client_data connect_send_tx_no_poll_timestamping = {
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
-					SOF_TIMESTAMPING_TX_SOFTWARE),
+					SOF_TIMESTAMPING_TX_COMPLETION),
 	.repeat_send = 1,
 	.no_poll_errqueue = true,
 };
@@ -2241,10 +2232,10 @@ static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
 	err = tx_tstamp_recv(&data->tx_ts, sk, isodata->send->iov_len);
 	if (err > 0)
 		return TRUE;
-	else if (!err && !data->step)
-		tester_test_passed();
-	else
+	else if (err)
 		tester_test_failed();
+	else if (!data->step)
+		tester_test_passed();
 
 	data->io_id[2] = 0;
 	return FALSE;
@@ -2289,7 +2280,7 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 	int err;
 	unsigned int count;
 
-	if (!(isodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+	if (!(isodata->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
 	tester_print("Enabling TX timestamping");
@@ -2336,7 +2327,7 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 	}
 
 	if (isodata->cmsg_timestamping)
-		so &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
+		so &= ~TS_TX_RECORD_MASK;
 
 	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
 	if (err < 0) {
@@ -2374,7 +2365,7 @@ static void iso_send_data(struct test_data *data, GIOChannel *io)
 		cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
 
 		*((uint32_t *)CMSG_DATA(cmsg)) = (isodata->so_timestamping &
-					SOF_TIMESTAMPING_TX_RECORD_MASK);
+					TS_TX_RECORD_MASK);
 	}
 
 	ret = sendmsg(sk, &msg, 0);
@@ -3645,11 +3636,6 @@ int main(int argc, char *argv[])
 	test_iso("ISO Send - TX Timestamping", &connect_send_tx_timestamping,
 						setup_powered, test_connect);
 
-	/* Test schedule-time TX timestamps are emitted */
-	test_iso("ISO Send - TX Sched Timestamping",
-			&connect_send_tx_sched_timestamping, setup_powered,
-			test_connect);
-
 	/* Test TX timestamping with flags set via per-packet CMSG */
 	test_iso("ISO Send - TX CMSG Timestamping",
 			&connect_send_tx_cmsg_timestamping, setup_powered,
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 1780c9fbd..7f3be6c0f 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -381,7 +381,8 @@ static const struct l2cap_data client_connect_tx_timestamping_test = {
 	.data_len = sizeof(l2_data),
 	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_OPT_ID |
-					SOF_TIMESTAMPING_TX_SOFTWARE),
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_COMPLETION),
 	.repeat_send = 2,
 };
 
@@ -594,7 +595,8 @@ static const struct l2cap_data le_client_connect_tx_timestamping_test = {
 	.data_len = sizeof(l2_data),
 	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_OPT_ID |
-					SOF_TIMESTAMPING_TX_SOFTWARE),
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_COMPLETION),
 };
 
 static const struct l2cap_data le_client_connect_adv_success_test_1 = {
@@ -1345,10 +1347,10 @@ static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
 	err = tx_tstamp_recv(&data->tx_ts, sk, l2data->data_len);
 	if (err > 0)
 		return TRUE;
-	else if (!err && !data->step)
-		tester_test_passed();
-	else
+	else if (err)
 		tester_test_failed();
+	else if (!data->step)
+		tester_test_passed();
 
 	data->err_io_id = 0;
 	return FALSE;
@@ -1362,7 +1364,7 @@ static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
 	int err;
 	unsigned int count;
 
-	if (!(l2data->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+	if (!(l2data->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
 	sk = g_io_channel_unix_get_fd(io);
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 6fc26b7af..130ab526d 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -665,10 +665,10 @@ static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
 	err = tx_tstamp_recv(&data->tx_ts, sk, scodata->data_len);
 	if (err > 0)
 		return TRUE;
-	else if (!err && !data->step)
-		tester_test_passed();
-	else
+	else if (err)
 		tester_test_failed();
+	else if (!data->step)
+		tester_test_passed();
 
 	data->err_io_id = 0;
 	return FALSE;
@@ -682,7 +682,7 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 	int err;
 	unsigned int count;
 
-	if (!(scodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+	if (!(scodata->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
 	sk = g_io_channel_unix_get_fd(io);
diff --git a/tools/tester.h b/tools/tester.h
index b6de084a4..82770014f 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -20,6 +20,15 @@
 #define SEC_NSEC(_t)  ((_t) * 1000000000LL)
 #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
 
+#if !HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION
+#define SOF_TIMESTAMPING_TX_COMPLETION	(SOF_TIMESTAMPING_LAST << 1)
+#endif
+#if !HAVE_DECL_SCM_TSTAMP_COMPLETION
+#define SCM_TSTAMP_COMPLETION		(SCM_TSTAMP_ACK + 1)
+#endif
+#define TS_TX_RECORD_MASK		(SOF_TIMESTAMPING_TX_RECORD_MASK | \
+						SOF_TIMESTAMPING_TX_COMPLETION)
+
 struct tx_tstamp_data {
 	struct {
 		uint32_t id;
@@ -59,6 +68,13 @@ static inline int tx_tstamp_expect(struct tx_tstamp_data *data)
 		pos++;
 	}
 
+	if (data->so_timestamping & SOF_TIMESTAMPING_TX_COMPLETION) {
+		g_assert(pos < ARRAY_SIZE(data->expect));
+		data->expect[pos].type = SCM_TSTAMP_COMPLETION;
+		data->expect[pos].id = data->sent;
+		pos++;
+	}
+
 	data->sent++;
 
 	steps = pos - data->count;
@@ -77,6 +93,7 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 	struct scm_timestamping *tss = NULL;
 	struct sock_extended_err *serr = NULL;
 	struct timespec now;
+	unsigned int i;
 
 	iov.iov_base = buf;
 	iov.iov_len = sizeof(buf);
@@ -89,7 +106,7 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
 	ret = recvmsg(sk, &msg, MSG_ERRQUEUE);
 	if (ret < 0) {
-		if (ret == EAGAIN || ret == EWOULDBLOCK)
+		if (errno == EAGAIN || errno == EWOULDBLOCK)
 			return data->count - data->pos;
 
 		tester_warn("Failed to read from errqueue: %s (%d)",
@@ -147,18 +164,29 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 		return -EINVAL;
 	}
 
-	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
-				serr->ee_data != data->expect[data->pos].id) {
-		tester_warn("Bad timestamp id %u", serr->ee_data);
+	/* Find first unreceived timestamp of the right type */
+	for (i = 0; i < data->count; ++i) {
+		if (data->expect[i].type >= 0xffff)
+			continue;
+
+		if (serr->ee_info == data->expect[i].type) {
+			data->expect[i].type = 0xffff;
+			break;
+		}
+	}
+	if (i == data->count) {
+		tester_warn("Bad timestamp type %u", serr->ee_info);
 		return -EINVAL;
 	}
 
-	if (serr->ee_info != data->expect[data->pos].type) {
-		tester_warn("Bad timestamp type %u", serr->ee_info);
+	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
+				serr->ee_data != data->expect[i].id) {
+		tester_warn("Bad timestamp id %u", serr->ee_data);
 		return -EINVAL;
 	}
 
-	tester_print("Got valid TX timestamp %u", data->pos);
+	tester_print("Got valid TX timestamp %u (type %u, id %u)", i,
+						serr->ee_info, serr->ee_data);
 
 	++data->pos;
 
-- 
2.48.1

