Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE542ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13E121A4C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 21:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503183AbfJQVHH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:07:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:39407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394814AbfJQVHH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Oct 2019 17:07:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 14:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="200509257"
Received: from ingas-nuc1.sea.intel.com ([10.251.143.15])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2019 14:07:06 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Implement AddAppKey and AddNetKey methods
Date:   Thu, 17 Oct 2019 14:07:05 -0700
Message-Id: <20191017210705.8829-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation for the following methods on
org.bluez.mesh.Node1 interface:
void AddNetKey(object element_path, uint16 destination,
		uint16 subnet_index, uint16 net_index, boolean update)
void AddAppKey(object element_path, uint16 destination,
		uint16 app_index, uint16 net_index, boolean update)
---
 mesh/node.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 74694d520..c47e1961d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -443,7 +443,7 @@ static void set_net_key(void *a, void *b)
 								netkey->phase);
 }
 
-static void set_app_key(void *a, void *b)
+static void set_appkey(void *a, void *b)
 {
 	struct mesh_config_appkey *appkey = a;
 	struct mesh_node *node = b;
@@ -512,7 +512,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	l_queue_foreach(db_node->netkeys, set_net_key, node);
 
 	if (db_node->appkeys)
-		l_queue_foreach(db_node->appkeys, set_app_key, node);
+		l_queue_foreach(db_node->appkeys, set_appkey, node);
 
 	mesh_net_set_seq_num(node->net, node->seq_number);
 	mesh_net_set_default_ttl(node->net, node->ttl);
@@ -2001,6 +2001,123 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
+static struct l_dbus_message *add_netkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct mesh_node *node = user_data;
+	const char *sender, *ele_path;
+	struct node_element *ele;
+	uint16_t dst, sub_idx, net_idx, src;
+	bool update;
+	struct keyring_net_key key;
+	uint8_t data[20];
+
+	l_debug("AddNetKey");
+
+	sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node->owner))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	if (!l_dbus_message_get_arguments(msg, "oqqqb", &ele_path, &dst,
+						&sub_idx, &net_idx, &update))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	ele = l_queue_find(node->elements, match_element_path, ele_path);
+	if (!ele)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+							"Element not found");
+
+	src = node_get_primary(node) + ele->idx;
+
+	if (!keyring_get_net_key(node, net_idx, &key))
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+							"NetKey not found");
+
+	if (!update) {
+		l_put_be16(OP_NETKEY_ADD, data);
+		memcpy(data + 4, key.old_key, 16);
+	} else {
+		if (key.phase != KEY_REFRESH_PHASE_ONE)
+			return dbus_error(msg, MESH_ERROR_FAILED,
+							"Cannot update");
+		l_put_be16(OP_NETKEY_UPDATE, data);
+		memcpy(data + 4, key.new_key, 16);
+	}
+
+	l_put_le16(sub_idx, &data[2]);
+
+	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
+							DEFAULT_TTL, data, 20))
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static struct l_dbus_message *add_appkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct mesh_node *node = user_data;
+	const char *sender, *ele_path;
+	struct node_element *ele;
+	uint16_t dst, app_idx, net_idx, src;
+	bool update;
+	struct keyring_net_key net_key;
+	struct keyring_app_key app_key;
+	uint8_t data[20];
+
+	l_debug("AddNetKey");
+
+	sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node->owner))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	if (!l_dbus_message_get_arguments(msg, "oqqqb", &ele_path, &dst,
+						&app_idx, &net_idx, &update))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	ele = l_queue_find(node->elements, match_element_path, ele_path);
+	if (!ele)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+							"Element not found");
+
+	src = node_get_primary(node) + ele->idx;
+
+	if (!keyring_get_app_key(node, app_idx, &app_key))
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+							"AppKey not found");
+
+	if (!keyring_get_net_key(node, app_key.net_idx, &net_key)) {
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+						"Bound NetKey not found");
+	}
+
+	if (!update) {
+		data[0] = OP_APPKEY_ADD;
+		memcpy(data + 4, app_key.old_key, 16);
+	} else {
+		if (net_key.phase != KEY_REFRESH_PHASE_ONE)
+			return dbus_error(msg, MESH_ERROR_FAILED,
+							"Cannot update");
+		data[0] = OP_APPKEY_UPDATE;
+		memcpy(data + 4, app_key.new_key, 16);
+	}
+
+	/* Pack bound NetKey and AppKey into 3 octets */
+	data[1] = app_key.net_idx;
+	data[2] = ((app_key.net_idx >> 8) & 0xf) | ((app_idx << 4) & 0xf0);
+	data[3] = app_idx >> 4;
+
+	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
+							DEFAULT_TTL, data, 20))
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
 static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -2219,6 +2336,12 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 						"", "oqbqay", "element_path",
 						"destination", "remote",
 						"net_index", "data");
+	l_dbus_interface_method(iface, "AddNetKey", 0, add_netkey_call, "",
+					"oqqqb", "element_path", "destination",
+					"subnet_index", "net_index", "update");
+	l_dbus_interface_method(iface, "AddAppKey", 0, add_appkey_call, "",
+					"oqqqb", "element_path", "destination",
+					"app_index", "net_index", "update");
 	l_dbus_interface_method(iface, "Publish", 0, publish_call, "", "oqay",
 					"element_path", "model_id", "data");
 	l_dbus_interface_method(iface, "VendorPublish", 0, vendor_publish_call,
-- 
2.21.0

