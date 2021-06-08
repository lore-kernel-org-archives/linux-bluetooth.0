Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29797C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DD161351
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFHMWv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:22:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:22782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhFHMWu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:22:50 -0400
IronPort-SDR: EToPOjGBRrRqBRzoVkG/TIS+MIuC+5nUitSeIIXNH/LKbDc/9v6B2ze9+Rx2cFSVcB763ZhCnP
 0B4I2GxEXzJA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202973562"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="202973562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:20:58 -0700
IronPort-SDR: Xvzt/NP+85A3zAeIo+IxFBIrQyePvZpTk28xbc79NjzoNLNEE0FS2TYy2jg9ZdZvU6XrplmjyS
 9qjtsP/DR6Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619283484"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 05:20:56 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v9 07/10] Bluetooth: btintel: define callback to set data path
Date:   Tue,  8 Jun 2021 17:54:52 +0530
Message-Id: <20210608122455.19583-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608122455.19583-1-kiran.k@intel.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds callback function which is called to set the data path
for HFP offload case before opening SCO connection

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 50 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  8 ++++++
 drivers/bluetooth/btusb.c   |  4 ++-
 include/net/bluetooth/hci.h |  8 ++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 95c6a1bef35e..3eba5c587ef6 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1308,6 +1308,56 @@ int btintel_read_offload_usecases(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
 
+int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
+			  struct bt_codec *codec)
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
+EXPORT_SYMBOL_GPL(btintel_set_data_path);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 9bcc489680db..9806970c9871 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -183,6 +183,8 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 int btintel_read_offload_usecases(struct hci_dev *hdev,
 				  struct intel_offload_usecases *usecases);
 int btintel_get_data_path(struct hci_dev *hdev);
+int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
+			  struct bt_codec *codec);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -325,4 +327,10 @@ static int btintel_get_data_path(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
 }
+
+static int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
+				 struct bt_codec *codec)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1e51beec5776..afafa44752a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3012,8 +3012,10 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	err = btintel_read_offload_usecases(hdev, &usecases);
 	if (!err) {
 		/* set get_data_path callback if offload is supported */
-		if (usecases.preset[0] & 0x03)
+		if (usecases.preset[0] & 0x03) {
 			hdev->get_data_path = btintel_get_data_path;
+			hdev->set_data_path = btintel_set_data_path;
+		}
 	}
 
 	/* Read the Intel version information after loading the FW  */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 31a5ac8918fc..42963188dcea 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1250,6 +1250,14 @@ struct hci_rp_read_local_oob_ext_data {
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
-- 
2.17.1

