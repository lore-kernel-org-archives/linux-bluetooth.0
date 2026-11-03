Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744369;
	b=XIcNBSMT2oQbGWIXo/Uvjly3SoE77b9OD5G3LrycPaJ+M2brEGV4dQiftwK3Bk/mVOSN
	 EHu3Db6IJVHFeaS7/psA7SNuBzTqFTwWHl8goutcuvZHdP8uUBaZjnu80LC9oN3YRd+jQ
	 RSrk9An6yJ4UUliwxf8c7HH+20st/VPR1vvvwbo0MPv8YHmyhRP579HhyBKk7WOH1/GB8
	 KkDnCMzz89b4sECjBs/FadlSTU+3aVPlO/9G8CVJ9uZQQ20GtliIhYYrm33Ji1jQtMBUU
	 /Bqgctm3sxP8jx0/1pHmO2z7z6FIeugqfTc/s0M/xFOvSoBBEhs40iDrxobQ+Iq3BlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PrOa+VYbzzeuUZt/+UmTbhGuNfKJ+vVPDmqWFy7hlUU=;
	b=gkA19VCrBc6+5ATzUaIowWcsRCF7vmVk/Z0+3+yX8qVSFTFR6+8Bc2XkrzN22ZbSkD1W
	 p1cddOSFSf7P4VIEDZ8KMD/HpKq2QJ++2ID5N/8xJdECWAh+9PDpNocVOcici3spLOZfV
	 qKcXVC5VSIseOwcbBdja4xC0DoeDj23Ghs0v6JDle/5KiAmr6rNO4fGn5svM4gO9e+Gvf
	 mGS76ane241UYcA5W/nHhWxQccwhkeV5GoYICgVHetXcb9LknIRJkeUB1nr2/Ax1MJbrM
	 s+hWlemaiCScVnu8B9JpW9PGoSCxmIYXi1ZL0joWbACi9WuU5fyrMkx4Zfc8QtP/jRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A4Bivh2/";
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A5606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 497A5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4Bivh2/
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so24718e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744367; x=1794349167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PrOa+VYbzzeuUZt/+UmTbhGuNfKJ+vVPDmqWFy7hlUU=;
        b=A4Bivh2/sV3Mb3RCmmI8MUDq8soqmJNkJMsqRPYwJKoGRdpcuZHis1tskdmllM33jx
         8GX2Dknyo3mm1tACRGr84jqxUhaGFkam3LeQpwUPDxVCJgVNd7ZpdHj6zIMNR2G1GeOh
         R4SVMKskFlML1XeqIisj7xIqGqJcb1819dGK77atd2vXyTHQmMiaElZkijH9WH9deTMB
         HwJR+OVbZGaTHef75+8QT2hdai6ediwu32Patz8A8HjpTdpkEnpyzMisvYKg9sOuB6Bs
         PHWH3onDbizs8sS6YIhnGGpwMzcstLNz46pqhs7mvhnBfSDNe/ujOnSV0Q/lSGzzSpcK
         MWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744367; x=1794349167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PrOa+VYbzzeuUZt/+UmTbhGuNfKJ+vVPDmqWFy7hlUU=;
        b=ZxOLantd8WDmMa87IYEiYF+1jaUD7bSXyaXrCfkCxOsXR3QJVLp6TQ7ivP3jZJNClg
         THyukucuxdSsep+WofJNkttY11T6WYmNVKvcP+cu6hePp/TzS6KesjXYGNDINn5JPC0Q
         +hB6JNk8u86a8YTEVrJcJRH708JrHQJV3XwXZybbUrdK2qjI4+Sq/9c92FWjLHZn8WYP
         j0r7NdbYuhWWegUid3mTCGYcX4n8Ehv+R9K4f6/uLKzbS6r9l/BM172jvgIQhRNYRIzl
         CQXVWpNGVwqTOV31N4NgRyM16HpPzuEt9kviFouZIR5+gX6SyITQcbTUDlZj7GQbpTYH
         wu6Q==
X-Gm-Message-State: APuU4Z9wQx4OTFsSU5evCGgDdXJvYh7YRdcHbXkkQIfmVpDUSMBZGh5q
	NY2zWK8fwZyq43U/ZNCjAaTUNeOayYzZ2S/GAr2gOQoM24OnJaUTM0xoAMMaaQ==
X-Gm-Gg: AYBFou0qPEapuXeW6ftXYvjPD3XGyiUKJuTDnuBgZFdC0o7xsFXj4icEiShsbJZ70iE
	nE36sFAgqjTHNesLSAzEvBT6YTNE+O4o4DFhYH53fgoWJRewVK7GvaP8ip3ZHpPndVNxwP3xhXX
	twXLIR2ZOHZBsqOe2ZcnpnosXqrEeQmL3UDPAy8Me0SWdkGaY2GW2AZPjTb3mwnJzzaJzg66Ssn
	Fn9SkNnnToZYYf4RTLKREbOWiKLqHot6R0CoodngAmy1kgXnIHdH/eA59PRq1g3yDwL1AuCvtDa
	g6QsRhaS+3NGnymOyzT/4NPNzQ31gkanEE97X1fCbdTcuUAipL4F42XEZPUmz55COwt6Y5Z9A/t
	muwoZMdP7cOo2f9XvUlq+kEX0gzXVPXnOGebaJbKGfJlGIJWGXZJDT7Ms839rPFW6GJOqRUlGBL
	TAXy+tym4bm12BI+5QMw5e2sVa9EADIxM2fmbSyBT5d07rkoth4rT2AM1BIbq17+34VplrycgMu
	JGH0uzcjsIpuhmv9oS1SuRrpUdbDKfa0P4EZwHbyZB+Lw4VLPvx+b0dTroEEyNbBZotd8PZ5M/U
	cdY1r8KjFS+HfpJk09kvTfZZjBK0NIeZQetFdUAw7d85jR3Fw41WMHdgth6yk46NVK36u9vRzVH
	DggXF+VIo2yjFYjOlWWfUkFt0/zvPjBjJWY3UtoHkB0ELcsj2qVVkeo8CKrDTijwl/KiNC+p7mE
	xxWrUh
X-Received: by 2002:a05:6102:c4d:b0:7a1:f7d2:e82a with SMTP id ada2fe7eead31-7d0728b9be0mr6493804137.35.1793744366623;
        Tue, 03 Nov 2026 14:19:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/6] Bluetooth: Add initial support for HDT PHY
Date: Tue,  3 Nov 2026 17:19:16 -0500
Message-ID: <20261103221921.4071765-3-luiz.dentz@gmail.com>
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

