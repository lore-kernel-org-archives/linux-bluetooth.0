Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF46C43462
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40ACC6124C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhERKkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:23234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348568AbhERKkO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:14 -0400
IronPort-SDR: VxchUP+h7gdFDjaPGG7zMDqUYWbs8mqa1VOA2Jy86HcG8ngX+6RSJ3PssMWJ3SeonQIeAlXVEL
 Xq0iX88Bnvig==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804825"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804825"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:38:56 -0700
IronPort-SDR: PXZQPSDOGb56DXvIWxiuOU8yie54Iv4+2kED4+cTvB1/1dWs974d0fzknUJ6+Drnl47DxGdNCa
 UKBHI9wAYWkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017864"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:38:54 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 6/9] Bluetooth: btintel: Add a callback function to configure data path
Date:   Tue, 18 May 2021 16:12:29 +0530
Message-Id: <20210518104232.5431-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In HFP offload usecase, Intel controllers require offload use
case id (NBS or WBS) to be set before opening SCO connection. Define
a new callback which gets called on setsockopt SCO socket. User space
audio module is expected to set codec via setsockopt(sk, BT_CODEC, ....)
before opening SCO connection.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

This callback gets called when audio module does setsockopt(sk, BT_CODEC,...)
on SCO socket and data_path is 1 (non-HCI transport). For non-HCI transport,
Intel controller expects presets to be set before opening SCO connection.
Presets are pre-defined, 0 - NBS, 1 - WBS. Likewise additional presets will
be defined for A2DP, LE Audio offload use cases.

 drivers/bluetooth/btintel.c      | 50 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h      |  8 +++++
 drivers/bluetooth/btusb.c        |  1 +
 include/net/bluetooth/hci.h      |  8 +++++
 include/net/bluetooth/hci_core.h |  2 ++
 5 files changed, 69 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8407e9736c62..8efb15504973 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1308,6 +1308,56 @@ int btintel_get_data_path_id(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btintel_get_data_path_id);
 
+int btintel_configure_data_path(struct hci_dev *hdev, __u8 type,
+				struct bt_codec *codec)
+{
+	__u8 preset;
+	struct hci_op_configure_data_path *cmd;
+	__u8 buffer[255];
+	struct sk_buff *skb;
+
+	if (type != SCO_LINK && type != ESCO_LINK)
+		return -EINVAL;
+
+	switch (codec->id) {
+	case 0x02:
+		preset = 0x00;
+	break;
+	case 0x05:
+		preset = 0x01;
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	cmd = (void *)buffer;
+	cmd->data_path_id = 0x01;
+	cmd->len = 1;
+	cmd->data[0] = preset;
+
+	cmd->direction = 0x00;
+	skb = __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH, sizeof(*cmd) + 1,
+			     cmd, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "configure input data path failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	cmd->direction = 0x01;
+	skb = __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH, sizeof(*cmd) + 1,
+			     cmd, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "configure output data path failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_configure_data_path);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 6d4edfd16d44..f4af22ecdc0d 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -177,6 +177,8 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
 int btintel_read_offload_usecases(struct hci_dev *hdev);
 int btintel_get_data_path_id(struct hci_dev *hdev);
+int btintel_configure_data_path(struct hci_dev *hdev, __u8 type,
+				struct bt_codec *codec);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -318,4 +320,10 @@ static int btintel_get_data_path_id(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
 }
+
+static int btintel_configure_data_path(struct hci_dev *hdev, __u8 type,
+				       struct bt_codec *codec)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f7b349db392a..220e7c85db10 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4632,6 +4632,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 		hdev->get_data_path_id = btintel_get_data_path_id;
+		hdev->configure_data_path = btintel_configure_data_path;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9658600ae5de..bd666b114aea 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1257,6 +1257,14 @@ struct hci_rp_read_local_oob_ext_data {
 	__u8     rand256[16];
 } __packed;
 
+#define HCI_CONFIGURE_DATA_PATH	0x0c83
+struct hci_op_configure_data_path {
+	__u8	direction;
+	__u8	data_path_id;
+	__u8	len;
+	__u8	data[];
+} __packed;
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 78d1ebab58f6..959585bafa8d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -618,6 +618,8 @@ struct hci_dev {
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
 	int (*get_data_path_id)(struct hci_dev *hdev);
+	int (*configure_data_path)(struct hci_dev *hdev, __u8 type,
+				   struct bt_codec *codec);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
-- 
2.17.1

