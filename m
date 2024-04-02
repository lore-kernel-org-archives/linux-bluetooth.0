Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B115B57D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083794; cv=pass; b=T4HUViMZwD0P+1AhCZaq5E88nV6eakyRxW7vC2McWsKUUGWt/JDnrUweVzg01BSb1nF6hlyiRyLcnxxbCXpA50wtkZGubgTdd0XMykjZXjvI5/o95okz3SGnhOkYx0h+K3rSm6DPH2oxdGRSGUKEUTRas7m9Q0bLEBYrZ4eIb3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083794; c=relaxed/simple;
	bh=TCLET5blhARH0Y9rYNPn+iH8jknXfTvFaUVSR0DWYpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJEwxzF/WlPmUhR/sQ7xkg+9ii7rbJkzCZhiIwlsg9GXdCOcDQFx4yjgL61rTZTjpPcuUOy5cAbya4T2RNCpqVIax6WTn4MuVXYZMPcCRUyAkN2mzkJfl3DBS8VxC/xn/yxEz1Wf5xpFT/A8r3SMKe6yzDTT254FCtcu3QrzgOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iMPafBFW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iMPafBFW"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8H3j6Yh1z49Q4P;
	Tue,  2 Apr 2024 21:49:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712083762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrP4Nncol27MzA8D+MQJQLCx3rKITNmukLoTjk6w3oE=;
	b=iMPafBFWCf9MBpfKtb9tesLstN/wbdI9QHIRdwdzeTE6DOIqeFhhY+9kWw5r96L+zP4K1O
	cF74CLoHgSRIoNQvtKrb4DZT9KMOIf56bLf+leYYwCwYtu5ihHRghOk5MadiKEM6T5+uwW
	PmNiKsTJ8rhDHa2iwAJJcMZOg2zAtIFPEOVvqbjiBvcdFULi/cJH9GiyBg+FfXPIUxUNU+
	KqEjx46sr0HMJx2L+ScCy2nRta8Pw/aiQNH/P/mgayXzBkyk8Tsm4MlLRGYSvXmzd8z7LC
	CuOL7jKl17Ko5RS11JaTikcWOX2LjI4ctP6z34/2etLhdnj/mwGGhP7n6LZSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712083762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrP4Nncol27MzA8D+MQJQLCx3rKITNmukLoTjk6w3oE=;
	b=V+eqiz1CR2NOXW61z2yAkQOBeO7S2g/jhLp44nrfvMGVgi6cO0sIGDIMkIxsgsFm1Quhpa
	aPa2d7HcXLiyxW5zqlyM3LhtzttbudXu/gHw4QvLCJm+wEnEyKzQ/PQfJ+gUiBmcGkUb+e
	spBKdW7sgv9dCjDA2IaI1Dc4R70a9AdpBstX9HHgu+JpxNWDA/QxRgn96XoU7bQATmrjg8
	KO2z7XNvODgmUvQA+hCePZP4bjj+kSbQWU44r+HA2n6GkdDyUOnHpeL244Z1aIE3nxqGCe
	fLP7vRYpzfMM2SQkKkftUWNYMkaNxvq6E7YW5DUISnf8dYndbLb/2Ev5EjJd+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712083762; a=rsa-sha256;
	cv=none;
	b=Je6MlKpQQAhzw/5UoTDvFaVrKnSHdWu9itp/nZqMmIyj9Oi0S2oHRohrdkKdIltuPD4rrl
	yWZGtbetTI9jPOCALd/Qj27ZVJ7enK3kioRga26zJJk/LfBswpPCp1Tl5WX9xXwF+d0mPi
	vIvx/cl3v+5coVJ9EJ/Hd/2eiqM8SeoinAOlO9X9eVwLgd6OtgKF1bwPyQ4rJMRiRzuxuO
	qEg4Pue4pfW+82CB/fdqKXM+ws7t+0034VrY7XjN8sxWcsQn46EKF+Qh8G8Ml8KOCWUEb7
	3hNY0ouPuootDUaifRHSutVyLeZwkcgqCrSeS1k0mRJmYCe/HNuXoHcvk6vHQQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 7/7] l2cap-tester: add tests for LE Client read/write/tx-timestamping
Date: Tue,  2 Apr 2024 21:49:14 +0300
Message-ID: <cbb252e2e0e4ff8d8d38d26b2aeeb49f4439e907.1712083655.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712083655.git.pav@iki.fi>
References: <cover.1712083655.git.pav@iki.fi>
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

