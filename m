Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0942C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87DA2080D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 18:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFPSOo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:14:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:49322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPSOn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 14:14:43 -0400
IronPort-SDR: moikEsVJ+Id1FeW4DCZxm0bGl9iFl/JWJKydLjbXgjdZMqHePT7CrkmjwZS6MQlWOPh+rnY5JC
 YhIhxHStYDAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 11:14:43 -0700
IronPort-SDR: 0rVb+n2yF3XT03RMVfWj+j6u5GrdWdhJcNAswv0UEYie0zNh8/hNGjNay8lTxERtil5dTRhzq/
 6ha2Jhdl5rKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="263085314"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.72.197])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2020 11:14:42 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if busy
Date:   Tue, 16 Jun 2020 11:14:36 -0700
Message-Id: <20200616181436.50319-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We require the successful return of JoinComplete() method before
handling subsequent Attach() or Leave() method calls. To simplify the
construction of Applications, we will accept one of these calls up to 1
second prior to receiving the final return status of JoinComplete,
which tells us that the Application is ready to use the node.

If the node is still not ready after the deferral, Attach and/or Leave
will fail.
---
 mesh/mesh.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index ab2393deb..bc170371d 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -104,6 +104,10 @@ static struct l_queue *pending_queue;
 
 static const char *storage_dir;
 
+/* Forward static decalrations */
+static void def_attach(struct l_timeout *timeout, void *user_data);
+static void def_leave(struct l_timeout *timeout, void *user_data);
+
 static bool simple_match(const void *a, const void *b)
 {
 	return a == b;
@@ -634,12 +638,26 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	uint64_t token;
 	const char *app_path, *sender;
 	struct l_dbus_message *pending_msg;
+	struct mesh_node *node;
 
 	l_debug("Attach");
 
 	if (!l_dbus_message_get_arguments(msg, "ot", &app_path, &token))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
+	node = node_find_by_token(token);
+	if (!node)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND, "Attach failed");
+
+	if (node_is_busy(node)) {
+		if (user_data)
+			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+		/* Try once more in 1 second */
+		l_timeout_create(1, def_attach, l_dbus_message_ref(msg), NULL);
+		return NULL;
+	}
+
 	sender = l_dbus_message_get_sender(msg);
 
 	pending_msg = l_dbus_message_ref(msg);
@@ -650,6 +668,19 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	return NULL;
 }
 
+static void def_attach(struct l_timeout *timeout, void *user_data)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg = user_data;
+	struct l_dbus_message *reply;
+
+	l_timeout_remove(timeout);
+
+	reply = attach_call(dbus, msg, (void *) true);
+	l_dbus_send(dbus, reply);
+	l_dbus_message_unref(msg);
+}
+
 static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -666,14 +697,33 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	if (!node)
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
-	if (node_is_busy(node))
-		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+	if (node_is_busy(node)) {
+		if (user_data)
+			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+		/* Try once more in 1 second */
+		l_timeout_create(1, def_leave, l_dbus_message_ref(msg), NULL);
+		return NULL;
+	}
 
 	node_remove(node);
 
 	return l_dbus_message_new_method_return(msg);
 }
 
+static void def_leave(struct l_timeout *timeout, void *user_data)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg = user_data;
+	struct l_dbus_message *reply;
+
+	l_timeout_remove(timeout);
+
+	reply = leave_call(dbus, msg, (void *) true);
+	l_dbus_send(dbus, reply);
+	l_dbus_message_unref(msg);
+}
+
 static void create_join_complete_reply_cb(struct l_dbus_message *msg,
 								void *user_data)
 {
-- 
2.25.4

