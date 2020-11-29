Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21818C3E8C5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 06:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69EF20809
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 06:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgK2GX3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Nov 2020 01:23:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:18352 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2GX3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Nov 2020 01:23:29 -0500
IronPort-SDR: /kFJ/uMI1kr0iXNJKUpOCZpEhLB8BK+RAA4Q66dhwgOsAdWaGYVUj6iMthG7mxhCNlwbXubysf
 7jZRXsvKWhRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="152348443"
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="152348443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 22:22:47 -0800
IronPort-SDR: mPkFmj9dXqN7TVXzT1qiSzbu/XW48wkbs6op2CSNPEkVnpaKBXtQUlECHuuscpvBhpaA5M0wf7
 8XvNrgZ8ZQDQ==
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="334197787"
Received: from brayanix-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.42.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 22:22:46 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, sbrown@ewol.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Fix check for mkdir return value in keyring.c
Date:   Sat, 28 Nov 2020 22:22:02 -0800
Message-Id: <20201129062202.91034-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove check for mkdir() return value, since checking for zero does not
cover "already exists" condition and adding extra check for errno value
unnecessarily complicates the code. If mkdir() fails due to any reason
than "already exists", the subsequent call to open() fails and the
error is detected and corectly processed by the code.
---
 mesh/keyring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 1ef4fc3ef..0b74ee914 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -51,8 +51,7 @@ bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, net_key_dir);
 
-	if (!mkdir(key_file, 0755))
-		return false;
+	mkdir(key_file, 0755);
 
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
 								net_idx);
@@ -88,8 +87,7 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, app_key_dir);
 
-	if (!mkdir(key_file, 0755))
-		return false;
+	mkdir(key_file, 0755);
 
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
 								app_idx);
@@ -207,8 +205,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
 
-	if (!mkdir(key_file, 0755))
-		return false;
+	mkdir(key_file, 0755);
 
 	for (i = 0; i < count; i++) {
 		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
-- 
2.26.2

