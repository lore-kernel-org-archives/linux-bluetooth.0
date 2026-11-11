Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414484;
	b=pW7tzzLMdcIDcFGC939K8vXi8sbjC+f2QiLEbFswjDhKe/Ga7IwfhPuE5mfnsG94Jk2c
	 f6aV08gWfgiDtZreXca/k8OpwJu0FQkm8B4Vso7ZUhswLW7XwxZwfFkdtLbCTEblQe8zs
	 lNa0D9SwqUSSPNSoyra6PcIvyhl/YCA4/JvLwyZin+HfpRBkrDann9VKoivzEtnDdm021
	 vTUeMHwqZkSKlMoIuqNmfdbq5Tr6nXCI8emoSfiDqOF4TX9HTNUHekb0rXQy9MXlItG6R
	 o830fzoTRvmIdvSaYQzRUFo9PBVd954upQ1N7WGJU2dy62eoHCgttvcM8i8vmFm/qrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/FfwQCH4i0+38v+P30L2QteJvs1CJcxhJQN+M1Ui0Ck=;
	b=4d+3XBRPQlMwk6a/sCMKrAheteScDEvnXaLvK+zZgmbFmxBJ5J+O5kvGAdUiG5jXjfBm
	 eIiMrFcrw6fu+5TOj0mfBYLR5pncJw2+10BUYNrpO71B/HzmCKbMpWkEsmoi3JWUjcKGo
	 zzZlKol1PGT+N4iTtOjwlV81sE+xH+7vba3MaSNw2IeDhT9FML9PuuO4dhNGBIG4z0wuE
	 S5l0eekxg3TW4k9csLbAtKn4WxSnMQB+5Wy8fSXJm6S1LEK0JQjMaevrxdzN8X8Jz39lm
	 nZ/GuYJO6SbAkfm2xw6IMQQJybdczJF/A8xJdPFGq59j2gylh7KmKdImi8bqucuRTmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuSA4lCI;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF97606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF97606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuSA4lCI
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5e9528732b4so2005775e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414483; x=1795019283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/FfwQCH4i0+38v+P30L2QteJvs1CJcxhJQN+M1Ui0Ck=;
        b=WuSA4lCIxRtAXdRN8lqebP0WPsxV8QjBHnFzJ5SP4uFOVQUzwp/VIHMq6J0cIDuVhK
         oqk3o+ySSsLKMMn5qX7vwEZFoK3//yIJMPjYCpEeGynuR1rAJlqWNMzgn059c8RUhkQe
         QyNJNlYGo9IriZKATpx5zbd222gLHxe7GVuWXvp2dLDQd6JAEors/iulv6lU9jeBYbV9
         sTl3Ccb31jFxcNF6Gon+5PRA4ww0h+k55O/qEyPCY0MZNp/qOoD1gLEtDF9DT2GnMxjQ
         COZnVhWrumHRBBBym8pB3waxsROFP8SGbdJUpHFu3QJrkP2hbDr0EJCTiAkC+i3jA99A
         hbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414483; x=1795019283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/FfwQCH4i0+38v+P30L2QteJvs1CJcxhJQN+M1Ui0Ck=;
        b=T1qWntQdzEdpDyyYcNC2ULxSphGu/BRFyBiFdK85hgDLPiPvOYRZCDwHJr6SR3iNbN
         WwuInaIEtWQQF1LqNqX1VMOUgPQUd/EeZx08Kpg14Lgm/vdiIsjC0ie28k1sz1bj+91J
         K1kKwQ7rRUVSaD7CfoGrwrCpQF23JzXJ4IlST0WLZ6NKwzzCe8is4LMj2yCRjUW7Fc35
         1ABT6qxfvcDiRNFOPIILbyIa7dNXZJrW//O2Z+AOCIgjn94lu5vcxt/NEGJS5JV52s3c
         SWAi0NaBgB1aaZb0MLmFQTyTZgrJAyynIpww8RguV0suM117qVHoIgLFuOLBa6l6Hi3r
         cemA==
X-Gm-Message-State: APuU4Z8smvjH+/TI2TSY2w5QiZhUwD01ZjAANof7+7QlCiOTr8klpKTe
	Io6hB61cXS9sSxss8nX/JOsizLfsQQ3y/zMNJL2XwLr303Ipm5siOXIotGf1mQ==
