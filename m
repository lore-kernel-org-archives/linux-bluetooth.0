Return-Path: <SRS0=kCXZ=IG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F15C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5970D651CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 11:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhCHLLz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:11:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:4527 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCHLL2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 06:11:28 -0500
IronPort-SDR: Gc8vyRZhL9nYqP3MCjj9MriY+BvjteXhnvMgXyrPmTTzLfv0q56UDv3Bd0rPkyEM7rFPGqcZws
 Gef/jroOBTVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="175118695"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="175118695"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 03:11:28 -0800
IronPort-SDR: qcM+zN2DMYfavb7EGRqUqFUKv28z1sB9pFSueGkuESuZz5InWOMLRNW0Gk7julcmPI6CR6g5pW
 HrCd4d2wMbmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="598818517"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2021 03:11:26 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] btusb: btintel: print firmware file name on error loading firmware
Date:   Mon,  8 Mar 2021 16:44:54 +0530
Message-Id: <20210308111454.31765-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

print the firmware file name on error loading from fie system

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0c20226d3b63..0d355bb45e08 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2540,7 +2540,8 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
-		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
+		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
+			   fwname, err);
 		return err;
 	}
 
@@ -2734,7 +2735,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
-		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
+		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
+			   fwname, err);
 		return err;
 	}
 
-- 
2.17.1

