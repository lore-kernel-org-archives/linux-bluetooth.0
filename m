Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744373;
	b=ITt3hoIjXcGVc1PUr/GuhsjwTVQyzM+2LNaoLPy5/qpE22F2fNdnXEU0U90CBW+r+3nO
	 /wCrn6ttCkBN/UFVSbRo+KGBLnBrwWgxQPWpXnKh8YJKALGj3eh6NCj3+SF41EXpHRsPb
	 uMW7nOVdS7l6ntkT05YdZQ2r9ncbw0fezb8qeebF1inG/gC9JegI1EGstyehRxf09Bhib
	 rcIb5K4/pwO/BFvN4JGnl/hgd0qC5AXTSOl1fmfvLcF68t83mJDQYPBhY16Y6tuqccd5X
	 XHp1jVoInIr5nwc3oXpQH9xqprmKjTocOSxwtb6OQ54uedftWYx/Pq4TfPA30XiuG2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BALpfVn/s3bvBVjB5thGqw1X33Eu/qPh0v/sdn1yKjE=;
	b=M+2tHN4nuy6qAgqajP1ms6naLsmzgLPnHsg/dB5ngZaZFvq2Gm1e9F7LceabaNOEPBrE
	 EfK7eJUde3nEiqnsQUBek7Vn0V4ISBZ21BIhUmZFc5tViOE0KqwjMexvKx9xuWZlYqOPh
	 XSRkqI97B+rkDtcbrM0zro1XBq4RLnEwjpgEdOgx/tFA7kZoebIeNIxTD70ygpbSVl46X
	 RxKpsmNAADlJyr1p/dSiEHIi7XDLSFNLPdr/W0OEiEAFW7ZJ/lw9iRZLMmKU8B2oUuUv+
	 o3OPRpWZ4swe27nGryBBCSE4QFGLgNyEZzzd72p3J/eeD5pMdG4UKmg40WSqsHkau7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rY6dMHjq;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CB606A331
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF2CB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rY6dMHjq
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-99806b7d89aso801522241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744372; x=1794349172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BALpfVn/s3bvBVjB5thGqw1X33Eu/qPh0v/sdn1yKjE=;
        b=rY6dMHjq1MTfgdJAwilW3N6YoLI/X+qZLff8ThZ2Y2Ya9GBZCnlB24DhDM/cdaMAtZ
         NMq0/7axFoNwM+8o4odd6sEMAA3s2r2qNa0ejI96q9OAsJRxnhdRbV1VjZXDa/Wqbei0
         D82yz9EqujLEBXDoRtP7Hd0/+zXa8GKnspiPRvJ1/7dhaVmHc0t82XdfOxqr61YrN9+g
         qeAaIt+QsdYJNySi7vwaAsDjKYWk+iabDb6nVDlikE7YyTPZX53RP8HY8w/5x/ewjiaP
         hvQb6yeNkQG6UOk8/7Gs7EMClQpzH73uknNua9lpMDigJVTsViYTgjtQJq8bCTtQ2FWQ
         s6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744372; x=1794349172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BALpfVn/s3bvBVjB5thGqw1X33Eu/qPh0v/sdn1yKjE=;
        b=R6+GhWQyaJEaICLKuRX114WpDT+jEsrUszYrFUE6pKyA+V/RhcOT5YGC01lm5cRcCG
         9Blpr3xr22PnLiaSIxLixREdIn09uedtMCqi/C9pnTKINROdcTu0i9TGX8apYpgKai+j
         pMmZNmaMnPSujWYWjj3IbPWI81gRjtb5X6Kf8Xrrv8upP4D8jQ/Dig2faxU9vr//oTmW
         7SOc3pq4Z7e0n/trmJv8COgTvWgDZ+8oV5lmIEAHPnIcv0TsLxgjTh8RY9716oVKAV3J
         +6knemAjd3XMhJM54/IMvxBMTgzuZYl/gvXSd8+UsVV76xc8v1h3cM5feHWCsVdfVHxy
         fCMw==
