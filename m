Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606CC21789
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 07:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCHLO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:11:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:29061 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCHLO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 03:11:14 -0400
IronPort-SDR: oC3WHtwvb5A/8rJ/1z/omLJG75TbWOnz8iTin5QA5LvWihpeq/klxvJ9AUN9zTPpFVw8SywdtC
 RvvoL179aJUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="212125514"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="212125514"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:11:14 -0700
IronPort-SDR: vrIiuVpGYi0pV2Gz0wp+TB9YE6Gx9xVGd08RMt6RduF1IPK3zyQV4nJHACcHmKoSgOZN4UuVy2
 IYtVt0NST9og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="426212110"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2020 00:11:12 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v2 2/5] Bluetooth: btintel: Refactor firmware header download sequence
Date:   Fri,  3 Jul 2020 12:42:09 +0530
Message-Id: <20200703071212.17046-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703071212.17046-1-kiran.k@intel.com>
References: <20200703071212.17046-1-kiran.k@intel.com>
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

Changes in v2:
  - Remove unwanted blank line, add empty line before goto label
Changes in v1:
  - Move firmware header download code to new function


 drivers/bluetooth/btintel.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dea96c585ecb..ffc888c4e9e3 100644
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
@@ -680,6 +678,21 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
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

