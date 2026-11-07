Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087982;
	b=vdQrO/TW14LT3GwsVL64g/SR/s4i+Ac5+iYGv2y3GUMlTu7t5gUUTZntJVEtWu83CnHf
	 IpffQRRyXn4MdAynUShMLZm85cIV+IdX5Unj8wcsF9QmBWw6M9ufv7/vSNg8ZewWibabv
	 05O+Tg5sZPXG/qvpBW4wQPdgWrs9Qmqx++D4OXghv11v0gF+p9c0SLYeuROTHGp+tJQT+
	 nBh29g4+qb56RFW7ff02qhdwUAf8kqpZvbTGX9PzenpCE0+qX0ECwqel2Ef/ShdUDT9LG
	 BmrB4H5sQAj4zV5Xx0esN0FOrzQgCfYTH7nYmPRYge0HYSNvATihfEFdavRQ9WomkOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
	b=0ctwS2ECuSVX6UUYwwsmMF3DJgUMBvzcr+Ml7kF70jhr/Je4Wl0iBI9aLfHVHvwUx1OX
	 s1MORsfgguFS5zc85oTgo7z55K2r8qgLYDVgwOTkAmS0c2jzB+jIFvGZ2Qfso3GqNx/eY
	 tA411Izbpz8zM4JDtbR3e6DFyegmH+SQuNu0pBIUHoCgHCNUrXXKsCKoKGnoTXGjDortL
	 37J4P1YNpJdBjUXh+pbSs4IMv1SSw0NJx39nYccaiI4b3KFaczdYyEz7gEyThMLsjrsok
	 1ZmWT8qN8/QFYMQ/DbDsBCwRfmnkM/RGEMoBNp20wr0kOpnr74I9RTTR+iYKpb5VKqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jq8dFqPI;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D0606A32D
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 21:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4D0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jq8dFqPI
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eae12762c9so14195e0c.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 13:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794087981; x=1794692781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
        b=jq8dFqPId2kyLYf6DSVSSXHAdDY+5DYPSqetvFTg2GZzAc/StC0t55Ubql1P/fhGeF
         9cDRthNm1sw0HtguyontvFrrA8sTMU5q8haQSUYSxCCxyunNDSBEWPGRj6TDFLssZZeE
         ucAyMpeOgKwExSk86XnAYPG/ooVb6xK8pzJKJRFT3zEu0tH3XW1u/lUqzwaECoxuFQ/F
         7YydO7Lp3ScSr4P4kJ4D8hD8asgAmXEj+ArQFQFdo1lJL2g/oW74fq5L8N+9lLqHQrkx
         8ZC6Ozix9VI7mSB1okXTHXubSL3zUMgUpQeBLT3p4khSbW4wEHQIqDpA7FgshWTTcroc
         tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794087981; x=1794692781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
        b=LsnDQsBO6Hvo8rGPIEwzg/og/mBFdmQXmwiuIQgdZPfHtSUmE3o9lSINhR6B1b6Z9F
         PxuA5/2LwcNx6AGBJeUi7NSpTTvbKi1yIoABK3IAc301ZRHlCa3epPp1De3ZFa0mwYdm
         L8mPoUyklzmj7PdAn2Q/CrTXp+IeH8FwVa+HBMkD3DfhHTl9cXfGJezen3h5KUyXpoNQ
         tQavaJGdyh/DiBcxfHOrM/s/SG7vApOp41fxWMr8oO1TZB2AVf6nizUtUah8fDOImwT2
         I4ayodD1zLobDfvGGRiS5bgFzcp43W+GUopal7j0hdmy/8415Q5X031IdiuqrLkQvTFB
         uh6g==
X-Gm-Message-State: APuU4Z/iqXOyiE0PCPQo3+eo9gzDj+M7bZWSFUGhbRpxGVFl7FytHlun
	SGFwre5TF5SUnQVnVkZdwglwe8IIMGRg+xsbA8FoWdv6U+q1rwtkbgEpVm25BQ==
