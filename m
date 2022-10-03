Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CABC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 06:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiJCGkD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJCGj5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 02:39:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91727677
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Oct 2022 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664779191; x=1696315191;
  h=from:to:cc:subject:date:message-id;
  bh=zKbCsV8FsK7XyhtNsIia4tqJ6rL2B+znEEbn6dzgKUk=;
  b=edV42xKPyALKGBCfAYm6j44HJUwKMsZuOf5l9qcLYExtjcRSuoxiKhsh
   RNicQHYpmZhF50gVTdH+2QbVzNDuoqu4O66JcEJXguPu8GwCR2mATRrK+
   kJgYaR09szKpjd+E00h1rEUg6FW3DhDW6WpxqkYzpOaaHEYNoDiOPjAMM
   FiIGVZHkttixLH886jui/ZFKFjIqymq1IxXdwgKHrEOyXO8qOSdSSnrQD
   GeKm91UVRYJE939NqmlC0c7ddHOjx4ZEfi7iX58F0DXgHQLOuJv0sKCus
   rQjjxBrNWSwPF/A3pLFzyeBMv60ryocADFtfVxq7Hl+pKlyUvM5DRs9Vh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="388850894"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="388850894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 23:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="618627097"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="618627097"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 02 Oct 2022 23:39:48 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] btusb: Avoid reset of ISOC endpoint alt settings to zero
Date:   Mon,  3 Oct 2022 12:18:36 +0530
Message-Id: <20221003064836.11414-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>

In case of suspend/resume and HCI_RESET (BT On and Off),
ISOC endpoint set to alt setting 0 when no SCO connection exists.
This patch shall avoid resetting of ISOC endpoint to alt setting to 0.

Signed-off-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btusb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..ebfec6d8573f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1981,10 +1981,11 @@ static void btusb_work(struct work_struct *work)
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
 			bt_dev_err(hdev, "set USB alt:(%d) failed!", new_alts);
 	} else {
-		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 		usb_kill_anchored_urbs(&data->isoc_anchor);
 
-		__set_isoc_interface(hdev, 0);
+		if (test_and_clear_bit(BTUSB_ISOC_RUNNING, &data->flags))
+			__set_isoc_interface(hdev, 0);
+
 		if (test_and_clear_bit(BTUSB_DID_ISO_RESUME, &data->flags))
 			usb_autopm_put_interface(data->isoc ? data->isoc : data->intf);
 	}
-- 
2.17.1

