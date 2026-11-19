Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126527;
	b=aSf3QVIfd6hI+0Wu3q73TMxWlZoZQLZvA0i0872TNJ75tw1S0TeAM6//foBoh8IQrbui
	 on+x8w/fnfplWxwbdabskwM0LT+cBZAH57WrF36lnxSyFN/udt7meMsPyyAntxPmjGSxy
	 NOBe7F4gIFtOugk3MaW5exRcOI0Pleqh19HsITSuqcHHxUWasIMTPHx05gQCitbLcIRkB
	 kChwvSU88lKhYKmiLsdQUvt2MBGFNbfB9su4hVVn/cJLyYwBFu2OHPUH2L61PsTxyilmZ
	 oV/myWz65mbq4Yymy+U9qoglHe4JuKvgsrf1MLjMdHQnAjTGyieFVRp4clRrEer1dtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C2qO7BfkvHYTlwro5vm7ktBflOO0C333xHbmtdZ4uak=;
	b=tjldCF6nXwktabgxKFqTauqwpWtpjm5nafiDASQyC1yX1t3BPNF07/vAOjLhRU/ifOvX
	 1vU12DFvxBQOPM1G6MwBoDVAZBcr3r7v+iP9dn7ssJedSDUROcJXhe6sjMns/0kgKMbNJ
	 z93hNRMjokfEV3OrVmIkoxBmfXq/78ZwF2xTuTTsKVpsB2lfIG4nmI5LL4lMoi/wdA7Fx
	 +E+D3I4psmIq4qXPOjMhqSIjY+eyj+B03fbD8eOtGsgWzpAeE3XQWCyapg+zgQbFpPJQR
	 FRbol9Ohh5/l6FWge7pmvG5aqpL5njX2dru8eIeH920QW1U4jI9r3G0EMdBiO1ldDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNzEoNRO;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA75606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA75606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNzEoNRO
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so106447137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126525; x=1795731325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C2qO7BfkvHYTlwro5vm7ktBflOO0C333xHbmtdZ4uak=;
        b=FNzEoNROPdiEF1Pdjh2cC2TQya1nszdwNPo2LlnplWYsGHcz62JAjf5Pir7Nm317Uq
         JnOi3tdE3qpbkpvRMdUso7TI7mPr3SjUta+8dXkYZfxylp2ZFC9brNtvpvJnNndwEt8P
         FdFM6V4cA4GLGBkpIsBW928cJ6wq0D/Rhqz5qLbpbynwtJe2N1q+pWXiqYEgcdW+//3I
         X54QylSzXWagFaYe9ba/4Wox7cmYOylqilf4aDkDLT04LrCsRzInGAk4FtXGVAOuWQUC
         pultNHRMKBZnedSuuyX5X18K00eYPHqxbII0sCqak337NwP0+FEEGbsqL5W8gJlz5hx/
         V4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126525; x=1795731325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C2qO7BfkvHYTlwro5vm7ktBflOO0C333xHbmtdZ4uak=;
        b=1GnmOOO0GU/tSrokDDzXI3At5SQOYxDqFXADrJVx99khTBrzc9qiN2E48DR0W29aWR
         GnN0OSViVeOdV70qp9fPICvfd9M0+uA+1xzTuGITHKKcSvHJvw8+vxXXBPuYqE3dvaOB
         xxPAsNAvbBzMOU712dO2SgWsLsj1o17H/souh/Sibb4cvZxz+lzlkZX6yEPL63Jxc2xU
         agfsWHCYDRRq+0F3QkMRJ9Ob+5O6XvDhnvcbK1xVabhI9Zl4ffsyc6bbrojnPvhYKsDf
         Xor22K03+BHdzpCwHiP51O32vn+Z96/BvSa1Vo9zozug4gNx8ledJwc3Ad6R5Q5GeWkk
         UNDQ==
X-Gm-Message-State: APuU4Z8PhYHUvowMvNE2vmD/4C8uCbVwU79ixc2c5o3JL+j1jYbClJpT
	OFZpfgIxYwxvh+sV3xZyis7H7edWww7+Jrq4w5WC16YfiH46ag0JwWuudkeJ07EM
X-Gm-Gg: AYBFou2HEpkm+bvsIlV6k60Q/l96TTV2nGNTlKyhFEgWliyBJ3klmEJtgWFhXKEgJ2Q
	N6kcVs9waodqtsgwGrEqMj3BJCho6/LhWkVJC80clz94bJPtrWEoEBx6PWr1M/NO2VC1kFRApWJ
	j24moV4rO64NYwcaXjm2ibEATJkp3vraP2TYXroAnUtQaVOQkD51DwQ20AmX2DzrpO8wDpRwwHS
	GBjpbfO26G+I87uiUKcxqyNokySYh4sLS/4Aes9cyoCd2hTOdcGYUNTGXWsLGg1OcRRgjeB6r+Y
	a8Mkd26Yct0oN5X5Wnh1v3Z3ANuHis5PG4/82D0bjVOEfXpH/3/ge6c3yUoJUIzFdtDJw5fRyAK
	y/2z16tUhMr01+v9cUYi25pBnq5CglPvOOJH1ulevBLB+Uen3cdUFUtnqm7btgBOPFzHdM+1T+f
	T5BQhQfmewvuk/rbEC9V9xwU7vlh2Ifie3bQQ2DimR3SaaUNaL1U5yZWFlwKoMO2dDjADbXwnMz
	F4WkNk1H0UVoRDdJMsrTO/+f5+tqQ1iQ6IAwxRe244wCcjKeCoqMD2qpNf1Lf27EC/9xfwwF5sy
	wZUx4112c8Re/19u0Q9ZOY2Kqx539qEUk9RX5kHCr3zqQ70HKqBNRNE1mtm/eui6MClBLjC/ivQ
	MgywmJ1p4c5tPm3MsBQhX6Q7MLXdKK1ZoXd7DnHgXgdyTJT23SwCKur2n2A2Uw/gHHnH7s9eR9X
	ZJ/b8=
