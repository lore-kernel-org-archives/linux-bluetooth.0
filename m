Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744393;
	b=TuKqMakXV1UIr4yvG+1iGIT6X+2WyhPjhypgsP5NeYiFG7sdbepA0n88xDWaInVVFqW8
	 7v6VHLZe4UBG22SapKBSqft4pU1h0RYyY/ixF/OLbezbZlpX/NTmYgdgxpVfxrVfsARdU
	 hORgSjkAhvBLzsdzig7RiSEFC7La4P9XSHFer7tVMKysZSnMAboLN2N3hvG39CluPQVEg
	 6QgaSSUQAgJZITE/OVAJNuxOBoAjwEKpq5bP6Bewy19Gy47p/gtARQD7MmCLdRMKGUjWq
	 x2Ip8BRxq0B21NVPRVGc5zuRAZ4VllDycUMeV0f9zoGFahcZtD/5NSfCINP81EnNvnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jC8w02OOiz8hwt/PgNYvqia/6xhvFDLVgCWyFbmlTVE=;
	b=1FA++XZ+4DZEv5yVStWd9BiJ6FnCmXAAp4LxFkZSggb+RDSGIagfKY8BtQbFGRkeOC9G
	 /Ur6VADbdPHuFG7Lf75rRYAZsojm+EKpNi7VJvwzlY0ofZjumsQoNfeie3rhz5o8xSnQd
	 sj18Pmo9h331koBE5wzCXgQ/tP1nx+BrlwK/B9dy9XO5DpO3cwXETHIutqW4GUR19gDVN
	 l6FDsB9JE9wHwU4HMExEIxmJxk4CzMkxDb1y6rcUhDYG9O4CrdgjnBantSOz0+px5mLTn
	 tIc6ImAjW0AWRPhBfB6P+gcd1xwyUbM25GOKC0sMzmA3V/dBdP/A0cwxfTMvmkfu5zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FGCw/uNZ";
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69B606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A69B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGCw/uNZ
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso28153137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744392; x=1794349192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jC8w02OOiz8hwt/PgNYvqia/6xhvFDLVgCWyFbmlTVE=;
        b=FGCw/uNZfg7WvRyZBLRMZsKAz/gAawrGjGuY8PBz5r8wTVU//B49FB8hl88C7Aj6d5
         sblCA/K7lRxYque6OX/bIhsy483BbfuhhwwkTCCq9mVCiq9G51+uvBM3FmbySMVbmIHF
         YjWcBZARCfP0WK/SKXvGzhyoSQjhlxMgvWdpJh8IKnpvtxT7oVjID/sVoWTH7c3MpNil
         Hu+n2NSuWVkeJb5DeOXbpOZC/n/8oKTUR++22rqIH1x/fjhQfWGJ+/jrqop+5tR5WHEF
         HCtBJXs9JTU1NcQrkIh6fc2QqOjx/kEdaTJgz1VAPXlfwpB/dkHb3CgBEf7LWES4VxGz
         6u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744392; x=1794349192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jC8w02OOiz8hwt/PgNYvqia/6xhvFDLVgCWyFbmlTVE=;
        b=PiBbr28sc52l28UXTd+LE8Dovq0yUp2J1fKpnVDlRjhGR+xWhI7A46/r7VbNbFzvOT
         g+lQyE77GOSJsXj/xXLRzrT4hkmOWUI+k1fCi3S+V0WpGg8TjKUrj703bMlK3n5xPKPB
         SDYiZdMwu9uZMp4pcJ8U5ceFZnv0a3hhXHjMBLYS968NI+WJYaCSlSaWHWatPwx0a+C9
         3RVPhozZCHxBKPNtYIENNWRjfyjnE49PaFIOYKvhJDDLNGkbqx9uGCp8iW+vuTYDB/HA
         8/3O64Dz4Cdy4Kv2Er7HmJb2lpn9ILLB1aD7qVxsxq2hU3mlIiLLFL/6bK/GaDAJa/8E
         NZCw==
X-Gm-Message-State: APuU4Z8jH36hIb85r3YjT7+31ByWYInU1YzYeuvd69hu9ulAc1RRT/ZQ
	YLHEHibUGV3+trsJUMdRuqynU2qSptSZyNAnXrekzlUrhEsquSUKOmulapkmMA==
