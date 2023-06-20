Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C2EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 23:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFTXlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 19:41:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B3170D
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687304502; x=1718840502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdiuOtf8BDGx94SN4j2iQFgXAiCTPNq2xldGSgn3QWw=;
  b=Ysn0sz0i3JeW14BuUfBCLWwKfm4RglI5BnzHMm1SJdQJlfYJmSOj1FUy
   w27czW3QApZMexEgUQ5tekQ0h6ZXPcknDd0q8QTIBXvTA8hS7xi/w4qhC
   9etRXRSNDOgVGNXM5GdnUXlscZqkCF8MHY/f+6egfExpHGMyvlXVkUr/8
   2mJAUcd6uumCt0t2qgXVmOYinNSEnIjFyGffJAYqUgoGblr+nUyUzpi9e
   j7jKCBI5jW7ra0ZaGRgy1A3YPb9GfuG42GXeanPvNtnaJcplruAl08cq7
   0CZanifdCa+XkLWAmwxApUnYuGumSCTUNVoqCB038SM8JaUfKCcDfbySd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340353586"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340353586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888429747"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="888429747"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 16:41:40 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        pmenzel@molgen.mpg.de, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel: Add comment for DSM metbods
Date:   Wed, 21 Jun 2023 05:22:33 +0530
Message-Id: <20230620235233.1845036-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620235233.1845036-1-kiran.k@intel.com>
References: <20230620235233.1845036-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

1. Add comment about reset method types.
2. Minor indentation and typo fixes.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 8 ++++++--
 drivers/bluetooth/btusb.c   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1110289ccd02..000ab44c303d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2500,10 +2500,14 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 {
 	struct btintel_data *data = hci_get_priv(hdev);
 	acpi_handle handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
-	u8 reset_payload[4] = {0x01, 0x00, 0x01, 0x00};
+	u8 reset_payload[4] = { 0x01, 0x00, 0x01, 0x00 };
 	union acpi_object *obj, argv4;
 	enum {
+		/* supported from TigerLake platform onwards on both discrete
+		 * and integrated solutions
+		 */
 		RESET_TYPE_WDISABLE2,
+		/* supported from MeteorLake platform with GalePeak2 NIC only */
 		RESET_TYPE_VSEC
 	};
 
@@ -2533,7 +2537,7 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 			return;
 		}
 		argv4.integer.type = ACPI_TYPE_INTEGER;
-		/* delay required to toggle BT power */
+		/* delay between WDISABLE2 pin assertion and deassertion */
 		argv4.integer.value = 160;
 		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
 					DSM_SET_WDISABLE2_DELAY, &argv4);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1c0879601735..34659255a14f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -864,7 +864,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 
 	if (intel_data->acpi_reset_method) {
 		if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data->flags)) {
-			bt_dev_err(hdev, "acpi: last reset failed ? Not resetting again");
+			bt_dev_err(hdev, "acpi: last reset failed? Not resetting again");
 			return;
 		}
 
-- 
2.25.1

