Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE02C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02120724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLKVR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:21:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:56439 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgCLKVR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:21:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 03:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="236589931"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2020 03:21:13 -0700
From:   Amit K Bag <amit.k.bag@intel.com>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: print fw build version in power-on boot
Date:   Thu, 12 Mar 2020 15:51:42 +0530
Message-Id: <20200312102142.26538-1-amit.k.bag@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sukumar Ghorai <sukumar.ghorai@intel.com>

To determine the build version of Bluetooth firmware to ensure reported
issue related to a particular release. This is very helpful for every fw
downloaded to BT controller and issue reported from field test.

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5924f3e8b8d..d4328008a714 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1930,7 +1930,12 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (err)
 		return err;
 
-	bt_dev_info(hdev, "Intel firmware patch completed and activated");
+       /* Need build number for downloaded fw patches in every power-on boot */
+       err = btintel_read_version(hdev, &ver);
+       if (err)
+               return err;
+       BT_INFO("%s: Intel Bluetooth fw patch 0x%02x completed and activated",
+               hdev->name, ver.fw_patch_num);
 
 	goto complete;
 
-- 
2.17.1

