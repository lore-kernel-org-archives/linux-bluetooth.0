Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624113;
	b=Y8uFfHR/xdBJ+jQMjR0hvNNOnJGtWQuw+FqT/2UvGBQYGDIEVEfNbVGNBjL37EmLn64p
	 njolQW+qn0ntjspsa1LH9Uo+/+8M+IOurAwZGeqzl0Z1hNutYb+H5GfGvhfNOmtDNBsrh
	 yTX7Sw/dZiZ5Sea8A/VsZJALU7/6oBt6D1/hDPXIk+eL5ChcBdyRrgghf6rT1q9ALtjhW
	 4YeyAMADO5vi00uCUMPuv1ijgqOnEKckcRkFb7RQ3Fb870jJOqd/I8MIzq+f1IVTknDn0
	 QwK2eE1wLfzVuDagVwo3eaSr7z4WA/PvHUfZkAxR851dgDvlIDACNhJculVridMaEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EaHeLM+0iePGwyjSDaIFO+amMcydBAJP+FK1ary6qd8=;
	b=24apWYEk1isdiRbykKZYK4lold70LpJOKMR095Cq1gvNf7HLPGrYAn7OhJ0FQogfdbUd
	 1K1No9eTuiXO9VohPCo6hXWDkTa7QkTmrWfV8PDGzwTWRHCSsPhdlKWCJ8Apr2xO4wAWo
	 Yv5pesApi4cVi3LTGdjVqWOAHjjGzWhbKd4/X0SkcKihQGyQ4QSWXR8g45L314XuNCpQ5
	 4r0TAUOG8ml6Citb+USZmzxSbY0TnGTQCT520hglcDcRUsHpWnsP7VE8nNUiJLqqWW0XI
	 NFFP19EwcDsVBGfpnEX1cNncRfFD8lW0vGTMc7SBA0m2aji9X9X6wMY/hogw4uAkIUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlG6wvwN;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98754606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98754606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlG6wvwN
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ec690faf85so2098342e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624111; x=1796228911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EaHeLM+0iePGwyjSDaIFO+amMcydBAJP+FK1ary6qd8=;
        b=DlG6wvwNxy4/Bkf50R56bWhKzKF8pqluqucCU6u1FdcVisbRlZXG3qO8+OFip2a6Vz
         SR8vyHy0dKlOe8PFmy78eLpzq6EnFQbIB9kqMRzbSczyTcEhh+MwLO+LqpN9vrtNIB43
         d8KLSgZTBGZoP2B/fqHSlkOjW1J+EggYch/I+/06oPYBNXNJOaPS2iCuqzw2uoJVanUp
         mKLxumKHdEDqKfdGN3u/sSCIYX0ccbvelo06vXz8UQIOTlq5QdzcSgdlQyBMqX6CBx3O
         ZPxKbWtTx8dC8l7TvtGdCWAzlDbR79fBhR/yFF6Oh0DxsbMV/7KyxxSw/P16O/huTHbB
         X14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624111; x=1796228911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EaHeLM+0iePGwyjSDaIFO+amMcydBAJP+FK1ary6qd8=;
        b=sljuuea5HwQ6iK3Eos3573nMsUTlfI+0PGGiR29Vxhmcei/NeBfuKEYeZn2vZ+xgTC
         0I0uKY8YqRKF4OPEIkB3YbsW3DbVX4I8m29oWtLMf+SLxqMPzWawg7ayXJzzwwhNhCmI
         9euDcq6VR3p8iF/iIk9WQoFBaZirWPlHvDSNwZzPtGPfBqz+Tv1Byjv45isz4QqAxXwy
         H3jixeghCg0dNnuugavDHxz6g3nTzHQZGRMW6xppJFjUxPIeYrRwV0eZXZvK+zbBmvej
         r0trDF2vsj+lxdj0kd87z0qtyi+WmFkwpD/EaeFBk9e12HDAiVdxqDMJ93R/a2Tnx4v5
         yjmw==
X-Gm-Message-State: APuU4Z/UI/arSo+7zwhXqW8EcQj823fc7mwz7eLCR6gSBybOGsryaliQ
	g7UAar9kydEpGUkai+UpiH9y8eFTp/a91c5MO5pKID1T3D44GWAuu+8V1QKopg==
