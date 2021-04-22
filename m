Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A4BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14779613DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhDVOL4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:11:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:14926 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236544AbhDVOLz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 10:11:55 -0400
IronPort-SDR: VwneOxwNemmfRh0f65yUVeqSkh2SoK6zDGi/JlffRo+5xDER/FaZvu5Er9Nvd4SzB+qLEA9JxJ
 pQKSN1Qa3gYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="193773437"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="193773437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 07:11:21 -0700
IronPort-SDR: f9U11uzsLCFb4223wSujEpOD/a01x82/jkMAkTHbytSBvaDU56SZ8CHyHoTrfWsJJHdAuOrO3f
 5QCupERiGJRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="427961241"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2021 07:11:18 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Subject: [PATCH v3 3/3] Bluetooth: cache local supported codec capabilities
Date:   Thu, 22 Apr 2021 19:44:49 +0530
Message-Id: <20210422141449.25155-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422141449.25155-1-kiran.k@intel.com>
References: <20210422141449.25155-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Cache the codec information in the driver and this data can
be exposed to user space audio modules via getsockopt

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v3
  remove unwanted log

* changes in v2
  add skb length check before accessing data

 include/net/bluetooth/hci.h      | 11 +++++++++++
 include/net/bluetooth/hci_core.h | 13 +++++++++++++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 34eb9f4b027f..6b4344639ff7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1323,6 +1323,17 @@ struct hci_op_read_local_codec_caps {
 	__u8	direction;
 } __packed;
 
+struct hci_codec_caps {
+	__u8	len;
+	__u8	caps[];
+} __packed;
+
+struct hci_rp_read_local_codec_caps {
+	__u8	status;
+	__u8	num_caps;
+	struct hci_codec_caps caps[];
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
 struct hci_rp_read_page_scan_activity {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2c19b02a805d..b40c7ed38d18 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -131,6 +131,14 @@ struct bdaddr_list {
 	u8 bdaddr_type;
 };
 
+struct codec_list {
+	struct list_head list;
+	u8	transport;
+	u8	codec_id[5];
+	u8	num_caps;
+	struct hci_codec_caps caps[];
+};
+
 struct bdaddr_list_with_irk {
 	struct list_head list;
 	bdaddr_t bdaddr;
@@ -534,6 +542,7 @@ struct hci_dev {
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
 	struct list_head	blocked_keys;
+	struct list_head	local_codecs;
 
 	struct hci_dev_stats	stat;
 
@@ -1843,6 +1852,10 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
+int hci_codec_list_add(struct list_head *list, struct hci_rp_read_local_codec_caps *rp,
+		       __u32 len,
+		       struct hci_op_read_local_codec_caps *sent);
+void hci_codec_list_clear(struct list_head *codec_list);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fda7077d0d47..17dc342f4486 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3569,6 +3569,35 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 	BT_DBG("All LE disabled connection parameters were removed");
 }
 
+int hci_codec_list_add(struct list_head *list, struct hci_rp_read_local_codec_caps *rp,
+		       __u32 len,
+		       struct hci_op_read_local_codec_caps *sent)
+{
+	struct codec_list *entry;
+
+	entry = kzalloc(sizeof(*entry) + len, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->codec_id, sent->codec_id, 5);
+	entry->transport = sent->transport;
+	entry->num_caps = rp->num_caps;
+	if (rp->num_caps)
+		memcpy(entry->caps, rp->caps, len);
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
+void hci_codec_list_clear(struct list_head *codec_list)
+{
+	struct codec_list *c, *n;
+
+	list_for_each_entry_safe(c, n, codec_list, list) {
+		list_del(&c->list);
+		kfree(c);
+	}
+}
 /* This function requires the caller holds hdev->lock */
 static void hci_conn_params_clear_all(struct hci_dev *hdev)
 {
@@ -3828,6 +3857,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
 	INIT_LIST_HEAD(&hdev->blocked_keys);
+	INIT_LIST_HEAD(&hdev->local_codecs);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -4046,6 +4076,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
+	hci_codec_list_clear(&hdev->local_codecs);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ca3535f30de..b55cd02abd02 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1057,6 +1057,34 @@ static void hci_cc_read_local_codecs_v2(struct hci_dev *hdev,
 	}
 }
 
+static void hci_cc_read_local_codec_caps(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_op_read_local_codec_caps *sent;
+	struct hci_rp_read_local_codec_caps *rp;
+
+	if (skb->len < sizeof(*rp))
+		return;
+
+	rp = (void *)skb->data;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS);
+
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hci_codec_list_add(&hdev->local_codecs, rp, skb->len - 2, sent);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_clock *rp = (void *) skb->data;
@@ -3615,6 +3643,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_local_codecs_v2(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_CODEC_CAPS:
+		hci_cc_read_local_codec_caps(hdev, skb);
+		break;
+
 	case HCI_OP_READ_FLOW_CONTROL_MODE:
 		hci_cc_read_flow_control_mode(hdev, skb);
 		break;
-- 
2.17.1

