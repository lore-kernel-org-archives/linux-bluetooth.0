Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD9C282E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BE021773
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfEWQOG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 12:14:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:39551 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbfEWQOG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 12:14:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 09:14:05 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.78.4])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2019 09:14:05 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 6/6] mesh: Implement remote dev key methods for keyring
Date:   Thu, 23 May 2019 09:13:29 -0700
Message-Id: <20190523161329.13017-7-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190523161329.13017-1-brian.gix@intel.com>
References: <20190523161329.13017-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Implements following org.bluez.mesh.Management1 methods:
ImportRemoteNode()
DeleteRemoteNode()

These methods are used to maintain Device Key keyring storage.
---
 mesh/manager.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 234ab5e2f..a79189934 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -54,18 +54,47 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
 }
 
+
+static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct l_dbus_message_iter iter_key;
+	uint16_t primary;
+	uint8_t num_ele;
+	uint8_t *key;
+	uint32_t n;
+
+	if (!l_dbus_message_get_arguments(msg, "qyay", &primary, &num_ele,
+								&iter_key))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_key, &key, &n)
+								|| n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad device key");
+
+	if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
 static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	struct mesh_node *node = user_data;
 	uint16_t primary;
 	uint8_t num_ele;
 
 	if (!l_dbus_message_get_arguments(msg, "qy", &primary, &num_ele))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	/* TODO */
-	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
+	keyring_del_remote_dev_key(node, primary, num_ele);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
@@ -388,7 +417,10 @@ static void setup_management_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "", "ay",
 								"", "uuid");
-	l_dbus_interface_method(iface, "DeleteRemodeNode", 0, delete_node_call,
+	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
+						"", "qyay", "", "primary",
+						"count", "dev_key");
+	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
 					"", "qy", "", "primary", "count");
 	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
 							"", "q", "", "seconds");
-- 
2.14.5

