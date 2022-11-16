Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D52C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 06:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiKPGUA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiKPGTx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 01:19:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E715717
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 22:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668579592; x=1700115592;
  h=from:to:cc:subject:date:message-id;
  bh=/J0wkZUAFhdtL/86/ykBYABiwi8FBxgu8eN1doQHxWE=;
  b=T5+3DutnenVougreEvGOYIOhqUKn+Yp6Alge9XRgz9myy93skorhRrD/
   yFiG2AQSCdu5wRDR/fY4nZgt4X1t+MH1Ozuv1sPZmkF3UYNXlZma7qCTi
   KPevYMk3/SH5DLOwmCtyjwEiDzhh/B+wBrNkiG5spAxiKGC0B2db2cuGT
   7PvTADskVdDnDSbWxQp6KHjqTqL8OswrFT1b+MORVbgs4XyxFsRFX14sF
   p9TnMa+JLdQXWcn1yx8k8T/8GV/xDruev/MVLh1UCJeO+2kKhBwmalURS
   s0/9seEkW4juO/gsmjKpQbPPlezIEOWMNft/ct3I8UcEePXoFLwDSn1/D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374596318"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374596318"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702739828"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702739828"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 22:19:50 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: Remove codec id field in vendor codec definition
Date:   Wed, 16 Nov 2022 11:59:17 +0530
Message-Id: <20221116062918.11879-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

As per the specfication vendor codec id is defined.
BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2127

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
Notes:
Changes in v2:
 - Fix commit message format

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

