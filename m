Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B5C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FEA2080F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 22:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeLNWs2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:48:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:9408 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730731AbeLNWs1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 17:48:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 14:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="100810052"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2018 14:48:26 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ 22/30] mesh: restructure App Key storage
Date:   Fri, 14 Dec 2018 14:47:45 -0800
Message-Id: <20181214224753.2892-23-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181214224753.2892-1-brian.gix@intel.com>
References: <20181214224753.2892-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/appkey.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 3d445d217..c4ebf16b6 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -31,7 +31,7 @@
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/crypto.h"
-#include "mesh/display.h"
+#include "mesh/util.h"
 #include "mesh/model.h"
 #include "mesh/storage.h"
 #include "mesh/appkey.h"
@@ -206,12 +206,12 @@ bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
 		}
 
 		if (seq < msg->seq) {
-			l_info("Ignoring packet with lower sequence number");
+			l_debug("Ignoring packet with lower sequence number");
 			return true;
 		}
 
 		if (seq == msg->seq) {
-			l_info("Message already processed (duplicate)");
+			l_debug("Message already processed (duplicate)");
 			return true;
 		}
 
@@ -302,6 +302,7 @@ bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 		return false;
 
 	key->net_idx = net_idx;
+	key->app_idx = app_idx;
 
 	if (key_value && !set_key(key, app_idx, key_value, false))
 		return false;
@@ -392,14 +393,14 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 			return MESH_STATUS_SUCCESS;
 
 		if (!update) {
-			l_info("Failed to add key: index already stored %x",
+			l_debug("Failed to add key: index already stored %x",
 				(net_idx << 16) | app_idx);
 			return MESH_STATUS_IDX_ALREADY_STORED;
 		}
 	}
 
 	if (!key) {
-		if (l_queue_length(app_keys) <= MAX_APP_KEYS)
+		if (!(l_queue_length(app_keys) < MAX_APP_KEYS))
 			return MESH_STATUS_INSUFF_RESOURCES;
 
 		key = app_key_new();
@@ -411,7 +412,7 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 			return MESH_STATUS_INSUFF_RESOURCES;
 		}
 
-		if (!storage_local_app_key_add(net, net_idx, app_idx, new_key,
+		if (!storage_app_key_add(net, net_idx, app_idx, new_key,
 								false)) {
 			appkey_key_free(key);
 			return MESH_STATUS_STORAGE_FAIL;
@@ -424,7 +425,7 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 		if (!set_key(key, app_idx, new_key, true))
 			return MESH_STATUS_INSUFF_RESOURCES;
 
-		if (!storage_local_app_key_add(net, net_idx, app_idx, new_key,
+		if (!storage_app_key_add(net, net_idx, app_idx, new_key,
 								true))
 			return MESH_STATUS_STORAGE_FAIL;
 	}
@@ -457,7 +458,7 @@ int appkey_key_delete(struct mesh_net *net, uint16_t net_idx,
 	l_queue_remove(app_keys, key);
 	appkey_key_free(key);
 
-	if (!storage_local_app_key_del(net, net_idx, app_idx))
+	if (!storage_app_key_del(net, net_idx, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	return MESH_STATUS_SUCCESS;
-- 
2.14.5

