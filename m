Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642BDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 03:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4768E2078C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 03:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFID7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:59:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:17236 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFID7N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 23:59:13 -0400
IronPort-SDR: obwE9KCuyTUQ1nxsEaweWcjz2EBbnJDd2opYdAolPe4vY3s+RIfmTzG7n4BR8W44dLZ0zaxcUR
 95F4HxpCqyfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 20:59:12 -0700
IronPort-SDR: zKH39IKqhmcIEqI+bXNouWkLTKYBTrLsuD8YyUQnAI8rbG0HgqDCORenu82JWY3oW057xscCsA
 Vf2cKRi0JV1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="274461148"
Received: from vrsuryad-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.38])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 20:59:12 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, przemyslaw.fierek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] mesh: Add destroy callback to dbus_send_with_timeout()
Date:   Mon,  8 Jun 2020 20:59:07 -0700
Message-Id: <20200609035909.51061-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609035909.51061-1-inga.stotland@intel.com>
References: <20200609035909.51061-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a destroy callback as a function parameter to
dbus_send_with_timeout() to allow automatic release of user data
on either reply or timeout.
---
 mesh/dbus.c | 11 ++++++++---
 mesh/dbus.h |  1 +
 mesh/mesh.c | 12 ++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index 83ae22c9f..ba2a28de5 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -41,6 +41,7 @@ struct send_info {
 	struct l_dbus *dbus;
 	struct l_timeout *timeout;
 	l_dbus_message_func_t cb;
+	l_dbus_destroy_func_t destroy_cb;
 	void *user_data;
 	uint32_t serial;
 };
@@ -153,12 +154,14 @@ void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_dict(builder);
 }
 
-static void send_reply(struct l_dbus_message *message, void *user_data)
+static void send_reply_cb(struct l_dbus_message *message, void *user_data)
 {
 	struct send_info *info = user_data;
 
 	l_timeout_remove(info->timeout);
 	info->cb(message, info->user_data);
+	if (info->destroy_cb)
+		info->destroy_cb(info->user_data);
 	l_free(info);
 }
 
@@ -167,12 +170,13 @@ static void send_timeout(struct l_timeout *timeout, void *user_data)
 	struct send_info *info = user_data;
 
 	l_dbus_cancel(info->dbus, info->serial);
-	send_reply(NULL, info);
+	send_reply_cb(NULL, info);
 }
 
 void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
 						l_dbus_message_func_t cb,
 						void *user_data,
+						l_dbus_destroy_func_t destroy,
 						unsigned int seconds)
 {
 	struct send_info *info = l_new(struct send_info, 1);
@@ -180,7 +184,8 @@ void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
 	info->dbus = dbus;
 	info->cb = cb;
 	info->user_data = user_data;
-	info->serial = l_dbus_send_with_reply(dbus, msg, send_reply,
+	info->destroy_cb = destroy;
+	info->serial = l_dbus_send_with_reply(dbus, msg, send_reply_cb,
 								info, NULL);
 	info->timeout = l_timeout_create(seconds, send_timeout, info, NULL);
 }
diff --git a/mesh/dbus.h b/mesh/dbus.h
index aafb85f6b..89d6b1d31 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -36,4 +36,5 @@ struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
 						l_dbus_message_func_t cb,
 						void *user_data,
+						l_dbus_destroy_func_t destroy,
 						unsigned int seconds);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 24ea3afd6..a5935c216 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -439,12 +439,12 @@ static void send_join_failed(const char *owner, const char *path,
 	free_pending_join_call(true);
 }
 
-static void prov_join_complete_reply_cb(struct l_dbus_message *message,
+static void prov_join_complete_reply_cb(struct l_dbus_message *msg,
 								void *user_data)
 {
 	bool failed = false;
 
-	if (!message || l_dbus_message_is_error(message))
+	if (!msg || l_dbus_message_is_error(msg))
 		failed = true;
 
 	if (!failed)
@@ -488,7 +488,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
 	dbus_send_with_timeout(dbus, msg, prov_join_complete_reply_cb,
-						NULL, DEFAULT_DBUS_TIMEOUT);
+					NULL, NULL, DEFAULT_DBUS_TIMEOUT);
 
 	return true;
 }
@@ -666,12 +666,12 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_join_complete_reply_cb(struct l_dbus_message *message,
+static void create_join_complete_reply_cb(struct l_dbus_message *msg,
 								void *user_data)
 {
 	struct mesh_node *node = user_data;
 
-	if (!message || l_dbus_message_is_error(message)) {
+	if (!msg || l_dbus_message_is_error(msg)) {
 		node_remove(node);
 		return;
 	}
@@ -716,7 +716,7 @@ static void create_node_ready_cb(void *user_data, int status,
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
 	dbus_send_with_timeout(dbus, msg, create_join_complete_reply_cb,
-						node, DEFAULT_DBUS_TIMEOUT);
+					node, NULL, DEFAULT_DBUS_TIMEOUT);
 	l_dbus_message_unref(pending_msg);
 }
 
-- 
2.26.2

