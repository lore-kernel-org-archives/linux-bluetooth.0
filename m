Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29B5C46467
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 15:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjAJPth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjAJPt1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 10:49:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A4944C5B
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673365765; x=1704901765;
  h=from:to:cc:subject:date:message-id;
  bh=klDJ3cXO3vOmIiwnOoIGpsEH2vvVWuW494w103h4vC4=;
  b=GF6YoIxA7ovqH0Jw3leInXSX1VYmvkiEkCoG99v7wMZA0rJwliu2KTry
   XoZb0AcSVepbsNmX/Rse8sE2232h9ibpVIWSWqCUcNtBO5Q0LOEKi0/g4
   R3mJ7Yc/sa/x3MhHskd8P2wTb58+/qxDGmpiDCVDdUuOiW8WD9TIgHMiS
   Jbz5PCaFKA3N0lL6xZgaX0/CSPrHJXZGHnZnSaCb562qZzp4/jORaV10k
   5HpQ2Cc5Z0L4Xbp8xDtfGBrTHyGX9p/NbILni2uMeVy/3wNG77WVTaTdl
   pxPLcR4f1YYRpLCD3z928nIjAO8sl4ikrRuQ0LXBSOIBsOE1vmO2nbBUy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="310977121"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="310977121"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 07:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="745812943"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="745812943"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2023 07:49:13 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Subject: [PATCH v1] btintel: Add recovery when secure verification of firmware fails
Date:   Tue, 10 Jan 2023 21:29:05 +0530
Message-Id: <20230110155905.18203-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On warm reboot stress test case, firmware download failure
has been observed with failure in secure verification of firmware
and BT becomes completely inaccessible. This can happen due to a race
condition in TOP registers when Wifi driver is also getting loaded
at the same time. This patch adds a work around to load the BT firmware
again when secure verify failure is observed.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btintel.c | 20 ++++++++++++++++----
 drivers/bluetooth/btintel.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d4e2cb9a4eb4..3f2976fb056a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1700,6 +1700,11 @@ static int btintel_download_wait(struct hci_dev *hdev, ktime_t calltime, int mse
 		return -ETIMEDOUT;
 	}
 
+	if (btintel_test_flag(hdev, INTEL_FIRMWARE_VERIFY_FAILED)) {
+		bt_dev_err(hdev, "Firmware secure verification failed");
+		return -EAGAIN;
+	}
+
 	if (btintel_test_flag(hdev, INTEL_FIRMWARE_FAILED)) {
 		bt_dev_err(hdev, "Firmware loading failed");
 		return -ENOEXEC;
@@ -1961,7 +1966,7 @@ static int btintel_download_fw(struct hci_dev *hdev,
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT || err == -EAGAIN)
 		btintel_reset_to_bootloader(hdev);
 
 done:
@@ -2153,7 +2158,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT || err == -EAGAIN)
 		btintel_reset_to_bootloader(hdev);
 
 done:
@@ -2644,8 +2649,15 @@ void btintel_secure_send_result(struct hci_dev *hdev,
 	if (len != sizeof(*evt))
 		return;
 
-	if (evt->result)
-		btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
+	if (evt->result) {
+		bt_dev_err(hdev, "Intel Secure Send Results event result: %u status: %u",
+			   evt->result, evt->status);
+
+		if (evt->result == 3)
+			btintel_set_flag(hdev, INTEL_FIRMWARE_VERIFY_FAILED);
+		else
+			btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
+	}
 
 	if (btintel_test_and_clear_flag(hdev, INTEL_DOWNLOADING) &&
 	    btintel_test_flag(hdev, INTEL_FIRMWARE_LOADED))
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..10e5be7e451a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -147,6 +147,7 @@ enum {
 	INTEL_BOOTLOADER,
 	INTEL_DOWNLOADING,
 	INTEL_FIRMWARE_LOADED,
+	INTEL_FIRMWARE_VERIFY_FAILED,
 	INTEL_FIRMWARE_FAILED,
 	INTEL_BOOTING,
 	INTEL_BROKEN_INITIAL_NCMD,
-- 
2.17.1

