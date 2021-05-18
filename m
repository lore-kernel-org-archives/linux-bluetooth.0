Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2606C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E68B611CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbhERKkH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:23229 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241902AbhERKkE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:04 -0400
IronPort-SDR: Iepi18u/V6rNEJtiXjGAXNMkkPHcqbJLesVGL1w4idq6ro4mQ9JbEBFSNB2fopCli0wlZr12x0
 4BrDm9Jfo6kQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804803"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804803"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:38:46 -0700
IronPort-SDR: Z0KXI2DQ6jMtWD6sGq/qGG2WONRmt/eECNTxbuWO/uCTpZdiMNknBdMkXCt/YbzappxJYFzHt9
 sOx72Yfw5zXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017806"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:38:44 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 1/9] Bluetooth: enumerate local supported codec and cache details
Date:   Tue, 18 May 2021 16:12:24 +0530
Message-Id: <20210518104232.5431-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move reading of supported local codecs into a separate init function,
query codecs capabilities and cache the data

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
* changes in v8:
  - add comments
  - split __u8 codec_id[5] into {__u8 id; __le16 cid, vid }
  - address review comment related codec caps structure

* changes in v7:
  - keep codec enumeration call in hci_init instead of having a separate
    function
  - Remove unused bitmasks defined for LE transports

* changes  in v6:
  - fix compiler warning reported for ARCH=arc

* changes in v5:
  - fix review comments
  - move code used to read standard/vendor codecs caps into single function

* changes in v4:
  - convert  reading of codecs and codecs caps calls from async to sync

* changes in v3
  move codec enumeration into a new init function

* changes in v2
  add skb length check before accessing data

 include/net/bluetooth/hci.h      |  41 +++++++
 include/net/bluetooth/hci_core.h |  17 +++
 net/bluetooth/hci_core.c         | 199 ++++++++++++++++++++++++++++++-
 3 files changed, 253 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c4b0650fb9ae..6cb9340a2d51 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1307,6 +1307,28 @@ struct hci_rp_read_data_block_size {
 } __packed;
 
 #define HCI_OP_READ_LOCAL_CODECS	0x100b
