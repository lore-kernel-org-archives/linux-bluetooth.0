Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624113;
	b=Vm1+NkWwwBMGGPhE5qhdhW397E2mnwhx0W10zRoEOv7/Ws5ZvPMvCxfACFnbFBOp4dq4
	 Gf66ou/RPSPqBt8i74zK4EL5nicmzRD1s24Xp2y9/0+wLAG9wUPB6knhGJtPPM5fn3bQE
	 Pn49Z8NH5RzS3hNSGbwbxNRirT6MmiATbGiJlIPkolbbR5FNPH407BKSNF/5bbXXtnzrx
	 2YPOp3wEnzUWXaN3rNv1n8BrC0G11aghH29UR63Kl38Aqir8jeYhNiEzAAB3ac+0P3E3z
	 nwNOFGqV3hJZDTQ0nGXHKYrn0iJP6zqSIeAnQq+N8upVhre4V3RxUaqgLKVJel77a8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kflqQNTv3+xGoqAAJVnuszPCwPVqlPQ0HZLpG8SpaGo=;
	b=tGDwe4O2vH6KNe2Hh2ExkGqOiWFvfba5Q9QJwcLBT+Ylv+mdSbri6EubSA5SqDW6uJcF
	 lrfmRnY5ounq8mncRXi/jYYd/5ZiTGeiRRVY3xBGsOiykHdL6BOjghsiNSLjO5//nkjgs
	 JWHfEpmi9y5dJesHVEATZQODISKKlr1bmuWvPW07kddSu0lSVVroUkWtLZa8WAVzpJxlz
	 81lLmQmDJOKD4vaRPN4enep3w+yQs1HnlwZFRe46H2Bwe1X/fDCe/InaSu+RG6lebwxj/
	 TSWUoQfALAPjuYTeJta8s/IffeSQxmLy1FklfymVhcrWzUVn6EcHtD4P+FiHB4fx4rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdqYSMUl;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034A606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1034A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdqYSMUl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so4122731e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624112; x=1796228912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kflqQNTv3+xGoqAAJVnuszPCwPVqlPQ0HZLpG8SpaGo=;
        b=XdqYSMUlpRW6h1JAaHYZn5DmZj9HA2TblNVKW49KxnQqCROcq9XaBxcq9cFP0WeKx/
         jfX7QiQb2kTtc0p1CxT+2RLD4lrsBBTiW4r8SmfAq/3WQZZGT5hUVo8r8wz0T3SO89jO
         i6XeisQyIDgtnWvAG5VN0evDgGleebJ/mQ3s5aKhqjS1/rOYBLNbfB76Cql2e52M9Qcp
         ozZxqCJfTK61awy/FzJs+xjUzQrGuYAYfbJ68CixryvCLKpeR1FSYlq0qZD6YSY2afQP
         kL+qAkPKQ3Nsp8cemlGieogJ5k/6ZRQZKUzI//EjKEqH1Wo25WrRxTw1jcWPqfOusmmr
         DpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624112; x=1796228912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kflqQNTv3+xGoqAAJVnuszPCwPVqlPQ0HZLpG8SpaGo=;
        b=Sry6S7bgNHmrJu+lIArouEQ3xbhtLseOGEciNzmpKWhUHJy5QvSumt2t2v02A94E1R
         nyDjLFnB1sL9nWk9j9/8/RTs2/r+t/YTyd08SFEGE5hPJD6/6rVfpjZrfMG4euWTx3EF
         uy8z3vJwzpAdnZbfUpg54A7Fh0GW7fvxxnuIjymB4z2bt4ERMPkZsmbGYoghxi2bY18d
         vGfhS9AfxVqT0ShrmSkaW+1weZPnrF6ZKhTw3GgwiEyhjpJijEpfJ3/NcazfQ0keWwKT
         MLZEw29hDGSmwWwXCFjU7+kKsVTl5szEjeDHLvq/9BYvJcCbHSnOqevUljRZU8iq3jqN
         vKdg==
X-Gm-Message-State: APuU4Z8ML5+gRfhqcoSomnpPrk01Cq5BeM+rbu0C8zKi6fmB+JE9+IFx
	JgBb70iTyEjL/NC2OR9p1N1OYVBuJppenSe/0Z+XuKZ3y/aN2+h1r7tbgh2U9Q==
X-Gm-Gg: AZFdTZeVOoj/62mNrSTqL6bJJ1IX4/6TGcXbIPJdhey6BMGnFadojmmT70sXsrYoac4
	PZ9tC5MZ4eEhVFObJEAhGHpnep21fyNHdVwf20G3ninKgvrBQvIVyNWWE7gHnNwNNNv00SiXfMn
	Y/53LS3Uvb8HudedObpe+07s46HFWhFovhaflWqwC0NDUMjXCo6djwU/ooPnx1aFdM9vVChEz/W
	7zK36YiFsE4+T2oOT4Y83BOZ5swZ+X50QyFSJXwfBvhq4tUbrraXDSynkEfzWc0dFK6Tc3MYb0/
	Mytu55bwajOinivibL+mh2VUMXjnfz1mdqry5iwW5O3iMhd+/A2b0uidIxol7vxdbFHMv+p5Cri
	G55nqbSCnjLQBnQ0fVfDQqIbU68crH6LnUhKMVR6q098iANijnEnK9xbWoxngKgCiD4PKKWfn5C
	0h/lax5WAF0j2t2CfnCbxOi5X8xNfzRSftbNN1HwkaO8xp+PNg8ux/X1cZu3HzfnI/YYVC0tgqQ
	LlZESnFiOP1bzPxeBWnMVHpfYcdNdRWCyi1mS7o9PbrdbtBSbADRgA2nn7BSMRlzqICg72Y6Trk
	aYqzyAfnXCBfmZxm65DTOuwU2reZjrJTTnG/eFrlRrUlXbP0ZkhcuFXQasu5J4uRN0/wVCXpvNG
	IP9W8oLfL1nA34EQhOJuSe9SRXJZ8K8z9LzCnGdJ2AaXiEWHOPJT1ciAJaZ0kCrc6gdlK/A83J5
	IguwI=
X-Received: by 2002:a05:6123:110:b0:5ea:aedd:6077 with SMTP id 71dfb90a1353d-5ee8aee227bmr7411195e0c.5.1795624111920;
        Wed, 25 Nov 2026 08:28:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5cd7c8sm17985305e0c.11.2026.11.25.08.28.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/5] rfcomm-tester: Add tests for deferred setup
Date: Wed, 25 Nov 2026 11:28:24 -0500
Message-ID: <20261125162825.1409753-5-luiz.dentz@gmail.com>
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

Basic RFCOMM Socket Server - Defer Success
Basic RFCOMM Socket Server - Defer Early Accept

Defer Early Accept has the listener accepting and authorizing the
connection while authentication, which then fails, is still pending and
expects the connection to be refused.

Assisted-by: OpenCode:claude-fable-5.2
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