Add support for the LE HDT PHY introduced by High Data Throughput (HDT)
in Bluetooth 7.0:

 - The HDT feature bits (Link Layer feature bits 76-83) and the
   le_feature() helper to access the FeatureSet pages above page 0,
   along with hdt_capable() and the per-rate capability checks.
 - BT_PHY_HDT_* bits for the HDT2, HDT3, HDT4, HDT6 and HDT7.5 rates in
   each direction, so userspace can select them with BT_PHY, which map
   to the LE HDT PHY and the rate bits of PHY_Options in LE Set PHY.
 - LE Read Maximum Data Length v2, LE Set Data Length v2, LE Read/Write
   Suggested Default Data Length v2 and LE Data Length Change v2, used
   instead of their v1 counterparts on HDT capable controllers so the
   data length is set for each PHY. The values given to LE Write
   Suggested Default Data Length are clamped to the maximum the
   specification allows.
 - LE Set CIG Parameters v2, LE CIS Established v3, LE Create BIG v2 and
   LE Create BIG Complete v2, which carry the HDT rates, MIC length and
   packet format of a CIS or BIS.
 - MGMT_SETTING_HDT to report HDT support to userspace.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  20 +-
 include/net/bluetooth/hci.h       | 179 +++++++++++++++-
 include/net/bluetooth/hci_core.h  |  32 +++
 include/net/bluetooth/hci_sync.h  |   5 +-
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 195 ++++++++++-------
 net/bluetooth/hci_event.c         | 326 ++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.c          | 342 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c              |   6 +
 9 files changed, 1019 insertions(+), 87 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index cd9189244566..aab6a1ac9a3e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -142,6 +142,16 @@ struct bt_voice {
 #define BT_PHY_LE_2M_RX		BIT(12)
 #define BT_PHY_LE_CODED_TX	BIT(13)
 #define BT_PHY_LE_CODED_RX	BIT(14)
+#define BT_PHY_HDT_2M_TX	BIT(15)
+#define BT_PHY_HDT_2M_RX	BIT(16)
+#define BT_PHY_HDT_3M_TX	BIT(17)
+#define BT_PHY_HDT_3M_RX	BIT(18)
+#define BT_PHY_HDT_4M_TX	BIT(19)
+#define BT_PHY_HDT_4M_RX	BIT(20)
+#define BT_PHY_HDT_6M_TX	BIT(21)
+#define BT_PHY_HDT_6M_RX	BIT(22)
+#define BT_PHY_HDT_7_5M_TX	BIT(23)
+#define BT_PHY_HDT_7_5M_RX	BIT(24)
 
 #define BT_PHY_BREDR_MASK	(BT_PHY_BR_1M_1SLOT | BT_PHY_BR_1M_3SLOT | \
 				 BT_PHY_BR_1M_5SLOT | BT_PHY_EDR_2M_1SLOT | \
@@ -151,6 +161,13 @@ struct bt_voice {
 #define BT_PHY_LE_MASK		(BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX | \
 				 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX | \
 				 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX)
+#define BT_PHY_HDT_TX_MASK	(BT_PHY_HDT_2M_TX | BT_PHY_HDT_3M_TX | \
+				 BT_PHY_HDT_4M_TX | BT_PHY_HDT_6M_TX | \
+				 BT_PHY_HDT_7_5M_TX)
+#define BT_PHY_HDT_RX_MASK	(BT_PHY_HDT_2M_RX | BT_PHY_HDT_3M_RX | \
+				 BT_PHY_HDT_4M_RX | BT_PHY_HDT_6M_RX | \
+				 BT_PHY_HDT_7_5M_RX)
+#define BT_PHY_HDT_MASK		(BT_PHY_HDT_TX_MASK | BT_PHY_HDT_RX_MASK)
 
 #define BT_MODE			15
 