+struct hci_std_codecs {
+	__u8	num;
+	__u8	codec[];
+} __packed;
+
+struct hci_ven_codec {
+	/* company id */
+	__le16	cid;
+	/* vendor codec id */
+	__le16	vid;
+} __packed;
+
+struct hci_ven_codecs {
+	__u8	num;
+	struct hci_ven_codec codec[];
+} __packed;
+
+struct hci_rp_read_local_supported_codecs {
+	__u8	status;
+	struct hci_std_codecs std_codecs;
+	struct hci_ven_codecs ven_codecs;
+} __packed;
 
 #define HCI_OP_READ_LOCAL_PAIRING_OPTS	0x100c
 struct hci_rp_read_local_pairing_opts {
@@ -1315,6 +1337,25 @@ struct hci_rp_read_local_pairing_opts {
 	__u8     max_key_size;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
+struct hci_op_read_local_codec_caps {
+	__u8	id;
+	__le16	cid;
+	__le16	vid;
+	__u8	transport;
+	__u8	direction;
+} __packed;
+
+struct hci_codec_caps {
+	__u8	len;
+	__u8	data[];
+} __packed;
+
+struct hci_rp_read_local_codec_caps {
+	__u8	status;
+	__u8	num_caps;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
 struct hci_rp_read_page_scan_activity {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43b08bebae74..cdc9580ff264 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -131,6 +131,17 @@ struct bdaddr_list {
 	u8 bdaddr_type;
 };
 
+struct codec_list {
+	struct list_head list;
+	u8	id;
+	__le16	cid;
+	__le16	vid;
+	u8	transport;
+	u8	num_caps;
+	u32	len;
+	struct hci_codec_caps caps[];
+};
+
 struct bdaddr_list_with_irk {
 	struct list_head list;
 	bdaddr_t bdaddr;
@@ -535,6 +546,7 @@ struct hci_dev {
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
 	struct list_head	blocked_keys;
+	struct list_head	local_codecs;
 
 	struct hci_dev_stats	stat;
 
@@ -1849,4 +1861,9 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+#define LOCAL_CODEC_ACL_MASK	BIT(0)
+#define LOCAL_CODEC_SCO_MASK	BIT(1)
+
+#define TRANSPORT_TYPE_MAX	0x04
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6eedf334f943..b74de5996a27 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -838,10 +838,6 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[22] & 0x04)
 		hci_set_event_mask_page_2(req);
 
-	/* Read local codec list if the HCI command is supported */
-	if (hdev->commands[29] & 0x20)
-		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
-
 	/* Read local pairing options if the HCI command is supported */
 	if (hdev->commands[41] & 0x08)
 		hci_req_add(req, HCI_OP_READ_LOCAL_PAIRING_OPTS, 0, NULL);
@@ -907,6 +903,195 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	return 0;
 }
 
+static int hci_codec_list_add(struct list_head *list,
+			      struct hci_op_read_local_codec_caps *sent,
+			      struct hci_rp_read_local_codec_caps *rp,
+			      void *caps,
+			      __u32 len)
+{
+	struct codec_list *entry;
+
+	entry = kzalloc(sizeof(*entry) + len, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->id = sent->id;
+	if (sent->id == 0xFF) {
+		entry->cid = __le16_to_cpu(sent->cid);
+		entry->vid = __le16_to_cpu(sent->vid);
+	}
+	entry->transport = sent->transport;
+	entry->len = len;
+	entry->num_caps = rp->num_caps;
+	if (rp->num_caps)
+		memcpy(entry->caps, caps, len);
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
+static void hci_codec_list_clear(struct list_head *codec_list)
+{
+	struct codec_list *c, *n;
+
+	list_for_each_entry_safe(c, n, codec_list, list) {
+		list_del(&c->list);
+		kfree(c);
+	}
+}
+
+static void hci_read_codec_capabilities(struct hci_dev *hdev, void *codec_id,
+					__u8 transport, bool is_vendor_codec)
+{
+	struct hci_op_read_local_codec_caps cmd;
+	__u8 i;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	if (is_vendor_codec) {
+		struct hci_ven_codec *ven_codec;
+
+		ven_codec = codec_id;
+		cmd.id = 0xFF;
+		cmd.cid = ven_codec->cid;
+		cmd.vid = ven_codec->vid;
+	} else {
+		cmd.id = *(__u8 *)codec_id;
+	}
+
+	cmd.direction = 0x00;
+
+	for (i = 0; i < TRANSPORT_TYPE_MAX; i++) {
+		if (transport & BIT(i)) {
+			struct hci_rp_read_local_codec_caps *rp;
+			struct hci_codec_caps *caps;
+			struct sk_buff *skb;
+			__u8 j;
+			__u32 len;
+
+			cmd.transport = i;
+			skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
+					     sizeof(cmd), &cmd,
+					     HCI_CMD_TIMEOUT);
+			if (IS_ERR(skb)) {
+				bt_dev_err(hdev, "Failed to read codec capabilities (%ld)",
+					   PTR_ERR(skb));
+				continue;
+			}
+
+			if (skb->len < sizeof(*rp))
+				goto error;
+
+			rp = (void *)skb->data;
+
+			if (rp->status)
+				goto error;
+
+			if (!rp->num_caps) {
+				len = 0;
+				/* this codec doesn't have capabilities */
+				goto skip_caps_parse;
+			}
+
+			skb_pull(skb, sizeof(*rp));
+
+			for (j = 0, len = 0; j < rp->num_caps; j++) {
+				caps = (void *)skb->data;
+				if (skb->len < sizeof(*caps))
+					goto error;
+				if (skb->len < caps->len)
+					goto error;
+				len += sizeof(caps->len) + caps->len;
+				skb_pull(skb,  sizeof(caps->len) + caps->len);
+			}
+
+skip_caps_parse:
+			hci_dev_lock(hdev);
+			hci_codec_list_add(&hdev->local_codecs, &cmd, rp,
+					   (__u8 *)rp + sizeof(*rp), len);
+			hci_dev_unlock(hdev);
+error:
+			kfree_skb(skb);
+		}
+	}
+}
+
+static void hci_codec_list_parse(struct hci_dev *hdev, __u8 num_codecs,
+				 void *codec_list, bool is_vendor_codec)
+{
+	__u8 i;
+
+	for (i = 0; i < num_codecs; i++) {
+		if (!is_vendor_codec) {
+			struct hci_std_codecs *codecs = codec_list;
+
+			hci_read_codec_capabilities(hdev, &codecs->codec[i],
+						    LOCAL_CODEC_ACL_MASK,
+						    is_vendor_codec);
+		} else {
+			struct hci_ven_codecs *codecs = codec_list;
+
+			hci_read_codec_capabilities(hdev, &codecs->codec[i],
+						    LOCAL_CODEC_ACL_MASK,
+						    is_vendor_codec);
+		}
+	}
+}
+
+static void hci_read_supported_codecs(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_local_supported_codecs *rp;
+	struct hci_std_codecs *std_codecs;
+	struct hci_ven_codecs *ven_codecs;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len < sizeof(*rp))
+		goto error;
+
+	rp = (void *)skb->data;
+
+	if (rp->status)
+		goto error;
+
+	skb_pull(skb, sizeof(rp->status));
+
+	std_codecs = (void *)skb->data;
+
+	/* validate codecs length before accessing */
+	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
+	    + sizeof(std_codecs->num))
+		goto error;
+
+	/* enumerate codec capabilities of standard codecs */
+	hci_codec_list_parse(hdev, std_codecs->num, std_codecs, false);
+
+	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
+		 + sizeof(std_codecs->num));
+
+	ven_codecs = (void *)skb->data;
+
+	/* validate vendor codecs length before accessing */
+	if (skb->len <
+	    flex_array_size(ven_codecs, codec, ven_codecs->num)
+	    + sizeof(ven_codecs->num))
+		goto error;
+
+	/* enumerate vendor codec capabilities */
+	hci_codec_list_parse(hdev, ven_codecs->num, ven_codecs, true);
+
+error:
+	kfree_skb(skb);
+}
+
 static int __hci_init(struct hci_dev *hdev)
 {
 	int err;
@@ -937,6 +1122,10 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	/* Read local codec list if the HCI command is supported */
+	if (hdev->commands[29] & 0x20)
+		hci_read_supported_codecs(hdev);
+
 	/* This function is only called when the controller is actually in
 	 * configured state. When the controller is marked as unconfigured,
 	 * this initialization procedure is not run.
@@ -1836,6 +2025,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
+	hci_codec_list_clear(&hdev->local_codecs);
 
 	hci_req_sync_unlock(hdev);
 
@@ -3837,6 +4027,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
 	INIT_LIST_HEAD(&hdev->blocked_keys);
+	INIT_LIST_HEAD(&hdev->local_codecs);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
-- 
2.17.1

