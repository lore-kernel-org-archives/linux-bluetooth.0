Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C65320707
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 17:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgFVRS0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:18:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:52716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgFVRS0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 13:18:26 -0400
IronPort-SDR: NSii6+4+//pRnpvp68w+GllNXLQOC2pKclP6lxtAqRMSD82bxvhkrBaBV0zmWDyp9Wg8mnrfU9
 G52eGXb75qGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142072552"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142072552"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:18:25 -0700
IronPort-SDR: GxJiDVgqxMp0I1Xq3vw7pKuGo+xhubDTDEnVf6lJqKr/u2XrFV4Dq1prFyIPV42V3hvj38R76S
 Kzf9lU+UBhFg==
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="310177608"
Received: from han1-mobl3.jf.intel.com ([10.255.228.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:18:25 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH V2] checkpatch: Add configuration for checkpatch
Date:   Mon, 22 Jun 2020 10:18:17 -0700
Message-Id: <20200622171817.144830-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a configuration with basic rules for checkpatch.
---
 .checkpatch.conf | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 .checkpatch.conf

diff --git a/.checkpatch.conf b/.checkpatch.conf
new file mode 100644
index 000000000..419733832
--- /dev/null
+++ b/.checkpatch.conf
@@ -0,0 +1,14 @@
+--no-tree
+--no-signoff
+--summary-file
+--show-types
+--max-line-length=80
+
+--ignore COMPLEX_MACRO
+--ignore SPLIT_STRING
+--ignore CONST_STRUCT
+--ignore FILE_PATH_CHANGES
+--ignore MISSING_SIGN_OFF
+--ignore PREFER_PACKED
+--ignore COMMIT_MESSAGE
+--ignore SSCANF_TO_KSTRTO
-- 
2.25.4

