Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904297;
	b=uWUR6jHZO+B1ZSwXcTg983xSsIuL/KvsgOTB//Th/5TK+TSHzX0YNZUVj42uvsGg83/S
	 VYIb9psNajkjhQhm/HnumrdgLcRKZGHEGpndGvNPKLljUwPiDtTMXAGtJPWO0WDBl2S1F
	 3INl1ODEsDlr3J4ZmPBZSSBZedItfguEmplxy/I2A0ArY7salVRftD5MR2QEn31uL3DQn
	 K/yj3ZAZC0PfvWSYiHjDW+f/CV+zuI+BJ0g+ZwebBuD8gf0dY4LC9L4X9gJSo9hx3EvwX
	 m9O6byL100hlsGpTY1EzUJgZzrOxTD/5qyeOjNKeOvJAuFnMxhYCJPem5qTfk3GxTiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PCoaCpNFuC3wGjXQhvXKQ8jE1/V355k/M5DsxRhhANA=;
	b=eVJmboMiFM4yEny58a7A5wsjbunkHRE8Fmsvx7fnXp8+WWEAcUS4AFlUfq8rDX+IfWEI
	 kUludPoobmOKnaH+8f2Ca0tl2i0o3XRIaxSASfNDj8Iwh6oV+TRRmHTSXJhefPkVXuAot
	 L3Oy/n62LD+xzt/CuJpf8eqbgq1VHZ6jcX5Jhi0uqs6A4p3tTHJra5X4s9pnkMDFEg/mG
	 N8XlcWvVRvVPzllpdfLzyU8dQFToUZCu4IMCt3j3mGK5h0zUuj6Ku2ZxUVIwVEWABBCfk
	 nr/t225pFRhDgkuepY5cSFV7M1W3t895Z3kSiIevsCoX9hHxoTBfwh3Z80EpFT88+Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9a7iXKE;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F6606D80C
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 18:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660F6606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9a7iXKE
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so855765e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 10:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904296; x=1794509096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PCoaCpNFuC3wGjXQhvXKQ8jE1/V355k/M5DsxRhhANA=;
        b=J9a7iXKE9Lp8YIi5xi/cPbo11YJbrdMEqlwYm4AcgjAZUof+SU/6Lx+EY35wEsGeMH
         dGUkfsdAHtlv2yUeQZaiE7DRzOBfaf+3Use48FC6sdacmPlU4XvwVWu/D5fkAqZcfeS7
         /VK69bTg6WDTr1TX3Oxbd9+icpHU0M+9dyF/J+wFtDA02UKw+LUmJ3pxhNU/2cacDhns
         V467Q3XuAugDmEQWFuHrNW9aYf/G8tMeZRrJzIRcUQrlO+C+ppfyfdXviwUWB43gHtPy
         5AE9LPfRAOlB0tg/MY/QVJd6xMP/GT6TvVb17PWpAYRrlnsgFb6r5QMC+O1PxcYy51Ew
         iTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904296; x=1794509096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PCoaCpNFuC3wGjXQhvXKQ8jE1/V355k/M5DsxRhhANA=;
        b=IpqvO6LX9AGvuwOiceiOoJzi8s2kavy9ZyCz3bPuuGzd/PEdl4O2FBRcbh6ufJKsg9
         gUCPiz6DoC30Mi4z4cV4E9u2lomj+XQkg5XPirfnkWeMVOVkTqBOIuwRsskm4Ra4RFQW
         b0190AveL6Ax31djzQpffk81mjQwpiH62dhjSWgic+JB3aGgIv6jF5GrS0uXREpCwSkz
         kPMbVdOzFOSiBXBYW3PTIvND0uPGT/dxxgkxnmAOmE4WcXS5qQ3x21gO7O7s22khf3ZK
         JEOvNjl1aLwdcMI7qDKxHzZQw0kAiwmXpVZjFvWYKbnpEEMepRRa3VdXii1Iu2AAh56L
         H3Pw==
X-Gm-Message-State: APuU4Z8jjv/tfhQxloaanpPsjE1SpRX+FNlnaoi+bHO/D8i0FYjYKt0q
	2KdQ2adesc0l2ub2KD6oBpaimoKgAdhGn1tTZOfIww8RadJEfZFNJ6hqZpl1gA==
X-Gm-Gg: AYBFou1Z4InlpgDjkrWc19wJIjJoJ4IxNJ+vypF4VHHRK7go4ygX1pOZY20dHg/MBU4
	+KqZX6XLiOUcz3jfa5WJpzOlZEAUJd4ON2m8B1ryHEQ4qtIKhatjSZ4LzCGBKGdb5GTZYL/CCuu
	pCf0WZaar0P5IF10cj9yJM1yIcwVv+3oGucRN+7kOl8ocpehazQo7t0PTTlNITR/I/KERc6WEOf
	+ZCBXwoGDHcYmNmAxBvHPx1h/paHwsDMvDTh/atLcSZXSuAg+WAx3+tNGhF1Sxe2MJZp7LOmAD5
	G/+2CFMbGVXOXbyBAnkWXfWSKpFLDXsRdbj4Cu8YBvbesr9SznJ5xqYytS009xzqKvCMXP+WQ5j
	JImSyDayXUOvtapHMRdDi0L+QcWVxiCwZHfz22yK8FkTIZ8GlXGa2XSUTKIXUrzBFBcc1wgW+b2
	RMisdKRkh0hmxiLq5KVUzGO8Ao9tJcapj8coyMpLUYtGN62mhH8+QSeXzuh0xn+6J1gOXND5A3h
	bk9w7EhGiGzxjGW2fr7Ed+dOHMr2p8zm+CWI3Qg2JYgGBPsGZngQLjfWzLQ6J2ivrEOIHKlCdzp
	LtPSX8JKt73hffxH+azVKY2bIglT8TSrb89RvAuWvjho65bGgMobiyHtzrRZfqbSCKljGkIriRG
	DAYSOw/cBmLy/66A9WdqpRfZfVLFn4hqr2FF1PM8hjcOA9J/NuEdpaZ58Hn+zQ5lSDEzc3hPS6L
	LncmU=
X-Received: by 2002:a67:e106:0:b0:7ce:a840:b86b with SMTP id ada2fe7eead31-7d2a159319fmr318220137.17.1793904296102;
        Thu, 05 Nov 2026 10:44:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99baea8aeb0sm12182241.9.2026.11.05.10.44.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:44:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Thu,  5 Nov 2026 13:44:48 -0500
Message-ID: <20261105184449.2149626-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105184449.2149626-1-luiz.dentz@gmail.com>
References: <20261105184449.2149626-1-luiz.dentz@gmail.com>
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
index 59db2e2668d1..81afb84087d3 100644
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
@@ -8673,10 +8705,11 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
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

