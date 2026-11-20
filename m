Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189677;
	b=MA5aaKb/vn1jPxWGWzZ5dgzJ60DGo9UlaubHrN2Tte1AXYvxyL7YF/Gr4qztMTzUniHD
	 KevNTR8lINsF8ItNyC+519tWYK9RVSE8as0C2BkiaM34FZR2Le0f7E5QfgUgD5k9Fmsso
	 dfHI61YbY9mn1pf0a2maGTotPZZ2q8Cl8ZC1KO2V5sOG4wd9yxjryJm5MLvLbhhvoeaBR
	 8w4xYpn6sV1eLCOZd2+5DK27ppeYFrqHK6Vvy1B3C2XZAStaPB2tlzGx5b/fic1mU9jDq
	 HkPjgVajLXYzVnhc0PF0ClO9ibVXXqRdfly1jZdSzpNzD3FeO96gN7ipMdR3+zwNwBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
	b=BcAooAaJmJx3HA6Tj2TPDiMfQ5QbdMJOYXHQY0naPY/jbXN15yCnqki9Yu/6rk+lHKPh
	 6lVDjTz5uqmzEoBMb/OLBhf/KApSUgqV0kOFjmLLE0ozn4xG1JQp5QBFGW05J+0MRQDgQ
	 eXmaJVC2k9pUbuJmZKVNsz589WTBZY+zbD3e+t3LeAFUkuI2Sun0+1Hkqp3Sfk2jrbEs4
	 EAy0I6VrO7cXmvs9WhA2OHVas8Qu/sQ743DvsSVG5HmS4mhHvNFPGkL0bOzAoI5I5Tluk
	 m4EwnFmEek1dsHpYKzVcx4eWanlnKNqsJKCsbIqj0py3LB9/5cx/7vvKG4wMbvREp/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M1mf/6hd";
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D460A2623
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C09D460A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M1mf/6hd
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99e1408dc59so495457241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189676; x=1795794476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
        b=M1mf/6hdjs6v9H7+CHmR5KIiAj2bxjip1QcqvUrTDxthBX7j7KT+4JCiY70gaz1Yie
         ILXnQ4bt8a3olovrprK87zb8hKu1iZR+xyi3COpQ7hb+H+zWQ87nDH0JfWp0kWyi2v/R
         OWKzUN/4wfU1e8WFeC38HrrYftmo99RZ6D3uOHj7RNUQKIpms9K6Kp598bV018kngkaX
         ZZZgriKU7LZIh6Lgm1qaqNVoJv4cqPA7KCV+bcie4a4Gn+eonAHB1DLBxDZO6lCCrchU
         ZkQOgVgr+NvYpKGANhBMtKcdpv3Sgd0BbXosNw6pOo++pyDvzq5jVH39zqIDtQg76Za5
         tNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189676; x=1795794476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
        b=H65Usl2utSGvSuGjHwbQMUcElG9sqGF34ehMX2/8UxUrVO00JWB8I+RZyQYqxyHw7m
         K6g737fQLQT8z1yFpN1EYDOF4ePav18NBbr2Duh24CRaZHfU/cyX9qGW7sI2IZbaJRxg
         nijQpCJvNPQQZSIQqvI8vwJ2n1ClFKGzHBbFGvMsYMtr2Mck9BDrwtuDnAn/u/71I6Gi
         Y3ZOrpoCOugpzQEOwFZPrlXMxl0MBZCLg/kslFWpbGlEVJrExIytnJKiazW2o4CbRzuo
         YW8fHb0V/MM8ykYERieNmAYaN45971AiVp4ypc/V7zp0wRdDOMr2p0wqSO1Ex1hJugV2
         YT3g==
X-Gm-Message-State: APuU4Z9azL6FUGqZlrqOP4e/PUEchyO1D2qCYkkdqqwKiSrjVq+D/0ez
	viZJK5leVhdEd6dCfa2xrpOvQoipk5/truLAq0faUX+YsEH1QMAri9ZUyq3yrXz3
