Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF3C2BB55
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 02:32:40 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88468206DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 02:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88468206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgDMCcj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgDMCcj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Apr 2020 22:32:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2975BC0A3BE0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2020 19:32:39 -0700 (PDT)
IronPort-SDR: CwU5K2YmdIzOHS+urLY5T8ZY+Oj+FXqXcrMpI43Frv/+AfX6PTNbWC8IlEw4XDkQcfQY5MNDoA
 rpQvWJIZ0IYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 19:32:38 -0700
IronPort-SDR: WCxU1qmPxFqNS/0LJGxeGGd8vJfyOAEq11Sumli3rqQnw71+7A5oMFMilTsbRqkgUXmRPTNf9R
 jZXaz1w0t+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="454076299"
Received: from sguggill-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.254.105.177])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2020 19:32:38 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v3 2/4] mesh: Change API to deliver tokens via JoinComplete
Date:   Sun, 12 Apr 2020 19:32:15 -0700
Message-Id: <20200413023217.20472-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413023217.20472-1-brian.gix@intel.com>
References: <20200413023217.20472-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

This patch changes Import and CreateNetwork API to deliver tokens via
the JoinComplete method call.  When application doesn't raise any error
during handling JoinComplete then it is assumed that the token has been
saved, otherwise when application replies with an error message then the
node is removed.
---
 mesh/mesh.c | 63 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 34fe6881e..8c9aa9187 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -429,6 +429,17 @@ static void send_join_failed(const char *owner, const char *path,
 	free_pending_join_call(true);
 }
 
+static void prov_join_complete_reply_cb(struct l_dbus_message *message,
+								void *user_data)
+{
+	bool failed = l_dbus_message_is_error(message);
+
+	if (!failed)
+		node_attach_io(join_pending->node, mesh.io);
+
+	free_pending_join_call(failed);
+}
+
 static bool prov_complete_cb(void *user_data, uint8_t status,
 					struct mesh_prov_node_info *info)
 {
@@ -455,7 +466,6 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 		return false;
 	}
 
-	node_attach_io(join_pending->node, mesh.io);
 	token = node_get_token(join_pending->node);
 
 	msg = l_dbus_message_new_method_call(dbus, owner, path,
@@ -463,10 +473,8 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 						"JoinComplete");
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
-
-	l_dbus_send(dbus, msg);
-
-	free_pending_join_call(false);
+	l_dbus_send_with_reply(dbus, msg,
+				prov_join_complete_reply_cb, NULL, NULL);
 
 	return true;
 }
@@ -660,11 +668,28 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
+static void create_join_complete_reply_cb(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct mesh_node *node = user_data;
+
+	if (l_dbus_message_is_error(message)) {
+		node_remove(node);
+		return;
+	}
+
+	node_attach_io(node, mesh.io);
+}
+
 static void create_node_ready_cb(void *user_data, int status,
 							struct mesh_node *node)
 {
+	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *reply;
 	struct l_dbus_message *pending_msg;
+	struct l_dbus_message *msg;
+	const char *owner;
+	const char *path;
 	const uint8_t *token;
 
 	pending_msg = l_queue_find(pending_queue, simple_match, user_data);
@@ -673,20 +698,28 @@ static void create_node_ready_cb(void *user_data, int status,
 
 	if (status != MESH_ERROR_NONE) {
 		reply = dbus_error(pending_msg, status, NULL);
-		goto done;
-	}
 
-	node_attach_io(node, mesh.io);
+		l_dbus_send(dbus_get_bus(), reply);
+		l_queue_remove(pending_queue, pending_msg);
+		return;
+	}
 
 	reply = l_dbus_message_new_method_return(pending_msg);
+
+	l_dbus_send(dbus, reply);
+	l_queue_remove(pending_queue, pending_msg);
+
+	owner = l_dbus_message_get_sender(pending_msg);
+	path = node_get_app_path(node);
 	token = node_get_token(node);
 
-	l_debug();
-	l_dbus_message_set_arguments(reply, "t", l_get_be64(token));
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+						MESH_APPLICATION_INTERFACE,
+						"JoinComplete");
 
-done:
-	l_dbus_send(dbus_get_bus(), reply);
-	l_queue_remove(pending_queue, pending_msg);
+	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
+	l_dbus_send_with_reply(dbus, msg,
+				create_join_complete_reply_cb, node, NULL);
 }
 
 static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
@@ -840,11 +873,11 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 								"token");
 
 	l_dbus_interface_method(iface, "CreateNetwork", 0, create_network_call,
-					"t", "oay", "token", "app", "uuid");
+					"", "oay", "app", "uuid");
 
 	l_dbus_interface_method(iface, "Import", 0,
 					import_call,
-					"t", "oayayayqa{sv}uq", "token",
+					"", "oayayayqa{sv}uq",
 					"app", "uuid", "dev_key", "net_key",
 					"net_index", "flags", "iv_index",
 					"unicast");
-- 
2.21.1

