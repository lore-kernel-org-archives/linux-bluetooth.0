Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244730;
	b=0zZ3k9qMST43Ol8YIbMj6M3/K+dAKw/2rYLsVsl2kiMj8EjuPSIvjNoJbL7WVzmAIqYv
	 eBPHqlVnfloOdAoHDBJ6Esp0IP7JgvONvF5qROOu+/AWgsD6EWf400MmYm7YTsu4wlYi/
	 rvQQNYkndBRhPf/ZfIfA2J2IOyNT6rmkLvafsUoumTmGKLvCbY9ezQ2xPA4kQ2YmpOvAF
	 jD1T3FeiUMLWP5f8ij0ToR7QY+5356lHWTKAQMk2P4s0N98DLfkbrXqTzubsDxiGBEF/f
	 FjOj8mL2S48Gw0a/jQK27xY5By90pIAUhZKlA0ZmUPbfQplmcIpG52AXfdBbOjj0gbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XPLduh4Q7Nh2rObxHqd/0BBhlFpEdsmpgp62SruFMl8=;
	b=CCWiIypdOWCGtUZh/7fxfhOlbiEzBDe3q4RxDY1i58+HCmvucqTicCDB9lgv3R/38RQ0
	 w1TIgSWxG1hXDJGlIeRJsML1LiDKezkdWbluiLksC+EG/Xsl654qrwtfZC4ZuUR+2b68n
	 CCltxbm2oeX+X1Lk4ZPtBCvmbdj+H9lx8xZX0REkAYIiqLVB2NXmSl07sWTwC6D+zn+aJ
	 BMEdxEry/uTBZ7qWua35vlRSEgqG//RbWF5xgxvwa45TiIu0jL61kqK8Nq38jnM4gRM9R
	 1VG22Y2UzM4YF5LYqhwZ1wQj4jaOxbAeBlR05wHJ9LP1L1sybk6yAmD2pSPRdxvRHcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p9YXgTNL;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7F606EE85
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 17:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F7F606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p9YXgTNL
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ece6c1d1cbso339885e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244729; x=1794849529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XPLduh4Q7Nh2rObxHqd/0BBhlFpEdsmpgp62SruFMl8=;
        b=p9YXgTNL+94kMfwO8JsEXZqi7SroqhlHKVA9BCdkw2a/UoYKZmDSuMfrEJZp4CYCVW
         n8XGyA55FaUhgdCDIjm64Y2YNuUM6t57pqnF7WgtRhD1ZY0cihEYVBz/47FrVd/PeBpR
         TeycHSfiyeEWh2X1XUVnb55cAX+hYYgnCw7PIwTvlKF/TfRKAgzDETp/VL1g7/BI6xj5
         FynnMs/dzG5YcTXGJJGtNNTn5Upq9Rkq4TlVGMZxJb7b4CeRJJSB/aJdQncCZd88hDfT
         e71dA/Cer7lkveF/YhMURcjuqsV7ki+EK+qARBFSYKhQUzJQ4ZZ8xuqHYEYjQRI/hAk+
         647g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244729; x=1794849529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XPLduh4Q7Nh2rObxHqd/0BBhlFpEdsmpgp62SruFMl8=;
        b=VF19LbOYVnovgbnin7PFyzgzGzPM7eAECO3cIcMAoweatJXiyECaaE0fSFtCDhr37O
         ORHRxIUbjHgsfsrWEKylG/E7qq1kdUJbVp3RMKnijLIzTvpeFypPWmrOX82OzivXTUis
         X5dKP3hfUXFcSUjFPL3TtdyZLdEPM9X3cG4YjMNxypbEg8nsnxp6iYDKjmj9gzifbB4j
         wRZeCBnyU60MAkTvJyygyhjJPr5OD/ms/pT90biKrcCv7UbAbCxYbINr/YW/cJqMwszU
         CoPCWdOq7RFTDqO6zb52D2VGIgm8TjAMqPn8XfD1Du+H7HShTUR3+6Q8j1L44wHIXR2K
         dj1A==
X-Gm-Message-State: APuU4Z8Ue9c0knnXntxG/9CAIWdVKfvmmSLimj+7r2UWW/8HVRk/+7Cj
	ZpnPoH7TPLC5ky7ndz7iUmlfauoCW06rdHfN8tATzwzAieZbXnJZ64OEO88zYA==
