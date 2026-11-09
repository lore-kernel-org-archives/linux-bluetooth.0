Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239939;
	b=CTMYZbUgJxCCCSAuobAY9BUnowxE1tEqJGlaELZHzADo35S/RNox0VFUl8rWeUR3yH5h
	 brvjJ7OhhW5cmQ57EegzNLRRt1f1uAS243Fjrwa7efnHAKwqobeDJLAKE9+qYqMh9n0NL
	 dXfVl3c8kCRFpOLfhJEfpVufJENVw3Igb5ntGN5odHZvaYtL3ke2hMkRo4w+tyz8OEkIH
	 rCKfkiGNC8KZpZKh1I5J6MBCpY839h2IVCpSYBuzLImNDl4ILYTY+V4J22ou7HvCf6X/4
	 a/M6BmxREqcj5MCcRAZoL6EGdKa9xr1asZR/lMxHTwrjnDqd6qT3rguKQ3+kCSLtWEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0DCCsS2RgfnGSsDZCPnaBu/qEmEnmgjeu3g4mio3Cro=;
	b=SuUgsmXWHmrJNFOdyZEdXE+3rqECYPpLJ8Hsd+Xu5Pi+Ym8uiS8f37S3hLn/hFK2TI70
	 Dc25wWaIGraB8aEPIo7pa/Q7d6+9G/qgn6RJdr/7FSmR7DkxtEv48cxqFVmNk3kA5GH6B
	 fktVR/pPmgvQNWroTTNSnnJglDsUg2tLyqzASCP00UKb+/H+rXFxHqPALRSjZTbLLWrrM
	 lXg4dfcTPAWO754IH0aL1J/E8ItwejGygy2dlCJtpWYf5gVARfCLUyHfl/uuaWpDxjaOR
	 dwN9ZwFeGmGFoTwP6GCX6RAgS/4xyoDWbVVJWpfAxB4L0Zw1KO/ZfwOH78QZEvY7fZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eUQweohn;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C9606EE93
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 292C9606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eUQweohn
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2c8141dc6so546718137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239938; x=1794844738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0DCCsS2RgfnGSsDZCPnaBu/qEmEnmgjeu3g4mio3Cro=;
        b=eUQweohnD6ymyAIQfevjanI14who90sckFxOWuJ4BYALA4+kjMukFnNK29jYY8U865
         Jao5Ht/TAABrHbvbxuvhp6uYRWwmZ8fIgSl7Eke55iI8hIVpDKOLNoDN6GtwtHxbonnZ
         XwI6MkXVWkjoecvVDT5HGY4yirGUNQBJLQM5Pxs8l1NqS3HCWQm7jEISgYx6OKn8KDIj
         nJFwmIDf0IYpoWXbpWgkL/l2CJM4gih4qop0LcdYTNLnJ5WKP0WfVjSjuqw18hzQ4pzB
         1OTgrD+0zfnvd6edKivOpBeDkmFu0j426ZnoymgyvPvIsqluK6JqMn3i474QC3lMIRIW
         GlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239938; x=1794844738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0DCCsS2RgfnGSsDZCPnaBu/qEmEnmgjeu3g4mio3Cro=;
        b=YnQxP+VwJ/dEIECL0KKwjBa8IHAwSx11QOX0XurcaMzYfLhkOOBmPdckccjZZnYH2E
         br41UtPY4TdnnqJzwReUgU0uVVd5pxZn7yO2BVjM3yabgM19rCfeaVceBprlTr+9eQDy
         YX7KY0UHBxKKWTmrjcjowv4CIC6f5CjLEtp1/2P5pRa9fZi/elqhvpDLO8oTen0TNdcH
         oLkKDRElmdGGSDMEOVUSZGrLOy5OYthmzYzDmPULqIblDClyt9vuNhz1Ccrkyq9hLVoY
         BWeSmK1gYVUyjUT5qHQ5j+8vmHuAKud0EqNqO3M5umitygu6IH+MuyBO9q3vKKo5oQId
         aeCA==
X-Gm-Message-State: APuU4Z88L3eIcq1zvdqNbdwQYwlik1SyhHNTHtDe9VfPaqM9DKkweWiv
	c7GTu8ubx+Pa05VbAI91kRt9FUmJ03ohGiyiFLvYORDN3xmIMhgULHqzLc+e1A==
