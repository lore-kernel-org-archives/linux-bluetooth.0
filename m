Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D449364B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332163; cv=none; b=b8kYqauO+SP2hCSvdNuzd0EQ3Q8vSqiLSs4yPteR7apPg854SqbANfoCqXZNyzHi8vdGC4IAnG4tsBesxNTSMshYNdhn6jLGy0qwqq95B9qLjWhC1ARI/zg2nhm3uCl779jEvdq5SbQNwFhZDkcmbLeFWvicB6Xm2wB6YozoTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332163; c=relaxed/simple;
	bh=YO29GgiEUXQe7IJ1b7mHRI+SUgL9ZeIs+9GEtBJXOsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPXfLqGvY9JaYRUgnDex2msyHRYweMG+k4Qiv0UXrCuiuim4cKTd7foQ2XOjxlFjBKEPIZlBCVI4ank4tw5EoXimoV6ZGjnxdftvu+AM/OpQ/q2lJmI6QIvbYVRE+kU2GawnOQqHd6NFhCYZUeh4imZHixFcgj9YVI/p2uszcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dAh19JS0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dAh19JS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790332159;
	bh=YO29GgiEUXQe7IJ1b7mHRI+SUgL9ZeIs+9GEtBJXOsE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dAh19JS0+KUgnN2OZFK+vifxlMfDI8/Q8Lysxao1U84zdD/FqSCSbGI1IUmweunC8
	 dYC2Lao/45sykJ+mtmqm8q0bRakytuBOMw3ITt3eQ0u2eaalxFVenl7+gSC5aBUoeX
	 czMXp/HOLbLrAklk/6YSUq26V4F66dnmiMs/0Z4IPckfH/G53uNCvrp0BEkHnAmnJ1
	 BUPwZ4JYb1WIJ6/YfuUq2bh91VGjcnh8431FHpG1bryWxqwzuE/t4g/S7L/6vGqFEe
	 H/9twha7EjimjLiBizn8Ff9p5OIKA0x+ADhuh8Hq3DNbrW1MHwZxWnlJS21mdOUXwf
	 nfpNFdg8nmO/g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CB43317E0B59
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:29:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 RESEND 2/6] mgmt-tester: Add Security Level Changed event tests
Date: Fri, 25 Sep 2026 12:29:10 +0200
Message-ID: <20260925102914.3282319-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925102914.3282319-1-frederic.danis@collabora.com>
References: <20260925102914.3282319-1-frederic.danis@collabora.com>
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
 tools/mgmt-tester.c | 133 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 5a183a8e5..28a1e0c89 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3792,6 +3792,110 @@ static bool verify_link_key(const void *param, uint16_t length)
 	return true;
 }
 
+static bool verify_security_level_changed(const void *param, uint16_t length)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *event = param;
+	const uint8_t *expected_addr;
+	uint8_t expected_addr_type;
+	uint8_t expected_enc_type;
+	uint8_t tlv_count;
+	uint8_t i;
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
+	tlv_count = event[7];
+	offset = sizeof(struct mgmt_addr_info) + 1;
+
+	for (i = 0; i < tlv_count; i++) {
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
@@ -3895,6 +3999,19 @@ static const struct generic_data pairing_acceptor_ssp_1 = {
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
@@ -4002,6 +4119,16 @@ static const struct generic_data pairing_acceptor_le_1 = {
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
@@ -13919,6 +14046,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Pairing Acceptor - SSP 1",
 				&pairing_acceptor_ssp_1, setup_pairing_acceptor,
 				test_pairing_acceptor);
+	test_bredrle("Pairing Acceptor - SSP Security Level Changed",
+				&pairing_acceptor_ssp_sec_level_changed,
+				setup_pairing_acceptor, test_pairing_acceptor);
 	test_bredrle("Pairing Acceptor - SSP 2",
 				&pairing_acceptor_ssp_2, setup_pairing_acceptor,
 				test_pairing_acceptor);
@@ -13937,6 +14067,9 @@ int main(int argc, char *argv[])
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

