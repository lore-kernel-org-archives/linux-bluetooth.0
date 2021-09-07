Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5127DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5326108E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbhIGKJG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:09:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:1677 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243048AbhIGKJF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 06:09:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="200362875"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="200362875"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 03:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="512785276"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2021 03:07:57 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, michaelfsun@google.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v15 13/13] Bluetooth: hci_vhci: Add support for offload codecs over SCO
Date:   Tue,  7 Sep 2021 15:42:49 +0530
Message-Id: <20210907101249.7323-13-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907101249.7323-1-kiran.k@intel.com>
References: <20210907101249.7323-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define the callbacks required to support offload codecs

Signed-off-by: Kiran K <kiran.k@intel.com>
---

Notes:
    changes in v15:
     - New patch - Add callbacks to support offload codecs
       for emulator

 drivers/bluetooth/hci_vhci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8ab26dec5f6e..cc3679f3491d 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -73,6 +73,24 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int vhci_get_data_path_id(struct hci_dev *hdev, u8 *data_path_id)
+{
+	*data_path_id = 0;
+	return 0;
+}
+
+static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
+				      struct bt_codec *codec, __u8 *vnd_len,
+				      __u8 **vnd_data)
+{
+	if (type != ESCO_LINK)
+		return -EINVAL;
+
+	*vnd_len = 0;
+	*vnd_data = NULL;
+	return 0;
+}
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -112,6 +130,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->close = vhci_close_dev;
 	hdev->flush = vhci_flush;
 	hdev->send  = vhci_send_frame;
+	hdev->get_data_path_id = vhci_get_data_path_id;
+	hdev->get_codec_config_data = vhci_get_codec_config_data;
 
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
-- 
2.17.1

