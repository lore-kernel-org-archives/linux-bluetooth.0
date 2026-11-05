Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898760;
	b=P4xWJBMq0/SDQQ3IuOSbo0eHLefVE2c/kSfwfAltNwG2kUGgQLDmQNAVkE6RxO9KsUE3
	 a2iqEPPvqp6wikcaMnkE0wXZIhbRsSJDjVfmI0ixgZeSDB3/CydJKn9JCUq31Uhl8nm1s
	 v+QgMzMxN+CsqiIOhZNuraZly3thPmNVmuDVg0cSW/ewz4DjqW6quGXY5A+Z7FmW1AgMs
	 7jcLdT9TSsXiU+j9QN2sfjEqpRHqyfe0pLJnptBTtyntP23JA94A0NrKaRcVv1DLJgdZg
	 0SaWKKDBoJhWr75C8VXWtYqVXSlM18Ne/ChXNsn46noZSA0909BovzCR6OLAEQv1o8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g184wJY9a7NvAFegdoJBlFkUo5qH8Y0Xdjg3iqZPUu0=;
	b=L0ygSdhn43regPA3r+BiCrfHO8jUOjpn2FgDTcm7rYEErJKF4A8s/c6SgHcKhGa5cqOk
	 /f/M8Y4ToFrI7Q47K0Jg1M3yKCGqMFoHhYQXrXAYNxlXLdc5OKRiqKx8LTU48jeASYxiV
	 qqJrJNO1BBUI1cTaXT0JeBbWA6sZc8WpbvoMZlxrw3MlTO2EcohDyrMp+UTTrkgZnlQi2
	 Qa6HAfoR5drE7clwx9cKP2u6Vc9M5o5Gnwjo7v3RKlpFmneEK4I8va5gZJ0dipBHcgqFm
	 V28cci2y8nGALEn6xPTVKYmKJz5hN8we63rGKmwnISxfpZarGG/vqaUs+7+Pj7+sicA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDI0PaEb;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA583606D813
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA583606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDI0PaEb
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc013095d4so679609137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898758; x=1794503558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g184wJY9a7NvAFegdoJBlFkUo5qH8Y0Xdjg3iqZPUu0=;
        b=TDI0PaEbLbZ/wwBfFk+F9Fp/9aHc51C5C3zhpAM5tOsq9qQVG9vf9N3WiJPCYf/Xxu
         4Q071FFNWRShQqxWaKWeDgV5IQeCUvat92/z20bTXgla6YyWyMjSlGGk2X2c17D9R86X
         ed3+Xp88liUz0WibfIG4ohrFsyeHK5fjeN8U6ro+vqi1/4XCEbmlRN0HXr5hj9Je2UZd
         PCXTnPeoIChKmP2BmLBhnr0PFI/91cKnaV3iS0r439Z1ZyZtFxaHzSXJX4NsNLFOKYrS
         kCpatfOePFBLrLsWE6iyiVYYUE2vWkNdGBgnKuVTumBNBh2NBubKGjVgBIBqaAgz+NSl
         5Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898758; x=1794503558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g184wJY9a7NvAFegdoJBlFkUo5qH8Y0Xdjg3iqZPUu0=;
        b=A4Ur+799fgS+EcKjW3MFq34EfvW+2YAIGgex5pWxDWrLaWrNlVtP8pkmo5OpW4lFbZ
         ezatgOPR7S4NFzmisfkxDkaUi2Yk39LKYCgVy8lGNr1yzTtWrES4GaTyfasEQb2EiDu9
         +mlRtT5AjZeHCqAwUnuM7ydUiFhP7/H08NQLxV1EoZdjA0uN8GNgAMQPwlqUsKar0i3M
         DHMfi4zWd3E//4LiPtOolU/jNjVo67pWkKv01ozXpvra97fj7iCUCOHj/XUf1G9aH0d6
         sDSBpmpH8LtYWuIUO7IBSKX03+HTqHAYQHhN5vmo7b/ShuFo5zhTl660zNCvK3/U+BtJ
         XHHg==
