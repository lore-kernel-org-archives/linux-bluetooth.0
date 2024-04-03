Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC43152189
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162770; cv=pass; b=ks4HkcqKE8FmGQFxeb51QUxF3igLJp31owGT5REIAj3o27ZIPMxdUltshriaT+lurHVtHCORRomY30vxlCu3wkyfjXJ9ms7W3vXll00iX0H/KACR5FEkv8ARTJBUvrioho1OdoaRIAGeNEzWf+lRrjyVcZ60iyy4Lw9ITRZTW0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162770; c=relaxed/simple;
	bh=CrXNap1pfijvwwb1PYCA8Mn9xNcPGXye6UaGzidWKcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQOp5U49uSNwmYpnUUz9gxIU3ZfvyVj9g5pYVr7+XGAJLaFyasCWfj1iqU9tn/nwEjQ6LAyWKx4DUAv42yjkxmPoqCeO0Fo4R0D+eypncM6MC23+8wP9pVSEvivDi37ZVrazrnYLltanXjCDZ3JIy+VNJIQ1aZJPUrmUiLGFssc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NfOvfNxW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NfOvfNxW"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8rGz18Xrz49Q4P;
	Wed,  3 Apr 2024 19:46:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712162763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dptXVj4bIU0PiLtrHZKTYLF2BmJUfMRxzrJx8J2qiDU=;
	b=NfOvfNxWW+UeSHcNGvGPHQ9a84csSLRqAg0xPogAAPIYjL/ANlNq0nHp9Riur1scLYSJzO
	2pVT+UsLVg6gMwBL3n3i/CWVtZYzCu0oZnpy9tpv+GGX5CCZK1E9GZIqi7yzVrvfhBV3IX
	Ecq4jNEV4M0PrUWp0lkK8A9c8q1WqGEdQVBJ7HLxvJdxuDWNvgKKAvDkKCk5DMeX3nyjm6
	IFWvULnfzgLTpvJ6mcrwnX2/60/fXNLkW4Eefg/wvC/gSEV8XrBFlk1A0slQUGL4WfhkPh
	+O5Kr+QZfokU2k2uMF4yVEpE/7uWW3hfkmnTrbASKpi3df14PhZFOxouB0hrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712162763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dptXVj4bIU0PiLtrHZKTYLF2BmJUfMRxzrJx8J2qiDU=;
	b=DyJtVNcoMpRXIfBmMHoZdLm8NN45TZBg19cPDLruPQoy0yL4z2+KDC4iZvLqZd4OmyBa/R
	Pgm0OZ+AcTy2PV4NR8zdog11/QLU0Osg9bvzV1kpqaLFJJBtVNssybqvJ/XwEYQOjFb+RH
	Yfqz1/1sVDtX6R/ulBPcNn3vJezRziIIw18IH41KFrB4Cup8wXtgDBA4tGDOgmvCYJtxFi
	uAw4dNpwKd0GQWcZNQp9XFxhHos0kvczkEvpO4IwdGvXvZrVkSefkISfVD9Yeyd4IFNFRv
	J/66SKQmsNd++A/CT7wDlHemm0ZDTnnN5tGOSP1hilFM6l5ClvY3Q/hFTY4LaQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712162763; a=rsa-sha256;
	cv=none;
	b=KHQYihqDM6ohpPMDMHHh+IZrPK754K8I/jXVEhaPnN8n6gHXvEdyv3DLW0l3LlAalIsKGp
	9hBCXhkzy5RYEjBg0IlKLc6IkCnw22FZc4Zuu4msvGyAa7DNjdTAhcLz5+8k7yL53NEcUg
	ISiotm0neC3eUeWWC9zXQITLTrDRoEMGeKwwi3NqQ2lZFiZ9f23MOgPhzvkSVht3L/V0ut
	FQl5XTih6uxOlrejv2UiPmm/U97iozis/+DCFtKp48I3Pv5vWwkGqBTmjfqR2sQpTzD4Jl
	detR6yCseeLrRDVY5NIgsZcEKn3XuxEiOakyCFiffCAcYBWaTwhBAajhcNi/6Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 7/7] l2cap-tester: add tests for LE Client read/write/tx-timestamping
Date: Wed,  3 Apr 2024 19:43:26 +0300
Message-ID: <5b8e511bfd245e3dc46a6ddbd850e0a6fc716d53.1712161649.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712161649.git.pav@iki.fi>
References: <cover.1712161649.git.pav@iki.fi>
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
index 375ff767b..02d1571d2 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -487,6 +487,30 @@ static const struct l2cap_data le_client_connect_timeout_test_1 = {
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
@@ -1082,6 +1106,8 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	char buf[1024];
 	int sk;
 
+	tester_debug("Client received data");
+
 	sk = g_io_channel_unix_get_fd(io);
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
 		tester_warn("Unable to read %u bytes", l2data->data_len);
@@ -1126,6 +1152,8 @@ static void bthost_received_data(const void *buf, uint16_t len,
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 
+	tester_debug("BTHost received data: %u bytes", len);
+
 	--data->step;
 
 	if (len != l2data->data_len) {
@@ -1314,7 +1342,7 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 		goto failed;
 	}
 
-	tester_print("Successfully connected");
+	tester_print("Successfully connected to CID 0x%04x", data->dcid);
 
 	if (!check_mtu(data, sk)) {
 		tester_test_failed();
@@ -1506,6 +1534,8 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 {
 	struct test_data *data = user_data;
 
+	tester_debug("Client connect CID 0x%04x handle 0x%04x", cid, handle);
+
 	data->dcid = cid;
 	data->handle = handle;
 }
@@ -2431,6 +2461,15 @@ int main(int argc, char *argv[])
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

