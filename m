Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C93CF034
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245789; cv=pass; b=kpQQmbPjFQrNiz37GMRw4Rlg9jdZNWEAZzzOKcCTLhern1adf+qgzNXRPGwo4jaePyvVsWsBVcQPR2wGgWWwSs/EaIOtlJ1l1PYbZv2k2yLIQehv5/ASux8ksjididHbZsmOxaFqMXHhEOTTQEutptlHykSm5jmdai/r4pjCtsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245789; c=relaxed/simple;
	bh=MJSPH6SlKMqvRb90oPI4isyLrX/zd5zIVsOV1Ggu6x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q43jXjNHyf/4/p98/otYkwdICvLofuqHT3wjtPUL52KwIt8FrDK0MAxOojxVXYq8ZkmtBFHEc249VyfTa/zW8ZysKVQ0JDNqsN1JTcJ+8PsJUV+6u/wGzkUE6gWeUEKxl/wPe/oo1I0rPQ3xPU9FVpORlu/9ESDLtfREUBnrLz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=W8OmFb/0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="W8OmFb/0"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG8T5JMBzywH;
	Wed, 11 Mar 2026 18:16:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzGxNlR5Z6FXUVKqq4r+guokM8IO1FOL1GqXoY47Wpc=;
	b=W8OmFb/0ncOQYnGUbjBc7qpkPmmoq6UaIT++zDYT6ApY+J66FDsdMyqIcocJqN1P1d28di
	1UKyNLnjtm+BZym+eniNTfaMM5dg+7JhJUsc8kTVOguGAubvEd6DXUOH/hL0u08Iv59t99
	1jrLlE6Xt+ByR1N98jA80rwAFr+RK6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzGxNlR5Z6FXUVKqq4r+guokM8IO1FOL1GqXoY47Wpc=;
	b=DmrdcAyt0ZQxufmdtSahdpihdgfrQ3yDBiMU1EeXWlQc1hvBgmEkYJEzJ7l6JlQ8SkF+4g
	CZVDjQeux8XJzwhSyy/wGApIvitr4vwwVEOrtNCqGz8/n919hHpWW6sBdirHo/kH2tbZ9Q
	jOF85gCS1SMDqsdzALFE/OA0NdsGJg0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245786;
	b=Tp2tmL0gqv/vn9pgP8hAYaffbGGvCVovtimPNNaZ/jWDNddqTKucortfNKwMHnOT6UMflP
	1oDKa0Gv3Jbxu/kGVl0PfbYYoDSKiRs01MWT8WImRb275UENw+J297JMx5Njz969WEDDpM
	fSkVGWHIT8bznvbBx90FBnloRrnv+/A=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 4/4] iso-tester: Add test for sending ISO packets with set timestamps
Date: Wed, 11 Mar 2026 18:16:20 +0200
Message-ID: <4b9b7c88c31e7c391ff6a0cc1eb1ead1a5dc6a31.1773245673.git.pav@iki.fi>
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

Add test

ISO Send - Set HW Timestamp
---
 tools/iso-tester.c | 68 +++++++++++++++++++++++++++++++++++++++-------
 tools/tester.h     | 10 +++++++
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index fb04ab642..2d4408d56 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -522,6 +522,9 @@ struct iso_client_data {
 	 * Used for testing TX timestamping OPT_ID.
 	 */
 	unsigned int repeat_send;
+
+	/* Set HW timestamp on sent packets */
+	bool set_hw_tstamp;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
@@ -1076,6 +1079,16 @@ static const struct iso_client_data connect_send_swhw_timestamping = {
 	.repeat_send_pre_ts = 2,
 };
 
+static const struct iso_client_data connect_send_set_hw_timestamp = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_RAW_HARDWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_HARDWARE),
+	.set_hw_tstamp = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1710,6 +1723,9 @@ static void bthost_recv_data(const void *buf, uint16_t len, bool ts,
 			tester_test_failed();
 	} else if (!data->step)
 		tester_test_passed();
+
+	if (isodata->set_hw_tstamp && (timestamp != 0x1234 || sn != 1234))
+		tester_test_failed();
 }
 
 static void bthost_iso_disconnected(void *user_data)
@@ -2629,15 +2645,24 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 	int sk;
 	int err;
 	unsigned int count;
