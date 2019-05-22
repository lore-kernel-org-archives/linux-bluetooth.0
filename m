Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B6CC282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A6F20856
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfEVTy7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 15:54:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:64438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731646AbfEVTy5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 15:54:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:54:56 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.78.4])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2019 12:54:56 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 3/5] mesh: Implement Net Key keyring storage handling
Date:   Wed, 22 May 2019 12:54:26 -0700
Message-Id: <20190522195428.1901-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190522195428.1901-1-brian.gix@intel.com>
References: <20190522195428.1901-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Affected methods:
CreateSubnet()
ImportSubnet()
UpdateSubnet()
DeleteSubnet()
---
 mesh/manager.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index d990ceec2..92297821a 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -24,9 +24,12 @@
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
+#include "mesh/mesh-defs.h"
 #include "mesh/dbus.h"
 #include "mesh/error.h"
 #include "mesh/mesh.h"
+#include "mesh/node.h"
+#include "mesh/keyring.h"
 #include "mesh/manager.h"
 
 static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
@@ -86,51 +89,112 @@ static struct l_dbus_message *cancel_scan_call(struct l_dbus *dbus,
 	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
 }
 
+static struct l_dbus_message *store_new_subnet(struct mesh_node *node,
+					struct l_dbus_message *msg,
+					uint16_t net_idx, uint8_t *new_key)
+{
+	struct keyring_net_key key;
+
+	if (net_idx > MAX_KEY_IDX)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (keyring_get_net_key(node, net_idx, &key)) {
+		/* Allow redandent calls only if they match */
+		if (!memcmp(key.old_key, new_key, 16))
+			return l_dbus_message_new_method_return(msg);
+
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS, NULL);
+	}
+
+	memcpy(key.old_key, new_key, 16);
+	key.net_idx = net_idx;
+	key.phase = KEY_REFRESH_PHASE_NONE;
+
+	if (!keyring_put_net_key(node, net_idx, &key))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
 static struct l_dbus_message *create_subnet_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
+	uint8_t key[16];
 	uint16_t net_idx;
 
-	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
+						net_idx == PRIMARY_NET_IDX)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	/* Generate key and store */
+	l_getrandom(key, sizeof(key));
+
+	return store_new_subnet(node, msg, net_idx, key);
 }
 
 static struct l_dbus_message *update_subnet_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
+	struct keyring_net_key key;
 	uint16_t net_idx;
 
-	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
+						net_idx > MAX_KEY_IDX)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	if (!keyring_get_net_key(node, net_idx, &key))
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST, NULL);
+
+	switch (key.phase) {
+	case KEY_REFRESH_PHASE_NONE:
+		/* Generate Key and update phase */
+		l_getrandom(key.new_key, sizeof(key.new_key));
+		key.phase = KEY_REFRESH_PHASE_ONE;
+
+		if (!keyring_put_net_key(node, net_idx, &key))
+			return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+		/* Fall Through */
+
+	case KEY_REFRESH_PHASE_ONE:
+		/* Allow redundant calls to start Key Refresh */
+		return l_dbus_message_new_method_return(msg);
+
+	default:
+		break;
+	}
+
+	/* All other phases mean KR already in progress over-the-air */
+	return dbus_error(msg, MESH_ERROR_BUSY, "Key Refresh in progress");
 }
 
 static struct l_dbus_message *delete_subnet_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
 	uint16_t net_idx;
 
-	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
+						net_idx > MAX_KEY_IDX)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	keyring_del_net_key(node, net_idx);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *import_subnet_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	uint16_t net_idx;
+	struct mesh_node *node = user_data;
 	struct l_dbus_message_iter iter_key;
+	uint16_t net_idx;
 	uint8_t *key;
 	uint32_t n;
 
@@ -142,8 +206,7 @@ static struct l_dbus_message *import_subnet_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad network key");
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	return store_new_subnet(node, msg, net_idx, key);
 }
 
 static struct l_dbus_message *create_appkey_call(struct l_dbus *dbus,
-- 
2.14.5

