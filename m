Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAFE20B1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgFPRFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:05:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:10921 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbgFPRFQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:05:16 -0400
IronPort-SDR: PrnzhPRXEvtS/HSBojBjKYHNsswmC+/X7YkQ7n9qGGrJO9dAyDE/8PpS33oDmBxHBQCENamd0p
 5hnMW29ggkow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 10:05:15 -0700
IronPort-SDR: /ebYbodjb7CIPib+KQWNj5B+1SLo58aCOkf1s6n95HW4U5FZ/Rx8Spiu7i4UgfiPgf4DTxGSlu
 Hk2101ZrCJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="351800794"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.72.197])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2020 10:05:15 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ] mesh: Add deferal of Attach() and Leave() if busy
Date:   Tue, 16 Jun 2020 10:05:10 -0700
Message-Id: <20200616170510.27378-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We require the successful return of JoinComplete() method before
handling subsequent Attach() or Leave() method calls.  To simplify the
construction of Applications, we will accept one of these calls up to 1
second prior to receiving the final return status of JoinComplete,
which tells us that the Application is ready to use the node.

If the node is still not ready after the deferal, Attach and/or Leave
will fail.
---
 mesh/mesh.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index c8767ee7a..96e7cf464 100644
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
+	struct l_dbus *dbus =  dbus_get_bus();
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
+	struct l_dbus *dbus =  dbus_get_bus();
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

