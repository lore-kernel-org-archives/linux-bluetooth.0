Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73A15A482
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076199; cv=pass; b=VXsj4GKHI1YKC8JiYkjol4pxzrLhl8p8Pe+JQL17HBzbAbjZ07x3+rZWmAcs/fuZfvk4lhCwJezOFR56vdrRp2S5L3msuxGAJzZmNRR3mRu8XG9F1dPPKO84mWwqncVdKM4MjLmgWasE6NdzqA1wgNWGBRpdrf8GXkSFlrnGk9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076199; c=relaxed/simple;
	bh=TCLET5blhARH0Y9rYNPn+iH8jknXfTvFaUVSR0DWYpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuUuBtsf50B8h35JF2PvvFF0p8luZ9x9j/t+5yU9r5i+ojUUrfrXJfpHyqGi7cJ+r0g7BZr4Ni8VNZ0LnYwG8nGKG2TYSTLpYaKQ+CLZ8PYs7oJgdYDj6NhTxkStFWrRmzhQbhb3iGY9vR8JphvDKz2TjRyB0LMXyBNmqQXCto4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xQkdP/rB; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xQkdP/rB"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DGC5zvpzyTX;
	Tue,  2 Apr 2024 19:43:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrP4Nncol27MzA8D+MQJQLCx3rKITNmukLoTjk6w3oE=;
	b=xQkdP/rBiU8P1NIqdLwbQ24wpvPRnUKWy7cOeprGX9bEq91qyH8ry6RtaiDDzczRQqCV4N
	m2bhxYTjQ+e68AEh8cOBXDiCSd6+XF4T1HAQdhGsjLwJNf/dqKMelod3W00u4P0XB7jqMO
	Zcw018PAH/g3e38qs+x5W2+T5LEMm18=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076196; a=rsa-sha256; cv=none;
	b=RlJwtOhpI7IIKnSKtV0/wYLcnkMoTtkkBwdBImIqUAi17MpHX/wbvwk0z9NmESIBFXCYxg
	AHX6hKSE74e7llnrWP4V2Hddq8qh6Qmp+xcKInKdzu/HPdb2mX0p5XNnah4mJ/t2J8l/S0
	7P7HRIk0mMmICFeHauwlkodABwUx4Kg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrP4Nncol27MzA8D+MQJQLCx3rKITNmukLoTjk6w3oE=;
	b=Ox7LyKMFVbxF94eDZt2gHrCwDSbMRyfY1bbHwEY59fszFUTq+NknsE+cgFMilBEkMSA6oF
	293mGJSbhvscESpkq2bptYjP2+OqghYYOWtbNs9UhspHif48V7ewhifUOHfckm3e3xWq94
	RKrC6rcJbg2Bv4QO0eItI50bL74yaxE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 7/8] l2cap-tester: add tests for LE Client read/write/tx-timestamping
Date: Tue,  2 Apr 2024 19:43:04 +0300
Message-ID: <7d439f0ec2b8f451c66b33ef720e0657c64cf21c.1712076170.git.pav@iki.fi>
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

