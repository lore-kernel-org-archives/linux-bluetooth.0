Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB3C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 01:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCJBfk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 20:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCJBfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 20:35:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB642E20EA
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 17:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678412124; x=1709948124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fFx053nYrBOacMkaAqxbeuR9dTxxH+y3egw3CGAVFPg=;
  b=EhcV6IjwoJ4BDUCSTr9/y4d4PgQNSsBqzJW/c8ltrADy1HIsllvHoKV8
   qGMu9G8RZRse/7nL/XV3RL0vAtQtvUooaXTPnL+BEhqBBk3OEqkFSVJEE
   ybaE/ib70hJUQyySiOFAJGiDloAh5uL3fDf9upxHslN21+ysaf9n9EtTw
   hMm7K5rlBTS72IhVxXyT1sbyy94LzNFPZd01NqonITDAA3LC/80kxUMBE
   SkO+hnSqP5hcIpEvopmocp7jKLgs7oOhQh2JhFy9qDukXT4ZpzPLhnnCt
   k8xyizG3K7lf51SZ48ndIUyXvtdjMKqEDOPZ+cfs2vzWRa8nKcb63krz8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364269076"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="364269076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 17:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707840888"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="707840888"
Received: from istotlan-mobl1.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.212.238.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 17:35:23 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     brian.gix@intel.com, brian.gix@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ] mesh: Fix node when loading from storage
Date:   Thu,  9 Mar 2023 17:35:12 -0800
Message-Id: <20230310013512.425033-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@gmail.com>

This fixes adding mandatory models (config server, remote provisioner)
to a node whose configuration is being loaded from storage:
mesh_model_add() was called with a wrong argument.

Was:     mesh_model_add(..., PRIMARY_ELE_IDX, ...);
Correct: mesh_model_add(..., ele->models, ...);
---
 mesh/node.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index ed3212685..93537c5ba 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -347,6 +347,7 @@ static bool add_elements_from_storage(struct mesh_node *node,
 					struct mesh_config_node *db_node)
 {
 	const struct l_queue_entry *entry;
+	struct node_element *ele;
 
 	entry = l_queue_get_entries(db_node->elements);
 
@@ -354,14 +355,19 @@ static bool add_elements_from_storage(struct mesh_node *node,
 		if (!add_element_from_storage(node, entry->data))
 			return false;
 
+	ele = l_queue_find(node->elements, match_element_idx,
+						L_UINT_TO_PTR(PRIMARY_ELE_IDX));
+	if (!ele)
+		return false;
+
 	/* Add configuration server model on the primary element */
-	mesh_model_add(node, PRIMARY_ELE_IDX, CONFIG_SRV_MODEL, NULL);
+	mesh_model_add(node, ele->models, CONFIG_SRV_MODEL, NULL);
 
 	/* Add remote provisioning models on the primary element */
-	mesh_model_add(node, PRIMARY_ELE_IDX, REM_PROV_SRV_MODEL, NULL);
+	mesh_model_add(node, ele->models, REM_PROV_SRV_MODEL, NULL);
 
 	if (node->provisioner)
-		mesh_model_add(node, PRIMARY_ELE_IDX, REM_PROV_CLI_MODEL, NULL);
+		mesh_model_add(node, ele->models, REM_PROV_CLI_MODEL, NULL);
 
 	return true;
 }
-- 
2.39.2

