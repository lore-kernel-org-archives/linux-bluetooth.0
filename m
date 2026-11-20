Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189676;
	b=3IdBr4+UwTeXlxob+SrqcUcTNfgbYTA3zvE7r2oPklMArTbwclv7EFre/DGCLfMWCTxK
	 zfO2ai/9jWiGiac2v40O9W1rhVVwKYcfGfK6IdT3XQCUNtUUJ1TbU87S9ecVK9CiYSPKO
	 S4tOSXToP+rOn1vfOUzOWIFvL2ZyLmzcXEbZJu3t75kRDcUgPQe1+CvkLDO2PRcnyIReV
	 +JgpnpRmZW/q+S6WVSc0zlFEjtT2Tp4X4gG1q9XIF8AG42fT8FLIJJKJY9aRXdZ81YGkb
	 SBPMFbhXswGlondyinHl3eT5jRsVbpIaTjWH5iJAO9Ho6AW1pDIMBcjOTNI8IfA/+Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QrqbVcqqjh4Bgi8fHtTEUMf4RMNz43OC47xdvLYrXvg=;
	b=RT+dt/LQlVBTX76CYqq/Ji1h3uWpj98iuzrwIROIrfQT6Ui0dRNf2ioeVP2VZCyuhjOa
	 Vs/sCtnwCIUSfLbF0dIm/6wzzmhAfytjs4ek+M7BpwGlHbrTZp+ySz1FevTHYwV8PESX5
	 wDCq4TqjTh3KSNIo6LqSkYlAwnr4uu0dvAyRM44ZsrS1dXvlzmYc7s8l49irdpAIBlfkh
	 zkDjX/STECepighhbuCvpl6iaf6YMGnLli2wwrEUofHJBXjCKPZOCxjeoHp0lOgJXBpiN
	 kDScWUOHqfviqyMPupi+VWRC+6HVREz6bWYVXMOgoELYtnRBZiMppm+hVk/lxb3Wh8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRFVv8DW;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DC60A2620
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254DC60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRFVv8DW
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99e1408dc59so495450241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189675; x=1795794475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QrqbVcqqjh4Bgi8fHtTEUMf4RMNz43OC47xdvLYrXvg=;
        b=ZRFVv8DWCqkRTt0JSeZqkJbg7h4g0zA8jRqWSLPrTgZlXmqHhjsPTJ82xImkgYkykJ
         BPNfhkoIQ1UdfVbTjnV2lxjvlPVn2h+yJ+fwlApcTmgBAswpbFuqwipVDK7OxYE3Fscs
         qh3ajiwJi1OKAGe+c/G1eAylx9KKx5f7xyVcYYkBwri/V99Jgc0ePJDc7+K9ICpJlm43
         3g96pYAtfVW5h1zL+Fgvb0RvhWO3iUNieAol8aiNriIh0mJJb35L6vhjJIK24VWfD0Vg
         6qfjqbLvuAEJAqiju1u+Vn5uSs/ZqvOHU9EYGDTD46S3RovslR7yCwYazNZqJFEC9dGP
         E4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189675; x=1795794475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QrqbVcqqjh4Bgi8fHtTEUMf4RMNz43OC47xdvLYrXvg=;
        b=DlCYbaqbW6mddppNcsSEx7elw3Nn7KJG+ZQjuxhIuBC4c8ZONPXEqe5emoGXQW56Oc
         dfnwAnPO7Eb6W9P0249Iq27m9HRKBw8Govd9AszgCXC3qJgIMZSzaK7vKDTu2ivlBNCR
         XcENbfK4dTeFOQaZayKNSFzcCk9y0IQAj3m724yqBMhTUOPzAu+4zmdWSoiDeSyWyQrs
         R2E1A/1lDgbjhod06lXwQkVhUp4Cr+utDKcO/PhYB2HrLT9gVRFZfk+i077MpZpQi+gI
         d2DLo6+QvXNhruUeYPsTXNXzt1MkSTCAg+anlb3UADTWQINza8izAs/cyZe8o00ckHqx
         1WrQ==
X-Gm-Message-State: APuU4Z9e7TyVQtL5W0YeIRtUSH59ZsLihjCDi/RNfZU5OrrJKJuujwUO
	AB0ZMWWvP+McFV+enjiDpPARpvZxTiB5rtRzmk+WbcylDDcsDz24C5oUsoonXk8b
