Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126527;
	b=0Ipjt1MjBTRm5mTt3WeYtWF3ipLcuF4wsraXVsbFf07j+XgtN1eXJzKrYS5fUfTBYton
	 YTzWMyK3HYKgR4KXpN1SBdZXyVWmIUmDH269IpC3cScaheaVqcetD+lYqJXOjAmDQ5Xr6
	 kPeNBv34ngtKWqYN4GwogO+M8zuJAuEK51iRpKbqaAIIfOlalzG9A91xHh6IIV89H1a+h
	 ju6HKFJUF+ObUzYFH7xtSRMh4vqxWIWrx6ngVoYmDPJJVQdmXpvIuuVdN+lmF4bHVNzsJ
	 jeUhKimA8mGy96CqnFPUSNE551lziaX79dqdYwSOVB4PY62Fmr0f2dMbaTiuf4HMfBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
	b=ytVnUxpOwIhlOOYwBYYThZJ+BJ6H2vZduU7K9TDwswmr0qFcQ0xJnpslLkY2RZCdGBm3
	 23XcrEyXK+tC73ZSLd08w3rm5ryMrjzmY6mkJO5jNNtDjJKhQRmBsy23yEG5ayeZsvYID
	 JgcWeEHBJ5hb3fXDTR3951A4o6bpbBlfdkeoUxIkphrsrYOcDjj/lWFsSO2MczQtYpqOP
	 dj/gOIphkiyCGVPmaZXgP4ehBye7HIllDuj+coTltSJCYyhu0kqqiYUelBFBpRDub5+qT
	 b/BXUi/SiQUTl1IsBLFdTAp17uVWpexmIRnwqzFdBVjXW00VptBv5Jmj3kINcH1wYMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLKA+dG6;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A694606A325
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A694606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLKA+dG6
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99e1b352df9so94889241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126526; x=1795731326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
        b=DLKA+dG6kMpbYH5nDfL2ZL1utSO/WFlU7ZgpKNYlaEMXsDeJ38tJU27QXe/+Z04EsB
         sCL9c1NtQGLf2YKxgOFFxlcjiIvj4O/7yum72/e7VFWaHbAfCJs9EmIEfauOfjwv3uR8
         fc9Bl4sDz7Kp2nyaYF9SiJR4g0WS0akELyjWJhRBWw9cylbcIuHQZxSYBPqAtbOTvOVi
         c6aMrCCLCcKJ8RhH9xY5nv+lGTXSxsPkeAvBDU8SBiO3kfni5TRgw7bSHOdBbASVe1OO
         KDfKT4DddDW7HHtBHRo9bpkuyCJiso+IcAlTcwegUrMAlnHm+VtkAKJM/Sp1E+1l1pOs
         M6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126526; x=1795731326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
        b=AbK9fYRz4B52RCdSDZmPxeSM1J18aTbJ93vvQLCSuPFvOIDkpcul9v+bVWB04oF1Vl
         C+Ac7fnfRrmDOgjOoYDt5Q8H7saLg/+LMCgAc5IP1l/4/lvrsJx3etyA6DLQLlU7dl01
         43zVbZdQw5JhFNkMzSdKNUO1RBaZfo9m5EYqRxGmf0YelK/qJ4INTMt7vD3D/kL2xofq
         qjXbldMn/pfUr6u08l4zqLx3GYp3XJ38oCCoIV8xizT42Tn+n3V4TesXAcrpWDjOK/7c
         AiHhEBt+R0bMnEHhevvHoMEWmfnvS/JgIDDQC7tEbiPjRMdg3MSFp1Iv3q58XHfEoB+k
         QRjA==
X-Gm-Message-State: APuU4Z+CguLR3bHadEW1kD4+WNSHlrSKzvg016/VwveuSvBjrg7YGrT4
	x9u8597HZ+QUzMPQko4dwKXegnevxq5EdCViYclWeZkdZKdCcFgQs9xt8Xojhds0
X-Gm-Gg: AYBFou1USApJUTeKwIBon+wjTNvxe/s3pK2aTcloiBlVCtAibkK/6kFt5eeUI/JiYut
	0jTTBcIett+X8qlZVKrekItZmTz27mFmesDZwmiFa7roL/WYR65zYqSlbBhfgKmazGXDnkXYzGm
	kvYgbToZIeFB1nP3vYwsN3mNIj8JO6UwE78GAGFMiLTxXv9MVIrTLu+JhhEdtMT51IPaZoGjo9n
	AgOd4l8MjpkwGCGonHR1ahL1iFjf/Thn0gSuAQozuBH0rlmMjDXBwljewy1OYeJm10I+rkne1Kz
	3oJJTYeMtFpXQ3me9g0yP5obDFLhsU8DBIp/woIKpen6dTejiWu9txozz95dLY08WwJmrSMC/rG
	c7USvbwym8V5FRDoxrM8S2/b0HJkKI15CqshLZIO+lxZeKKSp/rb6AJtetvxPhJTsDwzPFvMdMx
	iC2o4YTY3mJPK5hUulBKrd3/Mp6PoRMi9sATM8J3DlZ0nHjxCh1N8bvhNCzrl26ARsuYDm8r7zN
	/u6X6S+zH2m/V+w0eqb6QRrganEUINmHM4SUcFVkJxo61gdqdewHYuVolkW2x7EwmSmnxiI1Xn8
	wLD4UGCMrcBRopcYRscw+QT9jzS+f39SJzPaKkl0D0FwIqRg1p8DFd9DK+VSC/IEKtanD3PAPEH
	CrNBhJgCf8FaCjUGOWt9kiO3d1xT9TncRiVdSxG0eBN1CoqPG5McPqzGE3FFhwRcc8xlgb/9mBX
	qMDK8=
X-Received: by 2002:a05:6102:442b:b0:7ce:8505:9848 with SMTP id ada2fe7eead31-7d7396301edmr489041137.31.1795126526124;
        Thu, 19 Nov 2026 14:15:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec7cb5sm1268404241.2.2026.11.19.14.15.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:15:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] rfcomm-tester: Add tests for deferred setup
Date: Thu, 19 Nov 2026 17:15:20 -0500
Message-ID: <20261119221520.1311381-4-luiz.dentz@gmail.com>
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

