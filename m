Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002268;
	b=iFd+eRDVStpy2wutHQnInuMZtExXZRfnsaIJfiPa+Tyyk+bnyp0rK8X3Q4FCJwqc+S2E
	 pcSzVA0BojJVtlBxKToNd93ob0P57kCYsuSSXlyGyAuUg+mamJtGTQoDQZH8EP5MSdOLj
	 vE5YAiSIRf8X15c/mQaHu5UAatf9qpmcojF4oZe8E/v0eRzcyWz17PSorurSUZXHKcrTI
	 q8GRuJdNTXQVhbgKHbST4/nV7YMJZ4MXCY2sAA+GUVXiP4eAbvKNdJyab+3ERpu29lXcN
	 qKZRFntyNCJPkcsjlp42FJtH9XSly0G3pFW8O6bk5b7CK6Eb9uoF9HWC2pTmp/d55Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2lvpSgHXqljtzJ0pqCXu4BYnAPezRm45DqfX72jiFcg=;
	b=QewLXekMXa09scXlS2Kf/2v5CkA8egrsoX/cWW/pYTSyiQCITf48GLzEgiXiUAYRqqyA
	 AqTLXkK8EyVG0ZzVRJS/jm/INsxnnXJgIZuHx97/HD32arqwX/6x6nlOsIxq8tatFvMEo
	 DfkIkKIkZkHknvyCvVn9ZUT8VzlU/W4fcza9IbQiZYRwthksnNdngPMaA/bEEDYUyFXIh
	 ftdq3Hvt2PAV9r/nGvICakZnDCiBMfBTGposYYHIYtTlm8/3LCDSoitUmnn0eW3n77stV
	 dKNpZMjny+ecOwU+ENs0zDoFZyZjjJ5wTcIl1OxOMdNxtrTFDTDDFmZGP97Du0C95uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMh6t+eW;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912F606D810
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 21:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9912F606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMh6t+eW
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso485994e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 13:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794002266; x=1794607066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2lvpSgHXqljtzJ0pqCXu4BYnAPezRm45DqfX72jiFcg=;
        b=CMh6t+eWTxiX2mLqczQF3vNMjJKJAE0IKwBToshd0rNyu1aB2s92yrZKmqzYXal0CH
         tBBGP28hH9x7BlINUzUbQTKW1ku1eUgvd7I99ZwstHTdslH+RZtdGwpOFfH3mcYe3WYx
         KdpmMxXrL3Fre27QrHzuCZFoo/zIyfDG56tcd4gaqaFrIeaRGdrsGjdcGtAiVHID4oyY
         j4VGLgjVbZhe3KSyzPE+CGJVqPte03EmlWtqJ3/yGwaM5uLm99nYh/2O4Z699frXA3Bz
         O+nYRRJfGVKOT2u9pYfGkjn/KTVVB01MMXEfTvQlM/ufkyGj4BFD11BTeMHNjZkT0kzj
         wX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002266; x=1794607066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2lvpSgHXqljtzJ0pqCXu4BYnAPezRm45DqfX72jiFcg=;
        b=zFpidjgZHmcC//qlrfsL7SKVnKtuALIXUuYD1UZ6w5CbsKSYcqppIh3PdV12yoW1e/
         ILxtXkw/C3+jE9lesOa66e0Jws3Ht5iTZU4P5iN7limjwSFS8O71LGH788j6p+TAOyYr
         gd6h0A5Es5Y7nhqv117ESp9vXzV03/Pr3PWAfgNSFMu1oP6tBbAlxCN2HbpwbX1zdaPM
         U5YPNHZr6FDb4QoF2ieJomHQtYNgA3qon1VcjQ9p3YFcAaReplTiCNcmerOzIwl9AL/z
         KVYXBowLcUws2XNo81lsXI1Wl4AACqPQ6YfV8GPtPnwFe0qQDl1nMAeogTzKaAa9Eta8
         t7PA==
X-Gm-Message-State: APuU4Z/kBaEzDhjJ7lezco/ZwqMSWP/FZoh/ANQzuCKQfBYXi1V1GhOb
	e/7mt6A7+kTFoyZPd0x3UElHgpwxz3TvyOKgXykbEmSjxytV/1V7xa21ouPSaA==
X-Gm-Gg: AYBFou3xmbk64P9w1mdQSAAuS3TpP/jW0ehGpchFNCs0eSB7BAyHbPdNVfmXhYeBCwT
	Ogt/Hu0asGpt2ha1qdlfXoK/fQhVO6+kTHJMaJgs+lIaxDoGYmHhhsoaDbb/3s4emVnvpuCiGjZ
	P970b7aDLnY/PGEs4OtsZFjcCJlhNUT7d+WZqrESQq9eJTPiKZu3zB5/IUY5kyIg9ylC8N0QqGI
	vyOV+Tk9Skc3/cgmLdTfTAgmRTXDLZ1HulAV4YKug0f7+8LBjHdJCJBZ9UDrb1DtxwkcBr/5NVg
	gsG5Pq2TFZRHqllamnyoqRrGRzGJcUc6Q55sC6INDcZtt9nGGYGc2X3jyaovDxmbRyn/Ytyf10s
	JpHxXY9+4qfsW71ASp9eQj4zTs5iYjIMLK89OYQhQDaqNSJmaCDi5m+vap5CIe+R8pQBiRVH2J8
	gFFaWFzO9Um9y7gDafZFnyQx/yUk6tnIRRAa+VFr5DdV1e2fV3x52iLaiw1HppFIa+3hYpSwnR5
	J6Qj3U7F/y0OENzm8S1XVgvvEeqRoCCGWrWYnOfFfzieiYf3DWbPVw/rjwS0XqSw6Ao0KcmXUaG
	Osfd0Yz2egBdjvgII4Dr+s6LKjr2tQyzfkus/Vb34TD3X+ldGIuoVYP+WTRP4x16+FKDtGH84bj
	IKWtECTTZDcjF0NKdqkY5XqwG0jptJLO8SOUeuChZTzHNi/K0nVlJEF23VFazRalPwhodithFaa
	OZvpw=
X-Received: by 2002:a05:6122:4145:b0:5ea:b1f5:a657 with SMTP id 71dfb90a1353d-5ecc43a49c6mr1784920e0c.7.1794002266378;
        Fri, 06 Nov 2026 13:57:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6103sm2542570e0c.6.2026.11.06.13.57.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:57:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Fri,  6 Nov 2026 16:57:37 -0500
Message-ID: <20261106215738.3562688-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106215738.3562688-1-luiz.dentz@gmail.com>
References: <20261106215738.3562688-1-luiz.dentz@gmail.com>
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

