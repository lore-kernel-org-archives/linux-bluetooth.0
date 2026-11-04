Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817413;
	b=Mf0qW/0IhL9IV4hOOlZIDkDtThEGGg8kezMeQGVc4VKpjTet0Ca40CiV7xL5WFdBt2I3
	 XaZWsKBIU4u2X2lDLEBToPnxtX5qql71P2XgbMcBVzfuSAsgp50KPDfPghTeKGg1dIWQW
	 zxIGozNFq2MYAsRm2fl8qz6War2y6F9RruWpfRowtB+gjufSuGphwvWDbgDx9QkXKA6Uq
	 MPhm99xAhdTM0BNbu9jSAj82xoyN5Ddhnr33KFieDKARDCC1GaH+dD9PIAvW7mO1lbGBg
	 2hgZw4AVs7sQ9aBEa3pkKLZOBbnGzMU/4SxiLMpH1/D7AbcCbZE6+OGdIx1CupHEuSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8wDfjQVnpMMbhUqUW8plCD9N0eNV/qpFa2K7hQHaPrs=;
	b=ny5GRiyPotOJDdmKsiCaUSu8CqBkW3E+p9vey1oLPSN03zW/8XxWwRob1f+Fz0N/O07Y
	 XwMM/Hug+Jr3bryQnaffQSkeJvJ3le+4zO5iRr11ymJZvScopR2dblLLsvn5R2fLslwlr
	 nBFKeD1/DLWP5fyZSXP9NzBeP58HEHV+v3xvXSOgzR0TiAN7V0i1bhHjzyPN19Hup6e+O
	 iWrdR4mW5lwZ0pAHqljaffAJrchTzoK30StaR/9gUz8I9b8VgBhHE1mIbCaq2+q11gziv
	 2NSVBT9X/spH45zCjUtB5p0TaDL22BolsMgsFIrc/je6lGZfGrSSibye220Tdc4mZmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xQbur04p;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040B606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3040B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xQbur04p
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c33cc572e6so786902137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817412; x=1794422212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8wDfjQVnpMMbhUqUW8plCD9N0eNV/qpFa2K7hQHaPrs=;
        b=xQbur04pn4mmAgVbUI9/0wOm8egARduBVLyVVnIojeafRJmzQzVm0I+VTsd/roFZoA
         csbG6lOpo8VJFPz90JwVNDsxAYhT7yXKWhhuybZ3tIrPVfEaBVvYnfHhl74way/rvGm/
         a0n8PVEmVaQGu8TPaA5tHAr+ZIlJ7XOkC2O0mr5D0VxflB5m9k05uBmP2T6NiB4F0ym9
         rA+C0gqBwzzYIeOtTCk50CSiI/KmpAe5lgQgdk4T/AGBCUq/Z3Efp79a81laAjSPKrNO
         i6xYK8czL+3N0ZtsQ++rNEa8jGRz7mnMnGixkqCJGImKRSinC20EiRSOly4PkcTyqeoA
         aGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817412; x=1794422212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8wDfjQVnpMMbhUqUW8plCD9N0eNV/qpFa2K7hQHaPrs=;
        b=twILCAp6m6iIYDPCJqGyJcxtBeV+RTPxIy9axI6wyDKnViHxPL4ZVFQxNw1X+gWZNG
         N907psBd73Rb6qv5tEyhKh/ww+aXV8xZq07221Z/NOMevqK/Q0PaOljqAU9Enew9x3bh
         9ZpNNHtw86VkAVlOACk8aZlHYdx434eGGhe/reP0m1OyHW4bitH8opB29TmqkQv3yrif
         N9xfcpC6f7N2tnWE+7kvFAfNGq4JITvtYyVr1mxgdzhpX8/R1fdVECjdDu4Bqh6WcYcf
         1tKn2dcQjjsVcPLtqLSczVewjWdiHkCJDUyYBF1aJeeGSObJNO9wR8TqddyRie4vuuoX
         /Gzg==
X-Gm-Message-State: APuU4Z9cJL0u2UOANpnyWfyhz+cZhm9xXoqMv5ZPWRMdi9wT905INY4N
	pqykzCVTSnHchEdL4xF7ozmEvaxtArrUF9rDCWdfyn0jCkzLjA4uROh8ze0bWw==
X-Gm-Gg: AYBFou3vuSrSNmBwqM7MjjvH0MySdAYXqeroecjAiG/c/IZmzx4g699kSi+KeoDkyWl
	qDj94Il3EW1vjVHbjZjgIZ0Ei3UZPXfKIa9OPjb+pJOJyTqZ8fakEc8wTbv67D5u746iDrhjWsg
	EUb5i/vzSQ/dEWi57jXdkGp/wCL9KPF5tQ7F4onYwKW6UAh/WC6L0SUmHLDVH1dHm3STJo1uOtA
	ikchzegakrIoLpgZv9YGialjge/WPNmG0MY3jvN6UPuT1Z8dL/XAR+NOI8BNDL4JB8pAqsRL/3f
	TeV8IhDFCg9lvYQVz4P6ev55afxGqQKPLxv8WNekUucT6b21VDxdELwxoKWdv/8tNd+bAY1rU3V
	Gk1tW79ZHu6CWeWNPqvF+BZ+Ls6g0yW6uM80EI+I2MFGTS5LkzCC+NQQlfPclzoqVT8J8OquAms
	nsYq+ruR2Rqv+Qs624qwN1t+TfbX9cNgEHTVPI5X7Gm9JyT+WsbkxJFIDuV5oRv77xkeiU4d7Pc
	xR4CkGb/cgvH4pPjYeFqUWLtafKqD6BZUabe2YTpEclchoZW00KPLgwQlCsy6Lr4y5o91gPLjj+
	F3mZBvsUbtVYkXdoR8R+imMUXlxvUL6LJc3dcTwJm0fy6rNl/KWSOlYLPl2fGDyZ3UeK4CQBY0X
	8/awSX1Av5EIu9IuHEWmNre3GwYTXuplO2DV93IryROaf0+cyNwpKH7D5CeE1fBrya4Wke71LJv
	VfpLA=
X-Received: by 2002:a05:6102:6448:b0:7c0:115c:14ca with SMTP id ada2fe7eead31-7d28674445bmr147856137.5.1793817412123;
        Wed, 04 Nov 2026 10:36:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm696605241.9.2026.11.04.10.36.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/9] monitor: Add LL decoding for HDT
Date: Wed,  4 Nov 2026 13:36:38 -0500
Message-ID: <20261104183647.839090-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183647.839090-1-luiz.dentz@gmail.com>
References: <20261104183647.839090-1-luiz.dentz@gmail.com>
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