X-Gm-Gg: AYBFou0jesdvNyA65UN/mju7CQNlAzlNXc2iRhRLZfL5B0kVb2O0n2/S+0Geh1hdh8U
	JMa87OFywx6lWcXMpE6Ny+e0tKwmpfV0SUhbi94OGLtbmbDk8jH2T+pwou+Yii2X4LDgMcdaL6D
	S7y/09I2RY4QqzAruLizGX3V46wJie5Q2WZnbS5LiZZwcixg5mmJMCnTRnneBDnLjpY1cOgBMTp
	DPAAP/UXZ0ygKYf4vEnPkAgZF5pDuGncVuFp3DIH0blsQeWXoxnxN1ub22SlsBCmYj1GsFMfaor
	VefqH6zEMGUKj0HzKUFOMnlGxYEKnJ50KQENFo1m7FQ9wLcXwtKzGrR+QPezgVw68PIX8TN9MGZ
	eA4ilTBNotIgLb6Dbb6e4r6o9QMEP9/hz9lQx1Ai5GyPpWjkRwibdfknLVAmnxO6UPvbgkYEcgI
	10DKesSOloj7T/bUDuz1SDQS2wlkY5V6pLSs2yIQ+TfmdgyQlc5yeh6MtW/OSTCdCMSnCSL1GA8
	vGogTHNbPeIRSU3J4OGR8b5okofqbhgf8DYNIw4IYgmyNyVSHPB95rOR8vNMAz+3bst0pLfpFRj
	ubqHdPzaz4uo9+QGsmruTlU8s2VJPDKYpI8MXPmJmV6QMo2eWciYqK8hfwtpxNhHFGy/xEyLuIf
	EcOSO3Zw+AK0mFt01GJSr2ALHUhPd6D3Hmasnx6g2uSP1C7NWZKv9veZmoNZsOGjb58LGZxEs6E
	cABAw=
X-Received: by 2002:a05:6102:54a5:b0:7a4:e550:eeb9 with SMTP id ada2fe7eead31-7d2db0e3f61mr1390266137.22.1794239937959;
        Mon, 09 Nov 2026 07:58:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2db605322sm4145103137.7.2026.11.09.07.58.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:58:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Mon,  9 Nov 2026 10:58:49 -0500
Message-ID: <20261109155850.1394252-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109155850.1394252-1-luiz.dentz@gmail.com>
References: <20261109155850.1394252-1-luiz.dentz@gmail.com>
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

Add support for LE Set HDT Default Parameters, which sets the MIC
length, packet format and ACL rates the controller prefers on the LE
HDT PHY. The command is sent during controller initialization when the
controller supports HDT and the command, with the rates limited to the
ones the controller supports.

The defaults are stored in hci_dev, 128-bit MIC, no packet format
preference and all HDT rates, and exposed through the MGMT system
configuration TLVs 0x0021-0x0023 so userspace can change them; changing
them while the controller is up sends the command again.

The spec reserves the values other than 64 or 128 bits for the MIC
length (the 32-bit MIC being the one of the GFSK PHYs), the packet
formats above 1 and the rate bits above HDT7.5. A TLV with a reserved
value is rejected with Invalid Parameters, rather than sent to a
controller that rejects it, which would fail the initialization.

The default MIC length applies when the connection did not request
one: to LE Enable Encryption v2, LE Set CIG Parameters v2 and LE Create
BIG v2, so ACL, CIS and BIS are set up with the MIC length the host was
told to use.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  7 +++
 include/net/bluetooth/hci_core.h |  3 ++
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_core.c         |  3 ++
 net/bluetooth/hci_sync.c         | 41 +++++++++++++++--
 net/bluetooth/mgmt_config.c      | 79 ++++++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 778c234385ce..5edde8a6cc2d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2663,6 +2663,13 @@ struct hci_cp_le_create_big_v2 {
 	struct hci_bis_v2 bis;
 } __packed;
 
+#define HCI_OP_LE_SET_HDT_DEFAULT_PARAMS	0x20bc
+struct hci_cp_le_set_hdt_default_params {
+	__u8    mic_len;
+	__u8    format;
+	__le16  rates;
+} __packed;
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d2435bf49c5e..e2a79ea5b6bc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -433,6 +433,9 @@ struct hci_dev {
 	__u8		hdt_max_tx_win;
 	__u8		hdt_max_rx_win;
 	__u16		hdt_max_rx_packet;
+	__u8		hdt_def_mic_len;
+	__u8		hdt_def_format;
+	__u16		hdt_def_rates;
 	__u8		le_max_key_size;
 	__u8		le_min_key_size;
 	__u16		discov_interleaved_timeout;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index ab880384614a..e4e220ed098b 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -198,5 +198,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis);
 
