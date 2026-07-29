Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DC3AFD06
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352818; cv=none; b=MyzFtMFsYKtrORuXlZb15HfEzY3C9Pe0GRIikZknpBFptfJzVty1LiPfDKbdzps6ctgFVDqfIO9SYDvqBwk1nExLEEGibfaPhf44d3mV49KOOyEd54Rn3q3zCJN6xkGt4gj515jiiwF2b+8YVZ6Ht3Y0gzqSS0VjrgDrNuBSyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352818; c=relaxed/simple;
	bh=GdjQA52O0qEdSnp6ykGucCdnCkIybJ5DrJ0sg/AJWVE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DoZ1PzSQ/Rtyo8SB7sRJ8hO32kHQd+MTSxPmbLsRR3VIvV8No9SSKtblk7o3JAGkfhUaeuc8SBqfPwNCfzAiIFrCGuAbykY2pTXgr4SZo3+0XJsXI9e7A10fR6LWnNdQBgzam+zX9fHZ8qsWlZw9oDMShIdNdxWf0b3LQZAcgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIbF2eRS; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIbF2eRS"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-963f63fe025so390243241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352812; x=1785957612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGa46pNchzMYl4PrW+RFf/WFm/dOwhcMphbRbYza0Nw=;
        b=JIbF2eRSYYDn/KowKIBnWC4ct5Da0vf+gZ6bk1eHP0ZWbEuUrskqwFHAywRzTt7RJy
         v8Wm+6elnVVCJZE3nOWT1TVEahKXlHVG/Wi5xqnHikfgQtt1Jsh7xWnM2di3pBRzXvU0
         OW5dWJqDSZJG4o6/t+Tc+V7cOP+g4IlECnXQCm//azZujCFnssIMJ46AG6EhB8i5zxg7
         cz/4wzV0ppBkl9RfG/f3RBg29mcUc4vSFIvkjz4c+KaO9tUl5U+M8SFD0Nh0bsy7iqq1
         GD00qSrNKtKRthXvNLntTYRG6H30CmV2HFrCDij5ylgiT5RZL13qLtPd3x1ELSCmLS/y
         SCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352812; x=1785957612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jGa46pNchzMYl4PrW+RFf/WFm/dOwhcMphbRbYza0Nw=;
        b=lKWBl72s+nbhMNyQ8fGqqM4VlNsMOBuLkYLWcNbvQCGdtcyKe79cATVJ/MetgoXjAQ
         zgn6Z25W58HQ826Eb/uFO/ZqCIg6sqa0lgyayvQZN5AqyfLZMbzPfxYQFElAIZpXKHUl
         T1Fxb50W4SUx0HS2uCO3K/0es/oU8stuYY/xV4n2wecB0apJ0D9c67SWr3YNnaSUoTMy
         rXGurYtq6jmji5uzY/BQyDJfkFlKiocCI3pZA6KUqpm4hvqNUFA+7FV16kIpRikSy3fj
         K9NwtYzAcTtx6bkKUDHr1xSE1ntkRoWIIHyaTc8KouCtdbozwbeMmGoHyTOvo1MddfrM
         Rz8A==
X-Gm-Message-State: AOJu0YzhH4vXqqfn+pCrVeBMEk+d7LPugFazysc2XwNCmvrf+mtQl2gD
	rhG9v/tYkY9u4iQaWaSzjAU7xBiNV0UlSk/m607dWoO+wEUL1vRnG02ej0dLT3ZD
X-Gm-Gg: AR+sD12dDhJODeBnz4aFLl0DuoKfK/2korUbWUn48dJcisoktWIlSuBrcmtRF/PnF+I
	+pg4M2W5o6GnriPDtgCZtdsjL9WwH05mq2FXhLyOiw98BBfb0gctxA4m2xdlHCdOeQqaEPT9WPH
	Mo2MA/8p2BV+XHmGYl04+wWKCXt8zKYsLfryPz4RGs73SMAszBOqHiMhv2Cef3z9nOHs+JkLuAG
	tAbJdEvBwLQxVspbz2JcH82hnV2wzYtzQF6ghAtXfKBVLouMn7U6Q0y+3WCwBWh/v/t7EuW3mHt
	X9By0BW9NHx03LEwKGATkyIVcZ5edvMjO1i8G+jTxha5apG9ZXYfzqumMFe0Nog0T23yKGRFCE9
	aGQtzbLf+DGK4/xcHxDzO+i5E6T7Ko5LIysBqpO9IWtmxXZALknEtj4xZTrsJ5KdczedIYMKjv4
	Ri3xcOa87bKnOc3TapthkRmVdjGc3oHDJPC4Do4destJVSc+//Oh9ghPBnGsyhSml368OnGZZ8x
	gc010eQnVivJ9/9Bef0iNO2UXFzBWuYTYoXSIrH5nFpjilh9x4HDvxpe9o692T1yMw4cLI=