X-Gm-Message-State: APuU4Z9YHrcbP+xwkAMAl8yLe92SEnXxhGZvfpUfLapOGr+QSfZRT3jc
	+yMq+nshjI+06/D+REVlTTN6o7xrT/jrjs4m/906Ui6HgzznmNqTyxW/ZKmGdA==
X-Gm-Gg: AYBFou2SzJpq43l1Vi2tcV3BLbuMjUSbjyy2aL+E1bZYhfBQ+BoCwwFk62YB0CCJs10
	JuIyIdyZ393h8MSFgkkPbDXz8MbapFnEKg2+l5BN22n06Y18pKBTxy8q2t6VlgIl6ePLChSBETI
	+fl4Ikh+eL4ruklgduf9wagMf/HtvFjbqUYKbZBLv5d0aVTTSe6vJRf4u1W5XnzPp2EnvsKd1jW
	viZ9AK+DemX0wzdsuyC+h5OekzgAbazPfj5+eh7EWJRm70mOSRcRk1YZJUsv+IfZPpBnTA2XO/x
	xSPMJZfpRHs4Q1SdZOurirDpPzpF3e01dzPKAfm4ZeMgjZY6GqVnDqLI55nHO6r39jCWS3hn+Aa
	nXxyg97h7/eh+/CrxJy3pVWYTGHctLO9wVpOgpldbYKpc/zspXEV3ughOprv+IYg11+AFwsLLBa
	J8JFzHHvblNu8wK+IEP8Lt3PPcxlUEnWMh6cwYSgsmhDB/xviwWUtPEHlOv/tcV4/zDxwkXec5p
	N+n0q0OioB3OE5dOAd+PPgwc/gUu/AUzmq+7dWHG1g3RyFb4ehNPftFaQPyER0RZJLZ+rm8PiUO
	kA66GYY6jZ2mgkaJtUs0p5Zouv4e/3I8WQZGO/uw2Ya9U2ExW3BgjBkih3LsVxyPXQcTYGlFcsw
	NawfBqc/96/aICuJVfwcKQH8whiXWilh5fM3ivLItLDxotVzLeOrOR08p2DISrQAajWV5+rppr7
	07sME=
X-Received: by 2002:a05:6102:c51:b0:7cc:2152:4f95 with SMTP id ada2fe7eead31-7d2a12c4598mr207592137.3.1793898758509;
        Thu, 05 Nov 2026 09:12:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm4050798137.10.2026.11.05.09.12.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 05/11] monitor: Add LL decoding for HDT
Date: Thu,  5 Nov 2026 12:12:17 -0500
Message-ID: <20261105171229.2053802-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105171229.2053802-1-luiz.dentz@gmail.com>
References: <20261105171229.2053802-1-luiz.dentz@gmail.com>
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

Decode the LL_ENC_ECDH_REQ/RSP, LL_HDT_CONFIG_REQ/RSP and
LL_HDT_LQF_REPORTING_IND Link Layer PDUs introduced by HDT and EKS.
---
 monitor/ll.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 215 insertions(+), 6 deletions(-)

diff --git a/monitor/ll.c b/monitor/ll.c
index 6c0f67b5dcae..5baf334f3768 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -537,7 +537,9 @@ static void length_req_rsp(const void *data, uint8_t size)
 static const struct bitfield_data le_phys[] = {
 	{  0, "LE 1M"	},
 	{  1, "LE 2M"	},
-	{  2, "LE Coded"},
+	{  2, "LE Coded S=8"},
+	{  3, "LE Coded S=2"},
+	{  4, "LE HDT"	},
 	{ }
 };
 
@@ -558,6 +560,16 @@ static void phy_req_rsp(const void *data, uint8_t size)
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
+
+	/* [v2] */
+	if (size >= sizeof(*pdu) + sizeof(struct bt_ll_phy_v2)) {
+		const struct bt_ll_phy_v2 *v2 = (const void *) (pdu + 1);
+
+		print_field("Refresh: %u", v2->flags & 0x01);
+		print_field("MIC Length: %s (%u)",
+				v2->flags & 0x02 ? "64 bits" : "128 bits",
+				(v2->flags >> 1) & 0x01);
+	}
 }
 
 static void phy_update_ind(const void *data, uint8_t size)
