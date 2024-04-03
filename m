Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B315099C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168820; cv=pass; b=VdsXZF4tAHSqpj4lqHUblHSCaOykweKenVmvTTk8Bno77RgN8N77V05zNILTe2bqud5+22Xxel6+bvHXQCCKkmqci1SrZIQ+kNHIFO+wL4xGqEC0Z0r3jW2BGv0kUWsc6YQVSWrOEza8dEoMhdKEYLwghihRQpS2dtGwshab2tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168820; c=relaxed/simple;
	bh=CrXNap1pfijvwwb1PYCA8Mn9xNcPGXye6UaGzidWKcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BefwOCI9jTTyN5AWO8Vdw8tCbFlVJjZ87oQgUVdPkQiQraOKaUGpElNCDogwjsJdRLAEC44p90bCSiO1OaFdxFXqpa82zoPgOCHnyE6jAvgnYDWLDDw5FoDrgjikKKf663n/Yts7Z6RG8JZ+a2WxiIWTj+L6gknNegYu/IBI5m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lspDVDOQ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lspDVDOQ"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8tWD70xkz49Q6t;
	Wed,  3 Apr 2024 21:26:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712168809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dptXVj4bIU0PiLtrHZKTYLF2BmJUfMRxzrJx8J2qiDU=;
	b=lspDVDOQgSUEywhRUKDqOotj8e+67OuFSc1kn1F26E5NURQ/8PSYM4qutR3ctnkD0wFGsq
	yNdR0r3vz8qcplamELb/kwMIwC3DdwVm088x3y3O3fGdKyttBGH2J5wbS5k97SKPyRH6IB
	ujll+vjihET7kqkSvpsdjACfgvHql5vruegxywErR7k1r065RcRPVipp0USuZElKQ0Rj7m
	k42VwFq9hEdJMBsrrMtIts7TEK4o+6sMGUOSPC8TCYT+ergLGTnnUFyzZR4jk2RzO8kgWS
	VHZQ/2iIDdJxmfJtQ/duHBjJ3t8Oew9e+26HoucukoAaUVtzUKAJJlaeA62a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712168809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dptXVj4bIU0PiLtrHZKTYLF2BmJUfMRxzrJx8J2qiDU=;
	b=czV6hfEN7a3TCo0foJWUwr+MZd7Xk/N0PgnlXHLbKQyK4fZVtLCIeXUtukpk1Q+Fyrt8f9
	6E12HYfFaD66kqzIzaidR5H4uB/doxJSARcageyzwP6y4uDjH4FY86NSUCCMqE00in6wnC
	6U2/aOE56JnNvVza4oOC5pnRhE8nltpKj+UvNfcLLakLFUn+0oYZRHoMac+lOWjNWlQ/7d
	vESALflIsfI0YykVaODHupP9P6aPOvroYcUa/pB8na0rsmGLq3yGnyAPF1d5gc4UMwFzY0
	aZUUF7grNq3MHGLa9qvXin4zxzO4FyH/isiAu5GFrFzjW93QVdamCrggQhxbIQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712168809; a=rsa-sha256;
	cv=none;
	b=QHUKSX5TSMmqDlZcKoIR1OpyNet/2aQESNeXJtNz32PycpwkKtoDVGcX8m94r6GFLS4mhW
	Aa2BSZe5Gaq5sPsZ2mMT8/N/IDyd+emrhSC29ZkGiVYhJAM6/Dt30ITYpf0N7mvTjXZfNU
	9VkgUQbvA6G6dkxtxO6UD3gGV2xv8BmRkVTtmQk4vs+VUaR6V98t5CgEFI1aHmeE8x4NIl
	QKoyeBsKmorwMowSTz6GzNNkDtG9CGi3FV406QDm0kCJhC3cYeojBR7vKypZmS2akZkkk6
	uBJ61vNMWkbCuRL51FvM+gE6u/V2AdGjI6VsJm+ARmvCurxGLXlJepWBE57FvQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 7/7] l2cap-tester: add tests for LE Client read/write/tx-timestamping
Date: Wed,  3 Apr 2024 21:26:37 +0300
Message-ID: <a25c47d90e08e08617544b3942b858fa989cbcb3.1712168788.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168788.git.pav@iki.fi>
References: <cover.1712168788.git.pav@iki.fi>
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

