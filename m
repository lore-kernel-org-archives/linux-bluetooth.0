Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76823A1A3B
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788043698; cv=pass; b=EmHXAfAfo8v+4CV33BvNr0WlzaKBtLk61cv58xU1DSGPE4R1gWReZLzY7DB+iZM5niuqUQxWVkWJypBEib5cV6u8eyaVUotqjbQ6ddcC3Yxe6tkHgD3X+TzqvRY0siYYrh/l6iIdTMUwfiNdtbTyvESSbUQ8yBJB8W++lMkC/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788043698; c=relaxed/simple;
	bh=Kt22DI7OA683rgFKb++HyOLUHAXahdmDMB8EhGmLBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcZOVBHJpwp1uShg+hOXhccZ/1PuJTR1iV4CoWA+p+yeGeaTtpvXhqc7ItezykO+xlKcZn3WtTVAomMNNZwRF1Q04XankyiNJYmVAgJBS4nO7OteZXNgOoECCJA3b618+32yExDV7tYRdffrRJJ3NhNOAx9R+k89rynfQRpjwQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nx1bR8Jz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nx1bR8Jz"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXVlZ4S9gzyhS;
	Sun, 30 Aug 2026 01:48:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788043691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUID5Jq0k8YPhtdxBB6I3TSYcAjnW2YCJmtXe2sfG1o=;
	b=nx1bR8Jzbd54o5d9kv/ecM6rwWhNyK8IrkPopPn8+hn4p0f6JBGRNNiekq52aXCO40Txr6
	mZfmOG9a0KLDPs1DFaIq/C3+LV2zI3bCb6ALxSblAea3/4DNEpFLe6OwY54w2f4LqQKMlX
	+UHDofPGGGWAo3ljxTTE8j/gdvXtf4A=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788043691;
	b=F1zvQTrDf1bb1fnEQFuQc3NeezR0pWzyfY6Soglx+kftkKaJ9Xd+XqDQwLiGR1a9k1Ar8x
	ZHGiP3wZ8Wp4yeBwkawlWP5LCSq7okTFVu9daVnMjIePDYMJAAelTvQ0rtkxdi0WbSGsDI
	tcPEWvZiZ1jlTiPcDyWuChBYuFN+pN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788043691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUID5Jq0k8YPhtdxBB6I3TSYcAjnW2YCJmtXe2sfG1o=;
	b=oK6yC7QGejbcfIM+FUd5ch2gr2BZtfS+A3ro1M25KqEJuRpo/bx5SxHsdxAJ9QlveEkV+7
	7CdB9acnslfW482c1lnyCsXWp6H0WE/Yn0ECcKzAkFfiTnVbAhcLAqDsWdG+w6HqVkSrJh
	rsq4ci+/dUn0UBaYTe3Pbk0hh+hDqcU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] tools/l2cap-tester: add test for too many ECRED deferred sockets
Date: Sun, 30 Aug 2026 01:47:59 +0300
Message-ID: <ad357211d602dd6fd079da261b51be141cb614e5.1788043574.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
References: <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test tries to trigger connection with 5+1 ECRED channels, and
require the last connect() shall fail with -EPROTO.  On some kernels
this causes invalid ECRED REQ be sent with 6 SCID, and stack overwrite.

L2CAP Ext-Flowctl Client - Defer limit
---

Notes:
    Passing this test requires the kernel patch
    
    "Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect"

 tools/l2cap-tester.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 69c529aa8..4bbbe58dd 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1389,6 +1389,12 @@ static const struct l2cap_data ext_flowctl_client_set_phy_coded_test = {
 	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
 };
 
+static const struct l2cap_data ext_flowctl_client_defer_limit = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -2890,6 +2896,92 @@ static void test_connect_2(const void *test_data)
 								defer);
 }
 
+static gboolean watch_no_track_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	int sk = g_io_channel_unix_get_fd(io);
+
+	tester_print("Ready sk = %d", sk);
+	return FALSE;
+}
+
+static int watch_and_close_sk(int sk)
+{
+	GIOChannel *io;
+
+	if (sk < 0)
+		return sk;
+
+	io = g_io_channel_unix_new(sk);
+	g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						watch_no_track_cb, NULL);
+	g_io_channel_unref(io);
+
+	return sk;
+}
+
+static void test_connect_ext_defer_limit(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	const uint8_t *client_bdaddr;
+	int sk[6];
+	int err;
+	int opt = 1;
+	int i;
+
+	data->step = 6;
+
+	if (l2data->server_psm) {
+		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+		if (!l2data->data_len)
+			bthost_add_l2cap_server(bthost, l2data->server_psm,
+						NULL, NULL, NULL);
+	}
+
+	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+
+	/* Close sk only after connection, to trigger kernel processing */
+	sk[0] = watch_and_close_sk(connect_socket(client_bdaddr, NULL, true));
+	sk[1] = watch_and_close_sk(connect_socket(client_bdaddr, NULL, true));
+	sk[2] = watch_and_close_sk(connect_socket(client_bdaddr, NULL, true));
+	sk[3] = watch_and_close_sk(connect_socket(client_bdaddr, NULL, true));
+	sk[4] = watch_and_close_sk(connect_socket(client_bdaddr, NULL, false));
+
+	/* Open one deferred socket too many for ECRED REQ, triggers miscounting
+	 * of pending connections in some kernel versions.
+	 */
+	sk[5] = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
+								l2data->mode);
+	if (sk[5] < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	if (setsockopt(sk[5], SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
+							sizeof(opt)) < 0) {
+		tester_test_failed();
+		close(sk[5]);
+		return;
+	}
+
+	err = connect_l2cap_impl(sk[5], client_bdaddr, BDADDR_LE_PUBLIC,
+					l2data->client_psm, l2data->cid);
+	if (err == -EPROTO) {
+		tester_test_passed();
+
+		for (i = 0; i < (int)ARRAY_SIZE(sk); ++i)
+			if (sk[i] >= 0)
+				close(sk[i]);
+	} else {
+		/* Try to trigger kernel to make ECRED REQ with > 5 SCID */
+		watch_and_close_sk(sk[5]);
+
+		tester_test_failed();
+	}
+}
+
 static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -3528,6 +3620,11 @@ int main(int argc, char *argv[])
 				&ext_flowctl_client_set_phy_coded_test,
 				setup_powered_client, test_connect);
 
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Defer limit",
+				&ext_flowctl_client_defer_limit,
+				setup_powered_client,
+				test_connect_ext_defer_limit);
+
 	test_l2cap_le("L2CAP Ext-Flowctl Server - Success",
 				&ext_flowctl_server_success_test,
 				setup_powered_server, test_server);
-- 
2.55.0

