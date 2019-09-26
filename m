Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29781C4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B321A4A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 18:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfIZSPc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:15:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:4916 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfIZSPc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 14:15:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 11:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="196461353"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.25.152])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2019 11:15:31 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v3 3/3] mesh: Fix Key Ring permissions for local nodes
Date:   Thu, 26 Sep 2019 11:14:44 -0700
Message-Id: <20190926181444.4916-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926181444.4916-1-brian.gix@intel.com>
References: <20190926181444.4916-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We do *not* automatically create populated key rings for imported or
joined nodes, but we also do not *forbid* any node from adding a key
in it's possesion to the local key ring.
---
 mesh/manager.c |  5 -----
 mesh/node.c    | 15 ---------------
 2 files changed, 20 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 501ec10fe..633597659 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -282,7 +282,6 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
-	struct mesh_net *net = node_get_net(node);
 	struct l_dbus_message_iter iter_key;
 	uint16_t primary;
 	uint8_t num_ele;
@@ -298,10 +297,6 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device key");
 
-	if (mesh_net_is_local_address(net, primary, num_ele))
-		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
-					"Cannot overwrite local device key");
-
 	if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
diff --git a/mesh/node.c b/mesh/node.c
index 833377e99..af45a6130 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1681,7 +1681,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 	} else if (req->type == REQUEST_TYPE_IMPORT) {
 		struct node_import *import = req->import;
-		struct keyring_net_key net_key;
 
 		if (!create_node_config(node, node->uuid))
 			goto fail;
@@ -1692,23 +1691,9 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 					import->net_idx, import->net_key))
 			goto fail;
 
-		memcpy(net_key.old_key, import->net_key, 16);
-		net_key.net_idx = import->net_idx;
-		if (import->flags.kr)
-			net_key.phase = KEY_REFRESH_PHASE_TWO;
-		else
-			net_key.phase = KEY_REFRESH_PHASE_NONE;
-
 		/* Initialize directory for storing keyring info */
 		init_storage_dir(node);
 
-		if (!keyring_put_remote_dev_key(node, import->unicast,
-						num_ele, import->dev_key))
-			goto fail;
-
-		if (!keyring_put_net_key(node, import->net_idx, &net_key))
-			goto fail;
-
 	} else {
 		/* Callback for create node request */
 		struct keyring_net_key net_key;
-- 
2.21.0

