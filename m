Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFF7762C
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440500; cv=pass; b=DwMSC35RTE20MwFyMAeVgcTTw60O7JiUoQGLkTVDwApVs1qjpsEGCVgfWfbGFh9QMUYEVJg9HlbWg1EY8pHPnavDVTgCOILOd0MJqJz2jaBAgYZSSFzLwwULj2tOwcaipJWd5l/0p7TtTFqfie6htYgrFxqJg4ZW/N1HBNDDV+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440500; c=relaxed/simple;
	bh=TCLET5blhARH0Y9rYNPn+iH8jknXfTvFaUVSR0DWYpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbWViCfMSno26dDK1mL+wXxxPrnBkS9YAmQR0msVU92/vwxwfxxWifvi0qPr9PjlC7rDSDSzWEFjeX4sBtVpDqnf+enfyY0GAHskw20Be8yuegJJcDSnB+si6rudh6NHg7ly3JPVPesxnmbh/E2srdyikX4IboKBS9cmqR4b+iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=oyaLvVsK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="oyaLvVsK"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLP6NmQz49Pyr;
	Thu, 14 Mar 2024 20:21:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrP4Nncol27MzA8D+MQJQLCx3rKITNmukLoTjk6w3oE=;
	b=oyaLvVsKzAReYTyenafIKDuFToCkzIAYDrlpkUfoHE/IHZTHQFy5trS+7VJ1DCNYOhNbhO
	XVr58AyEooP4WERfFxzPN6/64U5atNZDo1joV6cr6hNeNowhTIbOBJ02VGeq4k0ltixtBh
	1Iy/ZsCBO17ZRlYRahzbU1aXahyaIhNaqxjFbY8ka3h/xrj2AToAKPExh2S4zhMoHYICv0
	8k18+H6zEQOaQzZBshVScoPZVrpRVkRAVlqQFtZLLym2/ZkJvbwkaAmuyWuKeJk4EbuWcY
	4SxZqMKulBKg975oUTdPlDI8ZlNnlB1o2oyRsTI5te8GncrTJqBObdkGOLKDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrP4Nncol27MzA8D+MQJQLCx3rKITNmukLoTjk6w3oE=;
	b=D8jPqvWSGfldUy/457y6esNZ62+fJwtC1xCRj2cURv8Ao0BeEwbMI9dOHCS3MOXERpcrrS
	xhoTptbU7KoufY6ij0PMOPueb1D0IoCImFYdR1NQDdgm7M2+uzw8DI6iX/u+glupg0tbJH
	2eQaUGPwBBuVuvdlwwV+nD8bTFurMY3oJOmYdMcsrG7jsQiyJjQNzzVYxr3Bq+QwIPkQXN
	/risISK5RItG6FO99HcEHQACdM76HhsAQsZMYWY9mIdxsNekF1ohkKVcUoNMM5yLNueYnV
	Mq6Xq0z2xFVLxvJ2G4jlpd2fc+UwKTCMCMUaqTEj8Tsg7fZ8fo4sRsCfWxBtqA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440494; a=rsa-sha256;
	cv=none;
	b=oOL4h+HRA0uncG1PPy1MMuGech0dXgunvtLcEW7JElxrwN4q0ceyuS3ST37j90aGjQOC/y
	g/TqFRP/1cQDd+4YyiZKGxWYZZQHogeyJor2K2hoC7NJTqMT3qseH1eWri7FdNW1d3hiqn
	3mqVOqPgw1x+eFhdxKgyVIZxAIVEoHnE6AG2NJ67ktG0tSpWzMjt8DHoXsCCMCiYgdJZsW
	kWiJzcTHxKYf78mytwEkjbHWouAvNGLCSIlznxrR/CVAiM/NC9ox9psWqh7+DRjb5VyqZI
	BxvP8g+kpbtR49sRMFkHEf0ykXCXQBZErtOiV/R53yKhxCIgacrOSLkQ8In1sA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 8/9] l2cap-tester: add tests for LE Client read/write/tx-timestamping
Date: Thu, 14 Mar 2024 20:21:17 +0200
Message-ID: <2b4931513287038026c73ebbee40965346b83ca5.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440408.git.pav@iki.fi>
References: <cover.1710440408.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests:

L2CAP LE Client - Read Success
L2CAP LE Client - Write Success
L2CAP LE Client - TX Timestamping
---
 tools/l2cap-tester.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index f990110d9..d7f2e481a 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -484,6 +484,30 @@ static const struct l2cap_data le_client_connect_timeout_test_1 = {
 	.timeout = 1,
 };
 
+static const struct l2cap_data le_client_connect_read_success_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.read_data = l2_data,
+	.data_len = sizeof(l2_data),
+};
+
+static const struct l2cap_data le_client_connect_write_success_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.write_data = l2_data,
+	.data_len = sizeof(l2_data),
+};
+
+static const struct l2cap_data le_client_connect_tx_timestamping_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.write_data = l2_data,
+	.data_len = sizeof(l2_data),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+};
+
 static const struct l2cap_data le_client_connect_adv_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1079,6 +1103,8 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	char buf[1024];
 	int sk;
 
+	tester_debug("Client received data");
+
 	sk = g_io_channel_unix_get_fd(io);
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
 		tester_warn("Unable to read %u bytes", l2data->data_len);
@@ -1123,6 +1149,8 @@ static void bthost_received_data(const void *buf, uint16_t len,
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 
+	tester_debug("BTHost received data: %u bytes", len);
+
 	--data->step;
 
 	if (len != l2data->data_len) {
@@ -1313,7 +1341,7 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 		goto failed;
 	}
 
-	tester_print("Successfully connected");
+	tester_print("Successfully connected to CID 0x%04x", data->dcid);
 
 	if (!check_mtu(data, sk)) {
 		tester_test_failed();
@@ -1505,6 +1533,8 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 {
 	struct test_data *data = user_data;
 
+	tester_debug("Client connect CID 0x%04x handle 0x%04x", cid, handle);
+
 	data->dcid = cid;
 	data->handle = handle;
 }
@@ -2430,6 +2460,15 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Timeout",
 				&le_client_connect_timeout_test_1,
 				setup_powered_client, test_connect_timeout);
+	test_l2cap_le("L2CAP LE Client - Read Success",
+					&le_client_connect_read_success_test,
+					setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - Write Success",
+				&le_client_connect_write_success_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - TX Timestamping",
+				&le_client_connect_tx_timestamping_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Client, Direct Advertising - Success",
 				&le_client_connect_adv_success_test_1,
 				setup_powered_client, test_connect);
-- 
2.44.0

