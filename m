Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841138;
	b=iobiKFYWDWuYLRBYeZL8viBOPEnBtOl3a22nP2BWQ9c2pUjW1rw979JuA1GdS0XXahbf
	 mIWuUSw8UK7s2UWK/LA3wfgdk1SP1WSRIJ9Xu+Cml5fxexuwwtNyIE759gPL86MqRj/N7
	 767kENYHQBSK3SBDCjI1GpXDBoYplXpY00bQlux0W0wbwMSc/iWxxUktpf0xfcC42h8Pv
	 LHgyT4LqfjR801vPkS9QaEZP8gGx2kXS7MLD9aeq+xollZol4UziRGCutYej3g01fEFLy
	 glceTXkUxXtRdCE0qhA2nGOh5EcJeE9Ahnhf47fkgQyytjZurxzpnepAIedJfQjCN2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t6mrRg8SLIvp/WihlBnud3MHjPWHBz/F5+Ggjf897dw=;
	b=qGdgfvpRcMonIUIelreM3wWHh7jSEYxJ0WEpdTewzYQw2vnFzNouB5ov/6iMajPhPmQv
	 GEiPvwvLUht7pU6gQTyKNKGevzvvQyXYkpD2Z/GO97xHdL9Gdzj0l3JJQpJ2eNIskIJI9
	 y7CUb2SoiW8i43nsKGUk/54qpo+b/MxQOpUWu6zesQsqlaKy5dkm/bsfhgPbJLeGWAGgD
	 1PMi3aWKxDGi5I0YVKREuAVLKACdrSOry2rQYbNzck24EbDo7mC4MEF0Hgenvdr9Q3jpl
	 kkhUNwnEEXZaBvPub5jrbhs8xpRWwnzfL/e3MhoMynB0xWnuJWRji5ErbUGp8Hcw2ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MkwR/n7z";
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA8606A31D
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27AA8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MkwR/n7z
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8acda240937so13039117b3.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841137; x=1793445937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6mrRg8SLIvp/WihlBnud3MHjPWHBz/F5+Ggjf897dw=;
        b=MkwR/n7zEMjlMo1mvUMs07N+QaQgnYUUpa6u9Zff6ERlUh9NfcgUDFmEgYs2y45+vx
         BRd5LSsoQ8ZX5vwmyNvPw1/h/HGXfeHVwCi7sYjY+L7naaxbGI1gzQcYCsuclyJHwMj2
         sl6rn4SOkSsqEw5qMVWmAseMUY5bbDDU6EViPwykvXmUEmoZ8Cj2ZRS4TkndhJ7zhFYR
         SVLT1I9h5xj7559I9SiFNPLZNVCWlcLZxnbv7eH2RzlFBgpb5bHnFWUL57RjlHbFluQu
         kMsMXWd/XJxpGEPjVYhLfP8akkNoHe9B48ORa42ui+HadMZNwxaCYDywhELqa36EV6iq
         IJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841137; x=1793445937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6mrRg8SLIvp/WihlBnud3MHjPWHBz/F5+Ggjf897dw=;
        b=mc2nB6ZBKtJv4LAS7EmMRi7OZvGBnGcnpMcRreF3TSoccOYi06zXASjdeChnTgwBrx
         IDB9aAh4G+PhdyhIf7UwOcd9hd6m1mBdcyohi7XUZftD9k8GFpZHyjEFXJPiEgnuDxHp
         emTZ0eAk4MpmIr+gd1Tg6W+ZPG7JIHe4DDCwOiE3nuccZSi3J4KBLhnNB2R++A4uaDHy
         zlUO3TpJ24AsbwI8+QuxKdXLJ/hF8X1TmjBLrao6o919npSTJ0dUrzHcJlVCuHQ+3sb5
         YqJsCd5drlYkltE63TnXojtm3Jej7LUEQ0GzkHaDeRMTV3scRL0eQn54DaJSFV1jkwBr
         M2Cw==
X-Gm-Message-State: AFq9FYJhSCq6B1LaH+l9d4btwugDyS9KZEgJR76Nkogd0n/iLPil38Fe
	55uFPlywZnf1zn6Tz4yJXSHmBVL8ZS//lJu+T0FOaTSGmzgKNHjJHgkw1r++A3gAgg8=
