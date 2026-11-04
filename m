Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830410;
	b=0z5d6oKrbRUMXhqachO6yOy5nAQeRQRzcaqr4NR65+p7c1lhv7gTpnTaWUoxD3fIVOfV
	 rE9MGLzebH+UPnmtsFR+9L2RDkaxxzpTt3q9ohi1EXqxtv9CUh0uWpLV3FXF4sNWpMmkV
	 t0WW0i1MlHFykr5HxbINToP0chrLg6tqNKHzZUte3s1yXjwk4H4GVLjhIgxWdLd7zjh6o
	 ApaO0ECdmKfoLEFxSgIMeCvfnpYkfL7bNi4RKREw4tBfJly5n21D7qkqZ9sWfjM29daMc
	 tOIK3rPYCznhwTxDl97WlvyPnUR2wRSvtwjE4LUPvh7iMPEhUW+5p8WmhgS1jAIiwng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EZWaLd+zbdUfkpwFiiPa9VOn6DohAtjN9kFgzClhZ8I=;
	b=ZHJS/kw3wrUh76diKUfVRmSypjeZumLxEkhznhzib1OVw3AVj6SQfbcCfMmHLgieOSV0
	 /luusswKnOJZan4rcG62C9r1WtkSZhyKX4TtIiCyD6m1fpbOVfj6lgFFNOZRJ5up7TJE6
	 slfOFOReuTDSR397CvsbfiT5W1r0nJi3xiTlPQgt6rWKbWcEz9i6jLp00C5VfRS3kCLI6
	 V5RS9iR2Xx8IgFELfkvgjWtOOLaNOfQK3YW/tR+QehuZDlDm+KEw4uZWrfKeTnWkg2UFi
	 wqlyDikIFsx2/SM8BIEzHzjz9+t2shrtTjbtLoGyQ1iXTGiXWnRz1g2lnJlD+J3Q19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zS1L2h98;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1146070334
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D1146070334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zS1L2h98
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so402560241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830409; x=1794435209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EZWaLd+zbdUfkpwFiiPa9VOn6DohAtjN9kFgzClhZ8I=;
        b=zS1L2h98ZwM+JOD3VdvdACkQlHrVfvGzJvhkJu0SMTWpLcKdNUz2heIoffDC7fHyw2
         j/DUVxnOlvekkp2cFuMgs0dn4vpnoPvvMBYpnU84bKke/WJ0VwzhuTX0DxjVySGcZL0B
         NPuq7ni/EMpM8CGepDQqD+NtoqO7YPjHhAHo1L5icP7yRrzELzBPvjrDEo6ut8A3eAP+
         30r7p1SkIm6QfZhmBgHFTvutqwKKA1WjL6mFYRCwYVrvWidLwdtT1XtD8t+V/RlLJ1oQ
         k8QE3NkQ8tGmCmg04zzUbTR2hb6UhXNAkBm0gevsllWZx7WUayGsSNNlBrYS+QSYsS2X
         8t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830409; x=1794435209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EZWaLd+zbdUfkpwFiiPa9VOn6DohAtjN9kFgzClhZ8I=;
        b=KO+mw34jU6+Qc8uAr4TFBanErFaIAUkf4my2m1LbUizm1CiMjdqzxXfWizYHK/ecRr
         1EVjz05hG78XjUtI/GJJ7o2DHD7s1gWRNkxhuDuoBwmY+E4uP+2qhJyDDk5OQftY+E+X
         As8z/BGbmZXL0w4yDx7mtkSHgjdj2xRHFRWpQfLSvca3ZZyuslNDpUfZC2eUDazsgwDX
         ca+lwY0vFmlsR+THGp50Rmqr+DNpiJDKrGtyghweNSTQX2RhPhDjrOjeHLTNCldDC5SA
         DgysZfDpHLve7ch/F+bPUMwtbwZ9wJj/20XTHqq9nVp+zO1ntNWFKekYVxC26XkiLBeS
         FB/w==
X-Gm-Message-State: APuU4Z8bnt4ku6Kc7iCDotxvQD56EPUrdl21VV5BuQIRR2G091b2I1Tj
	m4/wxxxR0yHD2//1BBli+iD0clv0eJnEOc60aE7XMwjumm63UWTawIEq9/2VJA==
