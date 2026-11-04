Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830863;
	b=YrfhmjvrrZVhI60PE/6KlGwnhdgjMFdutrW6P/IJdQRM0T9SrD4RRR28FIjpTaJnYSwn
	 z0IPjXX023DKoLk/AmTcn3CLgdJOEs8Krgg9zW6orRDMPuG0jkTHrFa7+r4hYYjOlfayF
	 lTeIIMBZaByBcoF/SRlrF/M1ld1iM2lQbPabEqAV8x1jD1Q06z0fRuInxxGPOWqYY0oNF
	 QlRwu5CqZ0B+eFBlWDSxHZADgIT5Ma1cxfV906a8sH+nqczHwa0oMiX+oT5fs824tnOZk
	 ST0Kz9SjKPxEYZYKZDv4QSAiUBzPFNQBkiNFiDaW8lrzz2ds9IXLy6xtKdhmlZQVuww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8wDfjQVnpMMbhUqUW8plCD9N0eNV/qpFa2K7hQHaPrs=;
	b=tytcVC1rvPGrHYiopCKcpmoOpQ6syProwNWK8VwHMzB+2WDrtwHqTJgKi5/0hQEpGJn4
	 ihHCgmv5DdEJgFIUYc09r1M0sAAHBTl/xXNkBUgmcYV8bIi/Af/PeZVgGT7FnrXAyku4o
	 60Q8cg5yS4pE1ZOjeXvPrVyNGrHLNtiIwWK8alQMhHRLW8dKi4sXXWbGu2j0dG3V+8oAs
	 5xokk6cKnQLOB/wDc+gdIxXTeASJ5yN/BhfSQXAJYCH3FdSG0vFK+eNInp8CaD4rN77iz
	 BpBZ7RdZS+LmMfVIrJSogMz9RhVKeyC0WtpDidOjjWGjGQ14yYxr69ZQYcf3hXUZ5wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYsIj19P;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE45606D80E
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE45606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYsIj19P
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7c19c6721a3so731722137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830862; x=1794435662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8wDfjQVnpMMbhUqUW8plCD9N0eNV/qpFa2K7hQHaPrs=;
        b=oYsIj19PxzaFDX9Gyk9LwzJRK2zMWmizbbZCyCM/wVEVQKeFiSVL8+4TTjrM5lLzuv
         /Y8ol/szyWLO08+uZghMXxIp4GbSDbw0NxPnufho9lvx1crynsmlJEhBF9MkEe0RM3YO
         AVgNYauY5EKsbJhtLCmH7hSaf7qIIOEzMb07EunegPCsQ0lU8n5eQ/YWI+1wEw2VKVag
         fFAv+bmS8nlNf/krmTSnDWX+O5VBnbaSr4uA4xkndHuYAQac29akFiJegHg8+y7e52ZL
         MI5T0dQj+w++EhS0cQgwRMIks12yNUsvdSxlF8TrIgK9+2kDiNTbj8mJZcNEQ1AyvnAC
         ECFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830862; x=1794435662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8wDfjQVnpMMbhUqUW8plCD9N0eNV/qpFa2K7hQHaPrs=;
        b=ilZj+d+3iPyC9xF/QIhKjoRFLdzIl5hENTIjnmfVttUo2BZR1XjRgr6I5RVTb0PhIa
         ozjXaLMefd7IlcHMjXNbUm0G1B1hLhK46cUtlmVy/yiMaBE+6QRWRCaB+eHrYJNMz7+2
         l4brmMaU33TgB5dAztlqiSVOn4Ro+QlOB9V/Ut7okfXuJ7+pnoY2HBHpeqL7JdBx/wCq
         XAAvlASD9Ew2btNqLhwHq6DnZtsud9AB5pfMlJe5LPFBBDIVwVtm/J5o+UmxSIxBhIXg
         RGQkgvYs+HqcKx6vLRbZ8LK2q9v9wjbOCdWIJAqJPSRVZZXdyTdH7E8elj52Mqb/AVNe
         etOg==
X-Gm-Message-State: APuU4Z+QugeKrZ4zLRVB2q1OiHgD/0mPXzREjhQz068CuUsolt/Ynq5M
	NAV1F4WwsQw3Kjdii02HhCC0MFLbT7WT5sUWu0S5StQNG/TBAgtAJNDJufPMZA==
X-Gm-Gg: AYBFou3FNuEQmF2sD3Q/fEDcOYcommDDPqVYlufhP1G/sM9sta8PKDZ10lQfYQaXRmg
	52xpuJpi5AGkKV81AGv7DPpSaqooqxIeJUxSlMjNz8PvSag0IJEwHejluDeiE6ElQk3nlwcv/vx
	H1TJ0Fm36FnJdjFfLmH+CLFQoUYVywunQgVG1AWa2oxe8zQcUdzTg1MyXhp4WaCqS7pl3VTQq1c
	E3NeoyrEST/ZuPe7WGz/vHIemAfzCBYNt1wYRUE9aUx/tBjpuhj/uqH8zN63ndrSTSgE9Eppp+C
	sCPczfJXMFOHLTwbKA69XKezYg0IjymBt9hvni9B7tL/b+nBlg+QSEqeF6qNBM9LstBgKURPkiN
	azLNuQsxodWIGkq2SoblqqjMvcbYCCsO+CneQvQEqUd2IO95yNaostg+36ygHJlbK1Hx+LcHwIc
	LlTV/hM+n1/P/8H2HjqoxCougDSazXGlc8bxR714K+nR9i00H7hKS5Zh7nt3WL/5xLVFzmu8ozF
	X/4kAm0qnOKKvEvC/qukmgnng+sOTiOGP2GegwF+JXP+BZWqaAadZhXifLZSMjpGT9eSvKQ8xeK
	84TNA0ur2XaGlLrdoh8uahI7CDw6hyuDaGMYLgNOGrxkh7NvLLxfrN3NgK2KpqOEe/RvfJ8mZPt
	+utbvrhJ/1vPU+tVSQXPyk8hnAI+uWqthN3xs/5stm3vBr4SyAUZmb2atMO48osICZ4uvpUgjt+
	IzCzQ=
