Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6973EE1E2
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083635; cv=none; b=FLBFtKH15tkaLr9J1OYx6Vx2rhCzWnImTicehMN40qkqeNQ6iiWFuuhjVDmAfexjHGc/uwMuDOcxHCUjKTJQXiSS59ylYIubP/l75ponYEx+823rp/IppE3y9EWFFewW6C6/4ySYi/RaJefvIGxaq04Jxy46mN2IPqRisRHP62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083635; c=relaxed/simple;
	bh=gGcflbLvacMJ5I9GwZFgMbYG7J30vdEms9JenLu+s8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t4S2gMbDONgplDUCh/qV46Fn/gCiN9faHOAzA2h3EoJHBa/jNX/i0OP3SibK3p7Iw4N9zY5zSjLPvCbHVrJwrluHT0bmVZAxYzQCKdv+9H8ztgSWHxNdZp6jv5FqW5whLCDqgc0QviYCjPsUcu3sJmEni236FtFMtY34d5/9mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kkj4wZK6; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkj4wZK6"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-575171b1ce7so1291913e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083622; x=1778688422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zkagk+U8caDjP4k/XeINeChN/sz38fwyKa1BLmLgfs=;
        b=Kkj4wZK640q7zHTS99/9WdukfdoaeeKb/xAwuw++5X5YsmpNU6qo5DdA3EJGEnygUA
         0d9iANeKDvYdLdaZrXZTzMYJKdXWDAJRDsydan8uxr6Ed0zq2hTeAgyDMSdcyXjg/yMF
         qORrsK/QfjIFzofFMPlVyNitn8j4J0OfZ/fXYfhsjosq64S0DGp9mCWR22ouphm95ETW
         ExkGBxqN63+0GwGh7uzEYBKHslwkfWZvovAbso3iLb5DcfdD8pMzj+xG6QLJxde8/RYy
         Q/uPo1pv1fBlm33nDfspPpbfePMAT4WHGCrh4QtKoRRTsL7oArTR79dbjJnxt0p135VQ
         wDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083622; x=1778688422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zkagk+U8caDjP4k/XeINeChN/sz38fwyKa1BLmLgfs=;
        b=gNCNOIrOq6FVO78U8EFhCBk8BrD6YVXIobiEf1MCmqIZCEdZBKSgIyySEXtVStAG0G
         bOSkLDvVdRuInBNKNtJjt16+7VdtBWDfD0eh21psO5oOURpAubVQg64QG6zMm7r9yPLi
         xPuUgpEmJxC3Th53cZAgxCmRDJkb7SOLrWpNVQ5WZJrkMDNgwWnWN9DNzyx2/09ljK06
         NctoNSXvkfcU//fRw5Hir7POihQZXQufTCweTc5n/gpBglebgkV/wIpO2BbjS7TBx5dG
         /XK7+7zcba55zfcOMoBqpzYp9G+SHZAQES+sJi0bG3mjg8YsWadv+u0XG0lOeCrnVijX
         G2Nw==
X-Gm-Message-State: AOJu0YzdTMeIQHk9Ebf/PJu8MO80CREld5ftSPUPziY6cO8J0jqMfSXW
	ddi5q65XfY4pbKzwxfPu3BsyVI4hATZDXFmnmk2tXIqhZIrg1MG3v0COOWHks/Kv
X-Gm-Gg: AeBDievdDL0sIS5I7c6qfFNjy8suIbsvIcEBJrH1MpgG6SlmVrp9Ve4CGhW06jGWyVi
	EqoiLXtVu8KABsZ8qa/Ug6U30cSGqhD+T9IGmfAG6jVkYnGUFFzMDuaMf62zecA2KSm1IY5Uqxa
	uKCRanNoDoDGsrfzbdH15wgYfGM8KXiHLa3PZc1tDgpBKR2IV2d4Hx/jMLar1jHhBJPvaDZhD3g
	bRzuGNgd1Qe6SvQOfMRCLHwD/SZVMLeWbj5eq15T2SNAU9RaNI48uI2DwpfKAC2tzaxPE2aKA+J
	O0LduaP8+D4FD2FURqQSjpNwfwZ5WooqjG7ia+kA5sG33nH84qyjGATu0/vJotIEegYhV452G/V
	H1uax/5q4Ggz3CiihuWtBEk8FPMUnxr8eBYDogNvWrT/oNYKQK694mDRgeQviaFvrGaeEuViVAP
	JXxvql+SSB5QeOnG/f0V5rGFNSNlwoLW7I7PKMVhmLy6QtzcUatrm+4vaBVZ7dw7zqyIFi9o7rJ
	8sD/oiq1B3KFQhVG9sozzbs2im4
