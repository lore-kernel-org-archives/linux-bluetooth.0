Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C55CC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572662063A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgDMRqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:46:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:34758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgDMRqA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:46:00 -0400
IronPort-SDR: x2lJfyS8nuauGG0DpsttShkRKc+mfCQ1GlvN8lq7igyq9a5lnXry1pqK5VuK6D5WA9WR3k9GjC
 UFglfpkgnPvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:46:00 -0700
IronPort-SDR: gN2XZNHyDQCEQaTnlEsIeaaJbtet2KnPGf3WuHKiPw1aDiTPc0aUK57uTtqbT1EDfHxgrrSEgg
 0L/vFe0LvqhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399679968"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.135.23.176])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 10:45:59 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v4 2/4] mesh: Change API to deliver tokens via JoinComplete
Date:   Mon, 13 Apr 2020 10:45:33 -0700
Message-Id: <20200413174535.21488-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413174535.21488-1-brian.gix@intel.com>
References: <20200413174535.21488-1-brian.gix@intel.com>
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

