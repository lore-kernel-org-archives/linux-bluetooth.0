Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265A3C1D68
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339264; cv=none; b=emxNq0PhS7nbRPm8dSjixwg9cC07Nl+1esZg/PoTKxJdc9d7C2pgk8Fs6VwVMT5aLpjWgG6IH8ax2DKHGvtyZJQndqe07CV4jTkePbQhK3fvmSaMjV4cnDpOISHs+tZ88MlWd06iClZpVC3xFXo4qKdr4Y3yliwb16jIIAqH5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339264; c=relaxed/simple;
	bh=FTSfYdAkm6JyzUIkyx48kt3whIeNH4LhmPGKgdXghc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rORx6VkMyYy+5cah5dPsU9KCJkBV/vd4FxdQ3gydFpxzaAbHGR83s9u3tqD0izj1rkYxQX9uME50SWv4UZTEYJi/Dm8aC/zgEi6JRUDjPNVWbg7B4lfmzA5FSsaysWKpE4fFrwcOkocsb/Ho7OkyygD3UstvzUehwf2zp52CFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1ZSdkDO; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1ZSdkDO"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-977310532a7so3603241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785339259; x=1785944059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dT/K8BMGY7PDA7PBhGefPkvkqgW1HPdsm39Oo9PnaX4=;
        b=P1ZSdkDOf60mjX6o7f9KxPv9/QN58pXkuP6zWeYC2mlj/XcDLb/jwSc2qsTODqTaw8
         lpgsXLxTZSRt2OiTW0Zn1VPNFoZgzIEVR/t5NjD1A0ThBs8zhtRllgZ30764L+dwcT9M
         ++FvBrx7T1asHE0GlvZ9pP+rQ9khPLk6JQgxDiOkexjMATW3YWHdWWx3KE03zV3eVXus
         uTu3ybZ/MjpkDSRvMdgWFwlpxP8w5r9GmNyBFFenqVItCPQVZ/5fwvIPgM35fkHMLvKC
         N32G31mpxQZ6QKMq160CGSs1xrzbSFQZjXBv18kN+APkqKP4RZ4sdWbl7qs2Ez6jsajo
         4vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339259; x=1785944059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dT/K8BMGY7PDA7PBhGefPkvkqgW1HPdsm39Oo9PnaX4=;
        b=XeAxXJ7Wpa0JqDpV0HoU0bl7AVVS5sLdbjiSEqltvK7QxTAlbxawLZkaOEkfUdLJ1A
         4X7YvWymzx5fd889do6sfhgxTsBBawaUuEncsqGcgw9V+u1eHYm/I3w3oxc8GpuNys/D
         hu7Wvl2UuLlehD9TDT3H5WkR3+jpq6XNoffIIi5kE4UPLnEJUrUtOXD/oPJAP/VNt2+o
         w+JWB0Un6x4fuNSni/C9NylVg/XEyVwhxRI6q8PyT40vrHRYNMdxcY63iwwsMXpQz9eg
         JGStaZgXCK8YzBYO8KR/ymDehoiC5wJSk6QTXVkJkaixZ2Q23WZk8wOW9wLesABflS0Q
         nHEA==
X-Gm-Message-State: AOJu0Yw2/Hhv/2wTO4jFVLRMAimddXTi/EjtoEXVKOOUwWSs8D1CjpqF
	lZQwxOVThbIXU6mRDvTxJCGrQ4bqQyCuKreaFZZQxIkpof0GoBVv3vVHwca6EcRA
X-Gm-Gg: AR+sD12/Swqijz1zF7duN6Y59jJKmmztF3QwYnHHKNnoIE0F4T4KMEBUx5jSw26mM+2
	mELBaQooEmiOg3nu+RtO4uv8QXiOGTwNO+TU9FnBn3gJp7s6z6nig/kkQj14SQ3ec+hTmb3C589
	HWI9p7jtEUg4xnRIaTlSuIZjMKRwBF6KjfxVMxIUgbCps2Sk8GWAa1JFjugCc1mSbNjEGKRxUYP
	R+mHFCUxqk7LJ4i+2sRCcpubD0AuPQOL61QJEyTOHt5EGkwcN9FYGs6V7ox6yLpN3zYFeoCR6rK
	9L1FGT6oFBgPVnBtfdt0RoGtrXGdaQJThTAApNqtqOBDkUrv3hC6p2gJ44TUoi/D0fdDCkPZHuD
	Ni601tLxje2SkRANgoGUlFPKN+YMdTEhJsn37G6iTSLfSu36KWPYljCk6zvM7Hbqny1423B1ja5
	isTXy9DO1ZAtbNuhWZayteKEdYaV4Dv8gW/1CeUSra34d6vAc9CUx/8xowu4MaCwdoFLpBqsHhG
	rqIB45zQl+DYTa2ueB4Qm69Mi8Rs37OsGvMEe1hcUmdUO4fVctfaVwnVzXK