X-Gm-Gg: AYBFou0qrFX+ywdODfAWGJq3I7sVkgVvNWx61G8O7/002Vq7f5XZOxDHBq/hl5TelO5
	hZMGG09dqy32l+1IRhidVgPsPYoamvAmqCWYrPi3g+Q0kG0KIqVgWW2tRHKesIBlyhJoHjeXvPf
	8Ke9msfmYEDikheAZzGqG3Gkup+vhTOdQEOwjQrRCIXHr10QajiulFLLadzfCSJGS8FF4zJe1Sp
	wymanNg/7LydZD/2XNBZbVTvyDujfFhIv61/VzHAQdARB9mQN7brdsgPU7MB9IguAn26gAFROb/
	EZB+5zBbT4v4gLAnKvUODdEDYB+e2jtgB36GtvmcWEMl4wKgcfFq1S2xG99+vIVaWKHFAGKZEVl
	kMTeSNz4YFA5A+UuPgO7NZQhCHBaSGf6O7+qx1OapP8mHzuS/3cSa1o3gZwFXaO4ciD7i2XsNp8
	OXHFdOQ4fvhiaJQyRbJQCRxN+mFwbGlaV67vkQJ9Ze4ZT4Q6rC+ry+kWNeoNBY/wZUl0/50uSvm
	ujaGIU96I1MYdwsM6peRSnKCZDjKSoSBQ9wd0bGo8giq6aTcA5qjTuy1er+VvC19svl3auXRqkD
	fbpp9StZSYdhls83lupEtdDnSRcDxTyK1N4o9vPuPhJkbAl4XQF2Dvd+GxacqK23YankJjNSXHf
	QNNrl14TrV/+WG9K+Q8sbi0Y5zDOYA6Ulqf7XJTpJzyyqr7kSXV2BLXVKOhPdkDDqVuG1t41Jgq
	v2brmmutL9mtj0xgJPCj7aR4jq
X-Received: by 2002:a05:6102:1a09:20b0:7d2:7c63:5a0a with SMTP id ada2fe7eead31-7d27c6373f2mr1005746137.23.1793830408953;
        Wed, 04 Nov 2026 14:13:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm2934001241.12.2026.11.04.14.13.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:13:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Wed,  4 Nov 2026 17:13:20 -0500
Message-ID: <20261104221321.1200529-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104221321.1200529-1-luiz.dentz@gmail.com>
References: <20261104221321.1200529-1-luiz.dentz@gmail.com>
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

The default MIC length applies when the connection did not request
one: to LE Enable Encryption v2, LE Set CIG Parameters v2 and LE Create
BIG v2, so ACL, CIS and BIS are set up with the MIC length the host was
told to use.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  7 ++++++
 include/net/bluetooth/hci_core.h |  3 +++
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_core.c         |  3 +++
 net/bluetooth/hci_sync.c         | 41 ++++++++++++++++++++++++++++----
 net/bluetooth/mgmt_config.c      | 33 +++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 41bd2482614e..3bda65f6998b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2658,6 +2658,13 @@ struct hci_cp_le_create_big_v2 {
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
index d08bca919793..d05ef2cd413f 100644
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
index d79aef0c8468..9d9f5b47331c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5415,11 +5415,40 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
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
 
@@ -8463,7 +8492,8 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
-		cis->mic_len = 0x02; /* Always prefer 128 bits? */
+		cis->mic_len = conn->req_mic_len ? conn->req_mic_len :
+			       hdev->hdt_def_mic_len;
 
 		/* Use the rates of each direction, or all the HDT rates the
 		 * controller supports if none were set.
@@ -8574,6 +8604,8 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+	cp.bis.mic_len = conn->req_mic_len ? conn->req_mic_len :
+			 hdev->hdt_def_mic_len;
 
 	/* Use the rates set, or all the HDT rates the controller supports if
 	 * none were set.
@@ -8644,10 +8676,11 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->rand = rand;
 	cp->ediv = ediv;
-	/* Use the MIC length requested for the connection, default to 128
-	 * bits if unset.
+	/* Use the MIC length requested for the connection, or the default
+	 * one if unset.
 	 */
-	cp->mic_len = conn->req_mic_len ? conn->req_mic_len : 0x02;
+	cp->mic_len = conn->req_mic_len ? conn->req_mic_len :
+					    hdev->hdt_def_mic_len;
 
 	/* The key is zero padded when shorter than 16 octets */
 	if (ltk) {
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index fdcc752c6f13..f30cffa94fbf 100644
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
@@ -201,9 +215,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -335,6 +352,15 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -344,6 +370,13 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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

