Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34DDC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 04:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCUEbZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 00:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUEbY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 00:31:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07534298DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 21:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679373083; x=1710909083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZZZuD2fF3ODyH1gdKReqTnYW4xHZwTZfnW7LCTpaRN8=;
  b=SEXiOlI/WePnn9/IY8Ns96y7OuBwuBBpQwxMhS7RlhT4Kdy9d3IVRi+1
   DSS6bOnR7jYC3+5tyV4iUyf/gqTWVij0rDrYlrTzTcbRB7cCdhTblLoFk
   eD7hWJ5RQCNZasMeXogULA2jCx0Ek4iEhNWuqXZok7VEURtUDAqupCz2C
   vBnCCsKGPTh26sYhzrgEVznwqoM4/hFXn7U7wjTkIHv7Gja1cxkdoijLM
   kTTlmtVnQEc3+yUamR0Y3uy22EQuoxhYJ/+D2gKuvbi4fn6LHqQNoAeXa
   XhYHck3hQ1GaFO+h2Bc6mz/u25Eid6apBA5hcW2hOTI4EhTV7lr5l9g7/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318496412"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="318496412"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 21:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="791915440"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="791915440"
Received: from latitude-5491.iind.intel.com ([10.224.186.158])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2023 21:31:21 -0700
From:   Chethan T N <chethan.tumkur.narayan@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiran.k@intel.com,
        chethan.tumkur.narayan@intel.com
Subject: [PATCH v2] Bluetooth: btintel: Add LE States quirk support for Intel's new generation controllers
Date:   Tue, 21 Mar 2023 10:03:10 +0530
Message-Id: <20230321043310.79085-1-chethan.tumkur.narayan@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Basically all Intel controllers support both Central/Peripheral
LE states.

This patch enables the LE States quirk by default on all
Solar and Magnertor Intel controllers.

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

