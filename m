Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 07:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKDHI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiKDHI4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 03:08:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A9A275F0
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667545734; x=1699081734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+ur2h0u5A0qDI1MQyqSFvFEa+4kpq4wx57U1cVt2HjU=;
  b=AH+25/S9MaX4m7rlCSQn9m0vXOR7nYH2vERZ0d2E8bqwmoY/y49xYqAk
   pWxyYm62P9R2gFZJRGqvFGpIolxbWYlNESWXyvLdLjiXcUJtDSdiD+hJT
   MmyvqlsN8chDr2qC0FNsOWcFZLRZ+4KOso7B75EvT/dyAD11LsmP2Sixq
   6sFRDwvoU5eRn6hM1EMc/S9+EwRNneQFpy2ivyplNGsX4e/9tTT+F6t90
   ll6DPA4b2jMQkAR8x/Hv5dn6EgLcjibPEdRQ1MqVHz0Ao1W182dhEtmH+
   YfaCUeVxmn6Cw3jRk5k9lXkM/xfr4/EvjrJ/ZVdalkCy0w8luzYDylySY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311637569"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="311637569"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809968465"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="809968465"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2022 00:08:48 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] bluetooth: Fix support for Read Local Supported Codecs V2
Date:   Fri,  4 Nov 2022 12:48:10 +0530
Message-Id: <20221104071810.22720-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

Handling of Read Local Supported Codecs was broken during the
HCI serialization design change patches.

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 net/bluetooth/hci_codec.c | 19 ++++++++++---------
 net/bluetooth/hci_sync.c  | 10 ++++++----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 38201532f58e..3cc135bb1d30 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -72,9 +72,8 @@ static void hci_read_codec_capabilities(struct hci_dev *hdev, __u8 transport,
 				continue;
 			}
 
-			skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
-					     sizeof(*cmd), cmd,
-					     HCI_CMD_TIMEOUT);
+			skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
+						sizeof(*cmd), cmd, 0, HCI_CMD_TIMEOUT, NULL);
 			if (IS_ERR(skb)) {
 				bt_dev_err(hdev, "Failed to read codec capabilities (%ld)",
 					   PTR_ERR(skb));
@@ -127,8 +126,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 	struct hci_op_read_local_codec_caps caps;
 	__u8 i;
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
-			     HCI_CMD_TIMEOUT);
+	skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
+				0, HCI_CMD_TIMEOUT, NULL);
 
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
@@ -158,7 +157,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 	for (i = 0; i < std_codecs->num; i++) {
 		caps.id = std_codecs->codec[i];
 		caps.direction = 0x00;
-		hci_read_codec_capabilities(hdev, LOCAL_CODEC_ACL_MASK, &caps);
+		hci_read_codec_capabilities(hdev,
+					    LOCAL_CODEC_ACL_MASK | LOCAL_CODEC_SCO_MASK, &caps);
 	}
 
 	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
@@ -178,7 +178,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 		caps.cid = vnd_codecs->codec[i].cid;
 		caps.vid = vnd_codecs->codec[i].vid;
 		caps.direction = 0x00;
-		hci_read_codec_capabilities(hdev, LOCAL_CODEC_ACL_MASK, &caps);
+		hci_read_codec_capabilities(hdev,
+					    LOCAL_CODEC_ACL_MASK | LOCAL_CODEC_SCO_MASK, &caps);
 	}
 
 error:
@@ -194,8 +195,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 	struct hci_op_read_local_codec_caps caps;
 	__u8 i;
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
-			     HCI_CMD_TIMEOUT);
+	skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
+				0, HCI_CMD_TIMEOUT, NULL);
 
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bd9eb713b26b..d09129ce2058 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -12,6 +12,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
+#include "hci_codec.h"
 #include "hci_debugfs.h"
 #include "smp.h"
 #include "eir.h"
@@ -4256,11 +4257,12 @@ static int hci_set_event_mask_page_2_sync(struct hci_dev *hdev)
 /* Read local codec list if the HCI command is supported */
 static int hci_read_local_codecs_sync(struct hci_dev *hdev)
 {
-	if (!(hdev->commands[29] & 0x20))
-		return 0;
+	if (hdev->commands[45] & 0x04)
+		hci_read_supported_codecs_v2(hdev);
+	else if (hdev->commands[29] & 0x20)
+		hci_read_supported_codecs(hdev);
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
-				     HCI_CMD_TIMEOUT);
+	return 0;
 }
 
 /* Read local pairing options if the HCI command is supported */
-- 
2.17.1

