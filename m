Return-Path: <SRS0=mQGV=RE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C2C4360F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Mar 2019 23:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA86206DD
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Mar 2019 23:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCAXxS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:53:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:1900 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfCAXxS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Mar 2019 18:53:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 15:53:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,429,1544515200"; 
   d="scan'208";a="324642134"
Received: from ingas-nuc1.sea.intel.com ([10.254.60.113])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2019 15:53:16 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix array processing in Send, Publish, Join
Date:   Fri,  1 Mar 2019 15:53:15 -0800
Message-Id: <20190301235315.12770-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use correct parameters when calling l_dbus_message_iter_get_fixed_array().
Also, check the return value and the length of the processed array and
return an error if the checks fail.
---
 mesh/mesh.c | 11 ++++-------
 mesh/node.c | 26 +++++++++++++-------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 8db83b7c3..a0a9a7c8e 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -73,7 +73,7 @@ struct join_data{
 	const char *app_path;
 	struct mesh_node *node;
 	uint32_t disc_watch;
-	uint8_t uuid[16];
+	uint8_t *uuid;
 };
 
 struct attach_data {
@@ -561,7 +561,6 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 {
 	const char *app_path, *sender;
 	struct l_dbus_message_iter iter_uuid;
-	uint8_t *uuid;
 	uint32_t n;
 
 	l_debug("Join network request");
@@ -576,17 +575,15 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 
 	join_pending = l_new(struct join_data, 1);
 
-	l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n);
-
-	if (n != 16) {
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid,
+						&join_pending->uuid, &n)
+								|| n != 16) {
 		l_free(join_pending);
 		join_pending = NULL;
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device UUID");
 	}
 
-	memcpy(join_pending->uuid, uuid, 16);
-
 	sender = l_dbus_message_get_sender(msg);
 
 	join_pending->sender = l_strdup(sender);
diff --git a/mesh/node.c b/mesh/node.c
index 6a7b4a260..761a67af4 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1537,7 +1537,7 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter_data;
 	struct node_element *ele;
 	uint16_t dst, app_idx, src;
-	uint8_t data[MESH_MAX_ACCESS_PAYLOAD];
+	uint8_t *data;
 	uint32_t len;
 	struct l_dbus_message *reply;
 
@@ -1559,10 +1559,10 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 
 	src = node_get_primary(node) + ele->idx;
 
-	l_dbus_message_iter_get_fixed_array(&iter_data, data, &len);
-	if (!len)
+	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
+					!len || len > MESH_MAX_ACCESS_PAYLOAD)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
-						"Mesh message is empty");
+							"Incorrect data");
 
 	if (!mesh_model_send(node, src, dst, app_idx,
 				mesh_net_get_default_ttl(node->net), data, len))
@@ -1583,7 +1583,7 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter_data;
 	uint16_t mod_id, src;
 	struct node_element *ele;
-	uint8_t data[MESH_MAX_ACCESS_PAYLOAD];
+	uint8_t *data;
 	uint32_t len;
 	struct l_dbus_message *reply;
 	int result;
@@ -1606,10 +1606,10 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 
 	src = node_get_primary(node) + ele->idx;
 
-	l_dbus_message_iter_get_fixed_array(&iter_data, data, &len);
-	if (!len)
+	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
+					!len || len > MESH_MAX_ACCESS_PAYLOAD)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
-						"Mesh message is empty");
+							"Incorrect data");
 
 	result = mesh_model_publish(node, VENDOR_ID_MASK | mod_id, src,
 				mesh_net_get_default_ttl(node->net), data, len);
@@ -1634,7 +1634,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	uint16_t model_id, vendor;
 	uint32_t vendor_mod_id;
 	struct node_element *ele;
-	uint8_t data[MESH_MAX_ACCESS_PAYLOAD];
+	uint8_t *data = NULL;
 	uint32_t len;
 	struct l_dbus_message *reply;
 	int result;
@@ -1657,10 +1657,10 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 
 	src = node_get_primary(node) + ele->idx;
 
-	l_dbus_message_iter_get_fixed_array(&iter_data, data, &len);
-	if (!len)
+	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
+					!len || len > MESH_MAX_ACCESS_PAYLOAD)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
-						"Mesh message is empty");
+							"Incorrect data");
 
 	vendor_mod_id = (vendor << 16) | model_id;
 	result = mesh_model_publish(node, vendor_mod_id, src,
@@ -1686,7 +1686,7 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 						"", "oqqay", "element_path",
 						"vendor", "model_id", "data");
 
-	/*TODO: Properties */
+	/* TODO: Properties */
 }
 
 bool node_dbus_init(struct l_dbus *bus)
-- 
2.17.2