X-Gm-Gg: AYBFou0thycZWjqxZYzl3JaM/ghKcMpbb5Am77L9GWFdyWrNDixJSnyr02/9ijeiJoP
	i0JWQ5S3r+h264PxbGXmAF0NSM/9NooGlh+50UgF2WdRrrjbrjBxfIpwtMTBWVkktglwfuPh9jd
	uY7UtZlgk8884ucS90sOBzAOiUrM/tW7W7bZPKYoaQpgvNGnJ+e7wDjzyd82nUbk1SmxmxfNEYI
	94n8G5n4TGZmY9/8MIKENDaNDgRhPrxO5WHatBGyppEnF9Xmz8lD3rLsTelOCnGCSCwlFt3BVh9
	zzl3lnxRMXhc18r+gEdD7vqQB70QVClhutmXuRyPYziptPevhiuUQKiSxIkar/1zRKO4W15vKIt
	40h4tY+fyQVU8LviXAV0wXjIqWs0AaNaDCRXlRva0wWBZCLbyQxz/5skLVAD8buS5wMwanCdVjZ
	XYYUYQfnhuwNlrCg6y0nUCN/lZNWUwodu5GKYnph3IOpqfRLO6mlytJ6C1lVoqp2Cg2GcEeie48
	+QloBNc8C1If1zjYNhSs7dXRKWN91ENPAPxVzqMlEKFhcUuAae9z5ZPKzrYAgJOx/VFo7Rgf+im
	iecrjhdoQyKz9QoejDg4DuYqda3AHTnPEdFnnHs6hG40q1m0Rf3M6VZymLmbnmh036HtofIkstL
	9YyMekP/r6rA8mFQ9rpT/3bwrXjMpOGZPWmY4kVD4LdbIba1NqPremAGqGyoDr8FPDrB/xxSbdG
	Ogf3I=
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id ada2fe7eead31-7d072247aa7mr6379206137.5.1793744392315;
        Tue, 03 Nov 2026 14:19:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/9] monitor: Add LL decoding for HDT
Date: Tue,  3 Nov 2026 17:19:37 -0500
Message-ID: <20261103221944.4072041-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
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
 monitor/ll.c | 331 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 330 insertions(+), 1 deletion(-)

diff --git a/monitor/ll.c b/monitor/ll.c
index 6c0f67b5dcae..2d4161c8f09b 100644
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
 
@@ -759,6 +761,303 @@ static void feature_ext_rsp(const void *data, uint8_t size)
 	packet_print_features_ext_ll(rsp->page, rsp->features);
 }
 