X-Received: by 2002:a05:6102:4187:b0:634:2450:7998 with SMTP id ada2fe7eead31-75609263c13mr946160137.4.1785339258737;
        Wed, 29 Jul 2026 08:34:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-755a74c0b80sm1820585137.4.2026.07.29.08.34.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:34:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
Date: Wed, 29 Jul 2026 11:34:10 -0400
Message-ID: <20260729153412.2564039-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add HCI command, event and feature bit definitions for the Bluetooth
6.2 Shorter Connection Interval feature:

Commands:
 - HCI_OP_LE_CONN_RATE (0x20a1) - Connection Rate Request
 - HCI_OP_LE_SET_DEF_RATE (0x20a2) - Set Default Rate Parameters
 - HCI_OP_LE_READ_CONN_INTERVAL (0x20a3) - Read Min Supported
   Connection Interval

Events:
 - HCI_EVT_LE_CONN_RATE_CHANGE (0x37) - Connection Rate Change

Feature bits:
 - HCI_LE_SCI - Shorter Connection Intervals
 - HCI_LE_SCI_HOST - Shorter Connection Intervals (Host Support)

During controller init, when SCI is supported:
 - Set Shorter Connection Intervals (Host Support) feature via
   LE Set Host Feature
 - Read Minimum Supported Connection Interval
 - Set Default Rate Parameters

The Connection Rate Change event handler updates the connection
interval, latency and supervision timeout on the hci_conn.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 53 ++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |  8 +++++
 net/bluetooth/hci_event.c        | 29 +++++++++++++++++
 net/bluetooth/hci_sync.c         | 53 ++++++++++++++++++++++++++++++--
 4 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef71fb1..f895278c268f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -653,6 +653,8 @@ enum {
 #define HCI_LE_LL_EXT_FEATURE		0x80
 #define HCI_LE_CS			0x40
 #define HCI_LE_CS_HOST			0x80
+#define HCI_LE_SCI			0x01	/* byte 9 - Shorter Connection Intervals */
+#define HCI_LE_SCI_HOST			0x02	/* byte 9 - Shorter Connection Intervals (Host) */
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
@@ -2489,6 +2491,46 @@ struct hci_cp_le_set_host_feature_v2 {
 	__u8	bit_value;
 } __packed;
 
+#define HCI_OP_LE_CONN_RATE			0x20a1
+struct hci_cp_le_conn_rate {
+	__le16	handle;
+	__le16	interval_min;
+	__le16	interval_max;
+	__le16	subrate_min;
+	__le16	subrate_max;
+	__le16	max_latency;
+	__le16	cont_num;
+	__le16	supv_timeout;
+	__le16	min_ce_len;
+	__le16	max_ce_len;
+} __packed;
+
+#define HCI_OP_LE_SET_DEF_RATE			0x20a2
+struct hci_cp_le_set_def_rate {
+	__le16	interval_min;
+	__le16	interval_max;
+	__le16	subrate_min;
+	__le16	subrate_max;
+	__le16	max_latency;
+	__le16	cont_num;
+	__le16	supv_timeout;
+	__le16	min_ce_len;
+	__le16	max_ce_len;
+} __packed;
+
+#define HCI_OP_LE_READ_CONN_INTERVAL		0x20a3
+struct hci_le_conn_interval_group {
+	__le16	min;
+	__le16	max;
+	__le16	stride;
+} __packed;
+
+struct hci_rp_le_read_conn_interval {
+	__u8	status;
+	__u8	num_grps;
+	struct hci_le_conn_interval_group grps[];
+} __packed;
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
@@ -3303,6 +3345,17 @@ struct hci_evt_le_cs_test_end_complete {
 	__u8	status;
 } __packed;
 
+#define HCI_EVT_LE_CONN_RATE_CHANGE			0x37
+struct hci_evt_le_conn_rate_change {
+	__u8	status;
+	__le16	handle;
+	__le16	interval;
+	__le16	subrate;
+	__le16	latency;
+	__le16	cont_number;
+	__le16	supv_timeout;
+} __packed;
+
 #define HCI_EV_VENDOR			0xff
 
 /* Internal events generated by Bluetooth stack */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7133ff87fbf..8126fed34613 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -720,6 +720,11 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
+	__u16		le_rate_interval;
+	__u16		le_subrate;
+	__u16		le_rate_latency;
+	__u16		le_cont_num;
+	__u16		le_rate_supv_timeout;
 	__u8		le_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8		le_adv_data_len;
 	__u8		le_per_adv_data[HCI_MAX_PER_AD_TOT_LEN];
@@ -2077,6 +2082,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define le_cs_host_capable(dev) \
 	((dev)->le_features[5] & HCI_LE_CS_HOST)
 
+#define le_sci_capable(dev) \
+	((dev)->le_features[9] & HCI_LE_SCI)
+
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea858391c789..d5ef7b3a50cb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7363,6 +7363,31 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_conn_rate_change_evt(struct hci_dev *hdev, void *data,
+					struct sk_buff *skb)
+{
+	struct hci_evt_le_conn_rate_change *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (conn) {
+		conn->le_rate_interval = le16_to_cpu(ev->interval);
+		conn->le_subrate = le16_to_cpu(ev->subrate);
+		conn->le_rate_latency = le16_to_cpu(ev->latency);
+		conn->le_cont_num = le16_to_cpu(ev->cont_number);
+		conn->le_rate_supv_timeout = le16_to_cpu(ev->supv_timeout);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
 [_op] = { \
 	.func = _func, \
@@ -7474,6 +7499,10 @@ static const struct hci_le_ev {
 		     sizeof(struct
 			    hci_evt_le_read_all_remote_features_complete),
 		     HCI_MAX_EVENT_SIZE),
+	/* [0x37 = HCI_EVT_LE_CONN_RATE_CHANGE] */
+	HCI_LE_EV(HCI_EVT_LE_CONN_RATE_CHANGE,
+		   hci_le_conn_rate_change_evt,
+		   sizeof(struct hci_evt_le_conn_rate_change)),
 };
 
 static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7a33513f1fc7..9dfab81e40f8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4478,6 +4478,10 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[6] |= 0x02;	/* LE CS Subevent Result Continue event */
 		events[6] |= 0x04;	/* LE CS Test End Complete event */
 	}
+
+	if (le_sci_capable(hdev))
+		events[6] |= 0x40;	/* LE Connection Rate Change event */
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
 				     sizeof(events), events, HCI_CMD_TIMEOUT);
 }
