Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF4BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B902076A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbgFITKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:10:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:40922 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389150AbgFITKU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 15:10:20 -0400
IronPort-SDR: BxVOGxPQTKu8XqG6jGnMre9iZxRA21tbEVM+MYPUgsDNOSH/C23PpUE5AOV+/aRJsixo8U2EPl
 XfA9yeAOkHSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 12:10:19 -0700
IronPort-SDR: 1anxwJfXYndFR3r21RIcA7FdRfsEqCoewDud6Lk10BtAyqadx+4QLN692GoLux5/c4YnZtztOR
 o0UAdF/RO8ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="259071187"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.229.21])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 12:10:19 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, przemyslaw.fierek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 2/4] mesh: Add destroy callback to dbus_send_with_timeout()
Date:   Tue,  9 Jun 2020 12:10:13 -0700
Message-Id: <20200609191015.18459-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609191015.18459-1-inga.stotland@intel.com>
References: <20200609191015.18459-1-inga.stotland@intel.com>
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
index 83ae22c9f..b72538779 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -41,6 +41,7 @@ struct send_info {
 	struct l_dbus *dbus;
 	struct l_timeout *timeout;
 	l_dbus_message_func_t cb;
+	l_dbus_destroy_func_t destroy;
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
+	if (info->destroy)
+		info->destroy(info->user_data);
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
+	info->destroy = destroy;
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

