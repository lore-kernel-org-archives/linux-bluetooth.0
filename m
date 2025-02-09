Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500F156230
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097608; cv=pass; b=AevRZCcDbnNpAEYtNOVjeX19z02FCCpyAP83g94ygdRQ2ZEKgoIfVPew0xtNKUEvo5xBQbNwlgsz364ydhpl9I1KlJaeEWSPctLl31BUUienc3NSHwkC/3vwasde+WYTShF+LWwKojiF3nuABzbTwRrbsrppZ/wnzDpLwQiOX8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097608; c=relaxed/simple;
	bh=rwb4TSe+AMqNTl8vvhFOsmLtxecmTYXF65mJCysLNyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWftm3cCQyfMGz6ThgWCnC1GFqETj+mhL80DzX+t5PBdKarC9outXTAbS/AMxehlZCLbGphNqnGn2VAXUoet7lzoWigP2e+EzPVC+DDevUsjfFcWfy27dpqMeNbiKdeJ5c+pPM36z9YyqHpW4optKNR/6Lr4ukn26vTgHxj1bnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=K9drfrJ1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="K9drfrJ1"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPNh2vwCz49Q8f;
	Sun,  9 Feb 2025 12:40:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=069MKW1HASgDTP9DVzl7X5YvjQ78Pp+mwBLwBlR5wfE=;
	b=K9drfrJ12+e7MhBiGjFr7fa9ifhNUxz8Y6vCF1eOWSCAsrAO9GLI86seUKSYKsNzEOBbhy
	LGAcXLswkno8obzOVhy8fpj3dV0L3whrmm6YpqLwtEluc9JfcB6Yk2uWIAmCWfmcvP3rf8
	yRToHrx70AmIcTeUTnSNyi/VZNVShoAOiqLLkxZkwsix9hKYEV2pCgcverJ/8Shf5qbAPw
	HTjwO2/oGcGHK6qOYaoizZlOxHR8mVBeEUaZcZ+ddCyt1hqIUKDDAxKLahSfQJbXww6o8V
	oZXZDJa0UGc+LCH8mZxtDpC6KoKmb7jYG22TXHV+IKugMbRpeV+Sy2J4kn3itw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097605; a=rsa-sha256;
	cv=none;
	b=GCFLCSwNj0Vgtwvox3zRlk1j1KOgK9KWK8tKaOiB7cfToF4C6ua4bmFj00mA9sBaRUhY5l
	oWso05wfGiQ1IBwQB62Z5FJAGjXB2Iz+jk1O0mkctUk2N7Cjoe6N34JjEZBkm5WSwiroma
	VkAg5s+mEYewsxTBOpBI1RVJCoK7Qfu89s/ibbvQBRxsJ3hdW/ZwaBRVdpcbU1yBijoBWS
	56XTBB/j1b707xX/3IBE6pcR0u9glmuL0PBJ9FZaRpPGOL5Yf5f2HZDe8wdQudxfclc7SS
	75dlOz45tbz3JxNwvcQJqsoM3RFgElAqOcfSSg+wXsSG86R3eGl795iLFe0sxQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=069MKW1HASgDTP9DVzl7X5YvjQ78Pp+mwBLwBlR5wfE=;
	b=SYfw7jXH8DV2xiZ9AjgZfMC9/pdgx8VTMmHMCur6a0uO47xo4aLWcXz9VUzV55f7YN301T
	IT6v9a6+hBJ/OXQ7MTVw9za/7yY7nXBingTyaRqAHbPzoYAotA5gfpBxgthihSt20LanoK
	UTF09GTt/wVAaabec42tgO41z1mnVd6kQGHXVn1FBAgaL/Qj+j1V1PE6sPHVskEP/lOn6A
	NcSxjdHb+Wa9lxaZMwuDWxTfvzel8m/zx2w9DwZ5FDEi0XYwqvwA3+gJnb9Tzq85HxIykh
	SqvVTivpjJp+ITR4hmAWjTr5UNy2I+IqixEy/4iaBAlfkEp7ol0HAi8yjwhTMw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] l2cap-tester: add test for stream socket TX timestamping
Date: Sun,  9 Feb 2025 12:39:56 +0200
Message-ID: <2f91b56dfcab5c3d163274667ea3bdca404bce77.1739026302.git.pav@iki.fi>
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
index 130ab526d..ae76b1ddd 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -689,10 +689,10 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	tester_print("Enabling TX timestamping");
 
-	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping);
+	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping, false);
 
 	for (count = 0; count < scodata->repeat_send + 1; ++count)
-		data->step += tx_tstamp_expect(&data->tx_ts);
+		data->step += tx_tstamp_expect(&data->tx_ts, 0);
 
 	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
 	if (err < 0) {
diff --git a/tools/tester.h b/tools/tester.h
index 82770014f..14aa1e3ab 100644
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