@@ -580,6 +592,22 @@ static void phy_update_ind(const void *data, uint8_t size)
 							" (0x%2.2x)", mask);
 
 	print_field("Instant: 0x%4.4x", pdu->instant);
+
+	/* [v2] */
+	if (size >= sizeof(*pdu) + sizeof(struct bt_ll_phy_update_ind_v2)) {
+		const struct bt_ll_phy_update_ind_v2 *v2;
+
+		v2 = (const void *) (pdu + 1);
+
+		print_field("Address: %2.2x%2.2x%2.2x%2.2x%2.2x",
+				v2->address[4], v2->address[3],
+				v2->address[2], v2->address[1],
+				v2->address[0]);
+		print_field("Refresh: %u", v2->flags & 0x01);
+		print_field("MIC Length: %s (%u)",
+				v2->flags & 0x02 ? "64 bits" : "128 bits",
+				(v2->flags >> 1) & 0x01);
+	}
 }
 
 static void min_used_channels(const void *data, uint8_t size)
@@ -648,6 +676,42 @@ static void clock_acc_req_rsp(const void *data, uint8_t size)
 	print_field("SCA: 0x%2.2x", pdu->sca);
 }
 
+static const struct bitfield_data coded_rates[] = {
+	{ 0, "CODED S=8" },
+	{ 1, "CODED S=2" },
+	{ }
+};
+
+static const struct bitfield_data hdt_rates[] = {
+	{ 0, "HDT 2M" },
+	{ 1, "HDT 3M" },
+	{ 2, "HDT 4M" },
+	{ 3, "HDT 6M" },
+	{ 4, "HDT 7.5M" },
+	{ }
+};
+
+/* The rates are those of the PHY set in phys, as defined in Table 2.24 */
+static void print_rates(const char *prefix, uint8_t phys, uint16_t rates)
+{
+	const struct bitfield_data *fields = NULL;
+
+	if (phys & BIT(4))
+		fields = hdt_rates;
+	else if (phys & BIT(2))
+		fields = coded_rates;
+
+	print_field("%s: 0x%4.4x", prefix, rates);
+
+	if (fields) {
+		uint16_t mask = print_bitfield(2, rates, fields);
+
+		if (mask)
+			print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%4.4x)", mask);
+	}
+}
+
 static void cis_req(const void *data, uint8_t size)
 {
 	const struct bt_ll_cis_req *cmd = data;
@@ -699,6 +763,26 @@ static void cis_req(const void *data, uint8_t size)
 	print_field("CIS Offset Maximum: 0x%6.6x", le32_to_cpu(interval));
 
 	print_field("Connection Event Count: %u", cmd->conn_event_count);
+
+	/* [v2] */
+	if (size >= sizeof(*cmd) + sizeof(struct bt_ll_cis_req_v2)) {
+		const struct bt_ll_cis_req_v2 *v2 = (const void *) (cmd + 1);
+
+		print_rates("Central to Peripheral Rates", cmd->c_phys,
+						le16_to_cpu(v2->c_rates));
+		print_rates("Peripheral To Central Rates", cmd->p_phys,
+						le16_to_cpu(v2->p_rates));
+		print_field("Config ID: %u", v2->config_id);
+		print_field("TL Group ID: %u", v2->tl_group_id & 0x1f);
+		print_field("Central to Peripheral Payload Window Size: %u",
+						v2->flags & 0x03);
+		print_field("Peripheral to Central Payload Window Size: %u",
+						(v2->flags >> 2) & 0x03);
+		print_field("MIC Length: %s (%u)",
+				v2->flags & 0x10 ? "64 bits" : "128 bits",
+				(v2->flags >> 4) & 0x01);
+		print_field("SE Length: %u us", get_le24(v2->se_length));
+	}
 }
 
 static void cis_rsp(const void *data, uint8_t size)
