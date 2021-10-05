Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABBDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6489561108
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhJEPQV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:16:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:63735 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhJEPQU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 11:16:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="223172076"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="223172076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 07:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="712587455"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2021 07:40:27 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: Read codec capabilities only if supported
Date:   Tue,  5 Oct 2021 20:15:56 +0530
Message-Id: <20211005144556.22074-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Read codec capabilities only if HCI_READ_LOCAL_CODEC_CAPABILITIES
command is supported. If capablities are not supported, then
cache codec data without caps.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 net/bluetooth/hci_codec.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index f0421d0edaa3..38201532f58e 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -25,9 +25,11 @@ static int hci_codec_list_add(struct list_head *list,
 	}
 	entry->transport = sent->transport;
 	entry->len = len;
-	entry->num_caps = rp->num_caps;
-	if (rp->num_caps)
+	entry->num_caps = 0;
+	if (rp) {
+		entry->num_caps = rp->num_caps;
 		memcpy(entry->caps, caps, len);
+	}
 	list_add(&entry->list, list);
 
 	return 0;
@@ -58,6 +60,18 @@ static void hci_read_codec_capabilities(struct hci_dev *hdev, __u8 transport,
 			__u32 len;
 
 			cmd->transport = i;
+
+			/* If Read_Codec_Capabilities command is not supported
+			 * then just add codec to the list without caps
+			 */
+			if (!(hdev->commands[45] & 0x08)) {
+				hci_dev_lock(hdev);
+				hci_codec_list_add(&hdev->local_codecs, cmd,
+						   NULL, NULL, 0);
+				hci_dev_unlock(hdev);
+				continue;
+			}
+
 			skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
 					     sizeof(*cmd), cmd,
 					     HCI_CMD_TIMEOUT);
-- 
2.17.1