X-Gm-Message-State: APuU4Z89tfF2GYkgwe6dKuUfFD8JKbZsTINy8c7vddUqsvk61Jv3xLty
	q/MQXv2a0DHmmhO5soa1ngPfFqF++ccsRrAs2xY75etorrHXPmg5xw6GVCeymA==
X-Gm-Gg: AYBFou1YlZgHtB2iUp9E0sHTV56hiPiGQQ/vwyQMgjVnyGbH37FZi8pff4yjHKByGyf
	ajGyC3lD+5XO9+GjmTLdAWSPiYivdagYg/8Vc4loYg7LCevwAiaiVTUbaSXjFLiijiDu6s0c3KI
	cWLSYvOdXrI8eHdRKqayGiDtOHm7Y7fZkyUiqqhrrPdqcIcatP303M6iEV87MlDrD7hbp2WSvuv
	yqa8xtBe3lWOCryPJMYYB30IZEdfQo0TJ66nbPnPNbJWVQ6Jucj416l2UVzs3qOpR6pHr9/5P1I
	sqqHUSSXvV8Twqpagu8laP1jAaqLTgz6wBGCaWp7dVySodPRi1LLqiVe30fJ57+w8oCqq9vETor
	EDfSF5AUdo0dwuNuWC+xGs58mbxSf4hlvFI4g3mkdivr5JfTflClASWIHZ0sSOpVWefmBQMeY5P
	HylC0Jz1gGhQg+HtFmbmufNPUyfbouoQcmj6pOhdnTMYtPShAMqwfaKVMfFPtUE0UEvGlY4RKbJ
	75hzkEVSoKan2hI3c68aw5XnLHV0oyUnqFAUb2BdPXjGGugW0RlOKsgPrmB+0NlqfE2n0Kq86wa
	Moz19Tw4dAzAvxLxxsoeWWqei7mF5eI3b1cFSgIMNQRY+0PcPgOh0paVuyyEswV6jx81pCkQByx
	WOWnPQfqqzfeVJgRXKcYM6lmExxToslXY58nmRdSXb+mfheY04sD4xaX1psNqpwA9qTRus/Rhrh
	ZynJU=
X-Received: by 2002:a67:e70e:0:b0:7b5:8fd9:27e9 with SMTP id ada2fe7eead31-7d07277d30cmr3556395137.2.1793744371746;
        Tue, 03 Nov 2026 14:19:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
Date: Tue,  3 Nov 2026 17:19:20 -0500
Message-ID: <20261103221921.4071765-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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

