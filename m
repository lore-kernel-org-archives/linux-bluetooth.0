Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC12C11D4
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jan 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478472; cv=pass; b=cHr5yd7qekRyIy6FmJQH4UUpHlSPBWPRGsYXZ4hn0BSzhzE6FKtMp02vOK8zrC+Wmlo19/WDW7gf42M7f+AHtcTlU4DscRIBWtLjTagteqq+9Xe/dHbFdfgjwcLHFNZZEX74e9mDqCq6XJasNUePNsnSaFlga06dxWtjZg07G+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478472; c=relaxed/simple;
	bh=vKn0qqCQOCLGBbS15UAA50x1fczgVyFIJTTfi1/5AT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKc6o7CNybl9Rq9VJH9hm7Uh4K3z04wbCvYQfPiYCoQFbyKu1ZAzZz/ggcpNrhcgma6w5SyH/2d/Z+omY1KAw8y9jOA95jhxpA2gZ8YdrVzzShLdx49Kpye7GhoYJ3SvLUlXYK4DVPABY+oLKMbuBfZ0FBt4kFEAoUWZJu3Q1aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HFAdAaJ3; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JU7BULXG; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HFAdAaJ3";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JU7BULXG"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dkFGM21Wgz49Q3J
	for <linux-bluetooth@vger.kernel.org>; Sun, 04 Jan 2026 00:14:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1767478459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=82Nq/RyjHj8B5eBXdSPhDo5dtw0do9+CLAcujHAMtaQ=;
	b=HFAdAaJ37SnZPaHyCX58zbQOnjF17oFP3pfZWe3RVLw0vtV1lAxvYuhQt/bE+Xk1cfx52N
	Z6h27eDCONq64yfWQRXjq4yYG/mOgMiORh4nuLT2YmP2ykDR6jEr6rS9LsYqQYyX6Z9BYL
	yDWGO65OQ/EEZRYLYFwvYSi9jRsESOgHq9r1tyHn2LJa0sSumUjhc9aSMsWsB5kOka4mbk
	NppsL2v8QqthVQaaD1da1cwY8gBfz6CXlcKYjrrnsM6j1HwKOOvWMaNhmaqELYVavMZoS1
	TMvYyiTC7aVZtgcMl2Vxh0McI+lxBoi8NTVN+79WLz4g/Uok4ckY+lzqfZu1aw==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dkFG96g5vzyRd;
	Sun, 04 Jan 2026 00:14:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767478450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=82Nq/RyjHj8B5eBXdSPhDo5dtw0do9+CLAcujHAMtaQ=;
	b=JU7BULXGOCTo8ROGq8MsuDuO8Ic6pgBxK6pf2ZJN5RlQvX6iMQuHt3KPv/PbWI7Ep5Yk9f
	nt2eDgbfKzFZ27KCT8uPlmwCckT+NKE5WcVPETRapfTTCBwxM5QS9O9m54BtA6/I476Ia9
	kWYgT52tqDXO0eumvi/p4XcnVcd2VFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767478450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=82Nq/RyjHj8B5eBXdSPhDo5dtw0do9+CLAcujHAMtaQ=;
	b=r+B8/CxnFuv4ecy9xwV6f6LYtjV+V3w7I/QdOPPF1hrOZaiSL5hvC8Md6139v0No22em/k
	tlhvp322r6rwrih9HyJRkaG/22Kv5TJrC3OrlMkfLkkGSKz4KGtdT3+UobNpVusIooRjm+
	Qk6o1BH5eA8FKCf4W18esSwEYTD6BPM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767478450;
	b=Oll+V4jww789yNfmenEZ84ECJvZQlyir4J12PMgU65qZ1XOckRsK47L+rKGycqbB7GmeIE
	DtLWZYVMpugPoirZa50j2sAmPHUXOuGPy8gG7dxSMlQTtQJgJ5CoGvHEBUGdLcrBBTvIXX
	kPVgcatDaGx40DxLizAx5cFxPN+kfTk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RESEND PATCH BlueZ 1/2] 6lowpan-tester: add test for header compression
Date: Sun,  4 Jan 2026 00:14:06 +0200
Message-ID: <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add smoke test for IPV6 header compression. These test the compressed
ipv6 code path in net/bluetooth/6lowpan.c

Client Recv IPHC Dgram - Success
Client Recv IPHC Raw - Success
---
 tools/6lowpan-tester.c | 61 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index e1d23d552..7fdacefeb 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -70,6 +70,10 @@ struct client_data {
 	const void *send_data;
 	uint16_t send_data_len;
 
+	/* Data to expect to be received as kernel client */
+	const void *send_expect_data;
+	uint16_t send_expect_data_len;
+
 	/* Interface listener socket type, SOCK_RAW / DGRAM */
 	int sk_type;
 };
