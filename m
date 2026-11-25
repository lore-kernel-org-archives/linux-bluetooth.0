Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641127;
	b=cYMg/MGSZKzuxBektpMg2hBj2tBkkwMGdQeaEGqNYMdmKIiFZsrhJ498KBGM3D6S//ry
	 K2gKQGnFmnjztCh/h7gV3EqWa9hqcMj+3mzPIAl8aHzLgt/heAunJFyt88CY+ynmXYK11
	 piVUBcwR05S9k2n6gJ0Of3JNJTSw3+o/ajlcMxxkYFfzwQnifQyXiLW82vfPlK6VuZFW7
	 ut92N6dBZsm5IZ7Wi3RWT1E4YzxpWgoEcGHM6zYaN2ViyCiNbcRQxCiMSSGWnQ1Dq2GZ7
	 R0kSoaN4Sk8WDWqkupTPxks79G1giyUNpjHxDmYJpQtBYBMpFsEKTEhcgN6CVhJF3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VA1A5RqFPxLzqF5LMVYpRTuhhjCSu0GUEJx0TA+EcEc=;
	b=S9zOQtnJgWJ+/nUQ/RjaPkj82cis7wByehFNp0WxjUathHjNVakCa8Te2Hvefp5qL0nM
	 OMdcPTgcb+QG+OaM9AFCJCuWMpQwvJpkD1fFpYlwnmylM0pb8FQ0MxajPhK9US32K3b0J
	 mOxCKgFlS/fRZ2wqzBKcOeNiT5xttkAu9mmFVeP3KD8f8oK9fwLs6JcE59ixTZTx45owI
	 VJ4ZwADjnvFjze4RClXjKihFeAcK7d/uCZaQ4JQsZur0aSZ5p4ZfJnQEe/dsdbcTgndwb
	 7iMfIfLmQj4rRrSpO7l6QTO23Db334K6t8twkJ3MLNuY38mb9vAn1pSakk9wlK5f9Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbHtOzeE;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD1606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FDD1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbHtOzeE
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-99e145569c6so1462574241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641126; x=1796245926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VA1A5RqFPxLzqF5LMVYpRTuhhjCSu0GUEJx0TA+EcEc=;
        b=cbHtOzeEZS5FFg1hEfIZ4c8lyHbqJ/rAKtRZ/9ZYkOqcG0Hgg5Um+QIGRXXqzXXdWa
         uMfULutAdEZSid+5xouRkTC+PxVRU3JeB9Q0aoyizYKo+AduyxUAgnNHSSmaV2bceOR3
         5IhfuadT4rI5sBtDUDiS+mMza1CXsU4QZ0LLUVBnM9J7JF9ClulSPibUgAh/DDoXWbFA
         WKc9m9IX8wPhnKvfrZmbnv64kn9YkXHqm3g3zW2FXq7BF3dupj9uJwW+rSuoQywt8FX4
         THPrdU/aE6ytlSssX+U2xm9NsWdtsiuEkWFibW7i7UTzgRqurLyQy2DSGC/cTanZw7S2
         Qq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641126; x=1796245926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VA1A5RqFPxLzqF5LMVYpRTuhhjCSu0GUEJx0TA+EcEc=;
        b=c8H/1PEow2ii6c9vR4EuqP6FU9raS4c8TW005RexBX/T1GV8Kf2twcU5m1zUJPen3a
         YqcrE+OFCsc14rHfEMgEbyu/ZtbMCz2tNcqmdd2qb4H8FHJ0y5H2UTuSOBsLCkx6Qyvt
         BT+s1vHL2l5RuWixCGare892z8gpZml4i1og0O/txpAno4M22pFYbjD4kzfOHShkvcx/
         Oo6ZY39T6CWFY9ewlbZXamph6dvKnzH57EJs31FRWI5FU7BD/VLG1GkuMouskrTXBsPK
         71fSw65zddjJEHj/GbQsfdvTZfoOXQjC07Ggyz/ol5BD8R4EHfkW5HfTwsqBEnmw8nmi
         rt/g==
X-Gm-Message-State: APuU4Z/QFDw8JwNTRp9G2oaQDT6HtehuRO2xUlqxqC7MIX2rBuvF+SOl
	sD+3bM5vlHKGdqzbC0scwCNl4+uxwKgoW0chvUsCWbe49PUpiED934bb9dGDkQ==