@@ -730,6 +814,13 @@ static void cis_ind(const void *data, uint8_t size)
 	print_field("CIS Synchronization Delay: %u us",
 					le32_to_cpu(interval));
 	print_field("Connection Event Count: %u", ind->conn_event_count);
+
+	/* [v2] */
+	if (size >= sizeof(*ind) + sizeof(struct bt_ll_cis_ind_v2)) {
+		const struct bt_ll_cis_ind_v2 *v2 = (const void *) (ind + 1);
+
+		print_field("PCA-H: 0x%2.2x", v2->pca_h);
+	}
 }
 
 static void cis_term_ind(const void *data, uint8_t size)
@@ -759,6 +850,107 @@ static void feature_ext_rsp(const void *data, uint8_t size)
 	packet_print_features_ext_ll(rsp->page, rsp->features);
 }
 
+static const struct bitfield_data lqf_transports[] = {
+	{ 0, "ACL" },
+	{ 1, "CIS" },
+	{ }
+};
+
+static void hdt_lqf_ind(const void *data, uint8_t size)
+{
+	const struct bt_ll_hdt_lqf_ind *pdu = data;
+	uint8_t mask;
+
+	print_field("Transport: 0x%2.2x", pdu->transport);
+
+	mask = print_bitfield(2, pdu->transport, lqf_transports);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+}
+
+static void hdt_config_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_hdt_config_req *pdu = data;
+
+	print_field("ACL RX Payload Windows Size: %u",
+			pdu->wincfg & 0x03);
+	print_field("Max CIS TX Windows Size: %u",
+			(pdu->wincfg >> 2) & 0x03);
+	print_field("Max CIS RX Windows Size: %u",
+			(pdu->wincfg >> 4) & 0x03);
+	print_rates("ACL RX Rates", BIT(4), le16_to_cpu(pdu->acl_rx_rates));
+	print_field("Max ACL RX Packet Size: %u",
+					le16_to_cpu(pdu->acl_rx_mtu));
+}
+
+static void hdt_config_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_hdt_config_rsp *pdu = data;
+
+	print_field("ACL RX Payload Windows Size: %u",
+			pdu->wincfg & 0x03);
+	print_field("Max CIS TX Windows Size: %u",
+			(pdu->wincfg >> 2) & 0x03);
+	print_field("Max CIS RX Windows Size: %u",
+			(pdu->wincfg >> 4) & 0x03);
+	print_rates("ACL RX Rates", BIT(4), le16_to_cpu(pdu->acl_rx_rates));
+	print_field("Max ACL RX Packet Size: %u",
+					le16_to_cpu(pdu->acl_rx_mtu));
+}
+
+static const struct bitfield_data ecdh_flags[] = {
+	{ 0, "Allow 64-bit MIC length" },
+	{ 1, "Opportunistic encryption" },
+	{ }
+};
+
+static void print_key_type(const char *str, uint8_t type)
+{
+	switch (type) {
+	case 0x00:
+		print_field("%s: Public key P-256 (0x00)", str);
+		break;
+	default:
+		print_field("%s: Reserved (0x%2.2x)", str, type);
+		break;
+	}
+}
+
+static void enc_ecdh_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_enc_ecdh_req *cmd = data;
+	uint8_t mask;
+
+	print_field("Flags: 0x%2.2x", cmd->flags);
+
+	mask = print_bitfield(2, cmd->flags, ecdh_flags);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_hex_field("Rand", cmd->rand, 16);
+	print_key_type("Key Type", cmd->key_type);
+	print_hex_field("Public Key", cmd->pubkey, 64);
+}
+
+static void enc_ecdh_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_enc_ecdh_rsp *rsp = data;
+	uint8_t mask;
+
+	print_field("Flags: 0x%2.2x", rsp->flags);
+
+	mask = print_bitfield(2, rsp->flags, ecdh_flags);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_hex_field("Rand", rsp->rand, 16);
+	print_key_type("Key Type", rsp->key_type);
+	print_hex_field("Public Key", rsp->pubkey, 64);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -767,6 +959,12 @@ struct llcp_data {
 	bool fixed;
 };
 