X-Gm-Gg: AYBFou3eaOfVCIzAmKDDn+OgoVntm2VvUraXkE/4e60+I5ojvHZiPGRjy7l5LvLmEic
	DzT5L1ith2nn7muDN06zOK6ul4+CHnEwOw5UbC8/6THgIIdgFmQU1hCX10DFzrZlGUzcg/BbIx8
	i2UyIZPQzmrIV2E3B/6lkZ08XgfRRYAxXWEelOV1geKKGyh8gbOvGkYxAvFs8qbJqVyaCnPIbKz
	/Q+gOsJXZrlgr/8dnUWLL9xS/gAhWUzwkm4txfrcrIlHESiUOmuk50h1cEcZVAtJ4XbjtAgt1N/
	S6XCRfK5PXyseU5Ki1qW/s7QiDglKjWkqRG5Gnb4wPP7WHXEVPXnhLpuUR7p5rOejXezaolVb7m
	mWMsIYLE/CLKUArAaLiuILRNa9v1ig/ixO+MFqnm5pL8R4K415LSfYgXvln1QZ93lrmsstY6Y9N
	zEsKVy3Ll5lPe8uhZDzc4KATmoINvIO2NsvPIo6NqVfH1Ju1ecMBGo6WhLW4bl4EHLcRAVIDT0h
	4EKpEUeAXh8MhRTDotz2/nh7tfF/VdjxZFkrAQNTAPvkgB1xOaaMelHbSYn7PNtCvvkviMlNmg1
	6NmgmC0ZQIBAFnyvQWTEVJ+7jL+bmL4h0P6rPD2Bw4jvT4In2ecQ48farMBMWdBx3DD1CTBFTnJ
	ZPEaxUe6lKbfWWo+3AG0t24Kr5GNMykVJPAzBLP73Ttx094IDTVUPusYqQ1MYborEnLTY5kd129
	BaXE8zjb+JA876sb3iJ7RlS8dg
X-Received: by 2002:a05:6122:4f81:b0:5e4:f6c8:b0a5 with SMTP id 71dfb90a1353d-5ece70013b0mr1622630e0c.0.1794244729100;
        Mon, 09 Nov 2026 09:18:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5b2233sm21944e0c.10.2026.11.09.09.18.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:18:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v11 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Mon,  9 Nov 2026 12:18:37 -0500
Message-ID: <20261109171838.1592267-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171838.1592267-1-luiz.dentz@gmail.com>
References: <20261109171838.1592267-1-luiz.dentz@gmail.com>
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
ones the controller supports, preferring all of them if that leaves
none, and a packet format the controller doesn't support, Packet
Format 1 being optional, replaced by any supported one, since the
controller would reject either and fail the initialization.

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
 net/bluetooth/hci_sync.c         | 63 +++++++++++++++++++++++--
 net/bluetooth/mgmt_config.c      | 79 ++++++++++++++++++++++++++++++++
 6 files changed, 153 insertions(+), 4 deletions(-)

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
index 0926dc844b44..6674f8db7f52 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5462,11 +5462,62 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+int hci_le_set_hdt_params_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_hdt_default_params cp;
+	u16 rates;
+	u8 format;
+
+	/* Only send if controller supports HDT and the command */
+	if (!hdt_capable(hdev) || !(hdev->commands[52] & BIT(1)))
+		return 0;
+
+	/* Mask out rates not supported by the controller */
+	rates = hdev->hdt_def_rates & hci_hdt_tx_rates(hdev);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part A,
+	 * Section 1:
+	 *
+	 * If the LE HDT PHY is supported, then HDT2, HDT3, and HDT4 shall be
+	 * supported.
+	 *
+	 * So if none of the preferred rates is supported, such as when none
+	 * is preferred, prefer all the ones that are rather than sending
+	 * none, which the controller would reject.
+	 */
+	if (!rates)
+		rates = hci_hdt_tx_rates(hdev);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.160:
+	 *
+	 * LE Set HDT Parameters Test fails with Command Disallowed when
+	 * "Packet_Format equals 0x2 and HDT Packet Format 1 is not
+	 * supported."
+	 *
+	 * So don't prefer a packet format the controller doesn't support,
+	 * 0x00 being any supported one, as it would reject it the same way.
+	 */
+	format = hdev->hdt_def_format;
+	if (format == 0x02 && !hdt_pf1_capable(hdev))
+		format = 0x00;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.mic_len = hdev->hdt_def_mic_len;
+	cp.format = format;
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
 
@@ -8482,7 +8533,8 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
-		cis->mic_len = 0x02; /* Always prefer 128 bits? */
+		cis->mic_len = conn->req_mic_len ? conn->req_mic_len :
+			       hdev->hdt_def_mic_len;
 
 		/* Use the rates of each direction, or all the HDT rates the
 		 * controller supports if none were set.
@@ -8593,6 +8645,8 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+	cp.bis.mic_len = conn->req_mic_len ? conn->req_mic_len :
+			 hdev->hdt_def_mic_len;
 
 	/* Use the rates set, or all the HDT rates the controller supports if
 	 * none were set.
@@ -8674,14 +8728,15 @@ static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
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

