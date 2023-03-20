Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0EBC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 06:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCTGQ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCTGQy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 02:16:54 -0400
Received: from mga03.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36491E2A8
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Mar 2023 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679293002; x=1710829002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yoClQzVSoepjT66Vu0+I7GutSNUdT3e3shHIut9G9+o=;
  b=GME66T4ohU3gjiqOKwzpLTredf5yIYcIEqTAKgPtJlwduVYBa2g0qkxi
   nUQTSHwXgunkO0FPB8KJxeIam5mIYfWoO0sVwjB2TBibVkPIeW0Sc/ZJr
   5N2IVj/E5gdHYmbjZ1lqUAx+Q1K8yfU0+ZB1C2pboUtk4rkZ/OToCfROc
   JzUrYD55pD9DTrkWRGt60e4qe0J7+x5BcuMGmT2DYl+VjlRhwNEv6dbe0
   Gp5QA9ACAziV+2tjuD4fePwqYKjzZ0MPW7HI0fpP0ygMJLtXt5dBj9VYo
   B3RsE6jSSLreKt5n9BxCXycYCesgOdZcfM9H3HfjFGlqlDMl0PtYmqlOx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340942064"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="340942064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 23:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="631005188"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="631005188"
Received: from latitude-5491.iind.intel.com ([10.224.186.158])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2023 23:16:27 -0700
From:   Chethan T N <chethan.tumkur.narayan@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiran.k@intel.com,
        chethan.tumkur.narayan@intel.com
Subject: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar onwards
Date:   Mon, 20 Mar 2023 11:48:13 +0530
Message-Id: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch shall enable the LE States quirks by default on all
Intel controller from Solar products on wards.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btintel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index af774688f1c0..7a6dc05553f1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2684,9 +2684,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Valid LE States quirk for GfP */
-		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		/* Apply LE States quirk from solar onwards */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
-- 
2.25.1

