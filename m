Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F3372B44
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245788; cv=pass; b=Tq8Ju/LX8bUEwyRtqM1ODD2CIHiJba00mhYNQlOGZuICueS3vOcdK++tFkmOc/KRMFERl0F6eHkf8+T4nWAkfkjAtdsqERoCbMy5NBeEBIVoILlQbv0F9wA/4cGHnn6ElTM7CUqCBnRdifTVNHe4xYHXd6Q4JPjxysb2ZcqDl0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245788; c=relaxed/simple;
	bh=1fLln2td069EBYmkdMtJtaIwPgp6zyoHvJgsOLt+lZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC6iERxFi83lIIvIyceWuFgSGD8FYk/UEhkUAK2DqmMs/y/Ed2It2La8C2pseVwJj0edDwMD4NcnifpU1ENHKo/GfJWXkCunufF5WRhX0BigfpUf9y1eF1erivNRM67ga9XWeg3jg4KOx0/icQnRQem+I9BZ2UDl3NsUniEHD8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=up5trVJN; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="up5trVJN"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG8T0K0mzyw9;
	Wed, 11 Mar 2026 18:16:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7u6QDPOZ/84xkSgw6FTKJkXAmYOMHjksTJyAQ/6zIU=;
	b=up5trVJNxxkw1U3xDjaHp9/72q6YC1+erSVGd2mW02IXmVf1TCeZuhVK4kJXL60+nrs0KK
	KqlV5QkW1VV22WSoie9YhWFEUG5k09QBidthtx7ylXrL0escmBNtn0ZhjOrSsIa/xqP7q5
	/U94X2W7mF7+QuMHlhh8efa8A+mVpfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7u6QDPOZ/84xkSgw6FTKJkXAmYOMHjksTJyAQ/6zIU=;
	b=whmQ04y+vMvCl5TSw8qCzxEsR6c676MY9W8Lp2/6wgumcBO1gx6rgJF7iZyMPdLMLIpxPM
	cTcDvPxqB45QZ7h5YLGF7Mlswq9IrkdzkdZy0E5zv2SwpZWL0Pk/YiOdv8fZTqulnwC056
	WR8MmqlZlwMyc5FsH9xMDCGytVh3Zic=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245785;
	b=AYSd2oTmgPUpqjzPbYxFQo8Mwt8euuZQG+ZGpfNZCmC0w0PExE+XwfklUC32ZpnrO/yPCd
	mUuUF3oh4wSM/UTGUhjahLyvmnXEFR93ZykLl2qr3P9McxOLVftBeA17yoTwz3vaOZkmoM
	EF5EFP1tbnKnrA2JZv47e82XFuNpiZ8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 3/4] iso-tester: add tests for ISO HW timestamps
Date: Wed, 11 Mar 2026 18:16:19 +0200
Message-ID: <095ffc4c52e432c97b7a2ca4c2541c216e3bb450.1773245672.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773245672.git.pav@iki.fi>
References: <cover.1773245672.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that check LE Read ISO TX Sync handling in kernel

ISO Send - HW Timestamping
ISO Send - SWHW Timestamping
---
 tools/iso-tester.c   | 36 +++++++++++++++++++++++++-
 tools/l2cap-tester.c |  2 +-
 tools/sco-tester.c   |  2 +-
 tools/tester.h       | 60 +++++++++++++++++++++++++++++++++++++-------
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 2ddb29a00..fb04ab642 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1051,6 +1051,31 @@ static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
 	.cmsg_timestamping = true,
 };
 
+static const struct iso_client_data connect_send_hw_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_RAW_HARDWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_HARDWARE),
+	.repeat_send = 1,
+	.repeat_send_pre_ts = 2,
+};
+
+static const struct iso_client_data connect_send_swhw_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_RAW_HARDWARE |
+					SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_HARDWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_TX_SWHW),
+	.repeat_send = 1,
+	.repeat_send_pre_ts = 2,
+};
+
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2604,13 +2629,15 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 	int sk;
 	int err;
 	unsigned int count;
+	int64_t interval = 10000000ULL;
 
 	if (!(isodata->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
 	tester_print("Enabling TX timestamping");
 
-	tx_tstamp_init(&data->tx_ts, isodata->so_timestamping, false);
+	tx_tstamp_init(&data->tx_ts, isodata->so_timestamping, false,
+			(isodata->repeat_send_pre_ts + 1)*interval, interval);
 
 	for (count = 0; count < isodata->repeat_send + 1; ++count)
 		data->step += tx_tstamp_expect(&data->tx_ts, 0);
@@ -4092,6 +4119,13 @@ int main(int argc, char *argv[])
 			&connect_send_tx_cmsg_timestamping, setup_powered,
 			test_connect);
 
+	test_iso("ISO Send - HW Timestamping", &connect_send_hw_timestamping,
+						setup_powered, test_connect);
+
+	test_iso("ISO Send - SWHW Timestamping",
+			&connect_send_swhw_timestamping, setup_powered,
+			test_connect);
+
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index c3aa96f84..5fd1f058f 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1810,7 +1810,7 @@ static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
 	tester_print("Enabling TX timestamping");
 
 	tx_tstamp_init(&data->tx_ts, l2data->so_timestamping,
-					l2data->sock_type == SOCK_STREAM);
+					l2data->sock_type == SOCK_STREAM, 0, 0);
 
 	for (count = 0; count < l2data->repeat_send + 1; ++count)
 		data->step += tx_tstamp_expect(&data->tx_ts, l2data->data_len);
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 3d6b59092..a4483cfdc 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -882,7 +882,7 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	tester_print("Enabling TX timestamping");
 
-	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping, false);
+	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping, false, 0, 0);
 
 	for (count = 0; count < scodata->repeat_send + 1; ++count)
 		data->step += tx_tstamp_expect(&data->tx_ts, 0);