X-Received: by 2002:a05:6102:a50:b0:720:7e04:b306 with SMTP id ada2fe7eead31-7549f147741mr3428142137.5.1785352812230;
        Wed, 29 Jul 2026 12:20:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-755a95889b0sm2106844137.8.2026.07.29.12.20.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:20:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
Date: Wed, 29 Jul 2026 15:20:00 -0400
Message-ID: <20260729192002.2636087-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h      | 53 ++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |  9 +++++
 net/bluetooth/hci_event.c        | 65 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 61 +++++++++++++++++++++++++++++-
 4 files changed, 186 insertions(+), 2 deletions(-)

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
index e7133ff87fbf..3da86ca4fe5e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -416,6 +416,7 @@ struct hci_dev {
 	__u16		le_conn_max_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
+	__u16		le_min_rate_interval;
 	__u16		le_def_tx_len;
 	__u16		le_def_tx_time;
 	__u16		le_max_tx_len;
@@ -720,6 +721,11 @@ struct hci_conn {
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
@@ -2077,6 +2083,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define le_cs_host_capable(dev) \
 	((dev)->le_features[5] & HCI_LE_CS_HOST)
 
+#define le_sci_capable(dev) \
+	((dev)->le_features[9] & HCI_LE_SCI)
+
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea858391c789..5732b282f6df 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1241,6 +1241,39 @@ static u8 hci_cc_le_read_local_features(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_read_conn_interval(struct hci_dev *hdev, void *data,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_le_read_conn_interval *rp = data;
+	u16 min_interval = 0;
+	int i;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	if (skb->len < struct_size(rp, grps, rp->num_grps)) {
+		bt_dev_err(hdev, "Invalid response length for 0x%4.4x",
+			   HCI_OP_LE_READ_CONN_INTERVAL);
+		return HCI_ERROR_UNSPECIFIED;
+	}
+
+	/* Store the smallest minimum supported connection interval reported by
+	 * the controller so the default rate parameters can be clamped to it.
+	 */
+	for (i = 0; i < rp->num_grps; i++) {
+		u16 min = le16_to_cpu(rp->grps[i].min);
+
+		if (!min_interval || min < min_interval)
+			min_interval = min;
+	}
+
+	hdev->le_min_rate_interval = min_interval;
+
+	return rp->status;
+}
+
 static u8 hci_cc_le_read_adv_tx_power(struct hci_dev *hdev, void *data,
 				      struct sk_buff *skb)
 {
@@ -4153,6 +4186,9 @@ static const struct hci_cc {
 	       sizeof(struct hci_rp_le_read_buffer_size)),
 	HCI_CC(HCI_OP_LE_READ_LOCAL_FEATURES, hci_cc_le_read_local_features,
 	       sizeof(struct hci_rp_le_read_local_features)),
+	HCI_CC_VL(HCI_OP_LE_READ_CONN_INTERVAL, hci_cc_le_read_conn_interval,
+		  sizeof(struct hci_rp_le_read_conn_interval),
+		  HCI_MAX_EVENT_SIZE),
 	HCI_CC(HCI_OP_LE_READ_ADV_TX_POWER, hci_cc_le_read_adv_tx_power,
 	       sizeof(struct hci_rp_le_read_adv_tx_power)),
 	HCI_CC(HCI_OP_USER_CONFIRM_REPLY, hci_cc_user_confirm_reply,
@@ -7363,6 +7399,31 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
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
@@ -7474,6 +7535,10 @@ static const struct hci_le_ev {
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
index 7a33513f1fc7..868ab1f1daf7 100644
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
@@ -4646,12 +4650,54 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u16 bit, u8 value)
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
+	u16 interval_min = 0x000a;	/* 1.25 ms */
+
+	if (!le_sci_capable(hdev))
+		return 0;
+
+	/* Clamp the minimum interval to the controller's minimum supported
+	 * connection interval (read via HCI_OP_LE_READ_CONN_INTERVAL) so the
+	 * default rate parameters are not rejected.
+	 */
+	if (hdev->le_min_rate_interval > interval_min)
+		interval_min = hdev->le_min_rate_interval;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/* Use the HIDS 1.2 recommended Full Range mode values as the default
+	 * rate parameters (see HOGP v1.2 spec). Connection intervals are in
+	 * units of 0.125 ms and the supervision timeout is in units of 10 ms.
+	 */
+	cp.interval_min = cpu_to_le16(interval_min);
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
@@ -4662,9 +4708,16 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
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
@@ -4697,6 +4750,10 @@ static const struct hci_init_stage le_init3[] = {
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

