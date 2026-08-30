Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885893AFAFA
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109931; cv=pass; b=hHXtVyrAeg9Wv1b7NCVbQKN7z5XivQKwLYawU54qRoLEDRDcWTli2HiA7oyd8Lvccnc/3dnm+DOEGmd2O8YscXi7lZixPs7hFJdYJi/oQc6qiPZeWGbwBB66/Fo5n9ZviijW8LTH9mPPKldO/Xi1j1YLg6DAUq4sURX2zFeCgXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109931; c=relaxed/simple;
	bh=Okv+z3moSFjVGNtFlZXHSz5T1wqzYJ54f5EI+grr4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OydRy+k4cY6F7Yg5DTMECr+/KUkTxIj09AmqQov8Gpmmu4woLsSqR59Z6JL9Q+R9FqlDNvXaojtKbzU1CfZ4wbM7rc0qZ6DUYwFvBLkIKADDPLKT/EKCYXIT/HJ/LWfy4IMCxIYWWwu86hv+i9kj27zLgVv612z+c71Xfbehc4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nXS8hErw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nXS8hErw"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXzF81kxmzyhS;
	Sun, 30 Aug 2026 20:11:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788109916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DmHpnUUIPfBW9B6ohToVkwhResTOVv1P966xVFzvGc=;
	b=nXS8hErwCEGBPOGHkIdJDeoNzyG5YiEu/btoBfB07nhWv5ARMl2heDx+isLwrP10ZsYyYV
	8uqa1EVPzH19PObb/DSAK41aVfvu3yciKVKATTTj+67jn0hyruLhLVhlSUvWn8WkZ37WcH
	Zupb9UnSC8SSdLYaijp8ppmpWWz88nk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788109916;
	b=XliPRJnwZomfP84t8WCJabmjw1t+162es9eNYotCMomlJK21NQ3SalHdQSwrRYc1vCBaVR
	7BzaiOeOIxE9rqW8vg7jlzf1QYjz3cavhtDuG/dmZJCMXtslNviMg2OdQLOhVc5XDKG18P
	30yL1O4O+14hvGdx4n4XvpZ1iOGUWYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788109916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DmHpnUUIPfBW9B6ohToVkwhResTOVv1P966xVFzvGc=;
	b=wQrlzIDvnZZFlvR3hYw729IL5NFjr0i1Bo43gxE7NYplquPvTo+/ELcuQZzG7Q4UosmKT+
	DnPH069lExPoDjXSwE11EYqAPDdy4/JUKUobFn1rmVuZKhq7lJ4jLWDUg+4T/7lHIXHdcQ
	K+/R9y1FZDED2Z70xmq8PONvbKBpn64=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server
Date: Sun, 30 Aug 2026 20:11:46 +0300
Message-ID: <3cc24b76e142e90a2c1fb320ae0685a04a7d65eb.1788109841.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <66d2971217dc632b10049fef7a5e9e735715bca2.1788109841.git.pav@iki.fi>
References: <66d2971217dc632b10049fef7a5e9e735715bca2.1788109841.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that checks Ext-Flowctl server handles invalid connection
requests with ident collisions. This triggers null-deref crash / hang on
some kernel versions.

L2CAP Ext-Flowctl Server - Nval Conn Req
---
 tools/l2cap-tester.c | 169 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 160 insertions(+), 9 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 69c529aa8..efff5c2d8 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -30,6 +30,7 @@
 
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
 #include "src/shared/util.h"
 
 #include "tester.h"
@@ -51,6 +52,7 @@ struct test_data {
 	int sk2;
 	bool host_disconnected;
 	int step;
+	struct queue *io_channels;
 	struct tx_tstamp_data tx_ts;
 };
 
@@ -267,6 +269,11 @@ static void test_pre_setup(const void *test_data)
 					read_index_list_callback, NULL, NULL);
 }
 