@@ -221,8 +238,9 @@ struct bt_iso_qos {
 #define BT_ISO_PHY_1M		BIT(0)
 #define BT_ISO_PHY_2M		BIT(1)
 #define BT_ISO_PHY_CODED	BIT(2)
+#define BT_ISO_PHY_HDT		BIT(4)
 #define BT_ISO_PHY_ANY		(BT_ISO_PHY_1M | BT_ISO_PHY_2M | \
-				 BT_ISO_PHY_CODED)
+				 BT_ISO_PHY_CODED | BT_ISO_PHY_HDT)
 
 #define BT_CODEC	19
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1c992e87534d..525344702c87 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -659,6 +659,16 @@ enum {
 #define HCI_LE_SCI			0x01	/* byte 9 - Shorter Connection Intervals */
 #define HCI_LE_SCI_HOST			0x02	/* byte 9 - Shorter Connection Intervals (Host) */
 
+/* HDT features - Page 1 */
+#define HCI_LE_EKS_FEATURE		BIT(4)	/* Byte 1 */
+#define HCI_LE_HDT_FEATURE		BIT(5)
+#define HCI_LE_HDT_6_RX_FEATURE		BIT(6)
+#define HCI_LE_HDT_6_TX_FEATURE		BIT(7)
+#define HCI_LE_HDT_7_5_RX_FEATURE	BIT(0)	/* Byte 2 */
+#define HCI_LE_HDT_7_5_TX_FEATURE	BIT(1)
+#define HCI_LE_HDT_PF_1			BIT(2)
+#define HCI_LE_HDT_LQF_FEATURE		BIT(3)
+
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
 #define HCI_CM_HOLD	0x0001
@@ -1891,9 +1901,10 @@ struct hci_cp_le_set_default_phy {
 	__u8    rx_phys;
 } __packed;
 
-#define HCI_LE_SET_PHY_1M		0x01
-#define HCI_LE_SET_PHY_2M		0x02
-#define HCI_LE_SET_PHY_CODED		0x04
+#define HCI_LE_SET_PHY_1M		BIT(0)
+#define HCI_LE_SET_PHY_2M		BIT(1)
+#define HCI_LE_SET_PHY_CODED		BIT(2)
+#define HCI_LE_SET_PHY_HDT		BIT(4)
 
 #define HCI_OP_LE_SET_PHY		0x2032
 struct hci_cp_le_set_phy {
@@ -2216,7 +2227,7 @@ struct hci_bis {
 	__le16  sdu;
 	__le16  latency;
 	__u8    rtn;
-	__u8    phy;
+	__u8    phys;
 	__u8    packing;
 	__u8    framing;
 	__u8    encryption;
@@ -2535,6 +2546,114 @@ struct hci_rp_le_read_conn_interval {
 	struct hci_le_conn_interval_group grps[];
 } __packed;
 
+#define HCI_OP_LE_WRITE_DEF_DATA_LEN_V2		0x20b2
+struct hci_cp_le_write_def_data_len_v2 {
+	__le16	tx_len;
+	__le16	tx_time;
+	__u8	phys;
+} __packed;
+
+#define HCI_OP_LE_READ_DEF_DATA_LEN_V2		0x20b1
+struct hci_cp_le_read_def_data_len_v2 {
+	__u8	phys;
+} __packed;
+
+struct hci_rp_le_read_def_data_len_v2 {
+	__u8	status;
+	__le16	tx_len;
+	__le16	tx_time;
+} __packed;
+
+#define HCI_OP_LE_READ_MAX_DATA_LEN_V2		0x20b0
+struct hci_cp_le_read_max_data_len_v2 {
+	__u8    phy;
+} __packed;
+
+struct hci_rp_le_read_max_data_len_v2 {
+	__u8    status;
+	__le16  tx_len;
+	__le16  tx_time;
+	__le16  rx_len;
+	__le16  rx_time;
+	__u8    tx_win;
+	__u8    rx_win;
+	__u16   rx_packet;
+} __packed;
+
+#define HCI_OP_LE_SET_MAX_DATA_LEN_V2		0x20aa
+struct hci_cp_le_set_data_len_v2 {
+	__le16  handle;
+	__le16  tx_len;
+	__le16  tx_time;
+	__u8    phys;
+} __packed;
+
+struct hci_rp_le_set_data_len_v2 {
+	__u8    status;
+	__u16   handle;
+} __packed;
+
+#define HCI_OP_LE_SET_CIG_PARAMS_V2		0x20b3
+struct hci_cis_params_v2 {
+	__u8    cis_id;
+	__le16  c_sdu;
+	__le16  p_sdu;
+	__u8    c_phys;
+	__u8    p_phys;
+	__u8    c_rtn;
+	__u8    p_rtn;
+	__u8    c_coded_rates;
+	__u8    p_coded_rates;
+	__le16  c_hdt_rates;
+	__le16  p_hdt_rates;
+	__u8    mic_len;
+	__u8    format;
+} __packed;
+
+struct hci_cp_le_set_cig_params_v2 {
+	__u8    cig_id;
+	__u8    c_interval[3];
+	__u8    p_interval[3];
+	__u8    sca;
+	__u8    packing;
+	__u8    framing;
+	__le16   c_latency;
+	__le16   p_latency;
+	__u8    num_cis;
+	struct hci_cis_params_v2 cis[] __counted_by(num_cis);
+} __packed;
+
+struct hci_rp_le_set_cig_params_v2 {
+	__u8    status;
+	__u8    cig_id;
+	__u8    num_handles;
+	__le16  handle[];
+} __packed;
+
+#define HCI_OP_LE_CREATE_BIG_V2			0x20b6
+struct hci_bis_v2 {
+	__u8    sdu_interval[3];
+	__u16   sdu;
+	__u16   latency;
+	__u8    rtn;
+	__u8    phys;
+	__u8    packing;
+	__u8    framing;
+	__u8    encryption;
+	__u8    bcode[16];
+	__u8    coded_rates;
+	__u16   hdt_rates;
+	__u8    mic_len;
+	__u8    format;
+} __packed;
+
+struct hci_cp_le_create_big_v2 {
+	__u8    handle;
+	__u8    adv_handle;
+	__u8    num_bis;
+	struct hci_bis_v2 bis;
+} __packed;
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
@@ -3360,6 +3479,58 @@ struct hci_evt_le_conn_rate_change {
 	__le16	supv_timeout;
 } __packed;
 
+#define HCI_EVT_LE_CIS_ESTABLISHED_V3			0x3a
+struct hci_evt_le_cis_established_v3 {
+	__u8    status;
+	__le16  handle;
+	__u8    cig_sync_delay[3];
+	__u8    cis_sync_delay[3];
+	__u8    c_latency[3];
+	__u8    p_latency[3];
+	__u8    c_phy;
+	__u8    p_phy;
+	__u8    nse;
+	__u8    c_bn;
+	__u8    p_bn;
+	__u8    c_ft;
+	__u8    p_ft;
+	__le16  c_mtu;
+	__le16  p_mtu;
+	__le16  interval;
+	__u8    sub_interval[3];
+	__le16  c_sdu;
+	__le16  p_sdu;
+	__u8    c_sdu_interval[3];
+	__u8    p_sdu_interval[3];
+	__u8    framing;
+	__le16  c_rates;
+	__le16  p_rates;
+	__u8    config_id;
+	__u8    group_id;
+	__u8    encryption;
+	__u8    mic_len;
+} __packed;
+
+#define HCI_EVT_LE_CREATE_BIG_COMPLETE_V2	0x3b
+struct hci_evt_le_create_big_complete_v2 {
+	__u8    status;
+	__u8    handle;
+	__u8    sync_delay[3];
+	__u8    latency[3];
+	__u8    phy;
+	__u8    nse;
+	__u8    bn;
+	__u8    pto;
+	__u8    irc;
+	__le16  max_pdu;
+	__le16  interval;
+	__le16  rates;
+	__u8    encryption;
+	__u8    mic_len;
+	__u8    num_bis;
+	__le16  bis_handle[];
+} __packed;
+
 #define HCI_EV_VENDOR			0xff
 
 /* Internal events generated by Bluetooth stack */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e33b158086fd..6a16bc1e775c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -424,6 +424,15 @@ struct hci_dev {
 	__u16		le_max_tx_time;
 	__u16		le_max_rx_len;
 	__u16		le_max_rx_time;
+	__u16		hdt_def_tx_len;
+	__u16		hdt_def_tx_time;
+	__u16		hdt_max_tx_len;
+	__u16		hdt_max_tx_time;
+	__u16		hdt_max_rx_len;
+	__u16		hdt_max_rx_time;
+	__u8		hdt_max_tx_win;
+	__u8		hdt_max_rx_win;
+	__u8		hdt_max_rx_packet;
 	__u8		le_max_key_size;
 	__u8		le_min_key_size;
 	__u16		discov_interleaved_timeout;
@@ -784,6 +793,7 @@ struct hci_conn {
 	__u8		le_rx_def_phys;
 	__u8		le_tx_phy;
 	__u8		le_rx_phy;
+	__u16		le_phy_opts;
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
@@ -2148,6 +2158,28 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	(past_sender_enabled(dev) || past_receiver_enabled(dev))
 #define ll_ext_feature_capable(dev) \
 	((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
+#define le_feature(dev, page, byte) \
+	(page ? ((dev)->le_features[(page - 1) * 24 + 8 + byte]) : \
+	((dev)->le_features[byte]))
+#define hdt_capable(dev) \
+	(((dev)->le_features[7] & BIT(3)) || \
+	(le_feature(dev, 1, 1) & HCI_LE_HDT_FEATURE))
+#define hdt_enabled(dev) \
+	(le_enabled(dev) && hdt_capable(dev))
+#define hdt_6_rx_capable(dev) \
+	(le_feature(dev, 1, 1) & HCI_LE_HDT_6_RX_FEATURE)
+#define hdt_6_tx_capable(dev) \
+	(le_feature(dev, 1, 1) & HCI_LE_HDT_6_TX_FEATURE)
+#define hdt_7_5_rx_capable(dev) \
+	(le_feature(dev, 1, 2) & HCI_LE_HDT_7_5_RX_FEATURE)
+#define hdt_7_5_tx_capable(dev) \
+	(le_feature(dev, 1, 2) & HCI_LE_HDT_7_5_TX_FEATURE)
+#define hdt_pf1_capable(dev) \
+	(le_feature(dev, 1, 2) & HCI_LE_HDT_PF_1)
+#define hdt_tx_capable(conn) \
+	((conn)->le_tx_def_phys & HCI_LE_SET_PHY_HDT)
+#define hdt_rx_capable(conn) \
+	((conn)->le_rx_def_phys & HCI_LE_SET_PHY_HDT)
 
 /* Channel sounding support */
 #define le_cs_capable(dev) \
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 59cb918d1405..a24f6a84a447 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -193,4 +193,7 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
 int hci_le_read_remote_features(struct hci_conn *conn);
 
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
-int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
+int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
+int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+			   u8 num_bis);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b02e915bb44c..17bdd6345d19 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -119,6 +119,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
 #define MGMT_SETTING_SCI		BIT(25)
+#define MGMT_SETTING_HDT		BIT(26)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b007f623b2ec..edf7be18a0cc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1941,11 +1941,8 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_create_big cp;
 	struct iso_list_data data;
 
-	memset(&cp, 0, sizeof(cp));
-
 	data.big = qos->bcast.big;
 	data.bis = qos->bcast.bis;
 	data.count = 0;
@@ -1954,84 +1951,14 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	hci_conn_hash_list_state(hdev, bis_list, BIS_LINK,
 				 BT_BOUND, &data);
 
-	cp.handle = qos->bcast.big;
-	cp.adv_handle = qos->bcast.bis;
-	cp.num_bis  = data.count;
-	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
-	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
-	cp.bis.latency =  cpu_to_le16(qos->bcast.out.latency);
-	cp.bis.rtn  = qos->bcast.out.rtn;
-	cp.bis.phy  = qos->bcast.out.phys;
-	cp.bis.packing = qos->bcast.packing;
-	cp.bis.framing = qos->bcast.framing;
-	cp.bis.encryption = qos->bcast.encryption;
-	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
-
-	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
+	return hci_le_create_big_sync(conn, qos, data.count);
 }
 
 static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 {
-	DEFINE_FLEX(struct hci_cp_le_set_cig_params, pdu, cis, num_cis, 0x1f);
 	u8 cig_id = PTR_UINT(data);
-	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
-	u8 aux_num_cis = 0;
-	u8 cis_id;
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn) {
-		hci_dev_unlock(hdev);
-		return 0;
-	}
-
-	qos = &conn->iso_qos;
-	pdu->cig_id = cig_id;
-	hci_cpu_to_le24(qos->ucast.out.interval, pdu->c_interval);
-	hci_cpu_to_le24(qos->ucast.in.interval, pdu->p_interval);
-	pdu->sca = qos->ucast.sca;
-	pdu->packing = qos->ucast.packing;
-	pdu->framing = qos->ucast.framing;
-	pdu->c_latency = cpu_to_le16(qos->ucast.out.latency);
-	pdu->p_latency = cpu_to_le16(qos->ucast.in.latency);
-
-	/* Reprogram all CIS(s) with the same CIG, valid range are:
-	 * num_cis: 0x00 to 0x1F
-	 * cis_id: 0x00 to 0xEF
-	 */
-	for (cis_id = 0x00; cis_id < 0xf0 &&
-	     aux_num_cis < pdu->num_cis; cis_id++) {
-		struct hci_cis_params *cis;
-
-		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, cig_id, cis_id);
-		if (!conn)
-			continue;
-
-		qos = &conn->iso_qos;
-
-		cis = &pdu->cis[aux_num_cis++];
-		cis->cis_id = cis_id;
-		cis->c_sdu  = cpu_to_le16(conn->iso_qos.ucast.out.sdu);
-		cis->p_sdu  = cpu_to_le16(conn->iso_qos.ucast.in.sdu);
-		cis->c_phys = qos->ucast.out.phys ? qos->ucast.out.phys :
-			      qos->ucast.in.phys;
-		cis->p_phys = qos->ucast.in.phys ? qos->ucast.in.phys :
-			      qos->ucast.out.phys;
-		cis->c_rtn  = qos->ucast.out.rtn;
-		cis->p_rtn  = qos->ucast.in.rtn;
-	}
-	pdu->num_cis = aux_num_cis;
 
-	hci_dev_unlock(hdev);
-
-	if (!pdu->num_cis)
-		return 0;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS,
-				     struct_size(pdu, cis, pdu->num_cis),
-				     pdu, HCI_CMD_TIMEOUT);
+	return hci_le_set_cig_params_sync(hdev, cig_id);
 }
 
 static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
@@ -3122,6 +3049,72 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 		if (conn->le_rx_def_phys & HCI_LE_SET_PHY_CODED)
 			phys |= BT_PHY_LE_CODED_RX;
 
+		if (conn->le_tx_def_phys & HCI_LE_SET_PHY_HDT) {
+			/* If le_phy_opts is set, it means user has
+			 * specified specific PHYs to use rather than the
+			 * default ones.
+			 */
+			if (conn->le_phy_opts) {
+				if (conn->le_phy_opts & BIT(2))
+					phys |= BT_PHY_HDT_2M_TX;
+
+				if (conn->le_phy_opts & BIT(3))
+					phys |= BT_PHY_HDT_3M_TX;
+
+				if (conn->le_phy_opts & BIT(4))
+					phys |= BT_PHY_HDT_4M_TX;
+
+				if (conn->le_phy_opts & BIT(5))
+					phys |= BT_PHY_HDT_6M_TX;
+
+				if (conn->le_phy_opts & BIT(6))
+					phys |= BT_PHY_HDT_7_5M_TX;
+			} else {
+				phys |= BT_PHY_HDT_2M_TX;
+				phys |= BT_PHY_HDT_3M_TX;
+				phys |= BT_PHY_HDT_4M_TX;
+
+				if (hdt_6_tx_capable(conn->hdev))
+					phys |= BT_PHY_HDT_6M_TX;
+
+				if (hdt_7_5_tx_capable(conn->hdev))
+					phys |= BT_PHY_HDT_7_5M_TX;
+			}
+		}
+
+		if (conn->le_rx_def_phys & HCI_LE_SET_PHY_HDT) {
+			/* If le_phy_opts is set, it means user has
+			 * specified specific PHYs to use rather than the
+			 * default ones.
+			 */
+			if (conn->le_phy_opts) {
+				if (conn->le_phy_opts & BIT(2))
+					phys |= BT_PHY_HDT_2M_RX;
+
+				if (conn->le_phy_opts & BIT(3))
+					phys |= BT_PHY_HDT_3M_RX;
+
+				if (conn->le_phy_opts & BIT(4))
+					phys |= BT_PHY_HDT_4M_RX;
+
+				if (conn->le_phy_opts & BIT(5))
+					phys |= BT_PHY_HDT_6M_RX;
+
+				if (conn->le_phy_opts & BIT(6))
+					phys |= BT_PHY_HDT_7_5M_RX;
+			} else {
+				phys |= BT_PHY_HDT_2M_RX;
+				phys |= BT_PHY_HDT_3M_RX;
+				phys |= BT_PHY_HDT_4M_RX;
+
+				if (hdt_6_rx_capable(conn->hdev))
+					phys |= BT_PHY_HDT_6M_RX;
+
+				if (hdt_7_5_rx_capable(conn->hdev))
+					phys |= BT_PHY_HDT_7_5M_RX;
+			}
+		}
+
 		break;
 	}
 
@@ -3175,7 +3168,7 @@ static u16 bt_phy_pkt_type(struct hci_conn *conn, u32 phys)
 	return pkt_type;
 }
 
