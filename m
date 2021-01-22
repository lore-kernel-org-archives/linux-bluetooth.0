Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57116C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 22:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F4423AAC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbhAVWnD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:43:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:45066 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbhAVToB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 14:44:01 -0500
IronPort-SDR: kZ8HcsdBQz2QBmRgRg96l/1w7N9kPaz9LI33ojUq44rpHvlNyBmHq5CZMxyu92NnEOEanqgAI4
 MAOy7JaTfw5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="264317667"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="264317667"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 11:43:18 -0800
IronPort-SDR: vXkG5+/XC0hdqF9LaETo8OYbq/BEo/k04+UdHDKuvQGQ4yWO213uBD0sXn1Vbwy6QLiMNOUvIW
 2X4E1SFnvLbg==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="428148625"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.2.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 11:43:18 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] tools: Fix static analysis warnings
Date:   Fri, 22 Jan 2021 11:42:58 -0800
Message-Id: <20210122194258.538970-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Usage of potentially NULL pointers
---
 tools/btmgmt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 383e7199e..f4eb541fa 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4912,6 +4912,12 @@ static void cmd_advmon_add_pattern(int argc, char **argv)
 
 	cp_len = sizeof(*cp) + argc * sizeof(struct mgmt_adv_pattern);
 	cp = malloc0(cp_len);
+	if (!cp) {
+		error("Failed to alloc patterns.");
+		success = false;
+		goto done;
+	}
+
 	cp->pattern_count = argc;
 
 	for (i = 0; i < argc; i++) {
@@ -4987,6 +4993,12 @@ static void cmd_advmon_add_pattern_rssi(int argc, char **argv)
 
 	cp_len = sizeof(*cp) + argc * sizeof(struct mgmt_adv_pattern);
 	cp = malloc0(cp_len);
+	if (!cp) {
+		error("Failed to alloc patterns.");
+		success = false;
+		goto done;
+	}
+
 	cp->pattern_count = argc;
 	cp->rssi.high_threshold = rssi_high;
 	cp->rssi.low_threshold = rssi_low;
-- 
2.25.4

