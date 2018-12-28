Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB53C43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B82217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeL1WIC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:08:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:19951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbeL1WIA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:08:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968741"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:56 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 20/26] mesh: restructure App Key storage
Date:   Fri, 28 Dec 2018 14:07:39 -0800
Message-Id: <20181228220745.25147-21-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181228220745.25147-1-brian.gix@intel.com>
References: <20181228220745.25147-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

Implements App key specific processing including Replay Protection
and Key Updating.
---
 mesh/appkey.c | 19 ++++++++++---------
 mesh/appkey.h |  1 -
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 3d445d217..a437763db 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -15,7 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  Lesser General Public License for more details.
  *
- *
  */
 
 #ifdef HAVE_CONFIG_H
@@ -24,6 +23,7 @@
 
 #define _GNU_SOURCE
 #include <ell/ell.h>
+#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 
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
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 8fce3dcd0..21bc6a70e 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -15,7 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  Lesser General Public License for more details.
  *
- *
  */
 
 /* TODO: get this number from configuration */
-- 
2.14.5

