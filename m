Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69779C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304AE2054F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETQUP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 12:20:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:37547 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETQUP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 12:20:15 -0400
IronPort-SDR: Hpxuf8zkn2wI7sYjBuJ9JJlwDwO1mNjnD3noC0yPfIKDmRaW9Ha5JqmBILK5r8T9lpCD0atT7a
 v1BJ65Pm1vyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 09:20:15 -0700
IronPort-SDR: zsuyLuQwbpq+D+Ym1NfyZ+YUK1mixKg/KPg90684L91Ow5FaGj46GHmNAl0CTFriecePNgsPSV
 0JvliMFzadNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="466582044"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.66.90])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2020 09:20:15 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v2 1/1] mesh: Fix double-free
Date:   Wed, 20 May 2020 09:20:05 -0700
Message-Id: <20200520162005.838134-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520162005.838134-1-brian.gix@intel.com>
References: <20200520162005.838134-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixing a prior memory leak created a double-free error when destroying
the NVM sorage of a node. We have two situations where we want to
discard a nodes dytnamic memory:

1. When the node is being deleted at runtime.  This causes release of
   both dynamic memory and NVM storage.

2. During shutdown, we release dynamic memory only.

This patch ensures that after node deletion releases dynamic memory,
the pointers to it are cleared, avoiding a second free attempt.
---
 mesh/mesh-config-json.c | 2 +-
 mesh/mesh-config.h      | 2 +-
 mesh/node.c             | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 6567d761c..0f125b95e 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2309,7 +2309,7 @@ bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 	return true;
 }
 
-void mesh_config_destroy(struct mesh_config *cfg)
+void mesh_config_release_nvm(struct mesh_config *cfg)
 {
 	char *node_dir, *node_name;
 	char uuid[33];
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 25002f5a7..d55bcb991 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -114,7 +114,7 @@ typedef bool (*mesh_config_node_func_t)(struct mesh_config_node *node,
 bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 							void *user_data);
 void mesh_config_release(struct mesh_config *cfg);
-void mesh_config_destroy(struct mesh_config *cfg);
+void mesh_config_release_nvm(struct mesh_config *cfg);
 bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 				mesh_config_status_func_t cb, void *user_data);
 struct mesh_config *mesh_config_create(const char *cfgdir_name,
diff --git a/mesh/node.c b/mesh/node.c
index 2b4b3a563..a675c831d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -352,8 +352,7 @@ void node_remove(struct mesh_node *node)
 
 	l_queue_remove(nodes, node);
 
-	if (node->cfg)
-		mesh_config_destroy(node->cfg);
+	mesh_config_release_nvm(node->cfg);
 
 	free_node_resources(node);
 }
-- 
2.25.4

