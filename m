Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E85C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 09:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619220656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfDXJPT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:15:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:58100 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfDXJPT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 05:15:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="143181295"
Received: from ubuntu-16-04.iind.intel.com ([10.224.186.15])
  by fmsmga008.fm.intel.com with ESMTP; 24 Apr 2019 02:15:17 -0700
From:   Amit K Bag <amit.k.bag@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: btintel: improvement: mask vendor events from controller
Date:   Wed, 24 Apr 2019 14:40:59 +0530
Message-Id: <1556097059-31577-1-git-send-email-amit.k.bag@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch mask unnecessary event notifications from controller to host

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5270d5513201..7e5cdd37cc1f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -313,7 +313,7 @@ EXPORT_SYMBOL_GPL(btintel_load_ddc_config);
 
 int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
 {
-	u8 mask[8] = { 0x87, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	u8 mask[8] = { 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	struct sk_buff *skb;
 	int err;
 
-- 
2.7.4

