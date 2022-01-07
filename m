Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B115C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiAGVuL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:50:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:40145 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbiAGVuK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641592210; x=1673128210;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xu/tyFiAMmtstPojdsTFx2QG/rQfJUyQITiUewY4//Y=;
  b=SgUBh1OkDneA4vG+YqOXvqu8tTmrZeudbNwCLEOzfMPk8PZE5GewqPrY
   QUp0lvYf1GigrnrooTGAehD0+feISil2/gwPruEDdChYFxasOr+dulLN4
   prbr3UzP5L98O++SKfsojDJsVwwBg7TX6tHPQW2QpgAuvyvVmpYuzXOg6
   etOdAmcDZJA44bCwaqjidgeRMTWFOT3d+eO0lydJvQCMYeexb57j2c+qW
   K3inHUIyFtnVVKZerL6J0B2uxOBWzM5NeWM5NdIq14FSns6Vqgv0iMdzk
   pMi7JJHP7t8LihwfQSC4s0pwFFh7QOtx/szTKs3B3B0eXt2FIaP5W2G53
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="329290867"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="329290867"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:50:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="473463984"
Received: from tqduong-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.213.180.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:50:09 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix typos in config storage
Date:   Fri,  7 Jan 2022 13:50:03 -0800
Message-Id: <20220107215003.115147-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix keyword typos and comments.
---
 tools/mesh/mesh-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 1a1ba380b..fa11837df 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -2007,7 +2007,7 @@ bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jarray = json_object_object_get(cfg->jcfg, "provisioniers");
+	jarray = json_object_object_get(cfg->jcfg, "provisioners");
 
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return false;
@@ -2041,7 +2041,7 @@ bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high)
 }
 
 /*
- * This is a simplistic implementation onf allocated range, where
+ * This is a simplistic implementation of allocated range, where
  * the range is one contiguous chunk of the address space.
  */
 static bool add_range(json_object *jobj, const char *keyword, uint16_t low,
-- 
2.31.1

