Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13A2135A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324853; cv=pass; b=lIFZ3z6HlQDiTbubZ7ARoVI2o0k4/MxEslnveyj4TbTSxsR8gARURuEYw1hBg437ILusImQ1+5MCIPPccnD166NhQVsxZH4rlt1EngCuNazEuz1UI3AXYLfBB/Ph4uRYkr2uCkESL15l0aExeAPdP5FpaqRKAE4caGmHJ2L0UWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324853; c=relaxed/simple;
	bh=LlRTh97lVs60io/RKk9/rRoVhe7jKnWlh/fEOYZs2nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe6XELcarAkrGSe7CMGVujpN2KKuv67VAyhwIoJHx7UD55Wh8MnxAc22jUgrto/0Lus3+fIe1At6Bqla3+pYs4lmvTL7EJ3350acT7G8XMmEvD65JHeX2yimIyLqdKbNrjk2h4bXtMN6Ghk8eLHbEBs1gq2k9D115WcsKHSoeHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=s3/6MAQc; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ihWzwgNk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="s3/6MAQc";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ihWzwgNk"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4ZHLv15Lj8z49Q4h
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 21:07:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Izje6gMapeWCGDWjSnO3LPWsFN4yZFeC887+M4Lbxeo=;
	b=s3/6MAQcCpFvDoo3qHyMrdWvspTscOjBU87fPx3+yOeWqBStWU3IAIop8XILe2vMv6dyWo
	N5i26HQ3+/FnC8nzJ/66O2Ywixmt4LtB7lPvutmu1kafSXAbVt2sPDgQA+b9CUto8PJTjQ
	QnWCyR92JVDz9fMCXzXePsDP43AEhCyAqCUAbyb2Mk+N7oz1dnhMTB902MivnqYgMlyegs
	vM/L/k7ZjBN9LOpf1AodHOs8It93Y07NHUkEo1FzFF8CLADKEv1Pcw3FKY/+CZAWEq0M+M
	05MB6isE+niRa/TF+uKaCHoRAb6I2uZMt2h2rwE1UFxVsSQpgLPsRl2NL4cvjA==
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZHLts2Y36zydw;
	Tue, 18 Mar 2025 21:07:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1742324837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Izje6gMapeWCGDWjSnO3LPWsFN4yZFeC887+M4Lbxeo=;
	b=ihWzwgNkSafIPsxvP44wbanBaUGKRhnxXjx12hzWHoeivhgGz6Zsktmeotzei5Qczg1X2S
	tt9dXHEubfxMk5rarqTzbf/MeKUgsli0Ubh6W7Z+LOvUYyFA21FYwCJaGmY2o6beCEU0VK
	Ar4It2Ft/BhBg1LYX+yRmefAU8fu+5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1742324837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Izje6gMapeWCGDWjSnO3LPWsFN4yZFeC887+M4Lbxeo=;
	b=AG5/OGuDkZY9uMQ09gTf6yW5kk15CEva/mN1Ovx3sQvhCS/GIWuTJ7i5GSkLojHLaBFbdp
	TSji6L7jqB7RusVnXZJdUVbLSckZqysTt8t6MenrRhdFSePXPwrBOS9vDztI9LnrLwBv5d
	xqV0TGXMQWRmsQPV7PHOGPDZ+QH/H3Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1742324837; a=rsa-sha256; cv=none;
	b=Cw4gBgjJPL17K3GFDIRbgIqTYbbM+1a6xe5olAnGGgMLHWQVf5GyAT9Op27vuhtLTNcjt7
	Zqp7MTjYkAXvzWy7Monn9o3QccajCuGz2wFeeuu9zDftZj5w0llm95NxIvyqLFlYPoLYgt
	7NFKiY9LXL+Ez9mwjOiPBKzB7YD8bjY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/3] l2cap-tester: add test for stream socket TX timestamping
Date: Tue, 18 Mar 2025 21:07:09 +0200
Message-ID: <50b21880919e75d61615f9c389521ff179216d5b.1742324646.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
References: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stream socket TX timestamp ids shall refer to the byte positions.
Add test:

L2CAP BR/EDR Client - Stream TX Timestamping
---
 tools/iso-tester.c   |  4 ++--
 tools/l2cap-tester.c | 32 ++++++++++++++++++++++++++++----
 tools/sco-tester.c   |  4 ++--
 tools/tester.h       | 12 +++++++++---
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b5e638808..ad0738091 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2285,10 +2285,10 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	tester_print("Enabling TX timestamping");
 
