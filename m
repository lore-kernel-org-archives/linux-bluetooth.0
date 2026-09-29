Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE605013A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677209; cv=none; b=oDsZXu/0E9NMnEi+KIHW4wkgIzmCradjaCPAtI6FIygNaHFXrDjIDXCzh2aWomwmDxBV1dYWZt80HuCSfiQTiJUrMpu+kV9tOfRu/p7f1uEHhHi9weV7IAiIQxOwarhWSVHyCRYDVuOH4qprkH5oXRLesuQmexTcHCm1yL704hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677209; c=relaxed/simple;
	bh=wIfFHOt5N+T7KpNcCmTATbg0IrIoEBljPy6pp+o8W5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbYr4dIss/BYCmrwDc9VeN3rj7crDDk3sZjC56HremJ9WegLSQHkLlpRmAgHa7sHy7i6JbXJtW9G7dSyCQr6ZvC+NtRubXXFF8DPP/G2GLcCAjYH2hea8j3AGim2yCTKiiVwUOUeos50maeZ0yx3r0yN/mExEoUFPsomUFrOYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m4CJoACI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m4CJoACI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790677200;
	bh=wIfFHOt5N+T7KpNcCmTATbg0IrIoEBljPy6pp+o8W5U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m4CJoACI2aBusXJZG7CfxK65k3zC8CqpjnxZ0OoiWBFOJJUQOjtCFQbTqNhvgBdEe
	 pG0dL6awu1AhIu6zyPqIPyMO22+KSvMa9Jz6AUPM+OgIOv142pvpmXIqlqPag9WdpI
	 7FesAAl7l1rXQSOdWVshXUwOFJUTdgjYajtJvOj/rAdZECwQFwy1fZLYKAg/cdwLsQ
	 mhPoy05anjzelK+ImtD7SeKxo9+p2ikPSl52PuDC4V87Z3sEINh/irE2Xd/Frjyziq
	 pV89w0ac6KPDNS0kBism3kdVXzCeISdx7O5C0stAzFX8bgdwP1LBraUXxvsm1tIWF5
	 ozL/DhmDRr70w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F1DA17E0C41
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:20:00 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/6] mgmt-tester: Add Security Level Changed event tests
Date: Tue, 29 Sep 2026 12:19:49 +0200
Message-ID: <20260929101953.254969-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929101953.254969-1-frederic.danis@collabora.com>
References: <20260929101953.254969-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Test that MGMT_EV_SECURITY_LEVEL_CHANGED is correctly received during
BREDR and LE secured connection.

Assisted-by: GPT:GPT-5.3-Codex
---
v3->v4: Following changes in kernel patch, replace tlv_count by tlv_length

 tools/mgmt-tester.c | 138 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 5a183a8e5..42dba54be 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3792,6 +3792,115 @@ static bool verify_link_key(const void *param, uint16_t length)
 	return true;
 }
 
