Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02480C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiKVIxb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiKVIxa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 03:53:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EB010B6F
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669107209; x=1700643209;
  h=from:to:cc:subject:date:message-id;
  bh=qiltSLMTb8npvmMquLgjAxBzu1BxxDUvT4WAtEgtcOA=;
  b=I7n+0jnikJGKMaGWIh9C3DGSAe1cGkopcKlvw1uz9//9zY482VMdNBhX
   XLuIM+FyRgmqve6CunuBm7F6AohvexjVTcASC6HrEseqCYDdtQ8Qsxmpv
   88BPphIi3SNzy8xtJeEeHsXM5ytfnSWsn0j2LGEyNQKwki5rXgOfS8+P0
   jjSnPq/kQ7aR9B1dxMFZDm89VzDKMoOW7XXC+I795ePXBGIG1eg2oQGml
   wdE5mvknbAtTzT1YESjytw2Ca+008JoE7DYrfe1xGln5L/l4YAMsneDeP
   3espKLcT17pRYBr0DHqsu7tSju7m+4MOQ5sydhhIqX3w3dl3nITXpGkNy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340635754"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="340635754"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 00:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="816029132"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="816029132"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 00:53:27 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: Remove codec id field in vendor codec definition
Date:   Tue, 22 Nov 2022 14:32:56 +0530
Message-Id: <20221122090257.26564-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

As per the specfication vendor codec id is defined.
BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2127

Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Codecs V2")
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
Add "Fixes" tag in commit message

changes in v2:
Fix typo in commit message

 include/net/bluetooth/hci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7a8a19bef92c..8d773b042c85 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1455,7 +1455,6 @@ struct hci_std_codecs_v2 {
 } __packed;
 
 struct hci_vnd_codec_v2 {
-	__u8	id;
 	__le16	cid;
 	__le16	vid;
 	__u8	transport;
-- 
2.17.1

