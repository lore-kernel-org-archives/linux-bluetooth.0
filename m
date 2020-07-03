Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C834C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F54821789
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 07:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgGCHLQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:11:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:29061 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCHLQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 03:11:16 -0400
IronPort-SDR: dEFShv6a8V6nWz28gMGq0c08zL7o3XlWBeH0OryM2wf1YBmWrcC+muih9o1zzdpCYmI8uPbXoJ
 fOBsIQow4eyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="212125516"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="212125516"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:11:16 -0700
IronPort-SDR: NCoqYr1U0RYdT5zbdhvtWwb/iBVtqUIIdgsKprhhUdewFMap6kzrT7CFG0xstBiTla0ZXJ85Cz
 BicUhRIJ1efQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="426212120"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2020 00:11:14 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v2 3/5] Bluetooth: btintel: Refactor firmware payload download code
Date:   Fri,  3 Jul 2020 12:42:10 +0530
Message-Id: <20200703071212.17046-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703071212.17046-1-kiran.k@intel.com>
References: <20200703071212.17046-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move firmware payload download code to a separate function to
enhance readability and reusability

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Changes in v2:
- Avoid exporting new public function for firmware download
- Move firmware payload download code to a new function
Changes in v1:
- Move firmware payload download code to a new function


 drivers/bluetooth/btintel.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ffc888c4e9e3..2cb55a97598c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -19,6 +19,7 @@
 #define VERSION "0.1"
 
 #define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+#define RSA_HEADER_LEN	644
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
@@ -682,8 +683,9 @@ static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
 	return err;
 }
 
-int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
-			      u32 *boot_param)
+static int btintel_download_firmware_payload(struct hci_dev *hdev,
+					     const struct firmware *fw,
+					     u32 *boot_param, size_t offset)
 {
 	int err;
 	const u8 *fw_ptr;
@@ -693,8 +695,9 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 	if (err)
 		goto done;
 
-	fw_ptr = fw->data + 644;
+	fw_ptr = fw->data + offset;
 	frag_len = 0;
+	err = -EINVAL;
 
 	while (fw_ptr - fw->data < fw->size) {
 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
@@ -740,6 +743,19 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 done:
 	return err;
 }
+
+int btintel_download_firmware(struct hci_dev *hdev,
+			      const struct firmware *fw,
+			      u32 *boot_param)
+{
+	int err;
+
+	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+	if (err)
+		return err;
+
+	return btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+}
 EXPORT_SYMBOL_GPL(btintel_download_firmware);
 
 void btintel_reset_to_bootloader(struct hci_dev *hdev)
-- 
2.17.1