X-Received: by 2002:a05:6102:292a:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d07262d5f8mr7501901137.13.1793830861436;
        Wed, 04 Nov 2026 14:21:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2852206e0c.1.2026.11.04.14.21.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:21:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 04/10] monitor: Add LL decoding for HDT
Date: Wed,  4 Nov 2026 17:20:48 -0500
Message-ID: <20261104222055.1207928-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104222055.1207928-1-luiz.dentz@gmail.com>
References: <20261104222055.1207928-1-luiz.dentz@gmail.com>
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
 monitor/ll.c | 215 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 6 deletions(-)

diff --git a/monitor/ll.c b/monitor/ll.c
index 6c0f67b5dcae..ba625adac46c 100644
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
 
@@ -558,6 +560,15 @@ static void phy_req_rsp(const void *data, uint8_t size)
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
+
+	/* [v2] */
+	if (size >= sizeof(*pdu) + sizeof(struct bt_ll_phy_v2)) {
+		const struct bt_ll_phy_v2 *v2 = data + sizeof(*pdu);
+
+		print_field("Refresh: %u", v2->flags & 0x01);
+		print_field("MIC Length: %s (%u)", v2->flags & 0x02 ?
+				"64 bits" : "128 bits", (v2->flags >> 1) & 0x01);
+	}
 }
 
 static void phy_update_ind(const void *data, uint8_t size)
@@ -580,6 +591,19 @@ static void phy_update_ind(const void *data, uint8_t size)
 							" (0x%2.2x)", mask);
 
 	print_field("Instant: 0x%4.4x", pdu->instant);
+
+	/* [v2] */
+	if (size >= sizeof(*pdu) + sizeof(struct bt_ll_phy_update_ind_v2)) {
+		const struct bt_ll_phy_update_ind_v2 *v2 = data + sizeof(*pdu);
+
+		print_field("Address: %2.2x%2.2x%2.2x%2.2x%2.2x",
+				v2->address[4], v2->address[3],
+				v2->address[2], v2->address[1],
+				v2->address[0]);
+		print_field("Refresh: %u", v2->flags & 0x01);
+		print_field("MIC Length: %s (%u)", v2->flags & 0x02 ?
+				"64 bits" : "128 bits", (v2->flags >> 1) & 0x01);
+	}
 }
 
 static void min_used_channels(const void *data, uint8_t size)
@@ -648,6 +672,41 @@ static void clock_acc_req_rsp(const void *data, uint8_t size)
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
+		if (mask)
+			print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%4.4x)", mask);
+	}
+}
+
 static void cis_req(const void *data, uint8_t size)
 {
 	const struct bt_ll_cis_req *cmd = data;
@@ -699,6 +758,25 @@ static void cis_req(const void *data, uint8_t size)
 	print_field("CIS Offset Maximum: 0x%6.6x", le32_to_cpu(interval));
 
 	print_field("Connection Event Count: %u", cmd->conn_event_count);
+
+	/* [v2] */
+	if (size >= sizeof(*cmd) + sizeof(struct bt_ll_cis_req_v2)) {
+		const struct bt_ll_cis_req_v2 *v2 = data + sizeof(*cmd);
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
+		print_field("MIC Length: %s (%u)", v2->flags & 0x10 ?
+				"64 bits" : "128 bits", (v2->flags >> 4) & 0x01);
+		print_field("SE Length: %u us", get_le24(v2->se_length));
+	}
 }
 
 static void cis_rsp(const void *data, uint8_t size)
@@ -730,6 +808,13 @@ static void cis_ind(const void *data, uint8_t size)
 	print_field("CIS Synchronization Delay: %u us",
 					le32_to_cpu(interval));
 	print_field("Connection Event Count: %u", ind->conn_event_count);
+
+	/* [v2] */
+	if (size >= sizeof(*ind) + sizeof(struct bt_ll_cis_ind_v2)) {
+		const struct bt_ll_cis_ind_v2 *v2 = data + sizeof(*ind);
+
+		print_field("PCA-H: 0x%2.2x", v2->pca_h);
+	}
 }
 
 static void cis_term_ind(const void *data, uint8_t size)
@@ -759,6 +844,107 @@ static void feature_ext_rsp(const void *data, uint8_t size)
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
@@ -767,6 +953,12 @@ struct llcp_data {
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
@@ -790,9 +982,9 @@ static const struct llcp_data llcp_table[] = {
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
@@ -800,11 +992,11 @@ static const struct llcp_data llcp_table[] = {
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
@@ -814,6 +1006,17 @@ static const struct llcp_data llcp_table[] = {
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

