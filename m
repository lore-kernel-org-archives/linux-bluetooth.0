Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E2286D4D
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296719; cv=pass; b=f46i7XarjXIdZsnu5XP7KmSky/FqOtRDlNyxQk3jtNBOQct/Jhj4JJ5TAKRvm0m+7Kfwom0yTxR6lS6+CnFnfpyHFMqNbo1+cnarGOorCdS1J8lTFhhdUUHRe+2/UrK+48Al5DL2KHdKQP5GFfwMYeDs+qZ8Ytd3i7gYfyFTNFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296719; c=relaxed/simple;
	bh=HLIuFRpqxHBdgE0x/WdChMazWx1dHSJ4QfptTkAvbV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfvI5GRfOjdAq+0CgUQgTB6myhCK7AJLHt9age2JjvshHBWkl3593e0AW/2qPN0Z3dqSBGvFgN0di4IJF8CX7yOtOpKw6Lm4rDZSWMbur2LR+kbX/azxlFeKyicKqXZ9mNvz8yF+HQrNCmQP8no5V8YOvUsLcnAehAJr7P5KrP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kysWhF5b; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kysWhF5b"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hZJKN06RmzyQZ;
	Wed, 02 Sep 2026 00:05:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788296712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/xFwpZuEQwqqOJbnvYMXJOIJXw0UGb/iBjbcrlaoOjE=;
	b=kysWhF5bWRaGYHXPk6bhE/Dv4lU+1645GmGS/+rHUhm5BW75LMMft/yGTGO5t29AvelL9G
	3y8CstfUwdfb24JN5Pnr00E+pyYRRL/NWXi63FSd/ERmX5oYcslKc5uwVAxsU/kinVBESY
	i217qK7IiI5WKGu3gHDTegzaDAjVdMg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788296712;
	b=sJYO4XrnMB6OVsQfmnatnuap6hUS+d8Hj8MnHUm5M5sqjZRFRsI9DMB9JSbGZ0ORjKx6V6
	QqWUkXrDUT4PNWfpt8OTF+KTsLuFS5yVQrCfrFAuJw46t7IY0AzHOLsKoeclHyFpJXpb24
	aRy4I5T48y5SB6q2enM/vMxd86SzApY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788296712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/xFwpZuEQwqqOJbnvYMXJOIJXw0UGb/iBjbcrlaoOjE=;
	b=dAeRQPNd/FhUjEDf9dJ0S6gw6eNCuLWpK1fGaD0urfVg11tdrsrNA2jVnVjVwatcWf8kIr
	af/3z7BItA4tzr+sx06aX+5vXPStAhD1dG8MGVkClRd2MDtEBbYK8ixNBOBKD0um3wsfWK
	WOcqmJ3gSLXmGSAup8GrR4ivKt86dnU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3] tools/l2cap-tester: test closing sockets with ECRED defer
Date: Wed,  2 Sep 2026 00:05:06 +0300
Message-ID: <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that does defer accept with ECRED with 2 SCIDs, and
accepts + closes the first before accepting the second. This triggers
deadlock on some kernel versions.

L2CAP Ext-Flowctl Server - Accept 2 Close 1
---

Notes:
    v3:
    - resend the deadlock test, now that it's fixed in bluetooth-next/master
      commit 62df5992 ("Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer")
    
    v2:
    - new test
    
    Lockdep fails to print a splat for this deadlock, since l2cap_sock.c is
    mixing lock_sock(sk) == lock_sock(sk, 0) and lock_sock_nested, and the
    normal sockets are at nesting level 1...

 tools/l2cap-tester.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 37b21a88a..f2d3e56b8 100644
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
@@ -3283,6 +3301,50 @@ static void test_server(const void *test_data)
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
@@ -3777,6 +3839,10 @@ int main(int argc, char *argv[])
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