X-Gm-Gg: AZFdTZek2tJJ48JuWtA8DJCFODgnnQa6xu9kloQkgdJqJYPXyTT63EkKouAokJaOo/t
	qid+hw98erUOTngFHxAoTHoXqyB1SEiDjJJ0g+rBpO3X7skQSVmVlyY88u1RZhBUv9zvU5McA/q
	JBfmoeaDwUBgF1hxDtfrZR9CeZUrmC7GzD5C4EQl6WcDP/3XZYLfm+3uAi1sSmZhI6XuzSfqtNy
	vasj2rz071k1WbcUiiMDqtuH+DIq6Jg4K4AIeIebr+pT2ILBHqWnIZcDwLYusNe2pfU5tsHKpSX
	hHrvX3pZhpW5A6fzxSa+wO1f+lkxs+A0PjQ3iOzAxooRlDF9enrWNTTxmlmh5uXcjMBsI6zKV3M
	xCF0oqtjuif5PGSbZTUug7rwZvLRT4PyKekYE+qnht2dj1UCdHN1f44Z28VfVklIdSGBWrIpWFN
	tArX8QEcyolx4Sj+0NE07kW8jDEuNmnNX9sPtG83pa+AaV5n1DGZwXMlEy8oxtCAAmyNbJZtHuq
	Uo/zTCgPaHZkoZxjWm5f8qzHyyXbUbuFqCfTauYDocpOqPKXV3zOs54+KchmxiFxefbjAonPJhX
	7nIg+TZwOK+EO9Z8ntQMTPcR59r4WG6wiyRMObVBhUmoQ+Uh5ti0+NiY4li3e3UvFLvTDXznYUl
	1sXsIZ7SZDJokILa4ZvSbGq5Fz0wJn+suqdWyLzlKJeU9tjPc59YwBLAAsIB17JO4Sl1BNWRGf1
	WF2d8=
X-Received: by 2002:a05:6122:218e:b0:5ec:d5e1:ee27 with SMTP id 71dfb90a1353d-5ee8af60a30mr10452444e0c.20.1795624111019;
        Wed, 25 Nov 2026 08:28:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5cd7c8sm17985305e0c.11.2026.11.25.08.28.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/5] l2cap-tester: Add tests for security of deferred setup
Date: Wed, 25 Nov 2026 11:28:23 -0500
Message-ID: <20261125162825.1409753-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125162825.1409753-1-luiz.dentz@gmail.com>
References: <20261125162825.1409753-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add the following tests:

L2CAP BR/EDR Server - Security Block Pairing Failed
L2CAP BR/EDR Server - Security Block Downgrade
L2CAP BR/EDR Server - Defer Success
L2CAP BR/EDR Server - Defer Encryption Off
L2CAP BR/EDR Server - Defer Early Accept
L2CAP LE Server - Defer Success

Defer Encryption Off has the peer disabling encryption while the
connection waits for the listener to authorize it, and Defer Early
Accept has the listener accepting and authorizing the connection while
authentication, which then fails, is still pending. Both expect the
connection to be blocked instead of being established.

Security Block Pairing Failed covers the connection being blocked once
pairing fails after the request has been responded as pending, since
L2CAP BR/EDR Server - Security Block is rejected before that, and
Security Block Downgrade covers pairing succeeding with a key that
doesn't meet the security level required.

Assisted-by: OpenCode:claude-fable-5.2
---
 tools/l2cap-tester.c | 305 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 305 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4d2c5cd15c64..6ad8a7aae717 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -26,6 +26,8 @@
 
 #include "monitor/bt.h"
 #include "emulator/bthost.h"
+#include "emulator/btdev.h"
+#include "emulator/vhci.h"
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
@@ -54,9 +56,15 @@ struct test_data {
 	int sk2;
 	int reencrypt_sk;
 	int opp_sk;
+	int listen_sk;
+	struct tester_io *defer_io;
 	bool opp_encrypted;
 	bool host_disconnected;
 	int step;
+	/* Result of accepting while security is pending: 1 if there was nothing
+	 * to accept, 2 if a connection was accepted and authorized
+	 */
+	int early_accept;
 	struct queue *io_channels;
 	struct tx_tstamp_data tx_ts;
 };