X-Gm-Gg: AYBFou2RdjQbMdtJC61Av0awb7s9+nR8uu/N4coIXfQYzfrutr0mtCzA8Xt+zUjNxKF
	tm+uCHNODgSO4jVZpCWvklBMXPDmoHlQZ/vyAVe4ywgNUF1jXX0fcMCEvwfrqcWtccBxw4hCJyj
	L2wYeSzdUSz/MSKUsyKlhnns5lr0cnPo7x3Ozep3/bgYNjg4zoGYwhQWt/szyve+7FO9//k0rL7
	U/J9T1c98SpAwFQ90cs25aggR3YWZmYi4GV9zrh5yNmWsxRxDT9trNmFPzwfmYff881BngUm+3v
	cc3KoTY/kpLaw0QCDAnBGU8jXHZJnmbhOlqP584aADs1lo+wJUun+jRsNY5koglk5kjN86235Iz
	o0kKdiN5NYXsK1Egwgo4FfZWm0Rueka9JlZyCijxK4ZEruSoYkz1B13dpeiC0oR2VyLnmiIWx6G
	sl3RfcQARCqXjXO9rJ4QQA7aGL5HGmPH3E6RKD2tcTrmb7YYr3yQM2EmlIScI72Od/ysoSXb28F
	ZxDVaKrzqokutCtvpnuEHceHKrLXJuj/q0vD/sCcNWPCaPy0ApQzB6BeucfNqGkDiZ7fVjR0ScE
	zhc01/oMnCL8qBtZOCjcKrSYbEAAjysQymQqElstISJRKghstsoSl4qv2evHso+oubA7S25A70P
	SmontoFgqeccA+LFNrGRYTHuoEm2OjjxyXjp5G8lHVq1GO1tJWr2k/xNYmGZ8DDCmXjpUm3zuqm
	5Sah8gyrFFzps016/vXLd0KZPU
X-Received: by 2002:a05:6123:102:b0:5c6:81c2:5496 with SMTP id 71dfb90a1353d-5ece720a7c6mr61949e0c.4.1794087980507;
        Sat, 07 Nov 2026 13:46:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6418de3sm382617e0c.13.2026.11.07.13.46.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 13:46:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 05/11] monitor: Add LL decoding for HDT
Date: Sat,  7 Nov 2026 16:46:04 -0500
Message-ID: <20261107214611.388705-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107214611.388705-1-luiz.dentz@gmail.com>
References: <20261107214611.388705-1-luiz.dentz@gmail.com>
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
 monitor/ll.c | 281 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 275 insertions(+), 6 deletions(-)

diff --git a/monitor/ll.c b/monitor/ll.c
index 6c0f67b5dcae..3c68977153b9 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -537,10 +537,20 @@ static void length_req_rsp(const void *data, uint8_t size)
 static const struct bitfield_data le_phys[] = {
 	{  0, "LE 1M"	},
 	{  1, "LE 2M"	},
-	{  2, "LE Coded"},
+	{  2, "LE Coded S=8"},
+	{  3, "LE Coded S=2"},
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
@@ -558,6 +568,24 @@ static void phy_req_rsp(const void *data, uint8_t size)
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
@@ -580,6 +608,32 @@ static void phy_update_ind(const void *data, uint8_t size)
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
@@ -648,6 +702,53 @@ static void clock_acc_req_rsp(const void *data, uint8_t size)
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
@@ -699,6 +800,38 @@ static void cis_req(const void *data, uint8_t size)
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
@@ -730,6 +863,13 @@ static void cis_ind(const void *data, uint8_t size)
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
@@ -759,6 +899,118 @@ static void feature_ext_rsp(const void *data, uint8_t size)
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
@@ -767,6 +1019,12 @@ struct llcp_data {
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
@@ -790,9 +1048,9 @@ static const struct llcp_data llcp_table[] = {
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
@@ -800,11 +1058,11 @@ static const struct llcp_data llcp_table[] = {
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
@@ -814,6 +1072,17 @@ static const struct llcp_data llcp_table[] = {
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