+static bool verify_security_level_changed(const void *param, uint16_t length)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *event = param;
+	const uint8_t *expected_addr;
+	uint8_t expected_addr_type;
+	uint8_t expected_enc_type;
+	uint8_t tlv_length;
+	uint16_t offset;
+	bool saw_level = false;
+	bool saw_enc_type = false;
+
+	if (length < sizeof(struct mgmt_addr_info) + 1) {
+		tester_warn("Invalid security level changed length %u", length);
+		return false;
+	}
+
+	expected_addr = hciemu_get_client_bdaddr(data->hciemu);
+	if (!expected_addr) {
+		tester_warn("No central bdaddr");
+		return false;
+	}
+
+	expected_addr_type = data->hciemu_type == HCIEMU_TYPE_LE ?
+						BDADDR_LE_PUBLIC : BDADDR_BREDR;
+	expected_enc_type = data->hciemu_type == HCIEMU_TYPE_LE ?
+					MGMT_CONN_SEC_ENCRYPT_NONE :
+					MGMT_CONN_SEC_ENCRYPT_E0;
+
+	if (memcmp(event, expected_addr, 6)) {
+		tester_warn("Unexpected security level changed address");
+		return false;
+	}
+
+	if (event[6] != expected_addr_type) {
+		tester_warn("Unexpected security level changed address type %u != %u",
+					event[6], expected_addr_type);
+		return false;
+	}
+
+	tlv_length = event[7];
+	offset = sizeof(struct mgmt_addr_info) + 1;
+
+	if (offset + tlv_length != length) {
+		tester_warn("Unexpected security level changed TLV length %u",
+					tlv_length);
+		return false;
+	}
+
+	while (offset < length) {
+		const struct mgmt_tlv *tlv;
+		uint16_t type;
+
+		if (offset + sizeof(*tlv) > length) {
+			tester_warn("Malformed security level changed TLV header");
+			return false;
+		}
+
+		tlv = (const struct mgmt_tlv *)(event + offset);
+		type = get_le16(&tlv->type);
+
+		if (offset + sizeof(*tlv) + tlv->length > length) {
+			tester_warn("Malformed security level changed TLV payload");
+			return false;
+		}
+
+		switch (type) {
+		case MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL:
+			if (tlv->length != 1) {
+				tester_warn("Invalid security level TLV length %u",
+						tlv->length);
+				return false;
+			}
+			saw_level = true;
+			break;
+		case MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE:
+			if (tlv->length != 1) {
+				tester_warn("Invalid encryption type TLV length %u",
+						tlv->length);
+				return false;
+			}
+
+			if (tlv->value[0] != expected_enc_type) {
+				tester_warn("Unexpected encryption type %u != %u",
+						tlv->value[0],
+						expected_enc_type);
+				return false;
+			}
+
+			saw_enc_type = true;
+			break;
+		}
+
+		offset += sizeof(*tlv) + tlv->length;
+	}
+
+	if (offset != length) {
+		tester_warn("Unexpected security level changed trailing bytes");
+		return false;
+	}
+
+	if (!saw_level || !saw_enc_type) {
+		tester_warn("Missing expected security level changed TLVs");
+		return false;
+	}
+
+	return true;
+}
+
 static uint16_t settings_powered_le_sc_bondable[] = {
 						MGMT_OP_SET_LE,
 						MGMT_OP_SET_SSP,
@@ -3895,6 +4004,19 @@ static const struct generic_data pairing_acceptor_ssp_1 = {
 	.just_works = true,
 };
 
+static const struct generic_data pairing_acceptor_ssp_sec_level_changed = {
+	.setup_settings = settings_powered_connectable_bondable_ssp,
+	.client_enable_ssp = true,
+	.expect_alt_ev = MGMT_EV_SECURITY_LEVEL_CHANGED,
+	.expect_alt_ev_len = 16,
+	.verify_alt_ev_func = verify_security_level_changed,
+	.expect_hci_command = BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY,
+	.expect_hci_func = client_bdaddr_param_func,
+	.io_cap = 0x03, /* NoInputNoOutput */
+	.client_io_cap = 0x03, /* NoInputNoOutput */
+	.just_works = true,
+};
+
 static const struct generic_data pairing_acceptor_ssp_2 = {
 	.setup_settings = settings_powered_connectable_bondable_ssp,
 	.client_enable_ssp = true,
@@ -4002,6 +4124,16 @@ static const struct generic_data pairing_acceptor_le_1 = {
 	.verify_alt_ev_func = verify_ltk,
 };
 
+static const struct generic_data pairing_acceptor_le_sec_level_changed = {
+	.setup_settings = settings_powered_bondable_connectable_advertising,
+	.io_cap = 0x03, /* NoInputNoOutput */
+	.client_io_cap = 0x03, /* NoInputNoOutput */
+	.just_works = true,
+	.expect_alt_ev = MGMT_EV_SECURITY_LEVEL_CHANGED,
+	.expect_alt_ev_len = 16,
+	.verify_alt_ev_func = verify_security_level_changed,
+};
+
 static const struct generic_data pairing_acceptor_le_2 = {
 	.setup_settings = settings_powered_bondable_connectable_advertising,
 	.io_cap = 0x04, /* KeyboardDisplay */
@@ -13919,6 +14051,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Pairing Acceptor - SSP 1",
 				&pairing_acceptor_ssp_1, setup_pairing_acceptor,
 				test_pairing_acceptor);
+	test_bredrle("Pairing Acceptor - SSP Security Level Changed",
+				&pairing_acceptor_ssp_sec_level_changed,
+				setup_pairing_acceptor, test_pairing_acceptor);
 	test_bredrle("Pairing Acceptor - SSP 2",
 				&pairing_acceptor_ssp_2, setup_pairing_acceptor,
 				test_pairing_acceptor);
@@ -13937,6 +14072,9 @@ int main(int argc, char *argv[])
 	test_le("Pairing Acceptor - LE 1",
 				&pairing_acceptor_le_1, setup_pairing_acceptor,
 				test_pairing_acceptor);
+	test_le("Pairing Acceptor - LE Security Level Changed",
+				&pairing_acceptor_le_sec_level_changed,
+				setup_pairing_acceptor, test_pairing_acceptor);
 	test_le("Pairing Acceptor - LE 2",
 				&pairing_acceptor_le_2, setup_pairing_acceptor,
 				test_pairing_acceptor);
-- 
2.43.0