The default MIC length also applies when a connection did not request
one: to LE Enable Encryption v2, LE Set CIG Parameters v2 and LE Create
BIG v2, and to the L2CAP channels, so ACL, CIS and BIS are set up with
the MIC length the host was told to use.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  7 +++++
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         |  3 +++
 net/bluetooth/hci_sync.c         | 37 ++++++++++++++++++++++++---
 net/bluetooth/l2cap_core.c       | 19 +++++++++-----
 net/bluetooth/mgmt_config.c      | 44 ++++++++++++++++++++++++++++++++
 6 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e9bbd687b12e..af8a20682e31 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2664,6 +2664,13 @@ struct hci_cp_le_create_big_v2 {
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
index d1c6ae23714d..def547e1b7f1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -433,6 +433,9 @@ struct hci_dev {
 	__u8		hdt_max_tx_win;
 	__u8		hdt_max_rx_win;
 	__u8		hdt_max_rx_packet;
+	__u8		hdt_def_mic_len;
+	__u8		hdt_def_format;
+	__u16		hdt_def_rates;
 	__u8		le_max_key_size;
 	__u8		le_min_key_size;
 	__u16		discov_interleaved_timeout;
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
index 5f743cf362e5..b2b1a553e7c2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5412,11 +5412,40 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int hci_le_set_hdt_params_sync(struct hci_dev *hdev)
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
+		rates &= ~BIT(3);
+	if (!hdt_7_5_tx_capable(hdev))
+		rates &= ~BIT(4);
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
 
@@ -8431,7 +8460,8 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 				   qos->ucast.in.rates;
 		cis->p_hdt_rates = qos->ucast.in.rates ? qos->ucast.in.rates :
 				   qos->ucast.out.rates;
-		cis->mic_len = 0x02; /* Always prefer 128 bits? */
+		cis->mic_len = conn->mic_len ? conn->mic_len :
+			       hdev->hdt_def_mic_len;
 
 		/* If HDT PHY is set but rates are not set then enable all HDT
 		 * supported rates.
@@ -8559,6 +8589,7 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
 	cp.bis.hdt_rates = qos->bcast.out.rates ? qos->bcast.out.rates : 0x00;
+	cp.bis.mic_len = conn->mic_len ? conn->mic_len : hdev->hdt_def_mic_len;
 
 	/* If HDT PHY is set but rates are not set then enable all HDT
 	 * supported rates.
@@ -8636,8 +8667,8 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->rand = rand;
 	cp->ediv = ediv;
-	/* Use requested mic_len from hcon, default to 128 bits if unset */
-	cp->mic_len = conn->mic_len ? conn->mic_len : 0x02;
+	/* Use requested mic_len from hcon if set; otherwise use hdev default */
+	cp->mic_len = conn->mic_len ? conn->mic_len : hdev->hdt_def_mic_len;
 
 	if (ltk) {
 		memcpy(cp->ltk, ltk, sizeof(cp->ltk));
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4abb4b28ddec..73712db05e14 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1030,19 +1030,26 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 {
 	struct l2cap_conn *conn = chan->conn;
+	struct hci_conn *hcon = conn->hcon;
 	__u8 auth_type;
 
-	if (conn->hcon->type == LE_LINK) {
-		/* Propagate mic_len requirement to hcon for encrypt_v2 */
-		if (chan->mic_len > conn->hcon->mic_len)
-			conn->hcon->mic_len = chan->mic_len;
+	if (hcon->type == LE_LINK) {
+		/* Propagate mic_len requirement to hcon for encrypt_v2.
+		 * Use chan->mic_len if set, otherwise fall back to the
+		 * device default HDT MIC length.
+		 */
+		u8 mic_len = chan->mic_len ? chan->mic_len :
+					     hcon->hdev->hdt_def_mic_len;
+
+		if (mic_len > hcon->mic_len)
+			hcon->mic_len = mic_len;
 
-		return smp_conn_security(conn->hcon, chan->sec_level);
+		return smp_conn_security(hcon, chan->sec_level);
 	}
 
 	auth_type = l2cap_get_auth_type(chan);
 
-	return hci_conn_security(conn->hcon, chan->sec_level, auth_type,
+	return hci_conn_security(hcon, chan->sec_level, auth_type,
 				 initiator);
 }
 
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index fdcc752c6f13..f5b37b0cd975 100644
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
@@ -140,11 +146,30 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 #define TLV_GET_LE16(tlv)	le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_U8(tlv)		(*((__u8 *)(TO_TLV(tlv)->value)))
 
+static int hci_le_set_hdt_params_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_set_hdt_default_params cp;
+
+	if (!hdt_capable(hdev) || !(hdev->commands[52] & BIT(1)))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.mic_len = hdev->hdt_def_mic_len;
+	cp.format = hdev->hdt_def_format;
+	cp.rates = cpu_to_le16(hdev->hdt_def_rates);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HDT_DEFAULT_PARAMS,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
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
@@ -201,9 +226,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -335,6 +363,15 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -344,6 +381,13 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		buffer += exp_len;
 	}
 
+	if (hci_dev_test_flag(hdev, HCI_UP) &&
+	    (hdev->hdt_def_mic_len != old_mic_len ||
+	     hdev->hdt_def_format != old_format ||
+	     hdev->hdt_def_rates != old_rates))
+		hci_cmd_sync_queue(hdev, hci_le_set_hdt_params_sync,
+				   NULL, NULL);
+
 	return mgmt_cmd_complete(sk, hdev->id,
 				 MGMT_OP_SET_DEF_SYSTEM_CONFIG, 0, NULL, 0);
 }
-- 
2.56.0

