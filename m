Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B212AAF8
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247699; cv=pass; b=Iv8EwYxsRj/WysPXEmb+2eWx5mlwvSuJ3n/cIUCvUx8awSFWBvmH5dErex2LwaQbQZumnmC4jG2PD1UWBLfgTk1T/c34WlpJI7otJLSXJWHazEuBJ3qIWcypSIZpjB1UoCEFUZax0CZdtD/xRIYD8lWAI1bez5VARSAt/lXfktg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247699; c=relaxed/simple;
	bh=CrXNap1pfijvwwb1PYCA8Mn9xNcPGXye6UaGzidWKcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hayo6+7AKofgSvcsJFFrLswq1JAUak9vlqDmInB7DRdPT+mZuCnNEG+jElueykXk3FX3Pr4ZVQGDOb+jTgpLwXvspA6mzdoAdZfJv3l71rgnOZxSxXMjfoA5ahgkd6vXgmKZ3gvPsaOPnorgcojEJczbFZ4TsbHE7QQYi0WuysE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=k/qRIzCk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="k/qRIzCk"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V9RhH3LNVz49Q20;
	Thu,  4 Apr 2024 19:21:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712247696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dptXVj4bIU0PiLtrHZKTYLF2BmJUfMRxzrJx8J2qiDU=;
	b=k/qRIzCkeReZzYP1tC8cnyZPZ4SwHh+QnKtS8xU2ddV+zGRI3+yMP15SGnUdJxSJNNjmxh
	WHblUo5JuPjnjiQAr4Pkvj73lEioyWN0O0Ku8fT0V7WaTeLHzvENv2LopL4X+qmWPN02ae
	gPqk0lYGjf42QuWtuw0cXfdvWir335AyKQ8/WLdt0Bq90kypB67W08p4JSdZfyKejfPeia
	07YhK/nZ728bl9TYCUg6l5WD1Zk1eqLeIYRyYlwnh7T6Gsb2XUzzujovuFnmL4QA3ahaeR
	UxivpOkH8mGqVKAObtBszRbzqmMZHJ0CgJwgdt2VN8VXAxqkZlc4oanHTHPbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712247696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dptXVj4bIU0PiLtrHZKTYLF2BmJUfMRxzrJx8J2qiDU=;
	b=Ez68ZYYIrNIRdrXSqGUb2hDErrOfPilxaalm8dqlflz92d2cOlTlo7dPYIKEgMINKJGKiA
	mpc3stVqXFoM5TW0WS3fa22zpME/LHvWi3VOFTMOuIjuog2JUCSMGQqWKPDy25CdkgKsCi
	XZv/ux16kj1NQX2ZzGlr64f0HSX1ArTmwREU1LjEJNUHPSNpCFoeEW6GWGujNQptFD0Ien
	coErKuVDO/L7OefUjejNmfDLAlWvE1GrFficbpTQ46i2SgxulC1bhiqCZ9UxKm82NWVa4b
	V6+wY6tDAyQ0A6FAiw7ahj4zlHjbfvbmqB8qxcj/fZtOKosWtYQQRluiiD84cQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712247696; a=rsa-sha256;
	cv=none;
	b=k8pzJgWjID+lUI5kPdWUoL8DghlEHPznaa3jCxHIjZBo7tSK3zpPmGxg7L2XhNvI12G+1X
	rxuy+0SwoGX8Dg+6vEF7uKrvkBvbAwQsSItdG+95tpGFAaMOcR57RV+KOy8ob4Pucfp3B8
	V30lQcChEICbHBcV1YME7DOR2JzkETupNy1cF5GljffUSRzVn5WjZBiGZ4lGkVvH5IORrY
	JLLZgz8SGPkaK8dxP0QvSQ2+lUXk/ICophwsCaEZF0oi7rNGoMz/JPlI/9hFvIHVzfCsr9
	kIvus0oMgQCc5p/oNDsFcn+kz+hmFUWDEYE27fkSeuCTAhh35rYLTQfLccK3yQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 7/7] l2cap-tester: add tests for LE Client read/write/tx-timestamping
Date: Thu,  4 Apr 2024 19:21:23 +0300
Message-ID: <cb708bf61320f65aa7961ab0ffd261a90a252198.1712243675.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712243675.git.pav@iki.fi>
References: <cover.1712243675.git.pav@iki.fi>
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