X-Gm-Gg: AZFdTZf006e1x83eAy+6YQlZe6RKY9AwAIhnLEz51iDO2UiRlA3mmMTgxUdax/+ZDuL
	5FRLofMY+b4vLbQ27GpGF7PC6n0AzVBF9o9n+8sgqTiDTsO8eQJlmyd+vmHLV7hE3pGbMfMPVTw
	lz/psW0Pj2jcW06HZwKelCWvzfOEQU3ilZe/2vo3xqG66Tg2xv/kI3qkkUwq6gTE2vB5HGHDz+V
	veN3a01I+7Azw2/qVHDgTmBa0aKCcYLEK7yNWq3PVKY+XX4MZ8dp8b6cQVaY/3bfU0xHW5+LHKj
	u2nwaMDtr+hccweTmXKPdiSpK1E/WzATPId0VESuZQTvWks0FLzVoV1hXtDmreS0A1/6KCDBsQ5
	JwDz86WjISqp0malNgLv46JI7TsiaD98Zlp3TfQS4xB0AkZRhXUl96MMICfiYTfghmlkl0s0aZf
	xE1E+lOgmbqfTN8wRGEd/saiF9e7CjvKdn+/D0Q/q3PK0tYmG6JDzJEC+Kb5s1JFonNyoG0GI7X
	YiY4ur0GzDx6b5t/pDv2GooCUNzfvOYXyvJ0D/1rdjc8Cp8sgKxF2pvxInMkbdJw1xn0yBDjj+Y
	QUXuNdmYIM6qWB1eOAHiOhri7C/nuD2fKKpXpDJW9tbx/lHqnROmLDnKjMhXze4thiWQiOs1AjD
	rXLV6b5UV+VFBOFqX31qi1UuGQmesrl/Q99Ek8QoJFiOPkCJD0p56HPfUfp10R3Y6vlUG+ic4/x
	dSdNY=
X-Received: by 2002:a05:6102:5707:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d7396386c5mr10986237137.34.1795641126121;
        Wed, 25 Nov 2026 13:12:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e0686b1sm20199653241.10.2026.11.25.13.12.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/6] rfcomm-tester: Add tests for deferred setup
Date: Wed, 25 Nov 2026 16:11:58 -0500
Message-ID: <20261125211200.1955466-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211200.1955466-1-luiz.dentz@gmail.com>
References: <20261125211200.1955466-1-luiz.dentz@gmail.com>
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

Basic RFCOMM Socket Server - Defer Success
Basic RFCOMM Socket Server - Defer Early Accept

Defer Early Accept has the listener accepting and authorizing the
connection while authentication, which then fails, is still pending and
expects the connection to be refused.

Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 tools/rfcomm-tester.c | 167 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 998d698c1bb2..083872728371 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -43,6 +43,11 @@ struct test_data {
 	struct tester_io *io;
 	unsigned int io_id;
 	uint16_t conn_handle;
+	int listen_sk;
+	/* Result of accepting while authentication is pending: 1 if there was
+	 * nothing to accept, 2 if a connection was accepted and authorized
+	 */
+	int early_accept;
 	uint16_t send_len;
 	uint16_t recv_len;
 };
@@ -61,6 +66,12 @@ struct rfcomm_server_data {
 	uint8_t server_channel;
 	uint8_t client_channel;
 	bool expected_status;
+	bool defer;
+	int sec_level;
+	const uint8_t *pin;
+	uint8_t pin_len;
+	const uint8_t *client_pin;
+	uint8_t client_pin_len;
 	const uint8_t *send_data;
 	const uint8_t *read_data;
 	uint16_t data_len;
@@ -286,13 +297,89 @@ static void setup_powered_server_callback(uint8_t status, uint16_t length,
 	tester_setup_complete();
 }
 
+/* Authorize a deferred connection, the socket is kept open in data->io */
+static void defer_authorize(struct test_data *data, int sk)
+{
+	ssize_t ret;
+	char c;
+
+	ret = recv(sk, &c, 1, MSG_DONTWAIT);
+
+	tester_print("Authorize deferred setup sk = %d: %zd (%s)", sk, ret,
+					ret < 0 ? strerror(errno) : "ok");
+
+	if (data->io)
+		tester_io_unref(data->io);
+
+	data->io = tester_io_new(sk);
+	tester_io_set_close_on_unref(data->io, true);
+}
+
+static void pin_code_request_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_pin_code_request *ev = param;
+	struct test_data *data = user_data;
+	const struct rfcomm_server_data *srv = data->test_data;
+	struct mgmt_cp_pin_code_reply cp;
+
+	/* Behave like a listener that does not wait to be notified: accept
+	 * and authorize whatever is queued while authentication is pending.
+	 */
+	if (srv->defer) {
+		int new_sk;
+
+		new_sk = accept(data->listen_sk, NULL, NULL);
+		if (new_sk < 0) {
+			if (errno != EAGAIN && errno != EWOULDBLOCK) {
+				tester_warn("accept failed: %s (%d)",
+						strerror(errno), errno);
+				tester_test_failed();
+				return;
+			}
+
+			tester_print("Nothing to accept while authentication "
+					"is pending");
+			data->early_accept = 1;
+		} else {
+			tester_print("Accepted sk = %d while authentication "
+					"is pending", new_sk);
+			data->early_accept = 2;
+			defer_authorize(data, new_sk);
+		}
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.addr, &ev->addr, sizeof(cp.addr));
+	cp.pin_len = srv->pin_len;
+	memcpy(cp.pin_code, srv->pin, srv->pin_len);
+
+	mgmt_reply(data->mgmt, MGMT_OP_PIN_CODE_REPLY, data->mgmt_index,
+					sizeof(cp), &cp, NULL, NULL, NULL);
+}
+
 static void setup_powered_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *srv = test_data;
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Powering on controller");
 
