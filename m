Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8094FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BCD20884
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGBMCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:02:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:27652 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMCO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 08:02:14 -0400
IronPort-SDR: kH1COQjSUSRVcskqBe+NboQo63WDpALiWX9kgWIx8eS3H6E4o6Jcdk5ZKtMmQya7ZL5XYlMlum
 hYN/4ceB724g==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="145947831"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="145947831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 05:02:14 -0700
IronPort-SDR: IuS5FJv9Xs18+7XPuq9aVg7WvtRi142tL8Y90l7j+mJsp443jK4jtTbhgBOLDpg3bWNcSKh2ue
 drvdkOQ9WbXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="304224729"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 05:02:11 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH 3/5] Bluetooth: btintel: Refactor firmware payload download code
Date:   Thu,  2 Jul 2020 17:33:13 +0530
Message-Id: <20200702120315.26768-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702120315.26768-1-kiran.k@intel.com>
References: <20200702120315.26768-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel.c   | 29 ++++++++++++++++++++---------
 drivers/bluetooth/btintel.h   | 10 +++++-----
 drivers/bluetooth/btusb.c     |  2 +-
 drivers/bluetooth/hci_intel.c |  2 +-
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1c820c187421..d0c6576212d7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -19,6 +19,7 @@
 #define VERSION "0.1"
 
 #define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+#define RSA_HEADER_LEN	644
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
@@ -681,20 +682,17 @@ static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
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
 	u32 frag_len;
 
-	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
-	if (err)
-		goto done;
-
-
-	fw_ptr = fw->data + 644;
+	fw_ptr = fw->data + offset;
 	frag_len = 0;
+	err = -EINVAL;
 
 	while (fw_ptr - fw->data < fw->size) {
 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
@@ -740,7 +738,20 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 done:
 	return err;
 }
-EXPORT_SYMBOL_GPL(btintel_download_firmware);
+
+int btintel_download_firmware_legacy(struct hci_dev *hdev,
+				     const struct firmware *fw,
+				     u32 *boot_param)
+{
+	int err;
+
+	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+	if (err)
+		return err;
+
+	return btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+}
+EXPORT_SYMBOL_GPL(btintel_download_firmware_legacy);
 
 void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 0865d2d4aca7..e476105d495b 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -96,8 +96,8 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
 int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
-int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
-			      u32 *boot_param);
+int btintel_download_firmware_legacy(struct hci_dev *dev, const struct firmware *fw,
+				     u32 *boot_param);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
 int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
@@ -191,9 +191,9 @@ static inline int btintel_read_boot_params(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_download_firmware(struct hci_dev *dev,
-					    const struct firmware *fw,
-					    u32 *boot_param)
+static inline int btintel_download_firmware_legacy(struct hci_dev *dev,
+						   const struct firmware *fw,
+						   u32 *boot_param)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d06c946f7810..364da6d44ee3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2438,7 +2438,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
+	err = btintel_download_firmware_legacy(hdev, fw, &boot_param);
 	if (err < 0) {
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f30cbc66d48f..14045a464309 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -755,7 +755,7 @@ static int intel_setup(struct hci_uart *hu)
 	set_bit(STATE_DOWNLOADING, &intel->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
+	err = btintel_download_firmware_legacy(hdev, fw, &boot_param);
 	if (err < 0)
 		goto done;
 
-- 
2.17.1

