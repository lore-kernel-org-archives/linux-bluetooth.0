Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B61BC282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2776720856
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfEVTzB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 15:55:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:64438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfEVTy7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 15:54:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:54:59 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.78.4])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2019 12:54:59 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 4/5] mesh: Implement App Key keyring storage handling
Date:   Wed, 22 May 2019 12:54:27 -0700
Message-Id: <20190522195428.1901-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190522195428.1901-1-brian.gix@intel.com>
References: <20190522195428.1901-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Affected Methods:
CreateAppKey()
ImportAppKey()
UpdateAppKey()
DeleteAppKey()
---
 mesh/manager.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 92297821a..b82ad02e4 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -209,51 +209,108 @@ static struct l_dbus_message *import_subnet_call(struct l_dbus *dbus,
 	return store_new_subnet(node, msg, net_idx, key);
 }
 
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
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
+						"Bound net key not found");
+
+	if (keyring_get_app_key(node, app_idx, &app_key)) {
+		/* Allow redundant calls with identical values */
+		if (!memcmp(app_key.old_key, new_key, 16) &&
+						app_key.net_idx == net_idx)
+			return l_dbus_message_new_method_return(msg);
+
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS, NULL);
+	}
+
+	memcpy(app_key.old_key, new_key, 16);
+	memcpy(app_key.new_key, new_key, 16);
+	app_key.net_idx = net_idx;
+	app_key.app_idx = app_idx;
+
+	if (!keyring_put_app_key(node, app_idx, net_idx, &app_key))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
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
+			app_idx > MAX_KEY_IDX)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	if (!keyring_get_app_key(node, app_idx, &app_key) ||
+			!keyring_get_net_key(node, app_key.net_idx, &net_key))
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST, NULL);
+
+	if (net_key.phase != KEY_REFRESH_PHASE_ONE)
+		return dbus_error(msg, MESH_ERROR_FAILED, "Invalid Phase");
+
+	/* Generate Key if in acceptable phase */
+	l_getrandom(app_key.new_key, sizeof(app_key.new_key));
+
+	if (!keyring_put_app_key(node, app_idx, app_key.net_idx, &app_key))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	return l_dbus_message_new_method_return(msg);
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
 
@@ -266,8 +323,7 @@ static struct l_dbus_message *import_appkey_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad application key");
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	return store_new_appkey(node, msg, net_idx, app_idx, key);
 }
 
 static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
@@ -305,9 +361,9 @@ static void setup_management_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
 					"", "qq", "", "net_index", "app_index");
 	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
-					"", "qq", "", "net_index", "app_index");
+						"", "q", "", "app_index");
 	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
-					"", "qq", "", "net_index", "app_index");
+						"", "q", "", "app_index");
 	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
 				"", "qqay", "", "net_index", "app_index",
 								"app_key");
-- 
2.14.5