+	if (srv && srv->pin) {
+		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+		mgmt_register(data->mgmt, MGMT_EV_PIN_CODE_REQUEST,
+				data->mgmt_index, pin_code_request_callback,
+				data, NULL);
+
+		bthost_set_pin_code(bthost, srv->client_pin,
+							srv->client_pin_len);
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_BONDABLE, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 				sizeof(param), param,
 				NULL, NULL, NULL);
@@ -374,6 +461,33 @@ const struct rfcomm_server_data listen_read_success = {
 	.read_data = data
 };
 
+const struct rfcomm_server_data listen_defer_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = true,
+	.defer = true,
+};
+
+static const uint8_t pair_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
+/* "1111" */
+static const uint8_t pair_wrong_pin[] = { 0x31, 0x31, 0x31, 0x31 };
+
+/* The listener accepts and authorizes the connection while authentication is
+ * still pending and then authentication fails, the connection shall be
+ * refused.
+ */
+const struct rfcomm_server_data listen_defer_early_accept = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = false,
+	.defer = true,
+	.sec_level = BT_SECURITY_MEDIUM,
+	.pin = pair_pin,
+	.pin_len = sizeof(pair_pin),
+	.client_pin = pair_wrong_pin,
+	.client_pin_len = sizeof(pair_wrong_pin),
+};
+
 const struct rfcomm_server_data listen_nval = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0e,
@@ -721,6 +835,13 @@ static bool rfcomm_listen_cb(struct tester_io *io, uint32_t cond,
 		return false;
 	}
 
+	/* The result is checked once the client connection completes */
+	if (srv->defer) {
+		tester_print("Accept deferred setup sk = %d", new_sk);
+		defer_authorize(data, new_sk);
+		return false;
+	}
+
 	if (srv->send_data) {
 		ssize_t ret;
 
@@ -767,6 +888,15 @@ static void connection_cb(uint16_t handle, uint16_t cid, void *user_data,
 		return;
 	}
 
+	/* The result only counts if the listener tried to accept while the
+	 * authentication was pending.
+	 */
+	if (srv->defer && srv->pin && !data->early_accept) {
+		tester_warn("Connection result before accepting it");
+		tester_test_failed();
+		return;
+	}
+
 	if (srv->expected_status == status)
 		tester_test_passed();
 	else
@@ -803,6 +933,37 @@ static void test_server(const void *test_data)
 		return;
 	}
 
+	if (srv->sec_level) {
+		struct bt_security sec;
+
+		memset(&sec, 0, sizeof(sec));
+		sec.level = srv->sec_level;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+			tester_warn("Can't set security level: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			close(sk);
+			return;
+		}
+	}
+
+	if (srv->defer) {
+		int opt = 1;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
+							sizeof(opt)) < 0) {
+			tester_warn("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			close(sk);
+			return;
+		}
+	}
+
+	data->listen_sk = sk;
+
 	if (listen(sk, 5) < 0) {
 		tester_warn("listening on socket failed: %s (%u)",
 				strerror(errno), errno);
@@ -868,6 +1029,12 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Server - Read Success",
 				&listen_read_success, setup_powered_server,
 				test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Defer Success",
+				&listen_defer_success, setup_powered_server,
+				test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Defer Early Accept",
+				&listen_defer_early_accept,
+				setup_powered_server, test_server);
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
 
-- 
2.56.0

