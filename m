Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiCaSJu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCaSJt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 14:09:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F12F7F70
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648750082; x=1680286082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=th16P1XGwpjUoo9hOaZJ8a25dvMbgXOsTsg75iq3T+E=;
  b=Nv3ij0o//zfoYI8EoiryM2sZl+udLnxmYgBIkoIqZa1VSWnsZtgP7+a8
   SfonAmkeyWgxz5A2+QzLfxA1lnGp39pCljybDdSynAeoEvbTZvCI8onKh
   NiT3YhfHfGkrwPJhwqJkeuy4MUnCt/Y7mmqC06m4sZE+arfiTa26wAvPV
   24ULhyKXkfgWh4jioj+YqkIdVIMjSms1x+xNw/I1F7OLmzXSwImMnV+6y
   GXdAwSlhnqTWe/jMtJnI0TkoIa4QAwhuO3uAOmGaCYScTjQc/19yMuGQc
   7fmvDvCFhPIB+jVN7RleAU3qv7EMho0wcjjZnAUkn42uhbmDBYJXuDKup
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257495898"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257495898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="840896161"
Received: from coletonb-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.6.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:08:00 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 1/3] Bluetooth: Keep MGMT pending queue ordered FIFO
Date:   Thu, 31 Mar 2022 11:07:47 -0700
Message-Id: <20220331180749.456913-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331180749.456913-1-brian.gix@intel.com>
References: <20220331180749.456913-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Small change to add new commands to tail of the list, and find/remove them
from the head of the list.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 37eef2ce55ae..b69cfed62088 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -297,7 +297,7 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	if (!cmd)
 		return NULL;
 
-	list_add(&cmd->list, &hdev->mgmt_pending);
+	list_add_tail(&cmd->list, &hdev->mgmt_pending);
 
 	return cmd;
 }
-- 
2.35.1