-static int bt_phy_le_phy(u32 phys, u8 *tx_phys, u8 *rx_phys)
+static int bt_phy_le_phy(u32 phys, u8 *tx_phys, u8 *rx_phys, u16 *phy_opts)
 {
 	if (!tx_phys || !rx_phys)
 		return -EINVAL;
@@ -3201,12 +3194,47 @@ static int bt_phy_le_phy(u32 phys, u8 *tx_phys, u8 *rx_phys)
 	if (phys & BT_PHY_LE_CODED_RX)
 		*rx_phys |= HCI_LE_SET_PHY_CODED;
 
+	if (phys & BT_PHY_HDT_2M_TX || phys & BT_PHY_HDT_3M_TX ||
+	    phys & BT_PHY_HDT_4M_TX || phys & BT_PHY_HDT_6M_TX ||
+	    phys & BT_PHY_HDT_7_5M_TX) {
+		*tx_phys |= HCI_LE_SET_PHY_HDT;
+
+		if (phys & BT_PHY_HDT_2M_TX)
+			*phy_opts |= BIT(2);
+		if (phys & BT_PHY_HDT_3M_TX)
+			*phy_opts |= BIT(3);
+		if (phys & BT_PHY_HDT_4M_TX)
+			*phy_opts |= BIT(4);
+		if (phys & BT_PHY_HDT_6M_TX)
+			*phy_opts |= BIT(5);
+		if (phys & BT_PHY_HDT_7_5M_TX)
+			*phy_opts |= BIT(6);
+	}
+
+	if (phys & BT_PHY_HDT_2M_RX || phys & BT_PHY_HDT_3M_RX ||
+	    phys & BT_PHY_HDT_4M_RX || phys & BT_PHY_HDT_6M_RX ||
+	    phys & BT_PHY_HDT_7_5M_RX) {
+		*rx_phys |= HCI_LE_SET_PHY_HDT;
+
+		if (phys & BT_PHY_HDT_2M_RX)
+			*phy_opts |= BIT(2);
+		if (phys & BT_PHY_HDT_3M_RX)
+			*phy_opts |= BIT(3);
+		if (phys & BT_PHY_HDT_4M_RX)
+			*phy_opts |= BIT(4);
+		if (phys & BT_PHY_HDT_6M_RX)
+			*phy_opts |= BIT(5);
+		if (phys & BT_PHY_HDT_7_5M_RX)
+			*phy_opts |= BIT(6);
+	}
+
 	return 0;
 }
 
 int hci_conn_set_phy(struct hci_conn *conn, u32 phys)
 {
 	u8 tx_phys, rx_phys;
+	u16 phy_opts;
 
 	switch (conn->type) {
 	case SCO_LINK:
@@ -3221,13 +3249,20 @@ int hci_conn_set_phy(struct hci_conn *conn, u32 phys)
 					       bt_phy_pkt_type(conn, phys));
 	case LE_LINK:
 		/* Only allow setting LE PHYs if link type is LE */
-		if (phys & ~BT_PHY_LE_MASK)
-			return -EINVAL;
+		if (phys & ~BT_PHY_LE_MASK) {
+			/* Check if HDT PHYs are supported */
+			if (!hdt_tx_capable(conn) && !hdt_rx_capable(conn))
+				return -EINVAL;
+
+			/* Check if any HDT PHYs are set */
+			if (phys & ~BT_PHY_HDT_MASK)
+				return -EINVAL;
+		}
 
-		if (bt_phy_le_phy(phys, &tx_phys, &rx_phys))
+		if (bt_phy_le_phy(phys, &tx_phys, &rx_phys, &phy_opts))
 			return -EINVAL;
 
-		return hci_le_set_phy(conn, tx_phys, rx_phys);
+		return hci_le_set_phy(conn, tx_phys, rx_phys, phy_opts);
 	default:
 		return -EINVAL;
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f0ce124bb12b..466f09124fcd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2995,6 +2995,7 @@ static void hci_cs_le_set_phy(struct hci_dev *hdev, u8 status)
 	if (conn) {
 		conn->le_tx_def_phys = cp->tx_phys;
 		conn->le_rx_def_phys = cp->rx_phys;
+		conn->le_phy_opts = __le16_to_cpu(cp->phy_opts);
 	}
 
 	hci_dev_unlock(hdev);
@@ -3942,6 +3943,35 @@ static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
 	rcu_read_unlock();
 }
 