+static const struct bitfield_data coded_rates[] = {
+	{ 0, "CODED S=8" },
+	{ 1, "CODED S=0" },
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
+static void print_rates(const char *prefix, uint8_t phy, uint16_t rates)
+{
+	const struct bitfield_data *fields = NULL;
+
+	switch (phy) {
+	case 0x01:
+	case 0x02:
+		break;
+	case 0x03:
+		fields = coded_rates;
+		break;
+	case 0x04:
+		fields = hdt_rates;
+		break;
+	default:
+		break;
+	}
+
+	print_field("%s: 0x%4.4x", prefix, rates);
+
+	if (fields) {
+		uint16_t mask = print_bitfield(2, rates, fields);
+		if (mask)
+			print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%4.4x)", mask);
+	}
+}
+
+static void print_le_phy(const char *prefix, uint8_t phy)
+{
+	const char *str;
+
+	switch (phy) {
+	case 0x01:
+		str = "LE 1M";
+		break;
+	case 0x02:
+		str = "LE 2M";
+		break;
+	case 0x03:
+		str = "LE Coded";
+		break;
+	case 0x04:
+		str = "LE HDT";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%2.2x)", prefix, str, phy);
+}
+
+static void cis_req_v3(const void *data, uint8_t size)
+{
+	const struct bt_ll_cis_req_v3 *cmd = data;
+
+	print_field("CIG ID: 0x%2.2x", cmd->cig);
+	print_field("CIS ID: 0x%2.2x", cmd->cis);
+
+	print_le_phy("Central to Peripheral PHY", cmd->c_phy);
+	print_le_phy("Peripheral To Central PHY", cmd->p_phy);
+
+	print_field("Central to Peripheral Maximum SDU: %u", cmd->c_sdu);
+	print_field("Peripheral to Central Maximum SDU: %u", cmd->p_sdu);
+
+	print_field("Central to Peripheral Interval: %u",
+						get_le24(cmd->c_interval));
+	print_field("Peripheral to Central Interval: %u",
+						get_le24(cmd->p_interval));
+
+	print_field("Central to Peripheral Maximum Payload: %u", cmd->c_pdu);
+	print_field("Peripheral to Central Maximum Payload: %u", cmd->p_pdu);
+
+	print_field("BN: %u", cmd->bn);
+
+	print_field("Sub-Interval: %u", get_le24(cmd->sub_interval));
+
+	print_field("NSE: %u", cmd->nse);
+
+	print_field("Central to Peripheral Flush Timeout: %u", cmd->c_ft);
+	print_field("Peripheral to Central Flush Timeout: %u", cmd->p_ft);
+
+	print_field("ISO Interval: %u", le16_to_cpu(cmd->iso_interval));
+
+	print_field("CIS Offset Minimum: %u", get_le24(cmd->offset_min));
+	print_field("CIS Offset Maximum: %u", get_le24(cmd->offset_max));
+
+	print_field("Connection Event Count: %u", cmd->conn_event_count);
+
+	print_rates("Central to Peripheral Rates", cmd->c_phy, cmd->c_rates);
+	print_rates("Peripheral To Central Rates", cmd->p_phy, cmd->p_rates);
+
+	print_field("Config ID: %u", cmd->config_id);
+	print_field("TL Group ID: 0x%2.2x", cmd->tl_group_id);
+
+	print_field("Central to Peripheral Windows Size: %u",
+			cmd->wincfg | (BIT(0) & BIT(1)));
+	print_field("Peripheral to Central Windows Size: %u",
+			cmd->wincfg | (BIT(2) & BIT(3)));
+	print_field("MIC Length: %u", cmd->wincfg & BIT(4));
+}
+
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
+			pdu->wincfg & (BIT(0) & BIT(1)));
+	print_field("Max CIS TX Windows Size: %u",
+			pdu->wincfg & (BIT(2) & BIT(3)));
+	print_field("Max CIS RX Windows Size: %u",
+			pdu->wincfg & (BIT(4) & BIT(5)));
+	print_rates("ACL RX Rates", 0x04, pdu->acl_rx_rates);
+	print_field("Max ACL RX Packet Size: %u", pdu->acl_rx_mtu);
+}
+
+static void hdt_config_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_hdt_config_rsp *pdu = data;
+
+	print_field("ACL RX Payload Windows Size: %u",
+			pdu->wincfg & (BIT(0) & BIT(1)));
+	print_field("Max CIS TX Windows Size: %u",
+			pdu->wincfg & (BIT(2) & BIT(3)));
+	print_field("Max CIS RX Windows Size: %u",
+			pdu->wincfg & (BIT(4) & BIT(5)));
+	print_rates("ACL RX Rates", 0x04, pdu->acl_rx_rates);
+	print_field("Max ACL RX Packet Size: %u", pdu->acl_rx_mtu);
+}
+
+static void phy_update_ind_v2(const void *data, uint8_t size)
+{
+	const struct bt_ll_phy_update_ind_v2 *pdu = data;
+	uint8_t mask;
+
+	print_field("C_TO_P_PHY: 0x%2.2x", pdu->c_phy);
+
+	mask = print_bitfield(2, pdu->c_phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("P_TO_C_PHY: 0x%2.2x", pdu->p_phy);
+
+	mask = print_bitfield(2, pdu->p_phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("Instant: 0x%4.4x", pdu->instant);
+
+	print_field("Address: %2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+			pdu->address[0], pdu->address[1], pdu->address[2],
+			pdu->address[3], pdu->address[4]);
+}
+
+static void cis_ind_v2(const void *data, uint8_t size)
+{
+	const struct bt_ll_cis_ind_v2 *ind = data;
+
+	print_field("CIS Access Address: 0x%4.4x", le32_to_cpu(ind->addr));
+	print_field("CIS Offset: 0x%6.6x", get_le24(ind->cis_offset));
+
+	print_field("CIG Synchronization Delay: %u us",
+				get_le24(ind->cig_sync_delay));
+	print_field("CIS Synchronization Delay: %u us",
+				get_le24(ind->cis_sync_delay));
+	print_field("Connection Event Count: %u", ind->conn_event_count);
+	print_field("PCA-H: 0x%2.2x", ind->pca_h);
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
+static const struct bitfield_data refresh_flags[] = {
+	{ 0, "64-bit MIC length preferred" },
+	{ }
+};
+
+static void refresh_enc_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_refresh_enc_req *pdu = data;
+	uint8_t mask;
+
+	print_field("Flags: 0x%2.2x", pdu->flags);
+
+	mask = print_bitfield(2, pdu->flags, refresh_flags);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+}
+
+static void refresh_enc_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_refresh_enc_req *pdu = data;
+	uint8_t mask;
+
+	print_field("Flags: 0x%2.2x", pdu->flags);
+
+	mask = print_bitfield(2, pdu->flags, refresh_flags);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+}
+
+static void refresh_enc_ind(const void *data, uint8_t size)
+{
+	const struct bt_ll_refresh_enc_ind *pdu = data;
+
+	print_field("MIC length: %u", pdu->mic_len);
+	print_field("Instant: 0x%4.4x", pdu->instant);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -767,6 +1066,12 @@ struct llcp_data {
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
@@ -814,6 +1119,30 @@ static const struct llcp_data llcp_table[] = {
 	{ BT_LL_CIS_RSP, "LL_FEATURE_EXT_RSP", feature_ext_rsp,
 					sizeof(struct bt_ll_feature_ext_rsp),
 					true },
+	/* HDT LLCP commands */
+	LLCP_OP(BT_LL_CIS_REQ_V3, "LL_CIS_REQ[v3]", cis_req_v3,
+					struct bt_ll_cis_req_v3),
+	LLCP_OP(BT_LL_HDT_LQF_REPORTING_IND, "LL_HDT_LQF_REPORTING_IND",
+					hdt_lqf_ind, struct bt_ll_hdt_lqf_ind),
+	LLCP_OP(BT_LL_HDT_CONFIG_REQ, "LL_HDT_CONFIG_REQ", hdt_config_req,
+					struct bt_ll_hdt_config_req),
+	LLCP_OP(BT_LL_HDT_CONFIG_RSP, "LL_HDT_CONFIG_RSP", hdt_config_rsp,
+					struct bt_ll_hdt_config_rsp),
+	LLCP_OP(BT_LL_PHY_UPDATE_IND_V2, "LL_PHY_UPDATE_IND[v2]",
+					phy_update_ind_v2,
+					struct bt_ll_phy_update_ind_v2),
+	LLCP_OP(BT_LL_CIS_IND_V2, "LL_CIS_IND[v2]", cis_ind_v2,
+					struct bt_ll_cis_ind_v2),
+	LLCP_OP(BT_LL_ENC_ECDH_REQ, "LL_ENC_ECDH_REQ", enc_ecdh_req,
+					struct bt_ll_enc_ecdh_req),
+	LLCP_OP(BT_LL_ENC_ECDH_RSP, "LL_ENC_ECDH_RSP", enc_ecdh_rsp,
+					struct bt_ll_enc_ecdh_rsp),
+	LLCP_OP(BT_LL_REFRESH_ENC_REQ, "LL_REFRESH_ENC_REQ", refresh_enc_req,
+					struct bt_ll_refresh_enc_req),
+	LLCP_OP(BT_LL_REFRESH_ENC_RSP, "LL_REFRESH_ENC_RSP", refresh_enc_rsp,
+					struct bt_ll_refresh_enc_rsp),
+	LLCP_OP(BT_LL_REFRESH_ENC_IND, "LL_REFRESH_ENC_IND", refresh_enc_ind,
+					struct bt_ll_refresh_enc_ind),
 	{ }
 };
 
-- 
2.56.0