X-Gm-Gg: AYBFou0xa2z5oCSUGISZRnPFXsuwGxtD+3n4GNsYrQPjJIFkCIF0QcG0H15Onz6tAlB
	9EOYGbFn6v0Im1X+VxBTRD8Cnmd1oDA/X5ZPCMCaVWGu2Z4Kd/8sjUpWsNPRsfX//J2IhBEkp6z
	CGJhB26Mk8ldKg31B5jO3kEWnUDSsa1VvGUEqDoqE68K/HvAkJ4jCuXUoK714D4QsgYxEjevQRx
	41DCiWSFIrlEo5m88LlCir+WkF8T8CHCziLZ2S3QtQ4KCHMouHr6ThcavLbN4KOJb+pwDl7BFhk
	7iLPu35YekoCislQc4YrFXCRy8nbaorC7wijMbS7yjTDIwtiDukfKV+ewd48qrj9kTyIjIw2h9a
	EU/LI/4Bg4DbhEmuntnjx4lmq9By/Bh7Ol7o6okr84MO4H9zSMCdVuxWPRH2sk5EH9z0mCDnlW8
	7XHQQt9MxL7I+3TxdmZesItBrC3v/3FCaSRvHFUov+ylwJEGRBGxrj8PVINhMu9LjnHUD/obrIO
	x/RR3oFE4BFyhUi1pBnU2WST9pUpFBZ4uvLCDriSW+kViObloaehhqjtZFvsvpQ47YKZ+mTit+E
	Go3LZkuxIbg4i88l8aoLNE7/+wVtudYgZ3dx4LpmziM9Ak1ufdrMTJdkU85PkuH/2LP7rlgkIca
	CLtAalIJOnD6jQqi2URF1ePBIP2yEybTiR+dEvEzA6MnNUe1L8ilATLIx1TOht3Bg4MYKhqnMj2
	APIqQ=
X-Received: by 2002:a05:6122:512:b0:5ea:e052:2ef0 with SMTP id 71dfb90a1353d-5ee1c3ff521mr1124734e0c.9.1794414482815;
        Wed, 11 Nov 2026 08:28:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.28.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:28:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 05/11] monitor: Add LL decoding for HDT
Date: Wed, 11 Nov 2026 11:27:48 -0500
Message-ID: <20261111162755.3506226-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162755.3506226-1-luiz.dentz@gmail.com>
References: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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

The payload window sizes of these PDUs are encoded as one less than the
size, so the size is printed along with the value in the PDU.
---
 monitor/ll.c | 278 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 273 insertions(+), 5 deletions(-)

diff --git a/monitor/ll.c b/monitor/ll.c
index 6c0f67b5dcae..c1c68d35ba3c 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -538,9 +538,18 @@ static const struct bitfield_data le_phys[] = {
 	{  0, "LE 1M"	},
 	{  1, "LE 2M"	},
 	{  2, "LE Coded"},
+	{  4, "LE HDT"	},
 	{ }
 };
 
+/* The payload window sizes of the HDT PDUs are encoded as one less than the
+ * size, print the size and the value as it is in the PDU.
+ */
+static void print_payload_window(const char *prefix, uint8_t val)
+{
+	print_field("%s: %u (0x%2.2x)", prefix, val + 1, val);
+}
+
 static void phy_req_rsp(const void *data, uint8_t size)
 {
 	const struct bt_ll_phy *pdu = data;
@@ -558,6 +567,24 @@ static void phy_req_rsp(const void *data, uint8_t size)
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+	 * Section 2.4.2.22:
+	 *
+	 * Refresh shall be set to 1 to require a key refresh. If the field
+	 * is not included, then the value is 0.
+	 * MIC_Length shall be set to 1 to request that the MIC_Length on the
+	 * LE HDT PHY is 64 bits. If the field is not included, then the
+	 * value is 0 (128 bits).
+	 */
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
@@ -580,6 +607,32 @@ static void phy_update_ind(const void *data, uint8_t size)
 							" (0x%2.2x)", mask);
 
 	print_field("Instant: 0x%4.4x", pdu->instant);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+	 * Section 2.4.2.23:
+	 *
+	 * Address shall be set to the Physical Channel Address for the PHY
+	 * that will be used after the instant on the ACL (with the most
+	 * significant octet set to 0x00 if the PCA is only 4 octets).
+	 * Refresh shall be set to 1 if the encryption key will be refreshed.
+	 * MIC_Length shall be set to 1 if the encryption key will be
+	 * refreshed and the new key uses a 64-bit MIC. If the MIC_Length
+	 * field is not included, then the value is 0 (128 bits).
+	 */
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
@@ -648,6 +701,53 @@ static void clock_acc_req_rsp(const void *data, uint8_t size)
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
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B, Table 2.27:
+ *
+ * Bit 0: For the LE Coded PHY, indicates use of the S=8 coding (possibly among
+ * others). For the LE HDT PHY, indicates use of the HDT2 rate (possibly among
+ * others). Otherwise, the bit is ignored.
+ * Bit 1: For the LE Coded PHY, indicates use of the S=2 coding (possibly among
+ * others). For the LE HDT PHY, indicates use of the HDT3 rate (possibly among
+ * others). Otherwise, the bit is ignored.
+ * Bits 2 to 4: For the LE HDT PHY, the HDT4, HDT6 and HDT7.5 rates.
+ *
+ * So the rates are those of the PHY set in phys, as defined in Table 2.24.
+ */
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
@@ -699,6 +799,38 @@ static void cis_req(const void *data, uint8_t size)
 	print_field("CIS Offset Maximum: 0x%6.6x", le32_to_cpu(interval));
 
 	print_field("Connection Event Count: %u", cmd->conn_event_count);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+	 * Section 2.4.2.29:
