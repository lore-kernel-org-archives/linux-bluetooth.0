Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 07:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKDHI4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKDHIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 03:08:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D1D2790E
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667545733; x=1699081733;
  h=from:to:cc:subject:date:message-id;
  bh=EMY8E2FNvA21c0E8I62NR0ZTyFpfEBJg1EehJJ/brq0=;
  b=SIu2QvFauROoMldz0ow1DXDr3BFC7B4XHdxQM3V81HWa29laITFvATU6
   LYimFT4rUQvXveFKddl49URBkrZGXljpncilzEOb7Lgt4OEmhXxSavE28
   xwORNnC5/CxpMd8uK0VYmR5Y4tO1nHChHNtqjxHFmABjyfgkW5YG90MFV
   kLIePtLkBNLz5KTFa3sgGChnzDNdJyENrU9vg6rqciO3zKVBk/PgUK+m5
   +Fg2ZSPBs5xbkmvZrTr2wkq5XlvFXL7FChbYB+OtU80yBH5X6a8JFghPN
   L/T+pcq8dH20D3w+etRkoNw4XdERMyoYI5eYnJc1997sYOR9o3DdSZSbL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311637565"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="311637565"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809968455"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="809968455"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2022 00:08:46 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] bluetooth: Remove codec id field in vendor codec definition
Date:   Fri,  4 Nov 2022 12:48:09 +0530
Message-Id: <20221104071810.22720-1-kiran.k@intel.com>
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
 include/net/bluetooth/hci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e004ba04a9ae..581539cbb856 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1424,7 +1424,6 @@ struct hci_std_codecs_v2 {
 } __packed;
 
 struct hci_vnd_codec_v2 {
-	__u8	id;
 	__le16	cid;
 	__le16	vid;
 	__u8	transport;
-- 
2.17.1