@@ -4646,12 +4650,46 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u16 bit, u8 value)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int hci_le_read_conn_interval_sync(struct hci_dev *hdev)
+{
+	if (!le_sci_capable(hdev))
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_CONN_INTERVAL,
+				     0, NULL, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_def_rate cp;
+
+	if (!le_sci_capable(hdev))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/* Use the HIDS 1.2 recommended Full Range mode values as the default
+	 * rate parameters (see HOGP v1.2 spec). Connection intervals are in
+	 * units of 0.125 ms and the supervision timeout is in units of 10 ms.
+	 */
+	cp.interval_min = cpu_to_le16(0x000a);	/* 1.25 ms */
+	cp.interval_max = cpu_to_le16(0x0078);	/* 15 ms */
+	cp.subrate_min = cpu_to_le16(0x0001);
+	cp.subrate_max = cpu_to_le16(0x0004);
+	cp.max_latency = cpu_to_le16(0x0000);
+	cp.cont_num = cpu_to_le16(0x0001);
+	cp.supv_timeout = cpu_to_le16(0x000c);	/* 120 ms */
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEF_RATE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* Set Host Features, each feature needs to be sent separately since
  * HCI_OP_LE_SET_HOST_FEATURE doesn't support setting all of them at once.
  */
 static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 {
-	int err;
+	int err = 0;
 
 	if (cis_capable(hdev)) {
 		/* Connected Isochronous Channels (Host Support) */
@@ -4662,9 +4700,16 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 			return err;
 	}
 
-	if (le_cs_capable(hdev))
+	if (le_cs_capable(hdev)) {
 		/* Channel Sounding (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 47, 0x01);
+		if (err)
+			return err;
+	}
+
+	if (le_sci_capable(hdev))
+		/* Shorter Connection Intervals (Host Support) */
+		err = hci_le_set_host_feature_sync(hdev, 73, 0x01);
 
 	return err;
 }
@@ -4697,6 +4742,10 @@ static const struct hci_init_stage le_init3[] = {
 	HCI_INIT(hci_set_le_support_sync),
 	/* HCI_OP_LE_SET_HOST_FEATURE */
 	HCI_INIT(hci_le_set_host_features_sync),
+	/* HCI_OP_LE_READ_CONN_INTERVAL */
+	HCI_INIT(hci_le_read_conn_interval_sync),
+	/* HCI_OP_LE_SET_DEF_RATE */
+	HCI_INIT(hci_le_set_def_rate_sync),
 	{}
 };
 
-- 
2.54.0

