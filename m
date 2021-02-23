Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964EDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602DD64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhBWTEU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:38104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233352AbhBWTEP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:15 -0500
IronPort-SDR: n1qRWhm8n4Evx4i+OjVxM0Kg2AJJoYr45Ud1xlJJPMcRTE+zKEZipRZIwbS9A47/t/i7myhtND
 AHdHPPab9L2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="269870524"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="269870524"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:34 -0800
IronPort-SDR: 9TBVLOY/jce5zWereWFkUvr8kB6273dORoVzzN44j7NeUkV2FLmkvHp1tzzUYvHxuaOPlC/KmE
 YWiiBI/7PGXw==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432831000"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:34 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 1/6] mesh: Cleanup deprecated symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:47 -0800
Message-Id: <20210223190252.483784-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210223190252.483784-1-brian.gix@intel.com>
References: <20210223190252.483784-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/rpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/rpl.c b/mesh/rpl.c
index 7cea8e346..ac0f6b6f2 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -62,7 +62,7 @@ bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 	snprintf(src_file, PATH_MAX, "%s%s/%8.8x/%4.4x", node_path, rpl_dir,
 								iv_index, src);
 
-	fd = open(src_file, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
+	fd = open(src_file, O_WRONLY | O_CREAT | O_TRUNC, 0600);
 	if (fd >= 0) {
 		snprintf(seq_txt, 7, "%6.6x", seq);
 		if (write(fd, seq_txt, 6) == 6)
-- 
2.25.4