X-Received: by 2002:a05:6122:915:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-5755959afc1mr2130295e0c.5.1778083621717;
        Wed, 06 May 2026 09:07:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575585f72c1sm2142241e0c.12.2026.05.06.09.07.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:07:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
Date: Wed,  6 May 2026 12:06:50 -0400
Message-ID: <20260506160651.1585012-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial support for SCI related commands, command bits, event
event mask bit and feature bits:

Events:

HCI_LE_Connection_Rate_Change(0x37)

Commands:

HCI_LE_Connection_Rate_Request(0x20a1)
HCI_LE_Set_Default_Rate_Parameters(0x20a2)
HCI_LE_Read_Minimum_Supported_Connection_Interval(0x20a3)

Also update the init sequence to incorporte support for reading SCI
groups and then setting the Default Rate

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 52 +++++++++++++++++++
 include/net/bluetooth/hci_core.h | 15 ++++++
 net/bluetooth/hci_core.c         | 14 ++++-
 net/bluetooth/hci_event.c        | 62 ++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 88 +++++++++++++++++++++++++++++++-
 5 files changed, 229 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d..848ec42de827 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -656,6 +656,7 @@ enum {
 #define HCI_LE_LL_EXT_FEATURE		0x80
 #define HCI_LE_CS			0x40
 #define HCI_LE_CS_HOST			0x80
+#define HCI_LE_SCI			0x01
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
@@ -2486,6 +2487,46 @@ struct hci_rp_le_cs_test {
 
 #define HCI_OP_LE_CS_TEST_END			0x2096
 
+#define HCI_OP_LE_CONN_RATE			0x20a1
+struct hci_cp_le_conn_rate {
+	__le16   handle;
+	__le16   interval_min;
+	__le16   interval_max;
+	__le16   subrate_min;
+	__le16   subrate_max;
+	__le16   max_latency;
+	__le16   cont_num;
+	__le16   supv_timeout;
+	__le16   min_ce_len;
+	__le16   max_ce_len;
+} __packed;
+
+#define HCI_OP_LE_SET_DEF_RATE		0x20a2
+struct hci_cp_le_set_def_rate {
+	__le16   interval_min;
+	__le16   interval_max;
+	__le16   subrate_min;
+	__le16   subrate_max;
+	__le16   max_latency;
+	__le16   cont_num;
+	__le16   supv_timeout;
+	__le16   min_ce_len;
+	__le16   max_ce_len;
+} __packed;
+
+#define HCI_OP_LE_READ_CONN_INTERVAL	0x20a3
+struct hci_le_conn_interval_group {
+	__le16   min;
+	__le16   max;
+	__le16   stride;
+} __packed;
+
+struct hci_rp_le_read_conn_interval {
+	__u8    status;
+	__u8    num_grps;
+	struct hci_le_conn_interval_group grps[] __counted_by(num_grps);
+} __packed;
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
@@ -3300,6 +3341,17 @@ struct hci_evt_le_cs_test_end_complete {
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
index aa600fbf9a53..61872403fe65 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -333,6 +333,14 @@ struct adv_monitor {
 #define HCI_ADV_MONITOR_EXT_NONE		1
 #define HCI_ADV_MONITOR_EXT_MSFT		2
 
+
+struct sci_group {
+	struct list_head list;
+	__u16 min;
+	__u16 max;
+	__u16 stride;
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 #define HCI_CONN_HANDLE_MAX		0x0eff
@@ -572,6 +580,7 @@ struct hci_dev {
 	struct list_head	pend_le_reports;
 	struct list_head	blocked_keys;
 	struct list_head	local_codecs;
+	struct list_head	sci_groups;
 
 	struct hci_dev_stats	stat;
 
@@ -2082,6 +2091,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
+/* Shorter Connection Intervals support */
+#define le_sci_capable(dev) \
+	((dev)->le_features[9] & HCI_LE_SCI)
+
+void hci_sci_groups_clear(struct hci_dev *hdev);
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c46c1236ebfa..04c5559ef029 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2543,8 +2543,9 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->adv_instances);
 	INIT_LIST_HEAD(&hdev->blocked_keys);
 	INIT_LIST_HEAD(&hdev->monitored_devices);
-
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_LIST_HEAD(&hdev->sci_groups);
+
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2740,6 +2741,16 @@ void hci_unregister_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_unregister_dev);
 
+void hci_sci_groups_clear(struct hci_dev *hdev)
+{
+	struct sci_group *grp, *tmp;
+
+	list_for_each_entry_safe(grp, tmp, &hdev->sci_groups, list) {
+		list_del(&grp->list);
+		kfree(grp);
+	}
+}
+
 /* Release HCI device */
 void hci_release_dev(struct hci_dev *hdev)
 {
@@ -2766,6 +2777,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
 	hci_codec_list_clear(&hdev->local_codecs);
+	hci_sci_groups_clear(hdev);
 	msft_release(hdev);
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eea2f810aafa..db2a8d5c456c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3957,6 +3957,51 @@ static u8 hci_cc_le_read_all_local_features(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_read_conn_interval(struct hci_dev *hdev, void *data,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_le_read_conn_interval *rp = data;
+	__u8 i;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status || !rp->num_grps)
+		return rp->status;
+
+	hci_dev_lock(hdev);
+
+	/* Clear any existing SCI groups before adding new ones. */
+	hci_sci_groups_clear(hdev);
+
+	for (i = 0; i < rp->num_grps; i++) {
+		struct hci_le_conn_interval_group *grp;
+		struct sci_group *sgrp;
+
+		/* Pull HCI event data for the current group. */
+		grp = skb_pull_data(skb, sizeof(*grp));
+		if (!grp) {
+			bt_dev_err(hdev, "invalid data length for SCI group");
+			break;
+		}
+
+		sgrp = kzalloc(sizeof(*sgrp), GFP_KERNEL);
+		if (!sgrp) {
+			bt_dev_err(hdev, "can't allocate memory for SCI group");
+			break;
+		}
+
+		sgrp->min = __le16_to_cpu(grp->min);
+		sgrp->max = __le16_to_cpu(grp->max);
+		sgrp->stride = __le16_to_cpu(grp->stride);
+
+		list_add(&sgrp->list, &hdev->sci_groups);
+	}
+
+	hci_dev_unlock(hdev);
+
+	return rp->status;
+}
+
 static void hci_cs_le_create_big(struct hci_dev *hdev, u8 status)
 {
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
@@ -4239,6 +4284,10 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_ALL_LOCAL_FEATURES,
 	       hci_cc_le_read_all_local_features,
 	       sizeof(struct hci_rp_le_read_all_local_features)),
+	HCI_CC_VL(HCI_OP_LE_READ_CONN_INTERVAL,
+		  hci_cc_le_read_conn_interval,
+		  sizeof(struct hci_rp_le_read_conn_interval),
+		  HCI_MAX_EVENT_SIZE),
 };
 
 static u8 hci_cc_func(struct hci_dev *hdev, const struct hci_cc *cc,
@@ -7372,6 +7421,16 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_conn_rate_change_evt(struct hci_dev *hdev, void *data,
+					struct sk_buff *skb)
+{
+	struct hci_evt_le_conn_rate_change *ev = data;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	/* TODO: Store rate to be used for next connection? */
+}
+
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
 [_op] = { \
 	.func = _func, \
@@ -7483,6 +7542,9 @@ static const struct hci_le_ev {
 		     sizeof(struct
 			    hci_evt_le_read_all_remote_features_complete),
 		     HCI_MAX_EVENT_SIZE),
+	/* [0x37 = HCI_EVT_LE_CONN_RATE_CHANGE] */
+	HCI_LE_EV(HCI_EVT_LE_CONN_RATE_CHANGE, hci_le_conn_rate_change_evt,
+		  sizeof(struct hci_evt_le_conn_rate_change)),
 };
 
 static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..31c3c873e33d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4449,6 +4449,10 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[6] |= 0x02;	/* LE CS Subevent Result Continue event */
 		events[6] |= 0x04;	/* LE CS Test End Complete event */
 	}
+
+	if (le_sci_capable(hdev))
+		events[6] |= 0x20;	/* LE Connection Rate Change */
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
 				     sizeof(events), events, HCI_CMD_TIMEOUT);
 }
@@ -4611,9 +4615,16 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
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
+		/* Short Connection Interval (Host Support) */
+		err = hci_le_set_host_feature_sync(hdev, 73, 0x01);
 
 	return err;
 }
@@ -4896,11 +4907,86 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+/* Read Connection Interval if command is supported and SCI feature bit is
+ * marked as supported.
+ */
+static int hci_le_read_conn_interval_sync(struct hci_dev *hdev)
+{
+	if (!(hdev->commands[48] & BIT(7)) || !le_sci_capable(hdev))
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_CONN_INTERVAL,
+				     0, NULL, HCI_CMD_TIMEOUT);
+}
+
+/* Set Default Connection Rate Parameters if command is supported, SCI feature
+ * bit is marked as supported and at least one of the supported SCI groups
+ * exists.
+ */
+static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_def_rate cp;
+	struct sci_group *grp, *tmp;
+	__u16 min = 0, max = 0;
+
+	if (!(hdev->commands[48] & BIT(6)) || !le_sci_capable(hdev) ||
+	    list_empty(&hdev->sci_groups))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/* Iterate over the SCI groups and find the widest supported connection
+	 * interval range to maximize compatibility with peer devices.
+	 */
+	list_for_each_entry_safe(grp, tmp, &hdev->sci_groups, list) {
+		if (!min == 0 || grp->min < min)
+			min = grp->min;
+
+		if (!max == 0 || grp->max > max)
+			max = grp->max;
+	}
+
+	cp.interval_min = cpu_to_le16(min);
+	cp.interval_max = cpu_to_le16(max);
+
+	/* HOG 1.2 Table 7.4. Modes with recommended parameter values suggests
+	 * subrate 1-4 for all modes so use that as default.
+	 */
+	cp.subrate_min = cpu_to_le16(0x0001);
+	cp.subrate_max = cpu_to_le16(0x0004);
+
+	/* HIP 1.2 Table 7.5. Modes with recommended parameter values suggests
+	 * max latency of 0 for all modes expect low power.
+	 */
+	cp.max_latency = 0x0000;
+
+	/* HIP 1.2 Table 7.5. Modes with recommended parameter values suggests
+	 * continuation number 1 for full range.
+	 */
+	cp.cont_num = cpu_to_le16(0x0001);
+
+	/* HOG 1.2 Table 7.4. Modes with recommended parameter values states
+	 * that link supervision timeout should be: Greater than or equal to
+	 * (1 + Peripheral Latency) x Subrate max x Connection Interval max x 2.
+	 */
+	cp.supv_timeout = cpu_to_le16((1 + 0) * 0x0004 * max * 2 / 10);
+
+	cp.min_ce_len = cpu_to_le16(min);
+	cp.max_ce_len = cpu_to_le16(max);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEF_RATE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 static const struct hci_init_stage le_init4[] = {
 	/* HCI_OP_LE_WRITE_DEF_DATA_LEN */
 	HCI_INIT(hci_le_set_write_def_data_len_sync),
 	/* HCI_OP_LE_SET_DEFAULT_PHY */
 	HCI_INIT(hci_le_set_default_phy_sync),
+	/* HCI_OP_LE_READ_CONN_INTERVAL */
+	HCI_INIT(hci_le_read_conn_interval_sync),
+	/* HCI_OP_LE_SET_DEF_RATE */
+	HCI_INIT(hci_le_set_def_rate_sync),
 	{}
 };
 
-- 
2.53.0