@@ -129,6 +137,12 @@ struct l2cap_data {
 	bool direct_advertising;
 	bool close_1;
 	bool defer;
+	bool hold_auth;
+	bool encrypt_off;
+	/* Follow a pending connection response until the final one */
+	bool pending_rsp;
+	/* Link key type the controller reports instead of the actual one */
+	uint8_t link_key_type;
 
 	bool shut_sock_wr;
 
@@ -355,6 +369,8 @@ static void test_data_free(void *test_data)
 	test_l2cap(name, HCIEMU_TYPE_BREDRLE70, data, setup, func)
 
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
+/* "1111" */
+static uint8_t pair_device_wrong_pin[] = { 0x31, 0x31, 0x31, 0x31 };
 
 static const struct l2cap_data client_connect_success_test = {
 	.client_psm = 0x1001,
@@ -614,6 +630,111 @@ static const struct l2cap_data l2cap_server_sec_block_test = {
 	.enable_ssp = true,
 };
 
+static const uint8_t l2cap_defer_sec_block_rsp[] = {
+						0x40, 0x00,	/* dcid */
+						0x41, 0x00,	/* scid */
+						0x03, 0x00,	/* Sec Block */
+						0x00, 0x00	/* status */
+};
+
+/* No response is expected so the test only passes once the socket is
+ * connected, after the connection has been authorized.
+ */
+static const struct l2cap_data l2cap_server_defer_success_test = {
+	.server_psm = 0x1001,
+	.defer = true,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+};
+
+/* Pairing fails after the connection request has been answered as pending,
+ * unlike l2cap_server_sec_block_test which is rejected right away.
+ */
+static const struct l2cap_data l2cap_server_sec_block_pairing_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.expect_cmd = l2cap_defer_sec_block_rsp,
+	.expect_cmd_len = sizeof(l2cap_defer_sec_block_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_wrong_pin,
+	.client_pin_len = sizeof(pair_device_wrong_pin),
+	.pending_rsp = true,
+};
+
+/* "0000000000000000" */
+static uint8_t pair_device_pin16[] = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+					0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+					0x30, 0x30, 0x30, 0x30 };
+
+/* Pairing succeeds but the controller reports an unauthenticated key, so
+ * encryption completes with a security level below the one required.
+ */
+static const struct l2cap_data l2cap_server_sec_block_downgrade_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.expect_cmd = l2cap_defer_sec_block_rsp,
+	.expect_cmd_len = sizeof(l2cap_defer_sec_block_rsp),
+	.sec_level = BT_SECURITY_HIGH,
+	.pin = pair_device_pin16,
+	.pin_len = sizeof(pair_device_pin16),
+	.client_pin = pair_device_pin16,
+	.client_pin_len = sizeof(pair_device_pin16),
+	.link_key_type = 0x04,
+	.pending_rsp = true,
+};
+
+/* The peer disables encryption while the connection waits for userspace to
+ * authorize it, the link no longer meets the security level so the connection
+ * shall be blocked instead of being offered again.
+ */
+static const struct l2cap_data l2cap_server_defer_encrypt_off_test = {
+	.server_psm = 0x1001,
+	.defer = true,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.expect_cmd = l2cap_defer_sec_block_rsp,
+	.expect_cmd_len = sizeof(l2cap_defer_sec_block_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_pin,
+	.client_pin_len = sizeof(pair_device_pin),
+	.client_encrypt = true,
+	.encrypt_off = true,
+};
+
+/* The listener accepts and authorizes the connection while authentication is
+ * still pending and then authentication fails, the connection shall be
+ * blocked.
+ */
+static const struct l2cap_data l2cap_server_defer_early_accept_test = {
+	.server_psm = 0x1001,
+	.defer = true,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.expect_cmd = l2cap_defer_sec_block_rsp,
+	.expect_cmd_len = sizeof(l2cap_defer_sec_block_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_wrong_pin,
+	.client_pin_len = sizeof(pair_device_wrong_pin),
+	.hold_auth = true,
+};
+
 static const uint8_t l2cap_nval_psm_rsp[] = {	0x00, 0x00,	/* dcid */
 						0x41, 0x00,	/* scid */
 						0x02, 0x00,	/* nval PSM */
@@ -1120,6 +1241,14 @@ static const struct l2cap_data le_server_success_test = {
 	.expect_cmd_len = sizeof(le_connect_rsp),
 };
 
+static const struct l2cap_data le_server_defer_success_test = {
+	.server_psm = 0x0080,
+	.defer = true,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+};
+
 static const uint8_t nval_le_connect_req[] = {	0x80, 0x00, /* PSM */
 						0x01, 0x00, /* SCID */
 						0x20, 0x00, /* MTU */
@@ -2223,6 +2352,20 @@ static void setup_powered_common(void)
 	if (test && test->reject_ssp)
 		bthost_set_reject_user_confirm(bthost, true);
 
+	if (test && test->hold_auth)
+		bthost_hold_auth_request(bthost, true);
+
+	if (test && test->link_key_type) {
+		struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+
+		btdev_set_link_key_type(vhci_get_btdev(vhci),
+							test->link_key_type);
+	}
+
+	if (test && (test->hold_auth || test->encrypt_off ||
+							test->pending_rsp))
+		bthost_set_l2cap_rsp_pending(bthost, true);
+
 	if (data->hciemu_type >= HCIEMU_TYPE_LE)
 		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -3938,6 +4081,128 @@ static bool defer_accept(struct test_data *data, struct tester_io *io,
 	return true;
 }
 
+/* Keep an accepted socket open until the test ends */
+static void defer_keep(struct test_data *data, struct tester_io *io)
+{
+	if (!data->io_channels)
+		data->io_channels = queue_new();
+
+	queue_push_tail(data->io_channels, io);
+}
+
+/* Authorize a deferred connection without closing its socket */
+static void defer_authorize(struct test_data *data, struct tester_io *io)
+{
+	int sk = tester_io_get_fd(io);
+	ssize_t ret;
+	char c;
+
+	ret = recv(sk, &c, 1, MSG_DONTWAIT);
+
+	tester_print("Authorize deferred setup sk = %d: %zd (%s)", sk, ret,
+					ret < 0 ? strerror(errno) : "ok");
+}
+
+/* Behave like a listener that does not wait to be notified: accept and
+ * authorize whatever connection is queued.
+ */
+static bool early_accept(struct test_data *data)
+{
+	struct tester_io *io;
+	int new_sk;
+
+	new_sk = accept(data->listen_sk, NULL, NULL);
+	if (new_sk < 0) {
+		if (errno != EAGAIN && errno != EWOULDBLOCK) {
+			tester_warn("accept failed: %s (%d)", strerror(errno),
+									errno);
+			tester_test_failed();
+			return false;
+		}
+
+		tester_print("Nothing to accept while security is pending");
+		data->early_accept = 1;
+		return true;
+	}
+
+	tester_print("Accepted sk = %d while security is pending", new_sk);
+	data->early_accept = 2;
+
+	io = tester_io_new(new_sk);
+	tester_io_set_close_on_unref(io, true);
+
+	defer_keep(data, io);
+	defer_authorize(data, io);
+
+	return true;
+}
+
+/* Handle the responses of the tests that follow a pending connection until
+ * its final response. Returns true if there is nothing else to check.
+ */
+static bool server_security_rsp(struct test_data *data,
+				const struct bt_l2cap_pdu_conn_rsp *rsp)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	uint16_t result = le16_to_cpu(rsp->result);
+	uint16_t status = le16_to_cpu(rsp->status);
+
+	tester_print("Connection response result 0x%04x status 0x%04x",
+							result, status);
+
+	if (!result) {
+		tester_warn("Connection accepted without required security");
+		tester_test_failed();
+		return true;
+	}
+
+	/* Not pending, check the final response, which only counts if the
+	 * action the test is about was done before it.
+	 */
+	if (result != 0x0001) {
+		if (l2data->hold_auth && !data->early_accept) {
+			tester_warn("Connection refused before accepting it");
+			tester_test_failed();
+			return true;
+		}
+
+		if (l2data->encrypt_off && !data->step) {
+			tester_warn("Connection refused before disabling "
+								"encryption");
+			tester_test_failed();
+			return true;
+		}
+
+		return false;
+	}
+
+	/* Authentication pending */
+	if (l2data->hold_auth && status == 0x0001 && !data->step) {
+		data->step = 1;
+		if (early_accept(data))
+			bthost_release_auth_request(bthost);
+		return true;
+	}
+
+	/* Authorization pending */
+	if (l2data->encrypt_off && status == 0x0002) {
+		if (!data->step) {
+			data->step = 1;
+			tester_print("Disabling encryption");
+			bthost_set_conn_encrypt(bthost, data->handle, 0x00);
+			return true;
+		}
+
+		/* Offered again after encryption was disabled, authorize it */
+		data->step = 2;
+		if (data->defer_io)
+			defer_authorize(data, data->defer_io);
+	}
+
+	return true;
+}
+
 static bool l2cap_listen_cb(struct tester_io *io, uint32_t cond,
 							void *user_data)
 {
@@ -3967,6 +4232,15 @@ static bool l2cap_listen_cb(struct tester_io *io, uint32_t cond,
 			return false;
 		}
 
+		/* Authorize only after the peer has disabled encryption */
+		if (l2data->encrypt_off) {
+			data->defer_io = io;
+			defer_keep(data, io);
+			if (data->step > 1)
+				defer_authorize(data, io);
+			return false;
+		}
+
 		if (!defer_accept(data, io, l2cap_accept_cb)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
@@ -3994,6 +4268,12 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
 	if (code == BT_L2CAP_PDU_CONN_RSP) {
 
 		const struct bt_l2cap_pdu_conn_rsp *rsp = data;
+
+		if ((l2data->hold_auth || l2data->encrypt_off ||
+				l2data->pending_rsp) && len >= sizeof(*rsp) &&
+				server_security_rsp(test_data, rsp))
+			return;
+
 		if (len == sizeof(rsp) && !rsp->result && !rsp->status)
 			return;
 
@@ -4196,6 +4476,8 @@ static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
 			return;
 		}
 
+		data->listen_sk = sk;
+
 		io = tester_io_new(sk);
 		tester_io_set_close_on_unref(io, true);
 
@@ -4557,6 +4839,26 @@ int main(int argc, char *argv[])
 					&l2cap_server_sec_block_test,
 					setup_powered_server, test_server);
 
+	test_l2cap_bredr("L2CAP BR/EDR Server - Security Block Pairing Failed",
+					&l2cap_server_sec_block_pairing_test,
+					setup_powered_server, test_server);
+
+	test_l2cap_bredr("L2CAP BR/EDR Server - Security Block Downgrade",
+					&l2cap_server_sec_block_downgrade_test,
+					setup_powered_server, test_server);
+
+	test_l2cap_bredr("L2CAP BR/EDR Server - Defer Success",
+					&l2cap_server_defer_success_test,
+					setup_powered_server, test_server);
+
+	test_l2cap_bredr("L2CAP BR/EDR Server - Defer Encryption Off",
+					&l2cap_server_defer_encrypt_off_test,
+					setup_powered_server, test_server);
+
+	test_l2cap_bredr("L2CAP BR/EDR Server - Defer Early Accept",
+					&l2cap_server_defer_early_accept_test,
+					setup_powered_server, test_server);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Invalid PSM",
 					&l2cap_server_nval_psm_test,
 					setup_powered_server, test_server);
@@ -4722,6 +5024,9 @@ int main(int argc, char *argv[])
 					setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Server - Success", &le_server_success_test,
 					setup_powered_server, test_server);
+	test_l2cap_le("L2CAP LE Server - Defer Success",
+					&le_server_defer_success_test,
+					setup_powered_server, test_server);
 	test_l2cap_le("L2CAP LE Server - Nval SCID", &le_server_nval_scid_test,
 					setup_powered_server, test_server);
 	test_l2cap_le("L2CAP LE Server - PHY", &le_server_phy_test,
-- 
2.56.0

