Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9067C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 03:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhLUDgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:36:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:4163 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhLUDgb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 22:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640057791; x=1671593791;
  h=from:to:cc:subject:date:message-id;
  bh=+/LhjQoPwPiq7D7LebmI8RVC6OrHecrF/OCEmgH7Rto=;
  b=EIcf6YozDGj1VZRiH2+JA33b80+T2EHW65AYE7lm3y64YZInKgNnYMh1
   v7PZtDBsAclQAkGQFxIGIm0t0UxC8RKv5klNv8/cy92tt1TdN8hHWshgX
   iiO30Bw3WUbPcPVv9mrnR20OIZ6n1esKLmIsAlV7IsjgXV55MD0CkLvpS
   eCuEuLaNJa3S6cqDKMrlVkiwMG+ENjTT8M2zwkQZ8+qoXBdKQiKfScelL
   HxsDxa/FfDUzA7yJXMHWg6VHbPhc1QRT2N64FWLyfV9+7Am8DWvavqra0
   YcWFmWZX2n/rUbaoJOwMMT92dCBgkWjpK5Xet0owAqRjI4NALSqLgNCQD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239061789"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="239061789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 19:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="613315969"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 20 Dec 2021 19:36:29 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fix MSFT extension support for Intel controllers
Date:   Tue, 21 Dec 2021 09:12:46 +0530
Message-Id: <20211221034246.2416-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

For ThP2/JfP2/HrP2 and CcP2 Intel controllers, MSFT extension
opcode was not set in operational mode.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e1f96df847b8..0dd389746439 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2549,10 +2549,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
 			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
-		/* Setup MSFT Extension support */
-		btintel_set_msft_opcode(hdev,
-					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
-
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		break;
 	default:
@@ -2560,6 +2556,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 		return -EINVAL;
 	}
+	/* Setup MSFT Extension support */
+	btintel_set_msft_opcode(hdev, INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 
 exit_error:
 	kfree_skb(skb);
-- 
2.17.1