+int hci_le_set_hdt_params_sync(struct hci_dev *hdev);
+
 int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 			  __u8 ltk[16], __u8 key_size);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bfc5bdebc71a..a4014bbcdfc2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2575,6 +2575,9 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
+	hdev->hdt_def_mic_len = 0x02;	/* 128-bit */
+	hdev->hdt_def_format = 0x00;	/* No preference */
+	hdev->hdt_def_rates = 0x001f;	/* All defined HDT rates */
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
 	hdev->def_le_autoconnect_timeout = HCI_LE_CONN_TIMEOUT;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b892aef12121..1810a8a48344 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5429,11 +5429,40 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+int hci_le_set_hdt_params_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_hdt_default_params cp;
+	u16 rates;
+
+	/* Only send if controller supports HDT and the command */
+	if (!hdt_capable(hdev) || !(hdev->commands[52] & BIT(1)))
+		return 0;
+
+	/* Compute supported rates based on controller capabilities */
+	rates = hdev->hdt_def_rates;
+
+	/* Mask out rates not supported by the controller */
+	if (!hdt_6_tx_capable(hdev))
+		rates &= ~HCI_HDT_RATE_6M;
+	if (!hdt_7_5_tx_capable(hdev))
+		rates &= ~HCI_HDT_RATE_7_5M;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.mic_len = hdev->hdt_def_mic_len;
+	cp.format = hdev->hdt_def_format;
+	cp.rates = cpu_to_le16(rates);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HDT_DEFAULT_PARAMS,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 static const struct hci_init_stage le_init4[] = {
 	/* HCI_OP_LE_WRITE_DEF_DATA_LEN */
 	HCI_INIT(hci_le_set_write_def_data_len_sync),
 	/* HCI_OP_LE_SET_DEFAULT_PHY */
 	HCI_INIT(hci_le_set_default_phy_sync),
+	/* HCI_OP_LE_SET_HDT_DEFAULT_PARAMS */
+	HCI_INIT(hci_le_set_hdt_params_sync),
 	{}
 };
 
@@ -8482,7 +8511,8 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
-		cis->mic_len = 0x02; /* Always prefer 128 bits? */
+		cis->mic_len = conn->req_mic_len ? conn->req_mic_len :
+			       hdev->hdt_def_mic_len;
 
 		/* Use the rates of each direction, or all the HDT rates the
 		 * controller supports if none were set.
@@ -8593,6 +8623,8 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+	cp.bis.mic_len = conn->req_mic_len ? conn->req_mic_len :
+			 hdev->hdt_def_mic_len;
 
 	/* Use the rates set, or all the HDT rates the controller supports if
 	 * none were set.
@@ -8674,14 +8706,15 @@ static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
 	int err;
 
 	/* Use the MIC length requested by the time the command is sent, as
-	 * channels may still raise it after it was queued, defaulting to 128
-	 * bits if unset.
+	 * channels may still raise it after it was queued, or the default one
+	 * if unset.
 	 */
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
 	if (conn)
-		cp->mic_len = conn->req_mic_len ? conn->req_mic_len : 0x02;
+		cp->mic_len = conn->req_mic_len ? conn->req_mic_len :
+						  hdev->hdt_def_mic_len;
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index fdcc752c6f13..054ba64e975b 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -91,6 +91,9 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(advmon_no_filter_duration);
 		HDEV_PARAM_U8(enable_advmon_interleave_scan);
 		HDEV_PARAM_U32(idle_timeout);
+		HDEV_PARAM_U8(hdt_def_mic_len);
+		HDEV_PARAM_U8(hdt_def_format);
+		HDEV_PARAM_U16(hdt_def_rates);
 	} __packed rp = {
 		TLV_SET_U16(0x0000, def_page_scan_type),
 		TLV_SET_U16(0x0001, def_page_scan_int),
@@ -125,6 +128,9 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		TLV_SET_U16(0x001e, advmon_no_filter_duration),
 		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
 		TLV_SET_U32(0x0020, idle_timeout),
+		TLV_SET_U8(0x0021, hdt_def_mic_len),
+		TLV_SET_U8(0x0022, hdt_def_format),
+		TLV_SET_U16(0x0023, hdt_def_rates),
 	};
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -140,11 +146,19 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 #define TLV_GET_LE16(tlv)	le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_U8(tlv)		(*((__u8 *)(TO_TLV(tlv)->value)))
 
