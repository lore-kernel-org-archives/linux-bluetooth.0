Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1519FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F302161AD0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhKSISL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234201AbhKSISI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098380"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098380"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468751"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:05 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 06/14] Bluetooth: Remove unused member in struct hci_vnd_codec_v2
Date:   Fri, 19 Nov 2021 13:50:19 +0530
Message-Id: <20211119082027.12809-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove unused "u8 id" member in struct hci_vnd_codec_v2. Vendor codec
is identifiable by Company Id and Vendor Id fields.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/hci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e52fd2f1e046..54fae19f3758 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1395,7 +1395,6 @@ struct hci_std_codecs_v2 {
 } __packed;
 
 struct hci_vnd_codec_v2 {
-	__u8	id;
 	__le16	cid;
 	__le16	vid;
 	__u8	transport;
-- 
2.17.1

