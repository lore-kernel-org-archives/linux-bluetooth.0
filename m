Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiKPGUB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiKPGTz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 01:19:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102E15717
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 22:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668579594; x=1700115594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Qoc55W22IQjPu1hTENPFauM1mIeCCVubfTKrVTNCr90=;
  b=iYutA1mmQyB3GCjzbV8aXJx+pDWTN9m+ETLLdAU3uob013vb9OxDFG8Y
   OhI06t84FLrilzs833WAafk4urTZPyIp9n6Fxt1uAmvPWh/byo/1GxzxB
   gUMRSSatV5POHJ0dEGdAI+RMNbuckO0/IgBfe3cL4vxclygs3IPeYOp81
   QfUE6tfkuRtXvgTzBHNgSKmDP2W/AxLvMXEpgcXyv1MYfuch15J5Lsqpe
   EbzglLhTfAxXJNY4mP39HBNbrm+LttFjJ5XnBf4kZLz4+gACUPdDz59f2
   YON8DF1b8NNzB3ZsHOca747JhZ9ZdjGa4BcHK0B34E4LFHmCxl+LpmeaD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374596320"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374596320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702739832"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702739832"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 22:19:52 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: Fix support for Read Local Supported Codecs V2
Date:   Wed, 16 Nov 2022 11:59:18 +0530
Message-Id: <20221116062918.11879-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221116062918.11879-1-kiran.k@intel.com>
References: <20221116062918.11879-1-kiran.k@intel.com>
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
Notes:
changes in v2:
- Fix commit message format

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
index d36d72352059..9e2d7e4b850c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -12,6 +12,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
+#include "hci_codec.h"
 #include "hci_debugfs.h"
 #include "smp.h"
 #include "eir.h"
@@ -4257,11 +4258,12 @@ static int hci_set_event_mask_page_2_sync(struct hci_dev *hdev)
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