-	tx_tstamp_init(&data->tx_ts, isodata->so_timestamping);
+	tx_tstamp_init(&data->tx_ts, isodata->so_timestamping, false);
 
 	for (count = 0; count < isodata->repeat_send + 1; ++count)
-		data->step += tx_tstamp_expect(&data->tx_ts);
+		data->step += tx_tstamp_expect(&data->tx_ts, 0);
 
 	sk = g_io_channel_unix_get_fd(io);
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 7f3be6c0f..395e76dbc 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -102,6 +102,9 @@ struct l2cap_data {
 
 	/* Number of additional packets to send. */
 	unsigned int repeat_send;
+
+	/* Socket type (0 means SOCK_SEQPACKET) */
+	int sock_type;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -386,6 +389,19 @@ static const struct l2cap_data client_connect_tx_timestamping_test = {
 	.repeat_send = 2,
 };
 
+static const struct l2cap_data client_connect_stream_tx_timestamping_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.write_data = l2_data,
+	.data_len = sizeof(l2_data),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_COMPLETION),
+	.repeat_send = 2,
+	.sock_type = SOCK_STREAM,
+};
+
 static const struct l2cap_data client_connect_shut_wr_success_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -1371,10 +1387,11 @@ static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	tester_print("Enabling TX timestamping");
 
-	tx_tstamp_init(&data->tx_ts, l2data->so_timestamping);
+	tx_tstamp_init(&data->tx_ts, l2data->so_timestamping,
+					l2data->sock_type == SOCK_STREAM);
 
 	for (count = 0; count < l2data->repeat_send + 1; ++count)
-		data->step += tx_tstamp_expect(&data->tx_ts);
+		data->step += tx_tstamp_expect(&data->tx_ts, l2data->data_len);
 
 	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
 	if (err < 0) {
@@ -1523,9 +1540,12 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 	const uint8_t *central_bdaddr;
 	struct sockaddr_l2 addr;
 	int sk, err;
+	int sock_type = SOCK_SEQPACKET;
 
-	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,
-							BTPROTO_L2CAP);
+	if (l2data && l2data->sock_type)
+		sock_type = l2data->sock_type;
+
+	sk = socket(PF_BLUETOOTH, sock_type | SOCK_NONBLOCK, BTPROTO_L2CAP);
 	if (sk < 0) {
 		err = -errno;
 		tester_warn("Can't create socket: %s (%d)", strerror(errno),
@@ -2523,6 +2543,10 @@ int main(int argc, char *argv[])
 					&client_connect_tx_timestamping_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - Stream TX Timestamping",
+				&client_connect_stream_tx_timestamping_test,
+				setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Invalid PSM 1",
 					&client_connect_nval_psm_test_1,
 					setup_powered_client, test_connect);
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 7a4d684be..145506321 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -773,10 +773,10 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	tester_print("Enabling TX timestamping");
 
-	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping);
+	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping, false);
 
 	for (count = 0; count < scodata->repeat_send + 1; ++count)
-		data->step += tx_tstamp_expect(&data->tx_ts);
+		data->step += tx_tstamp_expect(&data->tx_ts, 0);
 
 	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
 	if (err < 0) {
diff --git a/tools/tester.h b/tools/tester.h
index 802c92e96..4e7d7226b 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -38,22 +38,27 @@ struct tx_tstamp_data {
 	unsigned int count;
 	unsigned int sent;
 	uint32_t so_timestamping;
+	bool stream;
 };
 
 static inline void tx_tstamp_init(struct tx_tstamp_data *data,
-				uint32_t so_timestamping)
+				uint32_t so_timestamping, bool stream)
 {
 	memset(data, 0, sizeof(*data));
 	memset(data->expect, 0xff, sizeof(data->expect));
 
 	data->so_timestamping = so_timestamping;
+	data->stream = stream;
 }
 
-static inline int tx_tstamp_expect(struct tx_tstamp_data *data)
+static inline int tx_tstamp_expect(struct tx_tstamp_data *data, size_t len)
 {
 	unsigned int pos = data->count;
 	int steps;
 
+	if (data->stream && len)
+		data->sent += len - 1;
+
 	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SCHED) {
 		g_assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_SCHED;
@@ -75,7 +80,8 @@ static inline int tx_tstamp_expect(struct tx_tstamp_data *data)
 		pos++;
 	}
 
-	data->sent++;
+	if (!data->stream || len)
+		data->sent++;
 
 	steps = pos - data->count;
 	data->count = pos;
-- 
2.48.1