+static int set_hdt_params_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_le_set_hdt_params_sync(hdev);
+}
+
 int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 data_len)
 {
 	u16 buffer_left = data_len;
 	u8 *buffer = data;
+	u8 old_mic_len = hdev->hdt_def_mic_len;
+	u8 old_format = hdev->hdt_def_format;
+	u16 old_rates = hdev->hdt_def_rates;
 
 	if (buffer_left < sizeof(struct mgmt_tlv)) {
 		return mgmt_cmd_status(sk, hdev->id,
@@ -159,6 +173,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		const u16 exp_len = sizeof(struct mgmt_tlv) +
 				    len;
 		const u16 type = le16_to_cpu(TO_TLV(buffer)->type);
+		bool invalid;
 
 		if (buffer_left < exp_len) {
 			bt_dev_warn(hdev, "invalid len left %u, exp >= %u",
@@ -201,9 +216,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001b:
 		case 0x001d:
 		case 0x001e:
+		case 0x0023:
 			exp_type_len = sizeof(u16);
 			break;
 		case 0x001f:
+		case 0x0021:
+		case 0x0022:
 			exp_type_len = sizeof(u8);
 			break;
 		case 0x0020:
@@ -224,6 +242,51 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 				MGMT_STATUS_INVALID_PARAMS);
 		}
 
+		/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+		 * Section 7.8.159:
+		 *
+		 * Preferred_MIC_Length: 0x01 Preferred MIC length is 64 bits.
+		 * 0x02 MIC length is 128 bits (default). All other values
+		 * Reserved for future use.
+		 * Preferred_Packet_Format: 0x00 any supported, 0x01 packet
+		 * format 0, 0x02 packet format 1. All other values Reserved
+		 * for future use.
+		 * Preferred_ACL_Rates: bits 0 to 4 are the HDT2, HDT3, HDT4,
+		 * HDT6 and HDT7.5 rates. All other bits Reserved for future
+		 * use.
+		 *
+		 * So a reserved value is not valid, the controller would
+		 * reject it, failing the initialization when the default
+		 * parameters are sent. For the MIC length, that includes 0x00
+		 * (32 bits), the one of the GFSK PHYs.
+		 */
+		switch (type) {
+		case 0x0021:
+			invalid = TLV_GET_U8(buffer) != 0x01 &&
+				  TLV_GET_U8(buffer) != 0x02;
+			break;
+		case 0x0022:
+			invalid = TLV_GET_U8(buffer) > 0x02;
+			break;
+		case 0x0023:
+			invalid = TLV_GET_LE16(buffer) &
+				  ~(HCI_HDT_RATE_2M | HCI_HDT_RATE_3M |
+				    HCI_HDT_RATE_4M | HCI_HDT_RATE_6M |
+				    HCI_HDT_RATE_7_5M);
+			break;
+		default:
+			invalid = false;
+			break;
+		}
+
+		if (invalid) {
+			bt_dev_warn(hdev, "invalid value for type %u", type);
+
+			return mgmt_cmd_status(sk, hdev->id,
+				MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+				MGMT_STATUS_INVALID_PARAMS);
+		}
+
 		buffer_left -= exp_len;
 		buffer += exp_len;
 	}
@@ -335,6 +398,15 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x00020:
 			hdev->idle_timeout = TLV_GET_LE32(buffer);
 			break;
+		case 0x0021:
+			hdev->hdt_def_mic_len = TLV_GET_U8(buffer);
+			break;
+		case 0x0022:
+			hdev->hdt_def_format = TLV_GET_U8(buffer);
+			break;
+		case 0x0023:
+			hdev->hdt_def_rates = TLV_GET_LE16(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
@@ -344,6 +416,13 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		buffer += exp_len;
 	}
 
+	/* The controller may be up without being powered through MGMT */
+	if (test_bit(HCI_UP, &hdev->flags) &&
+	    (hdev->hdt_def_mic_len != old_mic_len ||
+	     hdev->hdt_def_format != old_format ||
+	     hdev->hdt_def_rates != old_rates))
+		hci_cmd_sync_queue(hdev, set_hdt_params_sync, NULL, NULL);
+
 	return mgmt_cmd_complete(sk, hdev->id,
 				 MGMT_OP_SET_DEF_SYSTEM_CONFIG, 0, NULL, 0);
 }
-- 
2.56.0

