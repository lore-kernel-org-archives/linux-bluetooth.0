Return-Path: <SRS0=xYxd=TV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A4C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D53217D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 17:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfEURBt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 May 2019 13:01:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:15125 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfEURBt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 May 2019 13:01:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 10:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,495,1549958400"; 
   d="scan'208";a="174083557"
Received: from bgix-dell-lap.sea.intel.com ([10.255.78.4])
  by fmsmga002.fm.intel.com with ESMTP; 21 May 2019 10:01:45 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Add App and Net Key Refresh keyring back-end
Date:   Tue, 21 May 2019 10:01:35 -0700
Message-Id: <20190521170135.32057-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fill in skeleton App Key and Net Key KeyRing methods that are affected
by the Key Refresh Procedure.
---
 doc/mesh-api.txt |   2 +
 mesh/manager.c   | 198 ++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 170 insertions(+), 30 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 112990a5d..9644553e8 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -434,6 +434,7 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.DoesNotExist
+			org.bluez.mesh.Error.Busy
 
 	void DeleteSubnet(uint16 net_index)
 
@@ -527,6 +528,7 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.DoesNotExist
+			org.bluez.mesh.Error.Busy
 
 	void DeleteAppKey(uint16 app_index)
 
diff --git a/mesh/manager.c b/mesh/manager.c
index d990ceec2..8ef32d735 100644
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
@@ -86,51 +89,110 @@ static struct l_dbus_message *cancel_scan_call(struct l_dbus *dbus,
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
+		/* Allow redundent calls only if they match */
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
+	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) || !net_idx)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	/* Generate key and submit */
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
+		if (!keyring_put_net_key(node, net_idx, &key))
+			return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+		/* Fall Through */
+
+	case KEY_REFRESH_PHASE_ONE:
+		/* Allow redundent calls to start Key Refresh */
+		return l_dbus_message_new_method_return(msg);
+
+	default:
+		break;
+	}
+
+	/* All other phases mean KR already in progress over-the-air */
+	return dbus_error(msg, MESH_ERROR_BUSY, "KR in progress");
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
 
@@ -142,55 +204,116 @@ static struct l_dbus_message *import_subnet_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad network key");
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	return store_new_subnet(node, msg, net_idx, key);
+}
+
+static struct l_dbus_message *store_new_appkey(struct mesh_node *node,
+					struct l_dbus_message *msg,
+					uint16_t net_idx, uint16_t app_idx,
+					uint8_t *new_key)
+{
+	struct keyring_net_key net_key;
+	struct keyring_app_key app_key;
+
+	if (net_idx > MAX_KEY_IDX || app_idx > MAX_KEY_IDX)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!keyring_get_net_key(node, net_idx, &net_key))
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST, NULL);
+
+	if (keyring_get_app_key(node, app_idx, &app_key)) {
+		/* Allow redundent calls with identical data */
+		if (!memcmp(app_key.old_key, new_key, 16) &&
+						app_key.net_idx == net_idx)
+			return l_dbus_message_new_method_return(msg);
+
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS, NULL);
+	}
+
+	memcpy(app_key.old_key, new_key, 16);
+	app_key.net_idx = net_idx;
+	app_key.app_idx = app_idx;
+
+	if (!keyring_put_app_key(node, app_idx, net_idx, &app_key))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *create_appkey_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
 	uint16_t net_idx, app_idx;
+	uint8_t key[16];
 
 	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	l_getrandom(key, sizeof(key));
+
+	return store_new_appkey(node, msg, net_idx, app_idx, key);
 }
 
 static struct l_dbus_message *update_appkey_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	uint16_t net_idx, app_idx;
+	struct mesh_node *node = user_data;
+	struct keyring_net_key net_key;
+	struct keyring_app_key app_key;
+	uint16_t app_idx;
 
-	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
+	if (!l_dbus_message_get_arguments(msg, "q", &app_idx) ||
+						app_idx > MAX_KEY_IDX)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	if (!keyring_get_app_key(node, app_idx, &app_key) ||
+			!keyring_get_net_key(node, app_key.net_idx, &net_key))
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST, NULL);
+
+	switch (net_key.phase) {
+	case KEY_REFRESH_PHASE_NONE:
+	case KEY_REFRESH_PHASE_ONE:
+		/* Generate Key if in acceptable phase */
+		l_getrandom(app_key.new_key, sizeof(app_key.new_key));
+		if (!keyring_put_app_key(node, app_idx, app_key.net_idx,
+								&app_key))
+			return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+		return l_dbus_message_new_method_return(msg);
+
+	default:
+		break;
+	}
+
+	/* Don't allow Updates from invalid phase */
+	return dbus_error(msg, MESH_ERROR_BUSY, "KR in progress");
 }
 
 static struct l_dbus_message *delete_appkey_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	uint16_t net_idx, app_idx;
+	struct mesh_node *node = user_data;
+	uint16_t app_idx;
 
-	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
+	if (!l_dbus_message_get_arguments(msg, "q", &app_idx))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	keyring_del_app_key(node, app_idx);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *import_appkey_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	uint16_t net_idx, app_idx;
+	struct mesh_node *node = user_data;
 	struct l_dbus_message_iter iter_key;
+	uint16_t net_idx, app_idx;
 	uint8_t *key;
 	uint32_t n;
 
@@ -203,22 +326,37 @@ static struct l_dbus_message *import_appkey_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad application key");
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	return store_new_appkey(node, msg, net_idx, app_idx, key);
 }
 
 static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
+	struct keyring_net_key key;
 	uint16_t net_idx;
 	uint8_t phase;
 
-	if (!l_dbus_message_get_arguments(msg, "qy", &net_idx, &phase))
+	if (!l_dbus_message_get_arguments(msg, "qy", &net_idx, &phase) ||
+					phase == KEY_REFRESH_PHASE_ONE ||
+					phase > KEY_REFRESH_PHASE_THREE)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	if (!keyring_get_net_key(node, net_idx, &key))
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST, NULL);
+
+	if (phase == KEY_REFRESH_PHASE_THREE &&
+					key.phase != KEY_REFRESH_PHASE_NONE) {
+		memcpy(key.old_key, key.new_key, 16);
+		key.phase = KEY_REFRESH_PHASE_NONE;
+	} else
+		key.phase = phase;
+
+	if (!keyring_put_net_key(node, net_idx, &key))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static void setup_management_interface(struct l_dbus_interface *iface)
@@ -242,9 +380,9 @@ static void setup_management_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
 					"", "qq", "", "net_index", "app_index");
 	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
-					"", "qq", "", "net_index", "app_index");
+					"", "q", "", "app_index");
 	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
-					"", "qq", "", "net_index", "app_index");
+					"", "q", "", "app_index");
 	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
 				"", "qqay", "", "net_index", "app_index",
 								"app_key");
-- 
2.14.5

