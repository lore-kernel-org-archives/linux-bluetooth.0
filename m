Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981561;
	b=uHB2BwbpammdiiKZcp7slQDy35fS4gn0DgB/2pH32qhdiuiiDCEUY0L4N7Pr48wBpwE5
	 LsalypUGFkWEX9DUA0wN5o0Vw9Okk0+5bX9M1b0L1D3PEGbkxP84hduISpI70dR4Fx9go
	 iHubjrekbBYvtshOcGT6Sca9e0p2MHNeZB95hDn8Ho19JPJ4zaqK1mzEbOTG618hOkr5L
	 U087Nfp+vSCFx3A+DkASnJYp0ApZPRONTSoaMqDJjVo6JCU28bIxIvJCn49Ir01nDEjeI
	 rxl5+UeQVbfpyNbXCral9nI641fMhAZ5+T1CAqJ3zkvYb8LiQi/cuIEIJYb/geeGLzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y4viFnMFF1In3L2b7ZzGsu5StbQoBH8wkN1KiDkFJBs=;
	b=qOQUmk5ex7W6w7XFozQkWDCSqV55BRFYKyf3yUmFWzX/FD9wlzT2FvZUbpa2xTSkafkL
	 rUVPf0VOsnjh1XyfbVC8sIQ6dRCL9UVyorJAA8+In+f+R+J4j3JfzUCNG4xgt1jRzxKhV
	 68c7/MFbsuzZlyLCfTjEbtkVa/QnCNm7PNYzR+CIOp5A4YGsLqTmsWfh8qUZ8iJN5xKkv
	 B7+zkysA0kDKUpC4rMKB7nGBR85liiobbzk8DwIn4PbTf1Hxju5aKZ5r+EJlKrVy9ayPL
	 fZjzKRvVycjmjrbc8/4CNH0YJETh6p5+wkw4ApWhYghqXE4rd7OaVDdqd4+sRJxJdOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iMlGYUCJ;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44812606A983
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 16:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44812606A983
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iMlGYUCJ
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafb65e169so538356e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981560; x=1794586360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y4viFnMFF1In3L2b7ZzGsu5StbQoBH8wkN1KiDkFJBs=;
        b=iMlGYUCJt1UJHh4XRAdTolKRuDFbNTninXZji+zX0qCwaF24bbts720Ts7pY82OEAl
         Vo8az9H0QK81opijQp6hE/ArILMdoKhY/OeBehugVcDRZUY6de0Xr7HY1Gx+3WY/1S9f
         GTgiEUp1AwT9cjk63kh6myZOOZtSZiUdA0ssR+Z4/YYmb/lZ4rly5uVMq9OdcXlqaBUh
         F39nB78azEoSlfBMmJm9XgjvIjoobya9iI2oAErycEH7XrzBi+nmP09QD0vVhlJNHUe5
         hSsCscejRV52yKARdVOdpL5BOUginBY09ie9FDSLEGQTbeB6Ua7fHyGIfcYPllwyNLRS
         o8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981560; x=1794586360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y4viFnMFF1In3L2b7ZzGsu5StbQoBH8wkN1KiDkFJBs=;
        b=IYPWV6M3ZHiZ1kwFhyBVxasYSNoF/M/WYXuEQP4E+iE4NY17f5Yb7xEN7aJjX+8Wov
         yPRWSaqh2jXXnlUdE0qGbCLPDJcglMhDtfiPMhqZsYlAF4h5JPDAjfY9d+iDEoQhLvnA
         pA/DdtyuUSl/WLPllx70cqSjoDgTVbVY3Q4EbJT3rFmyKhe1zJ+0AyCi18cqCnfjl976
         YH97uFCEGPUTtL/vLWZO50Loi/BAT5Rn2HYYrtg5vsUGeOzhXBTapEsbkmjcR1tBhjnp
         zMg+z3uT23wxIHZnZK1h/sGX24AQ0aM30Ho94Wxg7JJ3suFEeP5pkmEEO/kEtLkj5EKS
         SC1Q==
X-Gm-Message-State: APuU4Z/3RUdpJLFxxTrBr2Il/KY3F5itiAwr+TRf8TX+yS+gY+QiLcOE
	EPBIPszE0Lf7jbOWY5z3akt+PTZmGS29v5jc2uC1ix3d1f7m6q1WI8J7Pm6v2g==
X-Gm-Gg: AYBFou09nwsIBL6do3h/nG0trHvmq3vfUhBImEFVD7WtZsfcsczRIOJlHL05N9Lzm/k
	IRTY8QjJSpWTM/2GcB2PUR6xCETZJyD6p/qIRus0tm3l08d2wKTzdqchVfc2McGvSutx5YeITm2
	DMzTQ9sXeAEVLmGKcfP/Aw84tUGT0tuZn+a5PgPJPSYvvPotHuhB5XSx7RRdGu1cM5v1s3v569L
	rOmRRJV+ZpiLUHO/Y5ZkNPxP3i8bXI3y28tshNQnnaw7LXRkjgK3uyUjl6ugT8wWtd8m1sgxHMF
	B65jNmnD9VJoRt3y5WUzcTPb4eJ/tMleyFernIWdrWklI1bfgDRnzbPFpKglDh5JhGnyibNLP+o
	nyWrFDBvvNwUzfiT295X+pKvLQUlS9QdK2h5seEOJumgRE7HRceOVf2rJm/C/6+De7zjyEASfda
	x6mzLsqAmTorhaI1k/2ujPb+sB9Xjo5GS2WS6Gl+LS74ba9B5AAFyPKPmbniG5Mep2Ni/qvUbiO
	FjTuRBGdOTUokwq9UvNueexD0mT7w6AFwEzqOFyIJueqfGpXfngp5HmXvH+te4bdD841/2+zd7f
	NKZXz7RbrX2Ln0G5mQgl7/FEQFtkahtjhNFD3LhSKMSw78aox8olnsqqDUupMzz+euOHVkIRu6U
	CK7tEwN0VF6++ipeBoGYG9PZOolYb5faY+prlWc9ClPitrQOwxLfh8/qEozZIy/eJ/2QdloxsZ3
	nEo0AA
X-Received: by 2002:a05:6122:54e:b0:5ec:a9e:d80f with SMTP id 71dfb90a1353d-5ecc43a51f9mr1604371e0c.8.1793981560058;
        Fri, 06 Nov 2026 08:12:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ee921sm1689697e0c.12.2026.11.06.08.12.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:12:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Fri,  6 Nov 2026 11:12:26 -0500
Message-ID: <20261106161227.2814291-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106161227.2814291-1-luiz.dentz@gmail.com>
References: <20261106161227.2814291-1-luiz.dentz@gmail.com>
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
index fb4f6735f69b..236dc531dd14 100644
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
index fb6683ff7501..1df331bc09ed 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5418,11 +5418,40 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
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
 
@@ -8466,7 +8495,8 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
-		cis->mic_len = 0x02; /* Always prefer 128 bits? */
+		cis->mic_len = conn->req_mic_len ? conn->req_mic_len :
+			       hdev->hdt_def_mic_len;
 
 		/* Use the rates of each direction, or all the HDT rates the
 		 * controller supports if none were set.
@@ -8577,6 +8607,8 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+	cp.bis.mic_len = conn->req_mic_len ? conn->req_mic_len :
+			 hdev->hdt_def_mic_len;
 
 	/* Use the rates set, or all the HDT rates the controller supports if
 	 * none were set.
@@ -8658,14 +8690,15 @@ static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
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