+	 *
+	 * Rates_C_To_P and Rates_P_To_C are the bitmap of allowed contiguous
+	 * rates, as specified in Table 2.27, of the PHY of that direction.
+	 * Payload_Window_Size_C_To_P shall be set to one less than the size
+	 * of the payload window.
+	 * If the CIS is on the LE HDT PHY and encrypted and a 64-bit MIC is
+	 * to be used, then MIC_Length shall be set to 1. Otherwise,
+	 * MIC_Length shall be set to 0 (128 bits).
+	 * SE_Length shall be set to the time, in microseconds, that needs to
+	 * be reserved for the subevent.
+	 */
+	if (size >= sizeof(*cmd) + sizeof(struct bt_ll_cis_req_v2)) {
+		const struct bt_ll_cis_req_v2 *v2 = (const void *) (cmd + 1);
+
+		print_rates("Central to Peripheral Rates", cmd->c_phys,
+						le16_to_cpu(v2->c_rates));
+		print_rates("Peripheral To Central Rates", cmd->p_phys,
+						le16_to_cpu(v2->p_rates));
+		print_field("Config ID: %u", v2->config_id);
+		print_field("TL Group ID: %u", v2->tl_group_id & 0x1f);
+		print_payload_window("Central to Peripheral Payload Window",
+						v2->flags & 0x03);
+		print_payload_window("Peripheral to Central Payload Window",
+						(v2->flags >> 2) & 0x03);
+		print_field("MIC Length: %s (%u)",
+				v2->flags & 0x10 ? "64 bits" : "128 bits",
+				(v2->flags >> 4) & 0x01);
+		print_field("SE Length: %u us", get_le24(v2->se_length));
+	}
 }
 
 static void cis_rsp(const void *data, uint8_t size)
@@ -730,6 +862,13 @@ static void cis_ind(const void *data, uint8_t size)
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
@@ -759,6 +898,118 @@ static void feature_ext_rsp(const void *data, uint8_t size)
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
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+ * Section 2.4.2.61:
+ *
+ * ACL_RX_Payload_Window_Size shall be set to one less than the value of
+ * PayloadWindowSize that will be used on the ACL connection in the direction
+ * received by the device sending this PDU. Max_CIS_TX_Payload_Window_Size and
+ * Max_CIS_RX_Payload_Window_Size shall be set to one less than the maximum
+ * payload window size that can be supported by the device on an associated CIS
+ * in the transmit and receive direction. ACL_RX_Rates shall be set to a bitmap
+ * of rates (as specified in Table 2.27) that the Controller is allowed to
+ * receive from the remote Controller on the ACL connection. A value of zero
+ * indicates all supported rates are allowed.
+ */
+static void hdt_config_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_hdt_config_req *pdu = data;
+
+	print_payload_window("ACL RX Payload Window Size", pdu->wincfg & 0x03);
+	print_payload_window("Max CIS TX Payload Window Size",
+					(pdu->wincfg >> 2) & 0x03);
+	print_payload_window("Max CIS RX Payload Window Size",
+					(pdu->wincfg >> 4) & 0x03);
+	print_rates("ACL RX Rates", BIT(4), le16_to_cpu(pdu->acl_rx_rates));
+	print_field("Max ACL RX Packet Size: %u",
+					le16_to_cpu(pdu->acl_rx_mtu));
+}
+
+static void hdt_config_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_hdt_config_rsp *pdu = data;
+
+	print_payload_window("ACL RX Payload Window Size", pdu->wincfg & 0x03);
+	print_payload_window("Max CIS TX Payload Window Size",
+					(pdu->wincfg >> 2) & 0x03);
+	print_payload_window("Max CIS RX Payload Window Size",
+					(pdu->wincfg >> 4) & 0x03);
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
@@ -767,6 +1018,12 @@ struct llcp_data {
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
@@ -790,9 +1047,9 @@ static const struct llcp_data llcp_table[] = {
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
@@ -800,11 +1057,11 @@ static const struct llcp_data llcp_table[] = {
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
@@ -814,6 +1071,17 @@ static const struct llcp_data llcp_table[] = {
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

