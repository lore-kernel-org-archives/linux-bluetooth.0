Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE072622
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910921; cv=none; b=WyPjPUeKFf84HGO15rllKW/1p3cwaqwu0idH/6leFhKtoxtJGM0DlFN4ENpx0qy2w2xpzTCc5DsuM2T7JDlGM5P7l3Yc1yz3ctX/LhrKeLNLkVjIo/Kz+rFadjYlFqjJy00hlXeJylzSq1lAZZ+efGbUut+rfVQSURUWaMff0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910921; c=relaxed/simple;
	bh=2XuShH1VLr0uaLceLelk2x4jIIMd2ZRUghAdESw8+0c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Be///MOV9q9/BdmWLTBHWnyNDWocn61YeRevXvNgDf3E9fwLHqE4ics1Ybcza4PcGcJ2bhQyREnA9TlRGUjJyD6c1glTF9ZTDYMeOFaSYoS79ITJ8P7gRT3kdSxQJpsVlXn0tZM3a4ShnPUlG2g+MnJj64+kXNlUb88sMsfP1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdczts0O; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdczts0O"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso224561e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784910919; x=1785515719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JrlGwjESuM8rHu1WMhjXiLeq2szkL6b9iHaXnNyhC0=;
        b=pdczts0OGibTpQ1rc6KsS0lvn0Gva1aYn5fSVdRfR19FtePh377PSy3jbGUmMqr2mI
         IgEmQZ7zpy2DTsLMY28pfemrESGYkbYLQFIuyTl//otECFObsmuhKYyT7QeJPudsn2Tz
         qrMqGSm80Px08605ssa9U0fKq2bqFdSr2GRAncJwb3pT95arYE/w6K4E2liTg4+VcNHK
         Nste3TK0BEjBDq9EqzrvqdD5Q0Euw8b1Zvoy+vUeiki6erIMUU3EgVXwgdATHzO4/HGc
         BW5GANUGBkA5KnmlXzGOCf7AooPb3tmStAzAsh01+TTm8jXzV83nn14nvTKxuJGy+CbZ
         3ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910919; x=1785515719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+JrlGwjESuM8rHu1WMhjXiLeq2szkL6b9iHaXnNyhC0=;
        b=QEMrmS/iNjRWdc9B6fvtj4P7g3aQjUULMYeE8p4djwVxfZH6vHHAPGUshyYh7HqreW
         EDVJ+ii7Mb3AWV/4T9F/DV9svdRQBAxTT6ZTJMWIvYuWcNZueGh4yAbWOFFgBSYEmGiX
         G6DPLvVQZ0HrhPN9G93DBM4oDRn24TyYpRUS7B9n9GqBUs9/ffJ1wKEV/1nCvkwTZ788
         3MTnuzz0b+OHxZs/uFwtjlaDL7TOiRFCp04F+TzPRRhieFS59YzgMOvrPS71W0Rj+VgT
         hxC9iJtqGTn0md2O6vqlmohJ3a2HXOulEdLs112TmvfStifsCwzk1DoESeWU1z14VGP8
         5zxg==
X-Gm-Message-State: AOJu0Yykj0mnsJKSlACfzKOAEbcMrllzFDDkjHZggeuQOlz82WuZDYp5
	4K5UvNwdiy4fnYVz0X1+rKeVvDScRDuYNL4OlShfUGpX50uHOzFSF0h0/CALaCN+
X-Gm-Gg: AR+sD10aTPvzEB7LWOaDXPAdhaZ9zxLojespzBHysM5JDDyH13X21+XtWdB2AlqqG6M
	Uuc5RYrrCnQlpYZcoMiDzDo3EFuMR3sqye0gxVBfmJmERthHwAddkNskv5DtyaEx8qThktY+vrX
	2bmQroo126BI+TTUP8qk9ItbTNEYfPBFSE7ABQ1hC9DZDJH45pTJNjqBIzldrREoY2nLZjE3ltf
	B7VEpv9AyzCSnIFUsDdwNHBL9FSucSzqrQuDACNYr4q6PDh2XKMEE3Oa/hT9BP3fFPtLLzh+RUK
	W6fsoBHMGhV+EfKMv0va1iOk8nbMlpADouwOeRVN8PuboXkxhkeY+XE/Wf/KnD/OnWw8RhDXfPX
	oxJdEVYCd+hXT8O0nW5MJay4zPbQk9xZZfbZTkIvoEGLS7zSneyAlwR9IgG8IXDESd5vP0/pEvs
	tO6+hbTrPUGSnAlS2oYLG/eBm4xuhYmzgvjP/N5e2af7RMPDTFrNhwrJ2LQpmYd7q2vL6VvH6/
X-Received: by 2002:a05:6122:3d41:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c2d9dbd40bmr3787063e0c.0.1784910918561;
        Fri, 24 Jul 2026 09:35:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c2c6276fbfsm9730127e0c.4.2026.07.24.09.35.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:35:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
Date: Fri, 24 Jul 2026 12:35:09 -0400
Message-ID: <20260724163511.1737044-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h |  3 ++
 net/bluetooth/hci_event.c        | 27 ++++++++++++++++
 net/bluetooth/hci_sync.c         | 46 +++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

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
index e7133ff87fbf..7e58acb65f48 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2077,6 +2077,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define le_cs_host_capable(dev) \
 	((dev)->le_features[5] & HCI_LE_CS_HOST)
 
+#define le_sci_capable(dev) \
+	((dev)->le_features[9] & HCI_LE_SCI)
+
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea858391c789..a2da7876b6b4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7363,6 +7363,29 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
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
+		conn->le_conn_interval = le16_to_cpu(ev->interval);
+		conn->le_conn_latency = le16_to_cpu(ev->latency);
+		conn->le_supv_timeout = le16_to_cpu(ev->supv_timeout);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
 [_op] = { \
 	.func = _func, \
@@ -7474,6 +7497,10 @@ static const struct hci_le_ev {
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
index 7a33513f1fc7..cd3e39c8bb86 100644
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
@@ -4646,6 +4650,40 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u16 bit, u8 value)
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
@@ -4666,6 +4704,10 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 		/* Channel Sounding (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 47, 0x01);
 
+	if (le_sci_capable(hdev))
+		/* Shorter Connection Intervals (Host Support) */
+		err = hci_le_set_host_feature_sync(hdev, 73, 0x01);
+
 	return err;
 }
 
@@ -4697,6 +4739,10 @@ static const struct hci_init_stage le_init3[] = {
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

