Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9C212FAA
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324849; cv=pass; b=q22YHjF8wEehqJR1aHCT/cWNPMjQDTddPt01Vwo6ev/CDU8SVzUtYaZuNgg03WR/52PInmPs3pb5pNcJf9pwN6UvEoWoZGiKoxMwwlo2QPf3QEbIvz5jMoOnPm3XPyXSdW5thO/icO7rEvGcX7hAdSI6If/IP7c4qdIAU+V73XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324849; c=relaxed/simple;
	bh=G79H5nJ0coECr2Z5xM/xbB8ndEIT9uqHORjSJkp4UY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+EgAXHagdDGwgHjiPi5A0GtnmM7/cwN+4/E8nYLuW2rJhvubkU9q0r8XpyLiEXemjLeXTOt8N+lmHlnvulFZQEzJYEmKNMo6Pqg6GiunxZnHuTjawO9mMw1YT1iHNJKDrZA4PUrgDubRucB9OOQWr4LTFg9O4Pw0Haq3u3LDd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=QhJ+pWy0; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dbqZZrAQ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="QhJ+pWy0";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dbqZZrAQ"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4ZHLv106csz49PyD
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 21:07:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OtPocZcbfzDbcNvER8hSSVbMgB59Pkf4i+XHDiWBlCk=;
	b=QhJ+pWy08HsDDzPXwoaZzOGWApZa7W6Z1wNBghtY4Qs8l2/381PbshwiVvgPB2FhHc87uL
	JIJ+JEOJYgHNwBWbC8WUL4B+PPxLIWA5b0+ZrZXiOXYRlBqXnHXqIvS4KZJB7IwyYF/+ym
	6WkGXUfzx+Ix3GGcCqaUp2nhh15V5B3F9cHCAZuk6JYu3AwFEgz47nxOOmfdRKXNWNT/o6
	Dg4sshxi4HpOrm7Sk7Kcrduty02qfrA07rbAaxhZD76gmEQT1jIRzfpDH4AeEe9og5lNyN
	MmKKI8PAfRtvGJ4VE3ODBwDDBvOBO/09qMqNmug0YM+YGXsgWLktuAXm8TSnWw==
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZHLtq2mlyzyZM;
	Tue, 18 Mar 2025 21:07:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1742324835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OtPocZcbfzDbcNvER8hSSVbMgB59Pkf4i+XHDiWBlCk=;
	b=dbqZZrAQR8BMlbUn61CGvau2EEkhzc0nWiD6+vut2NqfQvwoul4QdPOwVetv2wS67OKga0
	szodTZRZBMYVcxWCSOSOfiezSz5Vc9cmwLyVTLjdATCtj6ajT/vVihO/GCaw6mZ4UD+vCp
	1BUYdLMqMbGqZsU8qNWWXDYR9KgFyRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1742324835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OtPocZcbfzDbcNvER8hSSVbMgB59Pkf4i+XHDiWBlCk=;
	b=XN6hky6siq1xSbdNefqGOmueqqFfOqH++3+AbJ8e9dgu10tYPR0AWuiJ2BP6hT3o2fwgk1
	Dc+mnOhiAJKfrtWYTvJlevkf/TWLXb0oKZbISYmTpyAdpd32t+8bO1orFblAqAgTK4NTRv
	+QNTW0q8PHdVDlcystbh7DyDmsJIphM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1742324835; a=rsa-sha256; cv=none;
	b=owiOout0kIe6hnQhI4o+YxIn/TO5RXvHU78Xk9KaAihRQdYuqwEGSnkp6/nFPzy0XJpecR
	HDgUiPhmxF0IWmawqsfJFYucMpCmg1tKt9um7xGQwHfqwFIm8C/0f2TQE5dSXZpifu2z9L
	sERBuX64aaLMrfyCPALLpztgYhiB040=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/3] tools/tester: test COMPLETION timestamps
