Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC269CD13D1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 09:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjIRJYA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjIRJXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 05:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91910D
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 02:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695029023; x=1726565023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KEoAY4cpNVGBn8mvNjFTLlJyzVYx1PGHeGPWirpHmHs=;
  b=EkGyPWzdFymtjIHHliVloJHliJIp7VffJlBEALzVSfRqmOclqsGFySjt
   2+93W3DtFFcsuz0ik4MbDVBfbWyVg/nhbDBehNhxNKXmCuO/bGH3AprmL
   cm2Pp1ZtBWX0derzYS054vHKrkb2DPQqzS7XQY3U+okcW5DiDoLnCz4A1
   V6YRM5/IgnFLnyjaMnuds9z9YfSYbAdZsquycWtkOw7hvFvU6qem2Azu2
   FBjQjDjGGpSSn9yU4Kou9QMff+TXVS6nT/hBao7l6D9+vg0qwIPCC68Bn
   6hl6PFm1MkswcjSvUFZe4iAVxGM0TmCNZPPeCBZpoku1UBsUG3rU+l5md
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364650182"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364650182"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="1076514279"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076514279"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2023 02:23:39 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: Release memory allocated to store supported codecs
Date:   Mon, 18 Sep 2023 15:05:17 +0530
Message-Id: <20230918093517.2163899-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Memory allocated to store local supported codecs needs to be freed
when BT is powered off.

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1be5763c261c..3640d73f9595 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5074,6 +5074,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
+	hci_codec_list_clear(&hdev->local_codecs);
 
 	hci_dev_put(hdev);
 	return err;
-- 
2.25.1

