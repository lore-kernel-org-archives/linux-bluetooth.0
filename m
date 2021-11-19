Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD270C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A190D61B31
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhKSJkE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhKSJkD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804834"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804834"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179332"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:36:59 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/9] shared/util: Decode MSFT offload codec UUID
Date:   Fri, 19 Nov 2021 15:12:28 +0530
Message-Id: <20211119094235.2432-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds MSFT offload codec UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 81b20d86f4ad..6754ca7bf17c 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1108,6 +1108,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "0cc2131f-96f0-4cd1-b313-b97e7cbc8335",
+		"BlueZ Experimental MSFT offload codecs" },
 	{ }
 };
 
-- 
2.17.1

