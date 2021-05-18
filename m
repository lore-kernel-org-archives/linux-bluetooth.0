Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320ABC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A506135B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348572AbhERKkR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:23234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348564AbhERKkK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:10 -0400
IronPort-SDR: kHRyBZbZxm0beyOhVw8uum8tt5ybdpCBO88WXliMTXAZhM6LncXzk4Q7CMDylzG/v4yekEYkW3
 hmGYP9Aq/FZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804816"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804816"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:38:52 -0700
IronPort-SDR: jAafBB6lcfZ17ggLccEq++03nYJ4F2Y1gqJvtN5XJWmEGFJT0ByjnbxlJQU0AhK76KJcS4nPDp
 SZLb++IxBScg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017841"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:38:50 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 4/9] Bluetooth: btitnel: Add a callback function to retireve data path
Date:   Tue, 18 May 2021 16:12:27 +0530
Message-Id: <20210518104232.5431-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is no standard HCI command to retrieve data path for transport.
Add a new callback function to retrieve data path which is used
in offload usecase.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

This callback gets called when audio module queries codecs suppoted
on SCO socket. For Intel controllers, data_path is always 1

 drivers/bluetooth/btintel.c      | 8 ++++++++
 drivers/bluetooth/btintel.h      | 6 ++++++
 drivers/bluetooth/btusb.c        | 1 +
 include/net/bluetooth/hci_core.h | 1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e3ad19244054..8407e9736c62 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1300,6 +1300,14 @@ int btintel_read_offload_usecases(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
 
+int btintel_get_data_path_id(struct hci_dev *hdev)
+{
+	if (!test_bit(HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED, &hdev->quirks))
+		return -EOPNOTSUPP;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(btintel_get_data_path_id);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d561d4899b1b..6d4edfd16d44 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -176,6 +176,7 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
 int btintel_read_offload_usecases(struct hci_dev *hdev);
+int btintel_get_data_path_id(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -312,4 +313,9 @@ static int btintel_read_offload_usecases(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
 }
+
+static int btintel_get_data_path_id(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ac245df5fa18..f7b349db392a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4631,6 +4631,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->get_data_path_id = btintel_get_data_path_id;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cdc9580ff264..78d1ebab58f6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -617,6 +617,7 @@ struct hci_dev {
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
+	int (*get_data_path_id)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
-- 
2.17.1

