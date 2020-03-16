Return-Path: <SRS0=gY20=5B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D2EC1975A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 06:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6384C20674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 06:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgCPGGw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:06:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:23343 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgCPGGv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 02:06:51 -0400
IronPort-SDR: ekoN9CIPrdXxc4Dbb4DZbww4ZavU0xdzvLqOzPSVOpqsA916HKQSOL0hDlaqN6T5QAa+8AQ3tR
 X9rFRxX9el1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 23:06:51 -0700
IronPort-SDR: AQVaNL2s100qVsUVErnbQeSudEOQm6mDauIM078GR6yNiPJ5bY2FQndKeNsUq9zOKHBl14vu7E
 qKDXpFq69+3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="267458106"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2020 23:06:48 -0700
From:   Amit K Bag <amit.k.bag@intel.com>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH v4] Bluetooth: print fw build version in power-on boot
Date:   Mon, 16 Mar 2020 11:37:18 +0530
Message-Id: <20200316060718.30948-1-amit.k.bag@intel.com>
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
Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
---
 drivers/bluetooth/btusb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5924f3e8b8d..db6211f34300 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1930,7 +1930,14 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (err)
 		return err;
 
-	bt_dev_info(hdev, "Intel firmware patch completed and activated");
+	/* Need build number for downloaded fw patches in
+	 * every power-on boot
+	 */
+       err = btintel_read_version(hdev, &ver);
+       if (err)
+               return err;
+       bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
+		   ver.fw_patch_num);
 
 	goto complete;
 
-- 
2.17.1