@@ -320,6 +324,8 @@ static const uint8_t dgram_data[64+1] = {
 static const struct client_data client_recv_dgram = {
 	.send_data = dgram_data,
 	.send_data_len = sizeof(dgram_data),
+	.send_expect_data = dgram_data + 1,
+	.send_expect_data_len = sizeof(dgram_data) - 1,
 	.sk_type = SOCK_DGRAM,
 	.disconnect = true,
 };
@@ -327,11 +333,49 @@ static const struct client_data client_recv_dgram = {
 static const struct client_data client_recv_raw = {
 	.send_data = dgram_data,
 	.send_data_len = sizeof(dgram_data),
+	.send_expect_data = dgram_data + 1,
+	.send_expect_data_len = sizeof(dgram_data) - 1,
 	.sk_type = SOCK_RAW,
 	.disconnect = true,
 	.skip_by_default_reason = "kernel BUG at net/core/skbuff.c:212"
 };
 
+static const uint8_t iphc_dgram_data[64+2] = {
+	/* IPHC dispatch: TF=11, NH=0, HLIM=00; see draft-ietf-6lowpan-hc-11 */
+	0x78,
+	/* CID=0, SAC=0, SAM=00, M=0, DAC=0, DAM=00 */
+	0x00,
+	/* rest of ipv6 fields (nh, hlim, src, dst) + data */
+	0xde, 0xad, 0xbe, 0xef
+};
+
+static const uint8_t iphc_uncompressed_dgram_data[70] = {
+	/* IPv6 (version, tc, fl) */
+	0x60, 0x00, 0x00, 0x00,
+	/* payload size */
+	0x00, sizeof(iphc_dgram_data) - 2 - (2 + 2*16),
+	/* rest of ipv6 fields + data */
+	0xde, 0xad, 0xbe, 0xef
+};
+
+static const struct client_data client_recv_iphc_dgram = {
+	.send_data = iphc_dgram_data,
+	.send_data_len = sizeof(iphc_dgram_data),
+	.send_expect_data = iphc_uncompressed_dgram_data,
+	.send_expect_data_len = sizeof(iphc_uncompressed_dgram_data),
+	.sk_type = SOCK_DGRAM,
+	.disconnect = true,
+};
+
+static const struct client_data client_recv_iphc_raw = {
+	.send_data = iphc_dgram_data,
+	.send_data_len = sizeof(iphc_dgram_data),
+	.send_expect_data = iphc_uncompressed_dgram_data,
+	.send_expect_data_len = sizeof(iphc_uncompressed_dgram_data),
+	.sk_type = SOCK_RAW,
+	.disconnect = true,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -501,7 +545,6 @@ static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
 	uint8_t buf[256];
 	int fd;
 	ssize_t ret;
-	int phy_hdr_size = (cdata->sk_type == SOCK_DGRAM) ? 1 : 0;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto done;
@@ -516,9 +559,9 @@ static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
 
 	tester_print("Recv %d bytes", (int)ret);
 
-	if (ret != cdata->send_data_len - phy_hdr_size)
+	if (ret != cdata->send_expect_data_len)
 		return TRUE;
-	if (memcmp(buf, cdata->send_data + phy_hdr_size, ret))
+	if (memcmp(buf, cdata->send_expect_data, ret))
 		return TRUE;
 
 	tester_print("Received sent packet");
@@ -559,7 +602,7 @@ static gboolean client_open_iface(gpointer user_data)
 				recv_iface_packet, data);
 		g_io_channel_unref(io);
 
-		tester_debug("Send %u+1 bytes", cdata->send_data_len - 1);
+		tester_debug("Send %u bytes", cdata->send_data_len);
 		bthost_send_cid(bthost, data->handle, data->dcid,
 				cdata->send_data, cdata->send_data_len);
 	} else if (cdata->disconnect) {
@@ -670,5 +713,15 @@ int main(int argc, char *argv[])
 							setup_powered_client,
 							test_connect);
 
+	test_6lowpan("Client Recv IPHC Dgram - Success",
+						&client_recv_iphc_dgram,
+						setup_powered_client,
+						test_connect);
+
+	test_6lowpan("Client Recv IPHC Raw - Success",
+						&client_recv_iphc_raw,
+						setup_powered_client,
+						test_connect);
+
 	return tester_run();
 }
-- 
2.52.0

