Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49551C282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A6121736
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 08:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfA1Iyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:54:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:9055 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1Iyu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 03:54:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 00:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="120014295"
Received: from ubuntu16.iind.intel.com ([10.224.186.218])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2019 00:54:48 -0800
From:   raghuram.hegde@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Subject: [PATCH] btusb: Add shutdown routine for BTUSB_INTEL_NEW devices
Date:   Mon, 28 Jan 2019 14:23:45 +0530
Message-Id: <1548665625-23742-1-git-send-email-raghuram.hegde@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

btusb_shutdown_intel routine shall reset the controller
and stop all BT operation.
Advantages:
	1. Power save on the platform
	2. Host and controller will be in Sync.

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5de0c2e59b97..66483ca3d870 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3139,6 +3139,7 @@ static int btusb_probe(struct usb_interface *intf,
		hdev->manufacturer = 2;
		hdev->send = btusb_send_frame_intel;
		hdev->setup = btusb_setup_intel_new;
+		hdev->shutdown = btusb_shutdown_intel;
		hdev->hw_error = btintel_hw_error;
		hdev->set_diag = btintel_set_diag;
		hdev->set_bdaddr = btintel_set_bdaddr;
--
2.7.4
