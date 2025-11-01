Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F82F656C
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999035; cv=pass; b=mMbLtfoo3VbDXA8oZHcvd+S/IzaXBYCGeLcajre1GtKPDsVXW4oZS03yOUD8QMUeySW5Uqp9oTugcySPFYXgSvDZmGausresEqvo/24iwixJY8y3ro01lWM7oAZg13ayqllfQ+1TAXiEXzwvffHTeBtoHGWualkNtLwxLuUy6Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999035; c=relaxed/simple;
	bh=0GyPpUaPfwgL0mI+kdZSJv/z6SA7VER6aK57eklUt1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSFDovJjc3lXX30GzEwXdzIYj4MBJTcoM11G7o+se5qRSqz0XKet6rRBLbx8hZ3Z3YfyyWbhKREFeNyTB381kyFOFhmBwKOGtBocahm13RSeycUfzX6vjtUPXqwiNz471QbCizey5FrQGfTS9Xh258M8zaOFem8wEgW2uTwKXCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=AWSs2mAi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="AWSs2mAi"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czGrl2DjRzyYr;
	Sat,  1 Nov 2025 14:10:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1761999031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qZYKQiAlDC9c1MfC9+3UZPrtTBqpGZqSKRqiJ5NW+xQ=;
	b=AWSs2mAiGg6VjbZlxk8uN/BxE+BrkFTrCBe8ZsbaQ7bouhkZaj2MrUSa0ulnl0Ij7/9846
	6LUUJdh1hSV8ilKeaZ7byStOLnYxH6mXEhiaRtGmcO4yTO/hhTG8pTuK08L6Ek+/x2RLTu
	vr6F3NKl/4Eb9Ih7W1iCLgy95EazgiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1761999031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qZYKQiAlDC9c1MfC9+3UZPrtTBqpGZqSKRqiJ5NW+xQ=;
	b=X+8D/ehoyO1TY6A2B2CuyxuuLnVTB7XvvrOSnqRPDyZ2S43WqIk92e937LAGWE01FY9Oiu
	6ja5GwkfLoON6OnChIxxbKGT9cZRw9bON3mA0v+vNRfRZ1z585nEqQGHG0t7PciuEjH44V
	fRnscDRHtPoOI7nIkpws0LCIjjK5bUE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1761999031; a=rsa-sha256; cv=none;
	b=bqTV24sT+JELMuy5TWzsd3/N04rtsd7tzWI4uIen5A8bLC+0B70O7DuS5l7zmRFaO2ALJc
	NJ48RzxDa3bbNwKvQntSNwjAFwRul8+wXh0Pwq/ueCiq4GWnT08EW35J9sOYGVudSCjNKG
	ACfsrenuhnDQd+uJMzVlFR+U7o0QCJ8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] 6lowpan-tester: add test for header compression
Date: Sat,  1 Nov 2025 14:10:11 +0200
Message-ID: <2fc1c535e6642706aad81d08bd3f8b14ee4f56c7.1761998984.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add smoke test for IPV6 header compression:

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
2.51.1