Date: Tue, 18 Mar 2025 21:07:08 +0200
Message-ID: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
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

Add test:

SCO CVSD Send No Flowctl - TX Timestamping
---
 configure.ac         |  7 +++++++
 tools/iso-tester.c   | 36 +++++++++++-------------------------
 tools/l2cap-tester.c | 14 ++++++++------
 tools/sco-tester.c   | 23 +++++++++++++++++++----
 tools/tester.h       | 44 ++++++++++++++++++++++++++++++++++++--------
 5 files changed, 81 insertions(+), 43 deletions(-)

diff --git a/configure.ac b/configure.ac
index a016c993f..0fa49f686 100644
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
@@ -1066,28 +1066,19 @@ static const struct iso_client_data connect_send_tx_timestamping = {
 	.send = &send_16_2_1,
 	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_OPT_ID |
-					SOF_TIMESTAMPING_TX_SOFTWARE),
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_COMPLETION),
 	.repeat_send = 1,
 	.repeat_send_pre_ts = 2,
 };
 
-static const struct iso_client_data connect_send_tx_sched_timestamping = {
-	.qos = QOS_16_2_1,
-	.expect_err = 0,
-	.send = &send_16_2_1,
-	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
-					SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_OPT_TSONLY |
-					SOF_TIMESTAMPING_TX_SCHED),
-	.repeat_send = 1,
-};
-
 static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
 	.qos = QOS_16_2_1,
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
index b88631d89..7a4d684be 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -314,6 +314,17 @@ static const struct sco_client_data connect_send_success = {
 };
 
 static const struct sco_client_data connect_send_tx_timestamping = {
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.send_data = data,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_COMPLETION),
+	.repeat_send = 2,
+};
+
+static const struct sco_client_data connect_send_no_flowctl_tx_timestamping = {
 	.expect_err = 0,
 	.data_len = sizeof(data),
 	.send_data = data,
@@ -738,10 +749,10 @@ static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
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
@@ -755,7 +766,7 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 	int err;
 	unsigned int count;
 
-	if (!(scodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+	if (!(scodata->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
 	sk = g_io_channel_unix_get_fd(io);
@@ -1142,6 +1153,10 @@ int main(int argc, char *argv[])
 					&connect_send_tx_timestamping,
 					setup_powered, test_connect);
 
+	test_sco_no_flowctl("SCO CVSD Send No Flowctl - TX Timestamping",
+				&connect_send_no_flowctl_tx_timestamping,
+				setup_powered, test_connect);
+
 	test_sco_11("SCO CVSD 1.1 Send - Success", &connect_send_success,
 					setup_powered, test_connect);
 
diff --git a/tools/tester.h b/tools/tester.h
index b6de084a4..802c92e96 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -20,6 +20,15 @@
 #define SEC_NSEC(_t)  ((_t) * 1000000000LL)
 #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
 
+#if !HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION
+#define SOF_TIMESTAMPING_TX_COMPLETION	(1 << 18)
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
-		return -EINVAL;
-	}
+	/* Find first unreceived timestamp of the right type */
+	for (i = 0; i < data->count; ++i) {
+		if (data->expect[i].type >= 0xffff)
+			continue;
 
-	if (serr->ee_info != data->expect[data->pos].type) {
+		if (serr->ee_info == data->expect[i].type) {
+			data->expect[i].type = 0xffff;
+			break;
+		}
+	}
+	if (i == data->count) {
 		tester_warn("Bad timestamp type %u", serr->ee_info);
 		return -EINVAL;
 	}
 
-	tester_print("Got valid TX timestamp %u", data->pos);
+	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
+				serr->ee_data != data->expect[i].id) {
+		tester_warn("Bad timestamp id %u", serr->ee_data);
+		return -EINVAL;
+	}
+
+	tester_print("Got valid TX timestamp %u (type %u, id %u)", i,
+						serr->ee_info, serr->ee_data);
 
 	++data->pos;
 
-- 
2.48.1