+static void io_channel_unref(void *data)
+{
+	g_io_channel_unref(data);
+}
+
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -281,6 +288,9 @@ static void test_post_teardown(const void *test_data)
 		data->err_io_id = 0;
 	}
 
+	queue_destroy(data->io_channels, io_channel_unref);
+	data->io_channels = NULL;
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -1137,6 +1147,12 @@ static const struct l2cap_data ext_flowctl_server_nval_scid_test = {
 	.expect_cmd_len = sizeof(nval_ecred_connect_rsp),
 };
 
+static const struct l2cap_data ext_flowctl_server_nval_conn_req_test = {
+	.server_psm = 0x0080,
+	.defer = true,
+	.mode = BT_MODE_EXT_FLOWCTL,
+};
+
 static const struct l2cap_data ext_flowctl_server_phy_test = {
 	.server_psm = 0x0080,
 	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
@@ -2897,6 +2913,8 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 	const struct l2cap_data *l2data = data->test_data;
 	int sk, err;
 
+	data->io_id = 0;
+
 	sk = g_io_channel_unix_get_fd(io);
 
 	if (!check_mtu(data, sk)) {
@@ -2929,7 +2947,8 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static bool defer_accept(struct test_data *data, GIOChannel *io)
+static bool defer_accept(struct test_data *data, GIOChannel *io,
+							GIOFunc accept_cb)
 {
 	int sk;
 	char c;
@@ -2953,11 +2972,12 @@ static bool defer_accept(struct test_data *data, GIOChannel *io)
 		}
 	}
 
-	data->io_id = g_io_add_watch(io, G_IO_OUT, l2cap_accept_cb, NULL);
+	if (accept_cb)
+		data->io_id = g_io_add_watch(io, G_IO_OUT, accept_cb, NULL);
 
 	g_io_channel_unref(io);
 
-	tester_print("Accept deferred setup");
+	tester_print("Accept deferred setup sk = %d", sk);
 
 	return true;
 }
@@ -2980,6 +3000,8 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	tester_print("Accept sk = %d", new_sk);
+
 	io = g_io_channel_unix_new(new_sk);
 	g_io_channel_set_close_on_unref(io, TRUE);
 
@@ -2989,7 +3011,7 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 			return FALSE;
 		}
 
-		if (!defer_accept(data, io)) {
+		if (!defer_accept(data, io, l2cap_accept_cb)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
 		}
@@ -3098,7 +3120,8 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 	}
 }
 
-static void test_server(const void *test_data)
+static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
+							GIOFunc listen_cb)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -3128,7 +3151,7 @@ static void test_server(const void *test_data)
 			return;
 		}
 
