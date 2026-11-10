Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328508;
	b=B1avQMd/w9DKgOVI0HAnXdsdzgo/U/qjHc9zKkK8BMqCfZKAmihoLF/D78zUBD1heQPr
	 GBrdAdW/PA0ZrmJhgCuLYj9sOYjRc+2Q1qGIBoZCgRMGUm0ZTQQAlh8xRpt86nM5wcKbZ
	 l7WqKdzSM6mxZbXJs0lBO+2oq5MZS7og35QD3kWqLm7uZAbmt0iCZ4Qhh++vlpFl88jCe
	 WB9pAp+UZF2AHVmZfUiVU3SjrlSa6Qd+/NAYxd57KS5d+g+MFNBnQ+O9QnCKZhkEymQTm
	 QjHjeAjx8mdAWtge5whA/msyBdXjf3/yvbdFKZ7p7MAPCkewECzL0oe+1P3OpCe4eFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
	b=y309FKZnUFykV9Nh6ivW9cQIXGJMa4jOW3SoHBkINQua5i9/t9CqESYIoxIQaCia022+
	 yLIAk1aeOJ2xLMMBDgslV1BMrLDLmYQNGgmDTr4nYA+L21P3NR7VBnMjKZHkQzMOF9/1v
	 1NJuMexeaSEpVC95K6z4flVU8SjfctYYKfRes0+3/cTQJRimH0RdVH/HUdRp0JoTuDDq0
	 fHYrHb4rqfPZ0t5IzbC6T9PoaGs0BMzM2kuT75QZjQgvzin4gkITBvCOy/ot49lDwXsKV
	 joRdCopi4t3nya1BzDsVjmoI3y5BO1ZQpkty3Vcw2mcIylEceFRilK7Es505F/5Nv4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p19xI3z1;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858DC606A884
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858DC606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p19xI3z1
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso1197373137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328506; x=1794933306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
        b=p19xI3z1J0OL/BqV2cXq2Uy2okQe7r8y0K2OdQXZssN/xrCiGuc0cxI+a4JHyNCu8b
         qlxh8bvAsjqEKOGfLRKh0sKUgGDHphHfRgnIsh2COx7bjW3QGYgtz1Y8LQxe15k3BUYJ
         6/Y6clGOPDXpWpJaYP+7jwW7YKydjgaxmXVfTHZh9CcYZX+3ywbGSbWkM3pCHTRl91eZ
         M8IcaZaDXJT4hAG09w4yu6xHhN12qcuoIwvD2aVPqgA57PR/ov888Cxkf49jVua+Cf9b
         sgAwMpjdEJcBaGDERMGH5NDuvwenFUoZEtqca2H/73LS1cijLXjmjWS86T6mro0aF+mo
         0S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328506; x=1794933306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
        b=UhNgA+0BvX3yHNG1O3HHXW5JwUXmv/tkOiRkR7mpXujea9/CG2JHVG89iB0+8Wpa8i
         c3qSMGv8E7Xfk6N7Pm1gHtVLSziwOlBVkFjW7lD+fR8GRF6KXdh/aXyJUBhfX+chXmlB
         GrHpP0wg39SUHpatpxtAa1jiRcaRiCz/1bE0EbkWGu59K6De9JdQ+COCa1X0c3dytsbE
         mrjfi5kq+Al+ADgB7WjrShCb/Erzsf4ctzYQOT8OVY/LKgKtc/lnplKoWY76HG+nfmJD
         UKYR8RWNwELV8B8ORAWVK3jeiWtGYV1gseL4U+YMOSrD4hPHDxo7aeaZSYa0VnkqQWtA
         45sA==
X-Gm-Message-State: APuU4Z8knOZU/xXboBXeXGJSv96s2fTCkfyEkCGFD5NOwS4QxHYZPWSp
	FR7M3ALfnhuU7e5QrQe1f8YXu5PaX1H7ThsF/m3xipPATZkOg5uiYFKpf7fltw==
X-Gm-Gg: AYBFou14+6s14J0aIHKgUR+p5xRZGkccZMVhrPJEpjSlfnppaaqNDNQ6C/ifDlqaQla
	wfp4tepw85hbdB9pWYozZt5ob7NatIpZ7KDRAtEr3EhNcsbKS+/L0O9peQPXnyL//8IKF+dwAXL
	RxSZ/HIunSSPosTaaaej8goEqi7hNsQyZjbsMTcySIT9Ql97WHuZ+2fmsDT4A5cfBto/7dbzDZ1
	fqgb1SW68f7Up4UNiiawRG8TbTpO3TS0rGYNA3Oa8Q30MgOKcONVAGb8edM5GMlwnCdBHmZkPx3
	ojMP3ehO1JdMCQIddFjR1khD1McegS9GQgEnnqV8Wsj+vPUwMdmBYTmbq38KJ1JSDnqeclzdH6j
	D2F0NXfFa2JSVXDA8QLjZN82D621+uwRlY7uDdBs1q4d2kXxKKAfJeCVCivRDbTVcM4mTgvvSfA
	lr5gSMnAfZcyxZaxJqaf/njTLxXBj2IxbFCQl0a2YKB75A9cECY8lgRlZGeuZCnhEEgtUySKYYE
	s6p3vq489uosj8aFuSmWEEkyym0o8fHhCNW+EA+vD1qndjj5/D1hCvNc8zMHf9i90OtdPiwz02u
	VS5vR45aeRGSg8tMhZ7nOMYLthb2A+9e42txfWdZLonIDaobnN5SumqjWakuLy0hVolEjkCk1U9
	T6RzAHaDrY8Isqq+xGVbmWS3iIxG3IA6vOpXc2mnreperrRqAuPvkLzP2bxjIIwHYWnKKQ/yqsK
	n7dx0=
X-Received: by 2002:a05:6102:f13:b0:7b4:879c:bb76 with SMTP id ada2fe7eead31-7d301c2e3e6mr1319642137.21.1794328505443;
        Tue, 10 Nov 2026 08:35:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.35.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:35:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 05/11] monitor: Add LL decoding for HDT
Date: Tue, 10 Nov 2026 11:34:45 -0500
Message-ID: <20261110163452.2649366-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110163452.2649366-1-luiz.dentz@gmail.com>
References: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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

