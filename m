Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB87C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC18760F48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhIWD2x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239063AbhIWD2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555928"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555928"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072389"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 15/20] tools/mesh-cfgclient: Add group parent address for DB compliance
Date:   Wed, 22 Sep 2021 20:25:58 -0700
Message-Id: <20210923032603.50536-16-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh/mesh-db.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 42ba831d4..0dc811801 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1590,6 +1590,10 @@ bool mesh_db_add_group(struct mesh_group *grp)
 			goto fail;
 	}
 
+	/* Initialize parent group to unassigned address for now*/
+	if (!write_uint16_hex(jgroup, "parentAddress", UNASSIGNED_ADDRESS))
+		goto fail;
+
 	json_object_array_add(jgroups, jgroup);
 
 	return save_config();
-- 
2.31.1