-		if (listen(sk, 5) < 0) {
+		if (listen(sk, 32) < 0) {
 			tester_warn("listening on socket failed: %s (%u)",
 					strerror(errno), errno);
 			tester_test_failed();
@@ -3139,8 +3162,7 @@ static void test_server(const void *test_data)
 		io = g_io_channel_unix_new(sk);
 		g_io_channel_set_close_on_unref(io, TRUE);
 
-		data->io_id = g_io_add_watch(io, G_IO_IN, l2cap_listen_cb,
-									NULL);
+		data->io_id = g_io_add_watch(io, G_IO_IN, listen_cb, NULL);
 		g_io_channel_unref(io);
 
 		tester_print("Listening for connections");
@@ -3154,7 +3176,7 @@ static void test_server(const void *test_data)
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
-	bthost_set_connect_cb(bthost, send_req_new_conn, data);
+	bthost_set_connect_cb(bthost, conn_cb, data);
 
 	if (data->hciemu_type == HCIEMU_TYPE_BREDR)
 		addr_type = BDADDR_BREDR;
@@ -3164,6 +3186,130 @@ static void test_server(const void *test_data)
 	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
+static void test_server(const void *test_data)
+{
+	start_test_server(test_data, send_req_new_conn, l2cap_listen_cb);
+}
+
+static gboolean ext_flowctl_nval_conn_req_ready_cb(gpointer ptr)
+{
+	struct test_data *data = tester_get_data();
+	const struct queue_entry *entry;
+	GIOFunc cb = l2cap_accept_cb;
+
+	if (data->io_id) {
+		g_source_remove(data->io_id);
+		data->io_id = 0;
+	}
+
+	data->err_io_id = 0;
+	data->step = 0;
+
+	tester_print("Accepting %d deferred", queue_length(data->io_channels));
+
+	entry = queue_get_entries(data->io_channels);
+	for (; entry; entry = entry->next) {
+		GIOChannel *io = entry->data;
+
+		if (!defer_accept(data, g_io_channel_ref(io), cb)) {
+			g_io_channel_unref(io);
+			tester_warn("Unable to accept deferred setup");
+			tester_test_failed();
+			break;
+		}
+
+		/* Require only the first to connect */
+		cb = NULL;
+	}
+
+	return FALSE;
+}
+
+static gboolean ext_flowctl_nval_conn_req_listen_cb(GIOChannel *io,
+					GIOCondition cond, gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	int sk, new_sk;
+	GIOChannel *new_io;
+
+	if (!data->step)
+		return FALSE;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
+		tester_test_failed();
+		return FALSE;
+	}
+
+	tester_print("Accept sk = %d", new_sk);
+
+	new_io = g_io_channel_unix_new(new_sk);
+	g_io_channel_set_close_on_unref(new_io, TRUE);
+
+	if (!data->io_channels)
+		data->io_channels = queue_new();
+	queue_push_tail(data->io_channels, new_io);
+
+	if (data->err_io_id) {
+		g_source_remove(data->err_io_id);
+		data->err_io_id = 0;
+	}
+
+	/* Accept all deferred connections at once, or until timeout */
+	data->step--;
+	if (!data->step) {
+		data->io_id = 0;
+		ext_flowctl_nval_conn_req_ready_cb(NULL);
+		return FALSE;
+	}
+
+	data->err_io_id = g_timeout_add(1000,
+				ext_flowctl_nval_conn_req_ready_cb, NULL);
+
+	return TRUE;
+}
+
+static void ext_flowctl_nval_conn_req_conn_cb(uint16_t handle, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct bthost *bthost;
+	int i;
+
+	tester_print("New client connection with handle 0x%04x", handle);
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	tester_print("Sending %d L2CAP_LE_CONN_REQ", data->step);
+
+	/* All L2CAP_LE_CONN_REQ (0x14) use the same PSM, same ident, different
+	 * SCID.  Receiver may reject some of these due to ident collision,
+	 * but at least it should not hang/crash.
+	 */
+	for (i = 0; i < data->step; ++i) {
+		uint8_t cmd[] = {
+			/* PSM(2), SCID(2), MTU(2), MPS(2), Crd(2) */
+			0x80, 0x00, 0x40 + i, 0x00,
+			0x40, 0x00, 0x40, 0x00,
+			0x05, 0x00
+		};
+
+		bthost_l2cap_sig_raw(bthost, handle, 0x14, 0x9f,
+							cmd, ARRAY_SIZE(cmd));
+	}
+}
+
+static void test_ext_flowctl_server_nval_conn_req(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->step = 32;
+	start_test_server(test_data, ext_flowctl_nval_conn_req_conn_cb,
+					ext_flowctl_nval_conn_req_listen_cb);
+}
+
 static void test_getpeername_not_connected(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3550,6 +3696,11 @@ int main(int argc, char *argv[])
 				&ext_flowctl_server_set_phy_coded_test,
 				setup_powered_server, test_server);
 
+	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Nval Conn Req",
+				&ext_flowctl_server_nval_conn_req_test,
+				setup_powered_server,
+				test_ext_flowctl_server_nval_conn_req);
+
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
 				setup_powered_client, test_connect);
-- 
2.55.0

