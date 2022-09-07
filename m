Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E52CC38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 07:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIGHLt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIGHLh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 03:11:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B8A286B
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662534682; x=1694070682;
  h=from:to:cc:subject:date:message-id;
  bh=TswZ8N7JglSxoMClbCwpIymTEhF/Bi8PFsVqffb7jY8=;
  b=RMSqf6kuF4kY6HAGJy4WkPMCyLZSjJC+VP6Od+O3ngcgwMzO+HlwXlkh
   hKHkqk1k+ah4uNgIBZ60nQSjLHoE2fmfL80ltYsxkHcdAJCTO5alEvA5y
   6HrT9iWb4I8EpTT/phE5NEcrkOEPGUt8LtTzoLXitDS67Ax+IlqGyb/RQ
   BFUP3q0pDF8H3kan4EBReBXpDv2RPpSOJlhoSamPqT+RvPrZ59eNPySOc
   nKXsrYC8G29d5icsqnmk40cxSyormm75mx9FNrLpggFDmtcHlCWDqkwU/
   0sXpvxWQA0bCN3+F0hJ7/Puicj0a43fmdbUakGJUhpycGd2lui0VGkXf/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283798349"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="283798349"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="703496705"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 00:11:20 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        tedd.an@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Mark Intel controller to support LE_STATES quirk
Date:   Wed,  7 Sep 2022 12:49:45 +0530
Message-Id: <20220907071945.9925-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HarrrisonPeak, CyclonePeak, SnowFieldPeak and SandyPeak controllers
are marked to support HCI_QUIRK_LE_STATES.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btintel.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 818681c89db8..d44a96667517 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2439,15 +2439,20 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 					       INTEL_ROM_LEGACY_NO_WBS_SUPPORT))
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
+			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
+				set_bit(HCI_QUIRK_VALID_LE_STATES,
+					&hdev->quirks);
 
 			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
 		case 0x0b:      /* SfP */
-		case 0x0c:      /* WsP */
 		case 0x11:      /* JfP */
 		case 0x12:      /* ThP */
 		case 0x13:      /* HrP */
 		case 0x14:      /* CcP */
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+			fallthrough;
+		case 0x0c:	/* WsP */
 			/* Apply the device specific HCI quirks
 			 *
 			 * All Legacy bootloader devices support WBS
@@ -2455,11 +2460,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 				&hdev->quirks);
 
-			/* Valid LE States quirk for JfP/ThP familiy */
-			if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
-				set_bit(HCI_QUIRK_VALID_LE_STATES,
-					&hdev->quirks);
-
 			/* Setup MSFT Extension support */
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
@@ -2530,9 +2530,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Valid LE States quirk for JfP/ThP familiy */
-		if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		/* Set Valid LE States quirk */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev, ver.hw_variant);
-- 
2.17.1

