Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D826DC38A2D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 00:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJVAti (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJVAth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 20:49:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027634714
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 17:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666399775; x=1697935775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rsjlNFywgKStKHCnFnQEwrLNiyD2xVDkRBnwtqnIJKY=;
  b=PcEGdh0vGUGDEkASLyQe9nbFxFo56btP3Nmi9kqgaUlEek9DU/PqbJg0
   FZzuVskfTeApNfxWjhSIqw0g1k8eSYyk0Aq49QNg0EMAcNl6WEFzBX3An
   jr+pDHr8LMfL5x+SIrC12qrUFGU6rzu89fQ1b5/gR2u7ZQqp5B25ZGMBZ
   BXm2/aFfvU0iQL7JLT0iJfMcvA7OoPQMtPamR43FI78vD3rbfRIEV337W
   588wC1zMPD7I8EWk0xFeS3s2+0LBSlm544VQuZInrGwLEfFCP0QVOQVXE
   XRjjOVtnIgVttcAFAHzeWwsF8nOaNfigYoQWoTMqncc8ezIysFLPPihq9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307128297"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="307128297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:49:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773254756"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773254756"
Received: from bmitch7x-mobl.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.209.0.254])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:49:35 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH v2] Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
Date:   Fri, 21 Oct 2022 17:48:56 -0700
Message-Id: <20221022004856.31984-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When validating the parameter length for MGMT_OP_ADD_EXT_ADV_PARAMS
command, use the correct op code in error status report:
was MGMT_OP_ADD_ADVERTISING, changed to MGMT_OP_ADD_EXT_ADV_PARAMS.

Fixes: 12410572833a2 ("Bluetooth: Break add adv into two mgmt commands")
Signed-off-by: Inga Stotland <inga.stotland@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a92e7e485feb..0dd30a3beb77 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8859,7 +8859,7 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 	 * extra parameters we don't know about will be ignored in this request.
 	 */
 	if (data_len < MGMT_ADD_EXT_ADV_PARAMS_MIN_SIZE)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_PARAMS,
 				       MGMT_STATUS_INVALID_PARAMS);
 
 	flags = __le32_to_cpu(cp->flags);
-- 
2.37.3