-	int64_t interval = 10000000ULL;
+	int64_t interval = 10000000ULL, hw_base;
 
 	if (!(isodata->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
 	tester_print("Enabling TX timestamping");
 
+	/* Note: these depend on emulator/btdev.c details */
+	if (!isodata->set_hw_tstamp) {
+		interval = 10000000ULL;
+		hw_base = (isodata->repeat_send_pre_ts + 1)*interval;
+	} else {
+		hw_base = 0x1234 * 1000 + 10000000ULL;
+		interval = 0;
+	}
+
 	tx_tstamp_init(&data->tx_ts, isodata->so_timestamping, false,
-			(isodata->repeat_send_pre_ts + 1)*interval, interval);
+			hw_base, interval);
 
 	for (count = 0; count < isodata->repeat_send + 1; ++count)
 		data->step += tx_tstamp_expect(&data->tx_ts, 0);
@@ -2661,12 +2686,12 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 static void iso_send_data(struct test_data *data, GIOChannel *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
-	char control[CMSG_SPACE(sizeof(uint32_t))];
+	char control[3 * CMSG_SPACE(sizeof(uint32_t))];
 	struct msghdr msg = {
 		.msg_iov = (struct iovec *)isodata->send,
 		.msg_iovlen = 1,
 	};
-	struct cmsghdr *cmsg;
+	struct cmsghdr *cmsg = NULL;
 	ssize_t ret;
 	int sk;
 
@@ -2674,20 +2699,39 @@ static void iso_send_data(struct test_data *data, GIOChannel *io)
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	if (isodata->cmsg_timestamping) {
-		memset(control, 0, sizeof(control));
-		msg.msg_control = control;
-		msg.msg_controllen = sizeof(control);
+	memset(control, 0, sizeof(control));
+	msg.msg_control = control;
+	msg.msg_controllen = 0;
+
+	if (isodata->cmsg_timestamping) {
+		msg.msg_controllen += CMSG_SPACE(sizeof(uint32_t));
+		cmsg = cmsg ? CMSG_NXTHDR(&msg, cmsg) : CMSG_FIRSTHDR(&msg);
 
-		cmsg = CMSG_FIRSTHDR(&msg);
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SO_TIMESTAMPING;
 		cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
-
 		*((uint32_t *)CMSG_DATA(cmsg)) = (isodata->so_timestamping &
 					TS_TX_RECORD_MASK);
 	}
 
+	if (isodata->set_hw_tstamp) {
+		msg.msg_controllen += CMSG_SPACE(sizeof(uint32_t));
+		cmsg = cmsg ? CMSG_NXTHDR(&msg, cmsg) : CMSG_FIRSTHDR(&msg);
+
+		cmsg->cmsg_level = SOL_BLUETOOTH;
+		cmsg->cmsg_type = BT_SCM_PKT_ISO_TS;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+		*((uint32_t *)CMSG_DATA(cmsg)) = 0x1234;
+
+		msg.msg_controllen += CMSG_SPACE(sizeof(uint16_t));
+		cmsg = CMSG_NXTHDR(&msg, cmsg);
+
+		cmsg->cmsg_level = SOL_BLUETOOTH;
+		cmsg->cmsg_type = BT_SCM_PKT_SEQNUM;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint16_t));
+		*((uint16_t *)CMSG_DATA(cmsg)) = 1234;
+	}
+
 	ret = sendmsg(sk, &msg, 0);
 	if (ret < 0 || isodata->send->iov_len != (size_t) ret) {
 		tester_warn("Failed to write %zu bytes: %s (%d)",
@@ -4126,6 +4170,10 @@ int main(int argc, char *argv[])
 			&connect_send_swhw_timestamping, setup_powered,
 			test_connect);
 
+	test_iso("ISO Send - Set HW Timestamp",
+			&connect_send_set_hw_timestamp, setup_powered,
+			test_connect);
+
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
diff --git a/tools/tester.h b/tools/tester.h
index cb28e9cea..d1ade4603 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -34,6 +34,16 @@
 #define TS_TX_RECORD_MASK		(SOF_TIMESTAMPING_TX_RECORD_MASK | \
 						SOF_TIMESTAMPING_TX_COMPLETION)
 
+#ifndef BT_PKT_SEQNUM
+#define BT_PKT_SEQNUM		22
+#endif
+#ifndef BT_SCM_PKT_SEQNUM
+#define BT_SCM_PKT_SEQNUM	0x05
+#endif
+#ifndef BT_SCM_PKT_ISO_TS
+#define BT_SCM_PKT_ISO_TS	0x06
+#endif
+
 struct tx_tstamp_data {
 	struct {
 		uint32_t id;
-- 
2.53.0

