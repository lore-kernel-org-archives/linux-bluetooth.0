Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240966;
	b=EUgJIr770lTmLBQZLgQ/6QzdiVuc6rmz2QojY5SWludHoEIhyoMGQ7FANYGJFJneIVro
	 gRf9hylSkinm0dCv6r7SlkdbEWjiMzm85FFAl6193ljGn04XgzW1sOihPtsKs8gA/VYfV
	 3OA/9q49H7Y8AE1jKLIm4tpveFrwHGL/nMA/jtYyuKslB2ht31gIvP1ZX1ql+Oj0HIP2n
	 c7LWOVZUaeCIj2uBdlaEfdeAFS6SN7+3uMWEQpu4hQ2Uevo1jydNUWO+nbICqIiJbucmy
	 cV8/+t/rDH3/m1bjJffCqEpydITXdL5Eiwmz0MlZ1WkY93YkUDKPQWz0a6OEy4ACAOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
	b=vXMPcsBbokO0miqxZ5eMMEBhLql3ilqbwmMDnkq9PbST439+BxdiXUcgdpIm02eCTtRn
	 Z2L58NZpVK8Og3L+klNXrC9hht7wPtk/IGQx15vqoPnGzxGbwsvmS0KLYlWitI6V6jbn6
	 bVDcPqEN2Wb1UhK20U24761iq73m2p3r8fMdJPvjgLxNIgGYXkjL/90q6tRzJ3OuY7CeO
	 nCE64Db3W+k8zZwvOgsTDfVm4I6hqzI7Y+6/vnamv2o/tLTrBwni0adRz0BW6bb+rWnzx
	 iUn9qRfJ58tG2SE+OxZQysTyQbcdO9onMKI6NjTZRKLaWV3BDEIwLDgADo+Qvq+h7Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZSi9FI6;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD889606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD889606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZSi9FI6
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so758280e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240964; x=1794845764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
        b=yZSi9FI6ULj9cvf4Qs/wZZ9E52LRF4BTyzLTKXyzNH3yz6ZDuCoQk4qcZP8aJFRy6Y
         Y91/fzZGZqempkv02VyOVq6MNybhubOgF92NW11unYbiiehexHLokYOc2ZFWr+UDkaFG
         3gXaBaZfpyF9IVKMR1jY8xGswhbugau3tvPVwB/xuk2scOonA07Id5anNi5VTBq+he/1
         wFNXzLwSiUHGEvQClP9CP1NH/5zgspZl7rahbgcRCpEuKekryqtdFqMaIVAuGHCsC36v
         YCeVJkCp5cv16ytrur8kgHzXoxm7gsIo7lSpEP1W+0A03lBgWM30mIr6UcdVvbQfc5CI
         xl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240964; x=1794845764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B+oU80qjw7KjT/rgeENYioBi/by39vIgIZusT86p17A=;
        b=ezk+dBN5wNQzZfj/dOPR+FI/Rv/fxDiLWP63FY/exlOgMhUe4FnmBdQhmPYIuUTCNT
         qCQjb3ZchJ79LaAwUlLeX5Y//fR+XuSGjl27aThMdkcKZYZjpiPVMqaQSNmvClXUA8+l
         BB4z9+DA0izZ21Au4+oyn4z4TvqPaCks6tikT7UImnrf2hZK4sFio67RtsyEwuXplpci
         j6PbVewtZdEg9p4TsqkOqexQXSkjlrL4SYHT2zXtBHeiCUQxS5UD74K0M7Brzg+X1j1E
         iasD7f3+dfNVb5ymg0YUYzFI0nh70gH8QgB0rWFQ+RX8/St/BtdfJonbLEGnbO2og9zC
         phFA==
X-Gm-Message-State: APuU4Z+Q9EwA9JJ3aPa23GlvSYV1D1XJJYUr9VCWpmGkufazW229oLU0
	wua4zNfF/SttpDlOI7JGmCcc7w9UgqNP/+kVkpDDThyAUnjw/kL5jY5AJb9IkA==
X-Gm-Gg: AYBFou35Ptdgc3fCPN+QOncGs7HRjUgQtcbRYapxEvg+1IGEMrpwsX5i9HgNm8bViFC
	ybO2FDTI6/q/CsokcSUmcX1JU5OsjbfRUN4muT8ha/KExkBqttW7rZAw7n1Lvn3JKjslG/DAnqv
	6wJYtubLx24rx/ABakK8nYtHLJJk3iFnw5V4YSMpreBZKt3xJMB2DJ7E6X2CORbOcXLkGo9CFZj
	2JQqBDiWMGHB1+d1YuB7jqZU2za3d2H3c+wh4ZBsaVRoha610/mOxY8egG0PWs6jKKspbTQGGnN
	B7dTt9IAIChUdN8q4CD+mi+g3jw/VVw7ZqrJev/4PrXX1iMG6JWIiteGXuzdhmd8c+UhHr1iQ0K
	5sIXdL+yL8++gRD1TG3EU7cODuNHRKulqFDZRrUM39EgSTxrUe+HQZmHrnId9AWApUOsglJMwQI
	7DMX1PNRU38gQWS+seaeRu8drMzIWFNbAE9QBeFoBA70eEKmk/FhhK1sVDOc2g76lmj2pu7tI+f
	eimZGlR985GcOgR45HXVHYCn+Tj8GhURTWjKnx1fpIEg/hZKGELdhzttScc7KMSQWuec6pn1rRN
	PnnahLjMzY+8sjphsXDu3iSNkqD1ciV43aAkUY0A5Qw8wiRJ9ipWQxDUXxU1wvCnOfBChqPfGQ8
	+cYiYobjfHP5IGsyLT4So3deClqmWfuTO+8KVcciWfy1qr0BMnS3tQrgg35yaT+zU8T/rICvrt2
	HmO8M=
X-Received: by 2002:a05:6122:2091:b0:5ed:e8fc:b13c with SMTP id 71dfb90a1353d-5ede8fcb621mr947937e0c.8.1794240964322;
        Mon, 09 Nov 2026 08:16:04 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.16.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:16:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 05/11] monitor: Add LL decoding for HDT
Date: Mon,  9 Nov 2026 11:15:45 -0500
Message-ID: <20261109161553.1506041-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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

