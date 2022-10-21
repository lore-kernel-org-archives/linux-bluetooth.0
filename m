Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B85C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 23:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJUXq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUXq1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 19:46:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553929E982
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666395985; x=1697931985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EFytebbYZoCeX9gjAXjbpSSAPQnhCm/i6i0o5IymFKw=;
  b=hvQRm0UapHIWcI6Cnf77jgQuEaqlpYZepAEqX21RxsuEMtdkrHO8BgNQ
   Marl8Dl+Hy4B56sSDMPj8vL/zsbk8SHAANVJtgM1VI5xzVhfjCcZjs7Wd
   hEcrJNBCzxO3+/MuYU656g8cboWIf+3SmpG8bwzrH6nnbbwp1OLixJTof
   zEVPCOqbh/t8xwFfqIuRzNnZ+v1q+21BnzA9r2eEj0l9eYYurngx1V/ws
   GeJqoVYI607Bnqc7HUYuKJxcidhCROzkO7/+X+pdxtyIhvByuKofoRYci
   Xy5BOjxyQJuA/fxzlGj8cdJz0fuJVmhveabdwII097Yv+kEwnlEUzNYEV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="287529943"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="287529943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:46:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="633126976"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="633126976"
Received: from bmitch7x-mobl.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.209.0.254])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:46:25 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH] Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
Date:   Fri, 21 Oct 2022 16:46:17 -0700
Message-Id: <20221021234617.28848-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When validating the parameter length for MGMT_OP_ADD_EXT_ADV_PARAMS
command, use the correct op code in error status report:
was MGMT_OP_ADD_ADVERTISING, changed to MGMT_OP_ADD_EXT_ADV_PARAMS.

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

