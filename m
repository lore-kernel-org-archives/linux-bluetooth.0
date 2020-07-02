Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0079C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBCC207CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGBMCM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:02:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:27652 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgGBMCL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 08:02:11 -0400
IronPort-SDR: XGl3C8HuIy2Jk/PMhqYYGOf9VnzyYKu0pnj5uYUSTOeQs9Pg/vZGBmQiZNVAMm3QOKMuMVISQJ
 2gcmdH3KhKlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="145947827"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="145947827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 05:02:11 -0700
IronPort-SDR: W2BRSz48UqmPOn4XB85Y3nspYydEHmB0wdj0zs+Sd36QKGQzKovQd6ASbqbvoeQBGSTcyeaih2
 0703lwsYyUlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="304224715"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 05:02:09 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH 2/5] Bluetooth: btintel: Refactor firmware header download sequence
Date:   Thu,  2 Jul 2020 17:33:12 +0530
Message-Id: <20200702120315.26768-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702120315.26768-1-kiran.k@intel.com>
References: <20200702120315.26768-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move firmware header download code to a separate function to
enhance readability and reusability

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dea96c585ecb..1c820c187421 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -646,12 +646,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_read_boot_params);
 
-int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
-			      u32 *boot_param)
+static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
+					      const struct firmware *fw)
 {
 	int err;
-	const u8 *fw_ptr;
-	u32 frag_len;
 
 	/* Start the firmware download transaction with the Init fragment
 	 * represented by the 128 bytes of CSS header.
@@ -679,6 +677,21 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 		bt_dev_err(hdev, "Failed to send firmware signature (%d)", err);
 		goto done;
 	}
+done:
+	return err;
+}
+
+int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
+			      u32 *boot_param)
+{
+	int err;
+	const u8 *fw_ptr;
+	u32 frag_len;
+
+	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+	if (err)
+		goto done;
+
 
 	fw_ptr = fw->data + 644;
 	frag_len = 0;
-- 
2.17.1

