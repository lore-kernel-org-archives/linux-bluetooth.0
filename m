Return-Path: <SRS0=vN2J=XU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E68C432C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Sep 2019 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FCC21D7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Sep 2019 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfIYQeA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:34:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:7878 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732918AbfIYQeA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Sep 2019 12:34:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 09:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="214100856"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.25.152])
  by fmsmga004.fm.intel.com with ESMTP; 25 Sep 2019 09:33:59 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v2 2/3] mesh: Use explicit Local vs Remote Device key usage
Date:   Wed, 25 Sep 2019 09:33:28 -0700
Message-Id: <20190925163329.23767-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925163329.23767-1-brian.gix@intel.com>
References: <20190925163329.23767-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When sending or receiving Device Key (privileged) mesh messages, the
local vs remote device key must be specified.  This allows Apps to
specify Key Ring stored device keys, and sanity checks that the correct
key exists before allowing the transmission. Loopback messages to local
servers *must* use keys from the Key Ring to indicate privilege has been
granted.
---
 mesh/model.c | 11 +++++++----
 mesh/node.c  | 25 +++++++++++++++----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index a06b684a5..c029a8365 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -735,14 +735,16 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 }
 
 static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
-					uint16_t src, uint16_t net_idx,
-					uint16_t size, const uint8_t *data)
+					uint16_t src, uint16_t app_idx,
+					uint16_t net_idx, uint16_t size,
+					const uint8_t *data)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *msg;
 	struct l_dbus_message_builder *builder;
 	const char *owner;
 	const char *path;
+	bool local = (app_idx == APP_IDX_DEV_LOCAL);
 
 	owner = node_get_owner(node);
 	path = node_get_element_path(node, ele_idx);
@@ -758,6 +760,7 @@ static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 	builder = l_dbus_message_builder_new(msg);
 
 	l_dbus_message_builder_append_basic(builder, 'q', &src);
+	l_dbus_message_builder_append_basic(builder, 'b', &local);
 	l_dbus_message_builder_append_basic(builder, 'q', &net_idx);
 	dbus_append_byte_array(builder, data, size);
 
@@ -936,8 +939,8 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
 				(decrypt_idx == APP_IDX_DEV_LOCAL &&
 				 mesh_net_is_local_address(net, src, 1)))
-				send_dev_key_msg_rcvd(node, i, src, 0,
-						forward.size, forward.data);
+				send_dev_key_msg_rcvd(node, i, src, decrypt_idx,
+						0, forward.size, forward.data);
 		}
 
 		/*
diff --git a/mesh/node.c b/mesh/node.c
index b6824f505..833377e99 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1976,7 +1976,8 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 	const char *sender, *ele_path;
 	struct l_dbus_message_iter iter_data;
 	struct node_element *ele;
-	uint16_t dst, net_idx, src;
+	uint16_t dst, app_idx, net_idx, src;
+	bool remote;
 	uint8_t *data;
 	uint32_t len;
 
@@ -1987,8 +1988,12 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &dst,
-							&net_idx, &iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqbqay", &ele_path, &dst,
+						&remote, &net_idx, &iter_data))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	/* Loopbacks to local servers must use *remote* addressing */
+	if (!remote && mesh_net_is_local_address(node->net, dst, 1))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	ele = l_queue_find(node->elements, match_element_path, ele_path);
@@ -1999,13 +2004,13 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
-					!len || len > MAX_MSG_LEN)
+						!len || len > MAX_MSG_LEN)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	/* TODO: use net_idx */
-	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
-							DEFAULT_TTL, data, len))
+	app_idx = remote ? APP_IDX_DEV_REMOTE : APP_IDX_DEV_LOCAL;
+	if (!mesh_model_send(node, src, dst, app_idx, net_idx, DEFAULT_TTL,
+								data, len))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -2226,9 +2231,9 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 						"element_path", "destination",
 						"key_index", "data");
 	l_dbus_interface_method(iface, "DevKeySend", 0, dev_key_send_call,
-						"", "oqqay", "element_path",
-						"destination", "net_index",
-						"data");
+						"", "oqbqay", "element_path",
+						"destination", "remote",
+						"net_index", "data");
 	l_dbus_interface_method(iface, "Publish", 0, publish_call, "", "oqay",
 					"element_path", "model_id", "data");
 	l_dbus_interface_method(iface, "VendorPublish", 0, vendor_publish_call,
-- 
2.21.0