+static u8 hci_cc_le_read_def_data_len_v2(struct hci_dev *hdev, void *data,
+					 struct sk_buff *skb)
+{
+	struct hci_rp_le_read_def_data_len_v2 *rp = data;
+	struct hci_cp_le_read_def_data_len_v2 *cp;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_READ_DEF_DATA_LEN_V2);
+	if (!cp)
+		return rp->status;
+
+	switch (cp->phys) {
+	case 0x00: /* All GFSK PHYs */
+		hdev->le_def_tx_len = le16_to_cpu(rp->tx_len);
+		hdev->le_def_tx_time = le16_to_cpu(rp->tx_time);
+		break;
+	case 0x01: /* HDT PHY */
+		hdev->hdt_def_tx_len = le16_to_cpu(rp->tx_len);
+		hdev->hdt_def_tx_time = le16_to_cpu(rp->tx_time);
+		break;
+	}
+
+	return rp->status;
+}
+
 static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 					struct sk_buff *skb)
 {
@@ -3969,6 +3999,78 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_read_max_data_len_v2(struct hci_dev *hdev, void *data,
+					 struct sk_buff *skb)
+{
+	struct hci_rp_le_read_max_data_len_v2 *rp = data;
+	struct hci_cp_le_read_max_data_len_v2 *cp;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_READ_MAX_DATA_LEN_V2);
+	if (!cp)
+		return rp->status;
+
+	switch (cp->phy) {
+	case 0x00:
+	case 0x01:
+	case 0x02:
+	case 0x03:
+		hdev->le_max_tx_len = le16_to_cpu(rp->tx_len);
+		hdev->le_max_tx_time = le16_to_cpu(rp->tx_time);
+		hdev->le_max_rx_len = le16_to_cpu(rp->rx_len);
+		hdev->le_max_rx_time = le16_to_cpu(rp->rx_time);
+		break;
+	case 0x05:
+		hdev->hdt_max_tx_len = le16_to_cpu(rp->tx_len);
+		hdev->hdt_max_tx_time = le16_to_cpu(rp->tx_time);
+		hdev->hdt_max_rx_len = le16_to_cpu(rp->rx_len);
+		hdev->hdt_max_rx_time = le16_to_cpu(rp->rx_time);
+		hdev->hdt_max_tx_win = rp->tx_win;
+		hdev->hdt_max_rx_win = rp->rx_win;
+		hdev->hdt_max_rx_packet = rp->rx_packet;
+		break;
+	}
+
+	return rp->status;
+}
+
+static u8 hci_cc_le_write_def_data_len_v2(struct hci_dev *hdev, void *data,
+					  struct sk_buff *skb)
+{
+	struct hci_cp_le_write_def_data_len_v2 *sent;
+	struct hci_ev_status *rp = data;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_WRITE_DEF_DATA_LEN_V2);
+	if (!sent)
+		return rp->status;
+
+	hci_dev_lock(hdev);
+
+	switch (sent->phys) {
+	case 0x00:
+		hdev->le_def_tx_len = le16_to_cpu(sent->tx_len);
+		hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);
+		break;
+	case 0x01:
+		hdev->hdt_def_tx_len = le16_to_cpu(sent->tx_len);
+		hdev->hdt_def_tx_time = le16_to_cpu(sent->tx_time);
+		break;
+	}
+
+	hci_dev_unlock(hdev);
+
+	return rp->status;
+}
+
 static void hci_unbound_cis_failed(struct hci_dev *hdev, u8 cig, u8 status)
 {
 	struct hci_conn *conn, *tmp;
@@ -4121,6 +4223,72 @@ static u8 hci_cc_le_read_all_local_features(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_set_cig_params_v2(struct hci_dev *hdev, void *data,
+				      struct sk_buff *skb)
+{
+	struct hci_rp_le_set_cig_params_v2 *rp = data;
+	struct hci_cp_le_set_cig_params_v2 *cp;
+	struct hci_conn *conn;
+	u8 status = rp->status;
+	bool pending = false;
+	int i;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS_V2);
+	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
+			    rp->cig_id != cp->cig_id)) {
+		bt_dev_err(hdev,
+			   "unexpected Set CIG Parameters V3 response data");
+		status = HCI_ERROR_UNSPECIFIED;
+	}
+
+	hci_dev_lock(hdev);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 2554
+	 *
+	 * If the Status return parameter is non-zero, then the state of the CIG
+	 * and its CIS configurations shall not be changed by the command. If
+	 * the CIG did not already exist, it shall not be created.
+	 */
+	if (status) {
+		/* Keep current configuration, fail only the unbound CIS */
+		hci_unbound_cis_failed(hdev, rp->cig_id, status);
+		goto unlock;
+	}
+
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2553
+	 *
+	 * If the Status return parameter is zero, then the Controller shall
+	 * set the Connection_Handle arrayed return parameter to the connection
+	 * handle(s) corresponding to the CIS configurations specified in
+	 * the CIS_IDs command parameter, in the same order.
+	 */
+	for (i = 0; i < rp->num_handles; ++i) {
+		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, rp->cig_id,
+						cp->cis[i].cis_id);
+		if (!conn || !bacmp(&conn->dst, BDADDR_ANY))
+			continue;
+
+		if (conn->state != BT_BOUND && conn->state != BT_CONNECT)
+			continue;
+
+		if (hci_conn_set_handle(conn, __le16_to_cpu(rp->handle[i])))
+			continue;
+
+		if (conn->state == BT_CONNECT)
+			pending = true;
+	}
+
+unlock:
+	if (pending)
+		hci_le_create_cis_pending(hdev);
+
+	hci_dev_unlock(hdev);
+
+	return rp->status;
+}
+
 static void hci_cs_le_create_big(struct hci_dev *hdev, u8 status)
 {
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
@@ -4409,8 +4577,14 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_TRANSMIT_POWER, hci_cc_le_read_transmit_power,
 	       sizeof(struct hci_rp_le_read_transmit_power)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_PRIVACY_MODE, hci_cc_le_set_privacy_mode),