X-Gm-Gg: AZFdTZftU8bniTUyISSlBNx0CbEBvmePtktK3aHtSUCgw92b6D6bSP3njtogTwjYFFm
	SI0YvNBMnx3HdwAZ99y6wWa/HmtnQB4GPGrpId9WwDuHFTEI+9wrps6sJGBpNt3hfjWz5ZvWetA
	bSUg6PDi20sdbp4ZTgOW/+tYI3qlY4IUHke9Fy+yA7MfRvgHTGxhLtBHHuuk8WuNa/Ba4WIaMSX
	5qf/VlFPBNkqClzH8QFWC2Gde87pLCsKZAGYDL1aYC0BYpKzUeTkil1xJNgJIZtB4Hfq/y3gvEn
	8PqYio300YJqFh3xu5pmGyBvSrC4Y+K0YXtk14hwjFL0Eh9aM8Ak2MMeRdaa+uveIqp/x1HQ6Lr
	8Z6kZf2JjoJYqOXfYnRlKXnzgBJd4ngZ8qma6SSX4D2Yf65eWLvECdi3RCyeJ69ulbnFtGmKklr
	Y64ZmNyeY8wsgJKLjgNM/+chnjYAtw5X8l8ywTJF7GHVot/zU/EYIEG9vQEn4ZV4vmS19pWUSDW
	hOsRWxVQnNc6nhExpgD/NhiGw7hkfl/bQZEgTeOLyQxpLLFCMt61V/0sWj/QhHUkNde94mgtxly
	b90lxrPFdrE/WUaPHxT8B17AezpwPPfIun1ncYCJnWZSrj4RIQVI5IB4P+WudoIPR14myrYFCyF
	bH9yKtNkjWGsHZW7I4bYpiUDWZYgGq7SMI6sOVXudJv7vEdmnWEuhzKvARhCIr69gIOgAGlZYBj
	gmy0g=
X-Received: by 2002:a05:6102:5107:b0:7be:25d4:7ff0 with SMTP id ada2fe7eead31-7d72b340e0dmr1628267137.4.1795189674934;
        Fri, 20 Nov 2026 07:47:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7b12eb7sm3358243137.0.2026.11.20.07.47.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:47:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] l2cap-tester: Add tests for security of deferred setup
Date: Fri, 20 Nov 2026 10:47:48 -0500
Message-ID: <20261120154750.1745643-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120154750.1745643-1-luiz.dentz@gmail.com>
References: <20261120154750.1745643-1-luiz.dentz@gmail.com>
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
 tools/l2cap-tester.c | 278 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 278 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4d2c5cd15c64..7004955a1af7 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -26,6 +26,8 @@
 
 #include "monitor/bt.h"
 #include "emulator/bthost.h"
+#include "emulator/btdev.h"
+#include "emulator/vhci.h"
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
@@ -54,6 +56,8 @@ struct test_data {
 	int sk2;
 	int reencrypt_sk;
 	int opp_sk;
+	int listen_sk;
+	struct tester_io *defer_io;
 	bool opp_encrypted;
 	bool host_disconnected;
 	int step;
@@ -129,6 +133,12 @@ struct l2cap_data {
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
 
@@ -355,6 +365,8 @@ static void test_data_free(void *test_data)
 	test_l2cap(name, HCIEMU_TYPE_BREDRLE70, data, setup, func)
 
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
+/* "1111" */
+static uint8_t pair_device_wrong_pin[] = { 0x31, 0x31, 0x31, 0x31 };
 
 static const struct l2cap_data client_connect_success_test = {
 	.client_psm = 0x1001,
@@ -614,6 +626,111 @@ static const struct l2cap_data l2cap_server_sec_block_test = {
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
@@ -1120,6 +1237,17 @@ static const struct l2cap_data le_server_success_test = {
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
@@ -2223,6 +2351,20 @@ static void setup_powered_common(void)
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
@@ -3938,6 +4080,102 @@ static bool defer_accept(struct test_data *data, struct tester_io *io,
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
@@ -3967,6 +4205,15 @@ static bool l2cap_listen_cb(struct tester_io *io, uint32_t cond,
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
@@ -3994,6 +4241,12 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
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
 
@@ -4196,6 +4449,8 @@ static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
 			return;
 		}
 
+		data->listen_sk = sk;
+
 		io = tester_io_new(sk);
 		tester_io_set_close_on_unref(io, true);
 
@@ -4557,6 +4812,26 @@ int main(int argc, char *argv[])
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
@@ -4722,6 +4997,9 @@ int main(int argc, char *argv[])
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