+#define LLCP_OP_VL(_op, _str, _func, _type) \
+	{ _op, _str, _func, sizeof(_type), false }
+
+#define LLCP_OP(_op, _str, _func, _type) \
+	{ _op, _str, _func, sizeof(_type), true }
+
 static const struct llcp_data llcp_table[] = {
 	{ 0x00, "LL_CONNECTION_UPDATE_REQ", conn_update_req,   11, true },
 	{ 0x01, "LL_CHANNEL_MAP_REQ",       channel_map_req,    7, true },
@@ -790,9 +988,9 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x13, "LL_PING_RSP",              null_pdu,           0, true },
 	{ 0x14, "LL_LENGTH_REQ",            length_req_rsp,     8, true },
 	{ 0x15, "LL_LENGTH_RSP",            length_req_rsp,     8, true },
-	{ 0x16, "LL_PHY_REQ",               phy_req_rsp,        2, true },
-	{ 0x17, "LL_PHY_RSP",               phy_req_rsp,        2, true },
-	{ 0x18, "LL_PHY_UPDATE_IND",        phy_update_ind,     4, true },
+	{ 0x16, "LL_PHY_REQ",               phy_req_rsp,        2, false },
+	{ 0x17, "LL_PHY_RSP",               phy_req_rsp,        2, false },
+	{ 0x18, "LL_PHY_UPDATE_IND",        phy_update_ind,     4, false },
 	{ 0x19, "LL_MIN_USED_CHANNELS_IND", min_used_channels,  2, true },
 	{ 0x1a, "LL_CTE_REQ",               cte_req,            1, true },
 	{ 0x1b, "LL_CTE_RSP",               null_pdu,           0, true },
@@ -800,11 +998,11 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x1d, "LL_CLOCK_ACCURACY_REQ",    clock_acc_req_rsp,  1, true },
 	{ 0x1e, "LL_CLOCK_ACCURACY_RSP",    clock_acc_req_rsp,  1, true },
 	{ BT_LL_CIS_REQ, "LL_CIS_REQ",      cis_req,
-					sizeof(struct bt_ll_cis_req), true },
+					sizeof(struct bt_ll_cis_req), false },
 	{ BT_LL_CIS_RSP, "LL_CIS_RSP",      cis_rsp,
 					sizeof(struct bt_ll_cis_rsp), true },
 	{ BT_LL_CIS_IND, "LL_CIS_IND",      cis_ind,
-					sizeof(struct bt_ll_cis_ind), true },
+					sizeof(struct bt_ll_cis_ind), false },
 	{ BT_LL_CIS_TERMINATE_IND, "LL_CIS_TERMINATE_IND", cis_term_ind,
 					sizeof(struct bt_ll_cis_term_ind),
 					true },
@@ -814,6 +1012,17 @@ static const struct llcp_data llcp_table[] = {
 	{ BT_LL_CIS_RSP, "LL_FEATURE_EXT_RSP", feature_ext_rsp,
 					sizeof(struct bt_ll_feature_ext_rsp),
 					true },
+	/* HDT LLCP commands */
+	LLCP_OP(BT_LL_HDT_LQF_REPORTING_IND, "LL_HDT_LQF_REPORTING_IND",
+					hdt_lqf_ind, struct bt_ll_hdt_lqf_ind),
+	LLCP_OP(BT_LL_HDT_CONFIG_REQ, "LL_HDT_CONFIG_REQ", hdt_config_req,
+					struct bt_ll_hdt_config_req),
+	LLCP_OP(BT_LL_HDT_CONFIG_RSP, "LL_HDT_CONFIG_RSP", hdt_config_rsp,
+					struct bt_ll_hdt_config_rsp),
+	LLCP_OP(BT_LL_ENC_ECDH_REQ, "LL_ENC_ECDH_REQ", enc_ecdh_req,
+					struct bt_ll_enc_ecdh_req),
+	LLCP_OP(BT_LL_ENC_ECDH_RSP, "LL_ENC_ECDH_RSP", enc_ecdh_rsp,
+					struct bt_ll_enc_ecdh_rsp),
 	{ }
 };
 
-- 
2.56.0