X-Gm-Gg: AYBFou1kVQagIeLZlJ//0nu9epYGPry7QFDCvnhjTWbtkp5mMe0w5tkCmu9wWxPcLeg
	SGX69PQiD5JSyzDNGwKjvW38tvrQ3oO/CTg74hLsC9i0scf0cTEdn1rJsINVdrSCpkgjWGX9bZP
	ZuzDQ9VH5635nQgZ8f+XTo+xCqqmNs03KqhASVwa8WRYkZAz20w8D8H3r8Dup+SY+FilqzCK3bZ
	PbdJjhpgYY/OeBl5HXJ0Yf7oTiQxHJLF/5r2SMmBkDLB8aMay684SebGZ/n5MlRBRQgg22EUb/6
	Xx+P1Hew4vTXsbecOF5ORMlDrqaHQVtDPuEqzPhB6F7mvZT0mNTDRGo8Bgy7eEMPbWp5SjxwJce
	TqwsDPRo8T1zoVvNtAMhDTgzfBHD1Yzm7yUHD7yqNBMYm5yXA6ebM+MyB6i5AkbHkmKtKlYHZEM
	iD2vxd0ncw9VUcs20G0gbKbVdf8Sk28utRO6wYHWZkuo3QneWzKAennvDOKUF7tKvOHuZvFP+Xp
	BmTZ3SA2qcECdRb1zz0ZVM3svaUvufZgRb/QBUkpJAJS6s=
X-Received: by 2002:a05:690c:f15:b0:8b1:368b:391f with SMTP id 00721157ae682-8b166c806bcmr13821837b3.61.1792841137128;
        Sat, 24 Oct 2026 04:25:37 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::dff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166ea85a6sm8085497b3.35.2026.10.24.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:25:36 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>
Subject: [PATCH BlueZ 2/2] smp-tester: Add identity key distribution tests
Date: Sat, 24 Oct 2026 07:25:27 -0400
Message-ID: <20261024112527.249473-2-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024112527.249473-1-turbine.bmw@gmail.com>
References: <20261024112527.249473-1-turbine.bmw@gmail.com>
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

Add server tests where the kernel bonds without privacy:

- Identity Key 1: the kernel distributes an all-zero IRK and the
  controller's identity address when the initiator asks for its
  identity key.
- Identity Key 2: the kernel does not store an all-zero IRK from the
  initiator and still completes bonding.

These need the kernel patches "Bluetooth: SMP: distribute the identity
address when bonding" and "Bluetooth: SMP: ignore an all-zero IRK".

The keys distributed by the kernel are random, so they are not compared,
and request list entries can now only wait for a PDU.

Assisted-by: Claude:claude-opus-5-5
---
 tools/smp-tester.c | 177 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 3 deletions(-)

diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index cde1211af..1f66bf54a 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -62,6 +62,7 @@ struct test_data {
 	uint8_t local_sk[32];
 	uint8_t dhkey[32];
 	int unmet_conditions;
+	unsigned int new_ltk_id;
 };
 
 struct smp_req_rsp {
@@ -80,6 +81,8 @@ struct smp_data {
 	uint8_t expect_hci_len;
 	const void * (*expect_hci_func)(uint8_t *len);
 	bool sc;
+	bool load_irks;
+	bool expect_no_irk;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -459,6 +462,93 @@ static const struct smp_data smp_client_sc_req_2_test = {
 	.sc = true,
 };
 
+static const uint8_t smp_enc_info[17] = { 0x06 };
+static const uint8_t smp_central_ident[11] = { 0x07 };
+static const uint8_t smp_ident_info_zero[17] = { 0x08 };
+static const uint8_t smp_ident_addr_info[8] = { 0x09 };
+static const uint8_t smp_sign_info[17] = { 0x0a };
+
+static const uint8_t smp_id_req_1[] = {	0x01,	/* Pairing Request */
+					0x03,	/* NoInputNoOutput */
+					0x00,	/* OOB Flag */
+					0x01,	/* Bonding - no MITM */
+					0x10,	/* Max key size */
+					0x05,	/* Init. key dist. */
+					0x07,	/* Rsp. key dist. */
+};
+static const uint8_t smp_id_req_1_rsp[] = {	0x02,	/* Pairing Response */
+						0x03,	/* NoInputNoOutput */
+						0x00,	/* OOB Flag */
+						0x01,	/* Bonding - no MITM */
+						0x10,	/* Max key size */
+						0x05,	/* Init. key dist. */
+						0x07,	/* Rsp. key dist. */
+};
+
+/* Without privacy the identity key is an all-zero IRK and the identity
+ * address of the controller.
+ */
+static const struct smp_req_rsp srv_id_req_1[] = {
+	{ smp_id_req_1, sizeof(smp_id_req_1),
+			smp_id_req_1_rsp, sizeof(smp_id_req_1_rsp) },
+	{ smp_confirm_req_1, sizeof(smp_confirm_req_1),
+			smp_confirm_req_1, sizeof(smp_confirm_req_1) },
+	{ smp_random_req_1, sizeof(smp_random_req_1),
+			smp_random_req_1, sizeof(smp_random_req_1) },
+	{ NULL, 0, smp_enc_info, sizeof(smp_enc_info) },
+	{ NULL, 0, smp_central_ident, sizeof(smp_central_ident) },
+	{ NULL, 0, smp_ident_info_zero, sizeof(smp_ident_info_zero) },
+	{ NULL, 0, smp_ident_addr_info, sizeof(smp_ident_addr_info) },
+	{ NULL, 0, smp_sign_info, sizeof(smp_sign_info) },
+};
+
+static const struct smp_data smp_server_id_req_1_test = {
+	.req = srv_id_req_1,
+	.req_count = G_N_ELEMENTS(srv_id_req_1),
+};
+
+static const uint8_t smp_id_req_2[] = {	0x01,	/* Pairing Request */
+					0x03,	/* NoInputNoOutput */
+					0x00,	/* OOB Flag */
+					0x01,	/* Bonding - no MITM */
+					0x10,	/* Max key size */
+					0x07,	/* Init. key dist. */
+					0x05,	/* Rsp. key dist. */
+};
+static const uint8_t smp_id_req_2_rsp[] = {	0x02,	/* Pairing Response */
+						0x03,	/* NoInputNoOutput */
+						0x00,	/* OOB Flag */
+						0x01,	/* Bonding - no MITM */
+						0x10,	/* Max key size */
+						0x07,	/* Init. key dist. */
+						0x05,	/* Rsp. key dist. */
+};
+
+/* An all-zero IRK resolves no address, so it must not be stored */
+static const struct smp_req_rsp srv_id_req_2[] = {
+	{ smp_id_req_2, sizeof(smp_id_req_2),
+			smp_id_req_2_rsp, sizeof(smp_id_req_2_rsp) },
+	{ smp_confirm_req_1, sizeof(smp_confirm_req_1),
+			smp_confirm_req_1, sizeof(smp_confirm_req_1) },
+	{ smp_random_req_1, sizeof(smp_random_req_1),
+			smp_random_req_1, sizeof(smp_random_req_1) },
+	{ NULL, 0, smp_enc_info, sizeof(smp_enc_info) },
+	{ NULL, 0, smp_central_ident, sizeof(smp_central_ident) },
+	{ NULL, 0, smp_sign_info, sizeof(smp_sign_info) },
+	{ smp_enc_info, sizeof(smp_enc_info), NULL, 0 },
+	{ smp_central_ident, sizeof(smp_central_ident), NULL, 0 },
+	{ smp_ident_info_zero, sizeof(smp_ident_info_zero), NULL, 0 },
+	{ smp_ident_addr_info, sizeof(smp_ident_addr_info), NULL, 0 },
+	{ smp_sign_info, sizeof(smp_sign_info), NULL, 0 },
+};
+
+static const struct smp_data smp_server_id_req_2_test = {
+	.req = srv_id_req_2,
+	.req_count = G_N_ELEMENTS(srv_id_req_2),
+	.load_irks = true,
+	.expect_no_irk = true,
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -578,6 +668,16 @@ static const void *get_pdu(const uint8_t *pdu, size_t len)
 		buf[0] = pdu[0];
 		memcpy(&buf[1], data->prnd, 16);
 		return buf;
+	case 0x09: /* Identity Address Information */
+		buf[0] = pdu[0];
+		if (data->out) {
+			buf[1] = data->ia_type;
+			memcpy(&buf[2], data->ia, 6);
+		} else {
+			buf[1] = data->ra_type;
+			memcpy(&buf[2], data->ra, 6);
+		}
+		return buf;
 	case 0x0c: /* Public Key */
 		buf[0] = pdu[0];
 		memcpy(&buf[1], data->local_pk, 64);
@@ -589,6 +689,20 @@ static const void *get_pdu(const uint8_t *pdu, size_t len)
 	return pdu;
 }
 
+static bool verify_ident_addr(const uint8_t *pdu)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *addr = data->out ? data->ra : data->ia;
+	uint8_t addr_type = data->out ? data->ra_type : data->ia_type;
+
+	if (pdu[1] != addr_type || memcmp(&pdu[2], addr, 6)) {
+		tester_warn("Unexpected identity address");
+		return false;
+	}
+
+	return true;
+}
+
 static bool verify_random(const uint8_t rnd[16])
 {
 	struct test_data *data = tester_get_data();
@@ -680,6 +794,15 @@ static void smp_server(const void *data, uint16_t len, void *user_data)
 		ecdh_shared_secret(test_data->remote_pk, test_data->local_sk,
 							test_data->dhkey);
 		goto next;
+	case 0x06: /* Encryption Information */
+	case 0x07: /* Central Identification */
+	case 0x0a: /* Signing Information */
+		/* The keys are random */
+		goto next;
+	case 0x09: /* Identity Address Information */
+		if (!verify_ident_addr(data))
+			goto failed;
+		goto next;
 	default:
 		break;
 	}
@@ -698,9 +821,12 @@ next:
 
 		req = &smp->req[test_data->counter];
 
-		pdu = get_pdu(req->send, req->send_len);
-		bthost_send_cid(bthost, test_data->handle, SMP_CID, pdu,
-								req->send_len);
+		if (req->send) {
+			pdu = get_pdu(req->send, req->send_len);
+			bthost_send_cid(bthost, test_data->handle, SMP_CID,
+							pdu, req->send_len);
+		}
+
 		if (req->expect)
 			break;
 		else
@@ -871,6 +997,16 @@ static void setup_powered_server(const void *test_data)
 				sizeof(param), param, NULL, NULL, NULL);
 	mgmt_send(data->mgmt, MGMT_OP_SET_ADVERTISING, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
+	if (smp->load_irks) {
+		struct mgmt_cp_load_irks cp;
+
+		/* Loading IRKs, as bluetoothd does, makes the kernel accept
+		 * identity keys from the remote device.
+		 */
+		memset(&cp, 0, sizeof(cp));
+		mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+				sizeof(cp), &cp, NULL, NULL, NULL);
+	}
 	if (smp->sc) {
 		mgmt_send(data->mgmt, MGMT_OP_SET_SECURE_CONN,
 				data->mgmt_index, sizeof(param), param, NULL,
@@ -883,6 +1019,25 @@ static void setup_powered_server(const void *test_data)
 			NULL, NULL);
 }
 
