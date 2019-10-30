Return-Path: <SRS0=evc1=YX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D299ECA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 06:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF7B20874
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 06:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfJ3G1v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:27:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:56391 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3G1v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Oct 2019 02:27:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="283463591"
Received: from ingas-nuc1.sea.intel.com ([10.255.229.102])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2019 23:27:50 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add authorization checks for Manager iface methods
Date:   Tue, 29 Oct 2019 23:27:49 -0700
Message-Id: <20191030062749.14343-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a check for org.bluez.mesh.Manager1 interface calls to
validate that a message sender, i.e. thatt the sender is the original
owner of the node object generated on Attach() method call.
If the check fails, org.bluez.mesh.Error.NotAuthorized is returned.
---
 mesh/manager.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 633597659..b39ea6ed7 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -287,6 +287,10 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 	uint8_t num_ele;
 	uint8_t *key;
 	uint32_t n;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "qyay", &primary, &num_ele,
 								&iter_key))
@@ -311,6 +315,10 @@ static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
 	struct mesh_net *net = node_get_net(node);
 	uint16_t primary;
 	uint8_t num_ele;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "qy", &primary, &num_ele))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -368,6 +376,10 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 	uint16_t duration;
 	struct mesh_io *io;
 	struct mesh_net *net;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "q", &duration))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -402,11 +414,17 @@ static struct l_dbus_message *cancel_scan_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
+	const char *sender = l_dbus_message_get_sender(msg);
 
-	if (scan_node != node)
-		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+	if (strcmp(sender, node_get_owner(node)) || !node_is_provisioner(node))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	scan_cancel(NULL, node);
+	if (scan_node) {
+		if (scan_node != node)
+			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+		scan_cancel(NULL, node);
+	}
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -446,6 +464,10 @@ static struct l_dbus_message *create_subnet_call(struct l_dbus *dbus,
 	struct mesh_node *node = user_data;
 	uint8_t key[16];
 	uint16_t net_idx;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
 						net_idx == PRIMARY_NET_IDX)
@@ -464,6 +486,10 @@ static struct l_dbus_message *update_subnet_call(struct l_dbus *dbus,
 	struct mesh_node *node = user_data;
 	struct keyring_net_key key;
 	uint16_t net_idx;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
 						net_idx > MAX_KEY_IDX)
@@ -501,6 +527,10 @@ static struct l_dbus_message *delete_subnet_call(struct l_dbus *dbus,
 {
 	struct mesh_node *node = user_data;
 	uint16_t net_idx;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
 						net_idx > MAX_KEY_IDX)
@@ -520,6 +550,10 @@ static struct l_dbus_message *import_subnet_call(struct l_dbus *dbus,
 	uint16_t net_idx;
 	uint8_t *key;
 	uint32_t n;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "qay", &net_idx, &iter_key))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -574,6 +608,10 @@ static struct l_dbus_message *create_appkey_call(struct l_dbus *dbus,
 	struct mesh_node *node = user_data;
 	uint16_t net_idx, app_idx;
 	uint8_t key[16];
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx, &app_idx))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -591,6 +629,10 @@ static struct l_dbus_message *update_appkey_call(struct l_dbus *dbus,
 	struct keyring_net_key net_key;
 	struct keyring_app_key app_key;
 	uint16_t app_idx;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "q", &app_idx) ||
 							app_idx > MAX_KEY_IDX)
@@ -618,6 +660,10 @@ static struct l_dbus_message *delete_appkey_call(struct l_dbus *dbus,
 {
 	struct mesh_node *node = user_data;
 	uint16_t app_idx;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "q", &app_idx))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -636,6 +682,10 @@ static struct l_dbus_message *import_appkey_call(struct l_dbus *dbus,
 	uint16_t net_idx, app_idx;
 	uint8_t *key;
 	uint32_t n;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "qqay", &net_idx, &app_idx,
 								&iter_key))
@@ -657,6 +707,10 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 	struct keyring_net_key key;
 	uint16_t net_idx;
 	uint8_t phase;
+	const char *sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "qy", &net_idx, &phase) ||
 					phase == KEY_REFRESH_PHASE_ONE ||
-- 
2.21.0