X-Gm-Gg: AZFdTZcZxyy8g7ijn0vaUtXNSh+gEHQgiJC85+okRGrtuarL2mSBjhuy/MHl4I4++3n
	tnxJxMncezKxgP3PKhg/VOFSl9HM7Jm9LlbiVclGvdEBG/rh6Kcb7zDKNtlBz/syg/OAv36G9HA
	0nik2zxwSBZeVWzi2P2CuymoOOvT6dGbzFawGYv/MSNZHqaf6laNu7Q0NpubaTaG6NHp2uBiN8t
	U0rRpeGuFHFTQ/GEI3NBWfLP37W40kxhq/eJ6lVtgiUdwn64jJ+sRXhjhVXisM7FpmcPiH4g5RA
	LZMdS0WQd9mmAMbrCAnmJ7MDB87G9R5Du6CIr0wewVSbU5ivZZkmSK+3ANLFsUU/k0TLPUO/toR
	BofNJcEbBMzQihiBbt5Cs8lwteS1yC1KtBlpwQYPTUZ13yR6tm10jo6PFis/GabJtUKWT4qyh/Y
	XbT34k52tFBzEHXDqhimdsUAuiH+l17yCR6tjZ3ex4KpW3ys0w308FtWU9c5VvpU2Z50BVDw91l
	xiuR1O7BDctkxn7GDdXgGZSWvio7UCOWs7hRS6XJ/pMQCUt6uigmL2AKazFlTboE2jYW+/JllXZ
	2ziacOzv4QaQjbWUEYiPtvvpg1FZmbVccJxLv20wEIK48dHCALc8ohuciL2AjazQNeAxM7duo5/
	O/I1ugLZ7XzgJGdNh6jMY8//QNG+SF5OoJ1zSsTojR8H+kys/q9AS1PKJAJ3V3Tj9oWZmWUGfVD
	z3mXWA
X-Received: by 2002:a05:6102:6e89:b0:7d2:8dd0:2ed with SMTP id ada2fe7eead31-7d739390129mr1372162137.10.1795189675679;
        Fri, 20 Nov 2026 07:47:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7b12eb7sm3358243137.0.2026.11.20.07.47.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:47:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] rfcomm-tester: Add tests for deferred setup
Date: Fri, 20 Nov 2026 10:47:49 -0500
Message-ID: <20261120154750.1745643-5-luiz.dentz@gmail.com>
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

Basic RFCOMM Socket Server - Defer Success
Basic RFCOMM Socket Server - Defer Early Accept

Defer Early Accept has the listener accepting and authorizing the
connection while authentication, which then fails, is still pending and
expects the connection to be refused.

Assisted-by: OpenCode:claude-fable-5.2
---
 tools/rfcomm-tester.c | 146 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 998d698c1bb2..ae4f3c7ee7ac 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -43,6 +43,7 @@ struct test_data {
 	struct tester_io *io;
 	unsigned int io_id;
 	uint16_t conn_handle;
+	int listen_sk;
 	uint16_t send_len;
 	uint16_t recv_len;
 };
@@ -61,6 +62,12 @@ struct rfcomm_server_data {
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
@@ -286,13 +293,81 @@ static void setup_powered_server_callback(uint8_t status, uint16_t length,
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
+			tester_print("Nothing to accept while authentication "
+					"is pending: %s (%d)", strerror(errno),
+					errno);
+		} else {
+			tester_print("Accepted sk = %d while authentication "
+					"is pending", new_sk);
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
@@ -374,6 +449,33 @@ const struct rfcomm_server_data listen_read_success = {
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
@@ -721,6 +823,13 @@ static bool rfcomm_listen_cb(struct tester_io *io, uint32_t cond,
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
 
@@ -803,6 +912,37 @@ static void test_server(const void *test_data)
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
@@ -868,6 +1008,12 @@ int main(int argc, char *argv[])
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