+	HCI_CC(HCI_OP_LE_READ_DEF_DATA_LEN_V2, hci_cc_le_read_def_data_len_v2,
+	       sizeof(struct hci_rp_le_read_def_data_len_v2)),
 	HCI_CC(HCI_OP_LE_READ_BUFFER_SIZE_V2, hci_cc_le_read_buffer_size_v2,
 	       sizeof(struct hci_rp_le_read_buffer_size_v2)),
+	HCI_CC(HCI_OP_LE_READ_MAX_DATA_LEN_V2, hci_cc_le_read_max_data_len_v2,
+	       sizeof(struct hci_rp_le_read_max_data_len_v2)),
+	HCI_CC_STATUS(HCI_OP_LE_WRITE_DEF_DATA_LEN_V2,
+		      hci_cc_le_write_def_data_len_v2),
 	HCI_CC_VL(HCI_OP_LE_SET_CIG_PARAMS, hci_cc_le_set_cig_params,
 		  sizeof(struct hci_rp_le_set_cig_params), HCI_MAX_CC_PLEN),
 	HCI_CC(HCI_OP_LE_SETUP_ISO_PATH, hci_cc_le_setup_iso_path,
@@ -4418,6 +4592,9 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_ALL_LOCAL_FEATURES,
 	       hci_cc_le_read_all_local_features,
 	       sizeof(struct hci_rp_le_read_all_local_features)),
+	HCI_CC_VL(HCI_OP_LE_SET_CIG_PARAMS_V2, hci_cc_le_set_cig_params_v2,
+		  sizeof(struct hci_rp_le_set_cig_params_v2),
+		  HCI_MAX_CC_PLEN),
 };
 
 static u8 hci_cc_func(struct hci_dev *hdev, const struct hci_cc *cc,
@@ -7623,6 +7800,11 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_CODED;
 			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_CODED;
 		}
+
+		if (!hdt_capable(conn)) {
+			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_HDT;
+			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_HDT;
+		}
 	}
 
 	if (conn->state == BT_CONFIG) {
@@ -7682,6 +7864,142 @@ static void hci_le_conn_rate_change_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
+					  struct sk_buff *skb)
+{
+	struct hci_evt_le_cis_established_v3 *ev = data;
+	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
+	bool pending = false;
+	u16 handle = __le16_to_cpu(ev->handle);
+	u32 c_sdu_interval, p_sdu_interval;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn) {
+		bt_dev_err(hdev,
+			   "Unable to find connection with handle 0x%4.4x",
+			   handle);
+		goto unlock;
+	}
+
+	if (conn->type != CIS_LINK) {
+		bt_dev_err(hdev,
+			   "Invalid connection link type handle 0x%4.4x",
+			   handle);
+		goto unlock;
+	}
+
+	qos = &conn->iso_qos;
+
+	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, conn->flags);
+
+	c_sdu_interval = get_unaligned_le24(ev->c_sdu_interval);
+	p_sdu_interval = get_unaligned_le24(ev->p_sdu_interval);
+
+	switch (conn->role) {
+	case HCI_ROLE_SLAVE:
+		qos->ucast.in.interval = c_sdu_interval;
+		qos->ucast.out.interval = p_sdu_interval;
+		/* Convert Transport Latency (us) to Latency (msec) */
+		qos->ucast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
+					  1000);
+		qos->ucast.out.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
+					  1000);
+		qos->ucast.in.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
+		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
+		qos->ucast.in.phys = le_phy_qos(ev->c_phy);
+		qos->ucast.out.phys = le_phy_qos(ev->p_phy);
+		break;
+	case HCI_ROLE_MASTER:
+		qos->ucast.in.interval = p_sdu_interval;
+		qos->ucast.out.interval = c_sdu_interval;
+		/* Convert Transport Latency (us) to Latency (msec) */
+		qos->ucast.out.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
+					  1000);
+		qos->ucast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
+					  1000);
+		qos->ucast.out.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
+		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
+		qos->ucast.out.phys = le_phy_qos(ev->c_phy);
+		qos->ucast.in.phys = le_phy_qos(ev->p_phy);
+		break;
+	}
+
+	if (!ev->status) {
+		conn->state = BT_CONNECTED;
+		hci_debugfs_create_conn(conn);
+		hci_conn_add_sysfs(conn);
+		hci_iso_setup_path(conn);
+		goto unlock;
+	}
+
+	conn->state = BT_CLOSED;
+	hci_connect_cfm(conn, ev->status);
+	hci_conn_del(conn);
+
+unlock:
+	if (pending)
+		hci_le_create_cis_pending(hdev);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_le_create_big_complete_v2_evt(struct hci_dev *hdev, void *data,
+					      struct sk_buff *skb)
+{
+	struct hci_evt_le_create_big_complete_v2 *ev = data;
+	struct hci_conn *conn;
+	__u8 i = 0;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_CREATE_BIG_COMPLETE_V2,
+				flex_array_size(ev, bis_handle, ev->num_bis)))
+		return;
+
+	hci_dev_lock(hdev);
+
+	/* Connect all BISes that are bound to the BIG */
+	while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
+						      BT_BOUND,
+						      HCI_ROLE_MASTER))) {
+		if (ev->status) {
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+			continue;
+		}
+
+		if (hci_conn_set_handle(conn,
+					__le16_to_cpu(ev->bis_handle[i++])))
+			continue;
+
+		conn->state = BT_CONNECTED;
+		set_bit(HCI_CONN_BIG_CREATED, conn->flags);
+		hci_debugfs_create_conn(conn);
+		hci_conn_add_sysfs(conn);
+		hci_iso_setup_path(conn);
+	}
+
+	if (!ev->status && !i)
+		/* If no BISes have been connected for the BIG,
+		 * terminate. This is in case all bound connections
+		 * have been closed before the BIG creation
+		 * has completed.
+		 */
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
+				   UINT_PTR(ev->handle), NULL);
+
+	hci_dev_unlock(hdev);
+}
+
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
 [_op] = { \
 	.func = _func, \
@@ -7799,6 +8117,14 @@ static const struct hci_le_ev {
 	/* [0x37 = HCI_EVT_LE_CONN_RATE_CHANGE] */
 	HCI_LE_EV(HCI_EVT_LE_CONN_RATE_CHANGE, hci_le_conn_rate_change_evt,
 		  sizeof(struct hci_evt_le_conn_rate_change)),
+	/* [0x3a = HCI_EVT_LE_CIS_ESTABLISHED_V3] */
+	HCI_LE_EV(HCI_EVT_LE_CIS_ESTABLISHED_V3, hci_le_cis_established_evt_v3,
+		  sizeof(struct hci_evt_le_cis_established_v3)),
+	/* [0x3b = HCI_EVT_LE_CREATE_BIG_COMPLETE_V2] */
+	HCI_LE_EV_VL(HCI_EVT_LE_CREATE_BIG_COMPLETE_V2,
+		     hci_le_create_big_complete_v2_evt,
+		     sizeof(struct hci_evt_le_create_big_complete_v2),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 };
 
 static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9213e3ef9f26..a076ff131bc4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4717,6 +4717,13 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (le_sci_capable(hdev))
 		events[6] |= 0x40;	/* LE Connection Rate Change event */
 
+	if (hdt_capable(hdev)) {
+		/* HDT events */
+		events[7] |= BIT(0);	/* LE Data Length Change v2  */
+		events[7] |= BIT(1);	/* LE CIS Established v3  */
+		events[7] |= BIT(2);	/* LE Create BIG Complete v2  */
+	}
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
 				     sizeof(events), events, HCI_CMD_TIMEOUT);
 }