+static void new_irk_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	tester_warn("Unexpected New IRK event");
+	tester_test_failed();
+}
+
+static void new_ltk_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	/* The kernel reports a new IRK before the new LTKs */
+	tester_print("New LTK event");
+
+	mgmt_unregister(data->mgmt, data->new_ltk_id);
+	test_condition_complete(data);
+}
+
 static void test_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -897,6 +1052,16 @@ static void test_server(const void *test_data)
 	bthost_set_connect_cb(bthost, smp_new_conn, data);
 	test_add_condition(data);
 
+	if (smp->expect_no_irk) {
+		mgmt_register(data->mgmt, MGMT_EV_NEW_IRK, data->mgmt_index,
+					new_irk_callback, data, NULL);
+		data->new_ltk_id = mgmt_register(data->mgmt,
+					MGMT_EV_NEW_LONG_TERM_KEY,
+					data->mgmt_index, new_ltk_callback,
+					data, NULL);
+		test_add_condition(data);
+	}
+
 	bthost_hci_connect(bthost, data->ra, BDADDR_LE_PUBLIC);
 
 	if (smp->expect_hci_command) {
@@ -923,6 +1088,12 @@ int main(int argc, char *argv[])
 	test_smp("SMP Server - Invalid Request 3",
 					&smp_server_nval_req_3_test,
 					setup_powered_server, test_server);
+	test_smp("SMP Server - Identity Key 1",
+					&smp_server_id_req_1_test,
+					setup_powered_server, test_server);
+	test_smp("SMP Server - Identity Key 2",
+					&smp_server_id_req_2_test,
+					setup_powered_server, test_server);
 
 	test_smp("SMP Client - Basic Request 1",
 					&smp_client_basic_req_1_test,
-- 
2.56.0

