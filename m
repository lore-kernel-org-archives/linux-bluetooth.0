Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AC1F5821
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788119939; cv=pass; b=hw7cRn03E8zGnU9VIQD/Ia1ZkLCEWrFqm5MlH/nMFHddL8zcpVMeRjA/hPEcz6/0GVjOcuTHboe0hFrgl4klJdtR/Tr2zpmMePDu9wmBr0BypnT5zXdm7DMQNvKPWmD9BTf4FmdMfI7dwOMxI934+S/dh3vWoOw/spT/SMH/s6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788119939; c=relaxed/simple;
	bh=ZkOGJUhHAkjODqNoUpo8flBFbk1+2JagyKnIFyxxh58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0XS9cN/U2wTFE2PYlFjm+5u+3oeKnas9vviTKF+FX1nnNIv621ElwiKyifdeyI9j3w6Dg3u8EEmjubrS9A4dhmxiF3YJr0ADtpcWc4vTOjK/S9a0SQevACdupRwULi7PG1bAukUecSAhaAWd5q2VGBUv/3OSV9eVrhf7tX5HDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ab7AYf9x; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ab7AYf9x"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hY2xl2YK7zyVw;
	Sun, 30 Aug 2026 22:58:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788119931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/52KFkD8xmv9Q6cJeCdxGW4ih/6Gt4tmDugGHHO8YhM=;
	b=Ab7AYf9xthjSlMOYF0sqxNcUtSFvPVF0NL0wTbVp4xs+I/tKdqqN1bF9Nx4ZjQGC5QaQXx
	U+/yz+B3mVBt1LIjCGFtVPqIAYFQ++tMBSoei3k5pDGsqeFAVm3ya9KAp7GZV5i2m206bJ
	s8alEKOAzi99yBRx61kpMqlYogUMruM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788119931;
	b=BVvyWZVqzS6zWD/6up5l/QUI8mQJaBdx9LRqpAkKarBBPnbmC1Apzy+8cbvjTWA/5FF9Px
	w1UV3bqX0vuNHKuGusP67g7ObQ+E5OKvRDjQpkfY/JhfAAs71FbljCqJMjrnpSpLDC5wU9
	1YIZ5Bq0tJj/Fmph7iViCwbh/tE12Xo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788119931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/52KFkD8xmv9Q6cJeCdxGW4ih/6Gt4tmDugGHHO8YhM=;
	b=iPk25+7kfFBdpL5XPPvH/Pl5Z63g5rwb3VA+UnnzYN+N5EKGXihavR/QaSU06KooFTSboI
	34IqlbRqUlyERua+vtLuAwOOshsnLK0QLg5YDirKVK0I37Lz7knGgt8hyZ3q5mvjK4llLW
	REUOu1DQ+IODnxOV/3ol2MlS+XVAESM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/3] tools/l2cap-tester: test closing sockets with ECRED defer
Date: Sun, 30 Aug 2026 22:57:24 +0300
Message-ID: <3d6b440c7c3a077daf91a47bbc578a2cd40f2a01.1788119838.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
References: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that does defer accept with ECRED with 1 SCIDs, and
accepts + closes the first before accepting the second. This triggers
deadlock on some kernel versions.

L2CAP Ext-Flowctl Server - Accept 2 Close 1
---

Notes:
    v2:
    - new test
    
    Lockdep fails to print a splat for this deadlock, since l2cap_sock.c is
    mixing lock_sock(sk) == lock_sock(sk, 0) and lock_sock_nested, and the
    normal sockets are at nesting level 1...

 tools/l2cap-tester.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index efff5c2d8..3f78fc86b 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1153,6 +1153,24 @@ static const struct l2cap_data ext_flowctl_server_nval_conn_req_test = {
 	.mode = BT_MODE_EXT_FLOWCTL,
 };
 
+static const uint8_t ecred_connect_req_2[] = {
+						0x80, 0x00, /* PSM */
+						0x40, 0x00, /* MTU */
+						0x40, 0x00, /* MPS */
+						0x05, 0x00, /* Credits */
+						0x41, 0x00, /* SCID #1 */
+						0x42, 0x00, /* SCID #2 */
+};
+
+static const struct l2cap_data ext_flowctl_server_accept_2_close_1_test = {
+	.server_psm = 0x0080,
+	.defer = true,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req_2,
+	.send_cmd_len = ARRAY_SIZE(ecred_connect_req_2)
+};
+
 static const struct l2cap_data ext_flowctl_server_phy_test = {
 	.server_psm = 0x0080,
 	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
@@ -3191,6 +3209,50 @@ static void test_server(const void *test_data)
 	start_test_server(test_data, send_req_new_conn, l2cap_listen_cb);
 }
 
+static gboolean ext_flowctl_accept_2_close_1_listen_cb(GIOChannel *io,
+					GIOCondition cond, gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	int sk, new_sk;
+	int err = 0;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	new_sk = accept(sk, NULL, NULL);
+	if (err < 0) {
+		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
+		tester_test_failed();
+		return FALSE;
+	}
+
+	if (!defer_accept(data, g_io_channel_unix_new(new_sk), NULL))
+		goto fail;
+
+	close(new_sk);
+
+	if (data->step--)
+		return TRUE;
+
+	tester_test_passed();
+
+	data->io_id = 0;
+	return FALSE;
+
+fail:
+	tester_test_failed();
+	close(new_sk);
+	return FALSE;
+}
+
+static void test_ext_flowctl_server_accept_2_close_1(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->step = 1;
+	start_test_server(test_data, send_req_new_conn,
+					ext_flowctl_accept_2_close_1_listen_cb);
+}
+
 static gboolean ext_flowctl_nval_conn_req_ready_cb(gpointer ptr)
 {
 	struct test_data *data = tester_get_data();
@@ -3680,6 +3742,10 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP Ext-Flowctl Server - Nval SCID",
 				&ext_flowctl_server_nval_scid_test,
 				setup_powered_server, test_server);
+	test_l2cap_le("L2CAP Ext-Flowctl Server - Accept 2 Close 1",
+				&ext_flowctl_server_accept_2_close_1_test,
+				setup_powered_server,
+				test_ext_flowctl_server_accept_2_close_1);
 	test_l2cap_le("L2CAP Ext-Flowctl Server - PHY",
 				&ext_flowctl_server_phy_test,
 				setup_powered_server, test_server);
-- 
2.55.0