X-Received: by 2002:a05:6102:c4b:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d72b361786mr495316137.2.1795126524810;
        Thu, 19 Nov 2026 14:15:24 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec7cb5sm1268404241.2.2026.11.19.14.15.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:15:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] l2cap-tester: Add tests for security of deferred setup
Date: Thu, 19 Nov 2026 17:15:19 -0500
Message-ID: <20261119221520.1311381-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119221520.1311381-1-luiz.dentz@gmail.com>
References: <20261119221520.1311381-1-luiz.dentz@gmail.com>
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
L2CAP BR/EDR Server - Security Block is rejected before that.

Assisted-by: OpenCode:claude-fable-5.2
---
 tools/l2cap-tester.c | 236 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4d2c5cd15c64..020d31b71d27 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -54,6 +54,8 @@ struct test_data {
 	int sk2;
 	int reencrypt_sk;
 	int opp_sk;
+	int listen_sk;
+	struct tester_io *defer_io;
 	bool opp_encrypted;
 	bool host_disconnected;
 	int step;
@@ -129,6 +131,10 @@ struct l2cap_data {
 	bool direct_advertising;
 	bool close_1;
 	bool defer;
+	bool hold_auth;
+	bool encrypt_off;
+	/* Follow a pending connection response until the final one */
+	bool pending_rsp;
 
 	bool shut_sock_wr;
 
@@ -355,6 +361,8 @@ static void test_data_free(void *test_data)
 	test_l2cap(name, HCIEMU_TYPE_BREDRLE70, data, setup, func)
 
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
+/* "1111" */
+static uint8_t pair_device_wrong_pin[] = { 0x31, 0x31, 0x31, 0x31 };
 
 static const struct l2cap_data client_connect_success_test = {
 	.client_psm = 0x1001,
@@ -614,6 +622,84 @@ static const struct l2cap_data l2cap_server_sec_block_test = {
 	.enable_ssp = true,
 };
 
+static const uint8_t l2cap_defer_sec_block_rsp[] = {
+						0x40, 0x00,	/* dcid */
+						0x41, 0x00,	/* scid */
+						0x03, 0x00,	/* Sec Block */
+						0x00, 0x00	/* status */
+};
+
+static const struct l2cap_data l2cap_server_defer_success_test = {
+	.server_psm = 0x1001,
+	.defer = true,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
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
@@ -1120,6 +1206,17 @@ static const struct l2cap_data le_server_success_test = {
 	.expect_cmd_len = sizeof(le_connect_rsp),
 };
 
+static const struct l2cap_data le_server_defer_success_test = {
+	.server_psm = 0x0080,
+	.defer = true,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+};
+
 static const uint8_t nval_le_connect_req[] = {	0x80, 0x00, /* PSM */
 						0x01, 0x00, /* SCID */
 						0x20, 0x00, /* MTU */
@@ -2223,6 +2320,13 @@ static void setup_powered_common(void)
 	if (test && test->reject_ssp)
 		bthost_set_reject_user_confirm(bthost, true);
 
+	if (test && test->hold_auth)
+		bthost_hold_auth_request(bthost, true);
+
+	if (test && (test->hold_auth || test->encrypt_off ||
+							test->pending_rsp))
+		bthost_set_l2cap_rsp_pending(bthost, true);
+
 	if (data->hciemu_type >= HCIEMU_TYPE_LE)
 		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -3938,6 +4042,102 @@ static bool defer_accept(struct test_data *data, struct tester_io *io,
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
+static void early_accept(struct test_data *data)
+{
+	struct tester_io *io;
+	int new_sk;
+
+	new_sk = accept(data->listen_sk, NULL, NULL);
+	if (new_sk < 0) {
+		tester_print("Nothing to accept while security is pending: "
+					"%s (%d)", strerror(errno), errno);
+		return;
+	}
+
+	tester_print("Accepted sk = %d while security is pending", new_sk);
+
+	io = tester_io_new(new_sk);
+	tester_io_set_close_on_unref(io, true);
+
+	defer_keep(data, io);
+	defer_authorize(data, io);
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
+	/* Not pending, check the final response */
+	if (result != 0x0001)
+		return false;
+
+	/* Authentication pending */
+	if (l2data->hold_auth && status == 0x0001 && !data->step) {
+		data->step = 1;
+		early_accept(data);
+		bthost_release_auth_request(bthost);
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
@@ -3967,6 +4167,15 @@ static bool l2cap_listen_cb(struct tester_io *io, uint32_t cond,
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
@@ -3994,6 +4203,12 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
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
 
@@ -4196,6 +4411,8 @@ static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
 			return;
 		}
 
+		data->listen_sk = sk;
+
 		io = tester_io_new(sk);
 		tester_io_set_close_on_unref(io, true);
 
@@ -4557,6 +4774,22 @@ int main(int argc, char *argv[])
 					&l2cap_server_sec_block_test,
 					setup_powered_server, test_server);
 
+	test_l2cap_bredr("L2CAP BR/EDR Server - Security Block Pairing Failed",
+					&l2cap_server_sec_block_pairing_test,
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
@@ -4722,6 +4955,9 @@ int main(int argc, char *argv[])
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