@@ -4794,22 +4801,71 @@ static int hci_le_set_rpa_timeout_sync(struct hci_dev *hdev)
 				     HCI_CMD_TIMEOUT);
 }
 
+/* Read LE Maximum Data Length V2 */
+static int hci_le_read_max_data_len_v2_sync(struct hci_dev *hdev, u8 phy)
+{
+	struct hci_cp_le_read_max_data_len_v2 cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.phy = phy;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_MAX_DATA_LEN_V2,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* Read LE Maximum Data Length */
 static int hci_le_read_max_data_len_sync(struct hci_dev *hdev)
 {
 	if (!(hdev->le_features[0] & HCI_LE_DATA_LEN_EXT))
 		return 0;
 
+	/* Check if HDT PHY and HCI_OP_LE_READ_MAX_DATA_LEN_V2 are supported */
+	if (hdt_capable(hdev) && hdev->commands[50] & BIT(5)) {
+		int err;
+
+		/* Read max data length for non-hdt PHYs (use 0x01 for LE 1M) */
+		err = hci_le_read_max_data_len_v2_sync(hdev, 0x01);
+		if (err)
+			return err;
+
+		/* Read max data length for HDT (0x05) */
+		return hci_le_read_max_data_len_v2_sync(hdev, 0x05);
+	}
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL,
 				     HCI_CMD_TIMEOUT);
 }
 
+/* Read LE Suggested Default Data Length V2 */
+static int hci_le_read_def_data_len_v2_sync(struct hci_dev *hdev, u8 phys)
+{
+	struct hci_cp_le_read_def_data_len_v2 cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.phys = phys;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_DEF_DATA_LEN_V2,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* Read LE Suggested Default Data Length */
 static int hci_le_read_def_data_len_sync(struct hci_dev *hdev)
 {
 	if (!(hdev->le_features[0] & HCI_LE_DATA_LEN_EXT))
 		return 0;
 
+	if (hdt_capable(hdev) && hdev->commands[50] & BIT(6)) {
+		int err;
+
+		/* All GFSK PHYs */
+		err = hci_le_read_def_data_len_v2_sync(hdev, 0x00);
+		if (err)
+			return err;
+
+		/* HDT PHY */
+		return hci_le_read_def_data_len_v2_sync(hdev, 0x01);
+	}
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_DEF_DATA_LEN, 0, NULL,
 				     HCI_CMD_TIMEOUT);
 }
@@ -5233,6 +5289,39 @@ static const struct hci_init_stage hci_init4[] = {
 	{}
 };
 
+/* Write Suggested Default Data Length V2 */
+static int hci_le_write_def_data_len_v2_sync(struct hci_dev *hdev, u8 phys)
+{
+	struct hci_cp_le_write_def_data_len_v2 cp;
+
+	switch (phys) {
+	case 0x00:
+		/* If already set to max skip */
+		if (hdev->le_def_tx_len == hdev->le_max_tx_len)
+			return 0;
+
+		memset(&cp, 0, sizeof(cp));
+		/* All GFSK PHYs */
+		cp.tx_len = cpu_to_le16(hdev->le_max_tx_len);
+		cp.tx_time = cpu_to_le16(hdev->le_max_tx_time);
+		break;
+	case 0x01:
+		/* If already set to max skip */
+		if (hdev->hdt_def_tx_len == hdev->hdt_max_tx_len)
+			return 0;
+
+		memset(&cp, 0, sizeof(cp));
+		/* HDT PHY */
+		cp.phys = 0x01;
+		cp.tx_len = cpu_to_le16(hdev->hdt_max_tx_len);
+		cp.tx_time = cpu_to_le16(hdev->hdt_max_tx_time);
+		break;
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_WRITE_DEF_DATA_LEN_V2,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* Set Suggested Default Data Length to maximum if supported */
 static int hci_le_set_write_def_data_len_sync(struct hci_dev *hdev)
 {
@@ -5241,7 +5330,31 @@ static int hci_le_set_write_def_data_len_sync(struct hci_dev *hdev)
 	if (!(hdev->le_features[0] & HCI_LE_DATA_LEN_EXT))
 		return 0;
 
+	/* Clamp if reported value is over maximum allowed by spec */
+	if (hdev->le_max_tx_len > 0x00fb)
+		hdev->le_max_tx_len = 0x00fb;
+
+	if (hdev->le_max_tx_time > 0x4290)
+		hdev->le_max_tx_time = 0x4290;
+
+	/* If controller is HDT check if it support V2 then use it */
+	if (hdt_capable(hdev) && hdev->commands[50] & BIT(7)) {
+		int err;
+
+		/* All GFSK PHYs */
+		err = hci_le_write_def_data_len_v2_sync(hdev, 0x00);
+		if (err)
+			return err;
+
+		return hci_le_write_def_data_len_v2_sync(hdev, 0x01);
+	}
+
+	/* If already set to max skip */
+	if (hdev->le_def_tx_len == hdev->le_max_tx_len)
+		return 0;
+
 	memset(&cp, 0, sizeof(cp));
+
 	cp.tx_len = cpu_to_le16(hdev->le_max_tx_len);
 	cp.tx_time = cpu_to_le16(hdev->le_max_tx_time);
 
@@ -5282,6 +5395,12 @@ static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 		cp.rx_phys |= HCI_LE_SET_PHY_CODED;
 	}
 
+	/* Enables HDT PHY if supported */
+	if (hdt_capable(hdev)) {
+		cp.tx_phys |= HCI_LE_SET_PHY_HDT;
+		cp.rx_phys |= HCI_LE_SET_PHY_HDT;
+	}
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEFAULT_PHY,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
@@ -8225,7 +8344,7 @@ static int hci_le_set_phy_sync(struct hci_dev *hdev, void *data)
 					HCI_CMD_TIMEOUT, NULL);
 }
 
-int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
+int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_set_phy *cp;
@@ -8239,6 +8358,7 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->tx_phys = tx_phys;
 	cp->rx_phys = rx_phys;
+	cp->phy_opts = cpu_to_le16(phy_opts);
 
 	err = hci_cmd_sync_queue_once(hdev, hci_le_set_phy_sync, cp,
 				      le_phy_update_complete);
@@ -8247,3 +8367,223 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
 
 	return (err == -EEXIST) ? 0 : err;
 }
