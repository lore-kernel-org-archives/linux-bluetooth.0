Return-Path: <SRS0=/BwN=SY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A6CC282E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Apr 2019 04:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BF520859
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Apr 2019 04:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDVEvS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:51:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:29256 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDVEvS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Apr 2019 00:51:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Apr 2019 21:51:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,380,1549958400"; 
   d="scan'208";a="152773300"
Received: from ingas-nuc1.sea.intel.com ([10.251.131.212])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2019 21:51:17 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Allow only one app attachment per node
Date:   Sun, 21 Apr 2019 21:51:11 -0700
Message-Id: <20190422045111.20943-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a node is already attached to an application process,
disallow another appication to attach to the same node.
This means that an Attach() method called with the token
identifying a node that is already in use, returns an error
org.bluez.mesh.Error.AlreadyExists
---
 doc/mesh-api.txt | 1 +
 mesh/node.c      | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index f034bc900..698e7ca4e 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -99,6 +99,7 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound,
+			org.bluez.mesh.Error.AlreadyExists,
 			org.bluez.mesh.Error.Failed
 
 	void Leave(uint64 token)
diff --git a/mesh/node.c b/mesh/node.c
index 5431a9e9c..e7016ce75 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1146,9 +1146,13 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	if (!node)
 		return MESH_ERROR_NOT_FOUND;
 
-	/* TODO: decide what to do if previous node->app_path is not NULL */
-	node->app_path = l_strdup(app_path);
+	/* Check if the node is already in use */
+	if (node->owner) {
+		l_warn("The node is already in use");
+		return MESH_ERROR_ALREADY_EXISTS;
+	}
 
+	node->app_path = l_strdup(app_path);
 	node->owner = l_strdup(sender);
 
 	req = l_new(struct attach_obj_request, 1);
-- 
2.17.2

