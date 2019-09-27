Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08D9C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 02:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61AE20872
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 02:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfI0C5E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:57:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:21594 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbfI0C5E (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 22:57:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 19:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="scan'208";a="389828640"
Received: from unknown (HELO ubuntu-16-04.iind.intel.com) ([10.224.186.155])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2019 19:57:02 -0700
From:   Amit K Bag <amit.k.bag@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: btusb: print FW version after FW download
Date:   Fri, 27 Sep 2019 08:21:53 +0530
Message-Id: <1569552714-16091-1-git-send-email-amit.k.bag@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After FW download there is no print to confirm the current
FW version. Add print to check FW version incase of FW download.

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9c35ebb30f8..f6c033b5042c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2432,6 +2432,14 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	btintel_set_event_mask(hdev, false);
 
+	/* Read the Intel version information after loading the FW  */
+	err = btintel_read_version(hdev, &ver);
+	if (err)
+		return err;
+
+	btintel_version_info(hdev, &ver);
+	bt_dev_info(hdev, "Setup complete");
+
 	return 0;
 }
 
-- 
2.7.4