+
+/* LE Set CIG Params V3 */
+static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
+{
+	DEFINE_FLEX(struct hci_cp_le_set_cig_params_v2, pdu, cis, num_cis,
+		    0x1f);
+	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
+	u8 aux_num_cis = 0;
+	u8 cis_id;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
+	if (!conn) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
+	qos = &conn->iso_qos;
+	pdu->cig_id = cig_id;
+	hci_cpu_to_le24(qos->ucast.out.interval, pdu->c_interval);
+	hci_cpu_to_le24(qos->ucast.in.interval, pdu->p_interval);
+	pdu->sca = qos->ucast.sca;
+	pdu->packing = qos->ucast.packing;
+	pdu->framing = qos->ucast.framing;
+	pdu->c_latency = cpu_to_le16(qos->ucast.out.latency);
+	pdu->p_latency = cpu_to_le16(qos->ucast.in.latency);
+
+	/* Reprogram all CIS(s) with the same CIG, valid range are:
+	 * num_cis: 0x00 to 0x1F
+	 * cis_id: 0x00 to 0xEF
+	 */
+	for (cis_id = 0x00; cis_id < 0xf0 &&
+	     aux_num_cis < pdu->num_cis; cis_id++) {
+		struct hci_cis_params_v2 *cis;
+
+		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, cig_id, cis_id);
+		if (!conn)
+			continue;
+
+		qos = &conn->iso_qos;
+
+		cis = &pdu->cis[aux_num_cis++];
+		cis->cis_id = cis_id;
+		cis->c_sdu  = cpu_to_le16(conn->iso_qos.ucast.out.sdu);
+		cis->p_sdu  = cpu_to_le16(conn->iso_qos.ucast.in.sdu);
+		cis->c_phys = qos->ucast.out.phys ? qos->ucast.out.phys :
+			      qos->ucast.in.phys;
+		cis->p_phys = qos->ucast.in.phys ? qos->ucast.in.phys :
+			      qos->ucast.out.phys;
+		cis->c_rtn  = qos->ucast.out.rtn;
+		cis->p_rtn  = qos->ucast.in.rtn;
+
+		if (cis->c_phys & BIT(4)) {
+			cis->c_hdt_rates |= BIT(0); /* HDT 2M */
+			cis->c_hdt_rates |= BIT(1); /* HDT 3M */
+			cis->c_hdt_rates |= BIT(2); /* HDT 4M */
+
+			if (hdt_6_tx_capable(hdev))
+				cis->c_hdt_rates |= BIT(3); /* HDT 6M */
+
+			if (hdt_7_5_tx_capable(hdev))
+				cis->c_hdt_rates |= BIT(4); /* HDT 7.5M */
+		}
+
+		if (cis->p_phys & BIT(4)) {
+			cis->p_hdt_rates |= BIT(0); /* HDT 2M */
+			cis->p_hdt_rates |= BIT(1); /* HDT 3M */
+			cis->p_hdt_rates |= BIT(2); /* HDT 4M */
+
+			if (hdt_6_rx_capable(hdev))
+				cis->p_hdt_rates |= BIT(3); /* HDT 6M */
+
+			if (hdt_7_5_rx_capable(hdev))
+				cis->p_hdt_rates |= BIT(4); /* HDT 7.5M */
+		}
+	}
+	pdu->num_cis = aux_num_cis;
+
+	hci_dev_unlock(hdev);
+
+	if (!pdu->num_cis)
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS_V2,
+				     struct_size(pdu, cis, pdu->num_cis),
+				     pdu, HCI_CMD_TIMEOUT);
+}
+
+/* LE Set CIG Params */
+int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
+{
+	DEFINE_FLEX(struct hci_cp_le_set_cig_params, pdu, cis, num_cis, 0x1f);
+	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
+	u8 aux_num_cis = 0;
+	u8 cis_id;
+
+	if (hdt_capable(hdev) && hdev->commands[51] & BIT(0))
+		return hci_le_set_cig_params_v2_sync(hdev, cig_id);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
+	if (!conn) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
+	qos = &conn->iso_qos;
+	pdu->cig_id = cig_id;
+	hci_cpu_to_le24(qos->ucast.out.interval, pdu->c_interval);
+	hci_cpu_to_le24(qos->ucast.in.interval, pdu->p_interval);
+	pdu->sca = qos->ucast.sca;
+	pdu->packing = qos->ucast.packing;
+	pdu->framing = qos->ucast.framing;
+	pdu->c_latency = cpu_to_le16(qos->ucast.out.latency);
+	pdu->p_latency = cpu_to_le16(qos->ucast.in.latency);
+
+	/* Reprogram all CIS(s) with the same CIG, valid range are:
+	 * num_cis: 0x00 to 0x1F
+	 * cis_id: 0x00 to 0xEF
+	 */
+	for (cis_id = 0x00; cis_id < 0xf0 &&
+	     aux_num_cis < pdu->num_cis; cis_id++) {
+		struct hci_cis_params *cis;
+
+		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, cig_id, cis_id);
+		if (!conn)
+			continue;
+
+		qos = &conn->iso_qos;
+
+		cis = &pdu->cis[aux_num_cis++];
+		cis->cis_id = cis_id;
+		cis->c_sdu  = cpu_to_le16(conn->iso_qos.ucast.out.sdu);
+		cis->p_sdu  = cpu_to_le16(conn->iso_qos.ucast.in.sdu);
+		cis->c_phys = qos->ucast.out.phys ? qos->ucast.out.phys :
+			      qos->ucast.in.phys;
+		cis->p_phys = qos->ucast.in.phys ? qos->ucast.in.phys :
+			      qos->ucast.out.phys;
+		cis->c_rtn  = qos->ucast.out.rtn;
+		cis->p_rtn  = qos->ucast.in.rtn;
+	}
+	pdu->num_cis = aux_num_cis;
+
+	hci_dev_unlock(hdev);
+
+	if (!pdu->num_cis)
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS,
+				     struct_size(pdu, cis, pdu->num_cis),
+				     pdu, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_create_big_v2_sync(struct hci_conn *conn,
+				     struct bt_iso_qos *qos, u8 num_bis)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_create_big_v2 cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = qos->bcast.big;
+	cp.adv_handle = qos->bcast.bis;
+	cp.num_bis  = num_bis;
+	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
+	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
+	cp.bis.latency = cpu_to_le16(qos->bcast.out.latency);
+	cp.bis.rtn = qos->bcast.out.rtn;
+	cp.bis.phys = qos->bcast.out.phys;
+	cp.bis.packing = qos->bcast.packing;
+	cp.bis.framing = qos->bcast.framing;
+	cp.bis.encryption = qos->bcast.encryption;
+	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+
+	/* Check if HDT PHY is set then enable HDT supported rates */
+	if (cp.bis.phys & BIT(4)) {
+		cp.bis.coded_rates |= BIT(0); /* HDT 2M */
+		cp.bis.coded_rates |= BIT(1); /* HDT 3M */
+		cp.bis.coded_rates |= BIT(2); /* HDT 4M */
+
+		if (hdt_6_tx_capable(hdev))
+			cp.bis.coded_rates |= BIT(3); /* HDT 6M */
+
+		if (hdt_7_5_tx_capable(hdev))
+			cp.bis.coded_rates |= BIT(4); /* HDT 7.5M */
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG_V2,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+			   u8 num_bis)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_create_big cp;
+
+	if (hdt_capable(hdev) && hdev->commands[51] & BIT(3))
+		return hci_le_create_big_v2_sync(conn, qos, num_bis);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = qos->bcast.big;
+	cp.adv_handle = qos->bcast.bis;
+	cp.num_bis  = num_bis;
+	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
+	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
+	cp.bis.latency =  cpu_to_le16(qos->bcast.out.latency);
+	cp.bis.rtn  = qos->bcast.out.rtn;
+	cp.bis.phys = qos->bcast.out.phys;
+	cp.bis.packing = qos->bcast.packing;
+	cp.bis.framing = qos->bcast.framing;
+	cp.bis.encryption = qos->bcast.encryption;
+	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 260ef2a45719..6ed3bf6f1738 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -865,6 +865,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (le_sci_capable(hdev))
 		settings |= MGMT_SETTING_SCI;
 
+	if (hdt_capable(hdev))
+		settings |= MGMT_SETTING_HDT;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -959,6 +962,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (le_sci_enabled(hdev))
 		settings |= MGMT_SETTING_SCI;
 
+	if (hdt_enabled(hdev))
+		settings |= MGMT_SETTING_HDT;
+
 	return settings;
 }
 
-- 
2.56.0