diff --git a/tools/tester.h b/tools/tester.h
index 9df600f90..cb28e9cea 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -38,50 +38,73 @@ struct tx_tstamp_data {
 	struct {
 		uint32_t id;
 		uint32_t type;
+		int64_t value;
+		bool sw;
 	} expect[16];
 	unsigned int pos;
 	unsigned int count;
 	unsigned int sent;
 	uint32_t so_timestamping;
 	bool stream;
+	int64_t hw_base;
+	int64_t hw_step;
 };
 
 static inline void tx_tstamp_init(struct tx_tstamp_data *data,
-				uint32_t so_timestamping, bool stream)
+			uint32_t so_timestamping, bool stream,
+			int64_t hw_base, int64_t hw_step)
 {
 	memset(data, 0, sizeof(*data));
 	memset(data->expect, 0xff, sizeof(data->expect));
 
 	data->so_timestamping = so_timestamping;
 	data->stream = stream;
+	data->hw_base = hw_base;
+	data->hw_step = hw_step;
 }
 
 static inline int tx_tstamp_expect(struct tx_tstamp_data *data, size_t len)
 {
+	uint32_t ts = data->so_timestamping;
 	unsigned int pos = data->count;
 	int steps;
 
 	if (data->stream && len)
 		data->sent += len - 1;
 
-	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SCHED) {
+	if (ts & SOF_TIMESTAMPING_TX_SCHED) {
 		g_assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_SCHED;
 		data->expect[pos].id = data->sent;
+		data->expect[pos].sw = true;
 		pos++;
 	}
 
-	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE) {
+	if ((ts & SOF_TIMESTAMPING_TX_SOFTWARE) &&
+					(!(ts & SOF_TIMESTAMPING_TX_HARDWARE) ||
+					(ts & SOF_TIMESTAMPING_OPT_TX_SWHW))) {
 		g_assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_SND;
 		data->expect[pos].id = data->sent;
+		data->expect[pos].sw = true;
 		pos++;
 	}
 
-	if (data->so_timestamping & SOF_TIMESTAMPING_TX_COMPLETION) {
+	if (ts & SOF_TIMESTAMPING_TX_COMPLETION) {
 		g_assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_COMPLETION;
 		data->expect[pos].id = data->sent;
+		data->expect[pos].sw = true;
+		pos++;
+	}
+
+	if (ts & SOF_TIMESTAMPING_TX_HARDWARE) {
+		g_assert(pos < ARRAY_SIZE(data->expect));
+		data->expect[pos].type = SCM_TSTAMP_SND;
+		data->expect[pos].value = data->hw_base +
+			data->sent * data->hw_step;
+		data->expect[pos].id = data->sent;
+		data->expect[pos].sw = false;
 		pos++;
 	}
 
@@ -105,6 +128,7 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 	struct sock_extended_err *serr = NULL;
 	struct timespec now;
 	unsigned int i;
+	bool sw = true;
 
 	iov.iov_base = buf;
 	iov.iov_len = sizeof(buf);
@@ -156,6 +180,9 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 		return -EINVAL;
 	}
 
+	if (!TS_NSEC(tss->ts))
+		sw = false;
+
 	if (serr->ee_errno != ENOMSG ||
 				serr->ee_origin != SO_EE_ORIGIN_TIMESTAMPING) {
 		tester_warn("BT_SCM_ERROR wrong for timestamping");
@@ -164,8 +191,9 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
 	clock_gettime(CLOCK_REALTIME, &now);
 
-	if (TS_NSEC(&now) < TS_NSEC(tss->ts) ||
-			TS_NSEC(&now) > TS_NSEC(tss->ts) + SEC_NSEC(10)) {
+	/* SW timestamp */
+	if (sw && (TS_NSEC(&now) < TS_NSEC(tss->ts) ||
+			TS_NSEC(&now) > TS_NSEC(tss->ts) + SEC_NSEC(10))) {
 		tester_warn("nonsense in timestamp");
 		return -EINVAL;
 	}
@@ -180,6 +208,9 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 		if (data->expect[i].type >= 0xffff)
 			continue;
 
+		if (sw != data->expect[i].sw)
+			continue;
+
 		if (serr->ee_info == data->expect[i].type) {
 			data->expect[i].type = 0xffff;
 			break;
@@ -190,14 +221,22 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 		return -EINVAL;
 	}
 
+	/* Note: +1 is kernel-provided offset since can't report 0 tstamp */
+	if (!sw && TS_NSEC(&tss->ts[2]) != data->expect[i].value + 1) {
+		tester_print("Bad HW timestamp %u != %u",
+					(unsigned int)TS_NSEC(&tss->ts[2]),
+					(unsigned int)data->expect[i].value);
+		return -EINVAL;
+	}
+
 	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
-				serr->ee_data != data->expect[i].id) {
+					serr->ee_data != data->expect[i].id) {
 		tester_warn("Bad timestamp id %u", serr->ee_data);
 		return -EINVAL;
 	}
 
-	tester_print("Got valid TX timestamp %u (type %u, id %u)", i,
-						serr->ee_info, serr->ee_data);
+	tester_print("Got valid TX timestamp %u (type %u, %s, id %u)", i,
+				serr->ee_info, sw ? "SW" : "HW", serr->ee_data);
 
 	++data->pos;
 
@@ -318,6 +357,9 @@ static inline void test_ethtool_get_ts_info(unsigned int index, int proto,
 		SOF_TIMESTAMPING_TX_COMPLETION;
 	int sk;
 
+	if (proto == BTPROTO_ISO)
+		so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE;
+
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, proto);
 	if (sk < 0) {
 		if (sk == -EPROTONOSUPPORT)
-- 
2.53.0

