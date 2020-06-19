Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE0AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 23:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE7522447
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 23:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgFSXBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:01:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:28919 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbgFSXBE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 19:01:04 -0400
IronPort-SDR: x0ChneJSOxF509BLIvnglRIhwElue+x/nAVGc+weUDBecVFwJz2LW7FrdfH3Q22dcNhQsdzYMG
 TXZdXq6EArDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="143076286"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="143076286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 16:01:03 -0700
IronPort-SDR: HKDKgHwUHPkNyqUkFbZeJaIe3PY1QMSHvJrR6iF6Jnt3qH6nc0hStXjstxU3i1LVlqq9f+AbHX
 j/sujG4TobfQ==
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="422015436"
Received: from han1-mobl3.jf.intel.com ([10.254.73.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 16:01:02 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] checkpatch: Add configuration for checkpatch
Date:   Fri, 19 Jun 2020 16:00:56 -0700
Message-Id: <20200619230056.49964-1-tedd.an@linux.intel.com>
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
 .checkpatch.conf | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 .checkpatch.conf

diff --git a/.checkpatch.conf b/.checkpatch.conf
new file mode 100644
index 000000000..7e9544671
--- /dev/null
+++ b/.checkpatch.conf
@@ -0,0 +1,13 @@
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
-- 
2.25.4

