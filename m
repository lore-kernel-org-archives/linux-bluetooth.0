Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98B6C2BB55
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CCD206DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 02:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CCD206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDMCct (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgDMCct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Apr 2020 22:32:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2588AC0A3BE0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2020 19:32:49 -0700 (PDT)
IronPort-SDR: +pQpDa9sFK3tjGQpoAX/+EClCG5Mc0LeJ4PpFyb5MPJ22kerb5Q3W4jiTIzU6hMFPqGz9/v11A
 7eGRWKIxz9Jw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 19:32:48 -0700
IronPort-SDR: Q0V06113X/wZTdo2Tm323OaSGGRjtDG2QHgEsqeLkHCe+7j5Y9OsCf5BvePlU75joV8pXFFvy2
 VoeqWXFBr5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="454076309"
Received: from sguggill-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.254.105.177])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2020 19:32:47 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v3 4/4] mesh: Add Time-outs to critical dbus send-with-replies
Date:   Sun, 12 Apr 2020 19:32:17 -0700
Message-Id: <20200413023217.20472-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413023217.20472-1-brian.gix@intel.com>
References: <20200413023217.20472-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

JoinComplete() dbus method calls are the only time that node tokens are
delivered to client Applications, so if the call fails for any reason
(including time-outs) the daemon has a way to clean-up the stale unused
node data.
---
 mesh/dbus.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 mesh/dbus.h |  6 ++++++
 mesh/mesh.c | 22 ++++++++++++----------
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index 6b9694ab7..2c9dd3ae0 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -37,6 +37,14 @@ struct error_entry {
 	const char *default_desc;
 };
 
+struct send_info {
+	struct l_dbus *dbus;
+	struct l_timeout *timeout;
+	dbus_send_with_to_func_t cb;
+	void *user_data;
+	uint32_t serial;
+};
+
 /*
  * Important: The entries in this table follow the order of
  * enumerated values in mesh_error (file error.h)
@@ -143,3 +151,38 @@ void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_variant(builder);
 	l_dbus_message_builder_leave_dict(builder);
 }
+
+static void send_reply(struct l_dbus_message *message, void *user_data)
+{
+	struct send_info *info = user_data;
+	bool failed = l_dbus_message_is_error(message);
+
+	l_timeout_remove(info->timeout);
+	info->cb(failed, info->user_data);
+	l_free(info);
+}
+
+static void send_to(struct l_timeout *timeout, void *user_data)
+{
+	struct send_info *info = user_data;
+
+	l_dbus_cancel(info->dbus, info->serial);
+	l_timeout_remove(info->timeout);
+	info->cb(true, info->user_data);
+	l_free(info);
+}
+
+void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
+						dbus_send_with_to_func_t cb,
+						void *user_data,
+						unsigned int seconds)
+{
+	struct send_info *info = l_new(struct send_info, 1);
+
+	info->dbus = dbus;
+	info->cb = cb;
+	info->user_data = user_data;
+	info->serial = l_dbus_send_with_reply(dbus, msg, send_reply,
+								info, NULL);
+	info->timeout = l_timeout_create(seconds, send_to, info, NULL);
+}
diff --git a/mesh/dbus.h b/mesh/dbus.h
index e7643a59d..31c174367 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -20,6 +20,8 @@
 #define BLUEZ_MESH_PATH "/org/bluez/mesh"
 #define BLUEZ_MESH_SERVICE "org.bluez.mesh"
 
+typedef void (*dbus_send_with_to_func_t) (bool failed, void *user_data);
+
 bool dbus_init(struct l_dbus *dbus);
 struct l_dbus *dbus_get_bus(void);
 void dbus_append_byte_array(struct l_dbus_message_builder *builder,
@@ -31,3 +33,7 @@ bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
 							const char *match);
 struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 						const char *description);
+void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
+						dbus_send_with_to_func_t cb,
+						void *user_data,
+						unsigned int seconds);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 8c9aa9187..f46e676d9 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -429,10 +429,9 @@ static void send_join_failed(const char *owner, const char *path,
 	free_pending_join_call(true);
 }
 
-static void prov_join_complete_reply_cb(struct l_dbus_message *message,
-								void *user_data)
+static void prov_join_complete_reply_cb(bool failed, void *user_data)
 {
-	bool failed = l_dbus_message_is_error(message);
+	l_debug("prov_join_complete_reply_cb");
 
 	if (!failed)
 		node_attach_io(join_pending->node, mesh.io);
@@ -468,13 +467,14 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 
 	token = node_get_token(join_pending->node);
 
+	l_debug("Calling JoinComplete (prov)");
 	msg = l_dbus_message_new_method_call(dbus, owner, path,
 						MESH_APPLICATION_INTERFACE,
 						"JoinComplete");
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
-	l_dbus_send_with_reply(dbus, msg,
-				prov_join_complete_reply_cb, NULL, NULL);
+	dbus_send_with_timeout(dbus, msg, prov_join_complete_reply_cb,
+								NULL, 30);
 
 	return true;
 }
@@ -668,12 +668,13 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_join_complete_reply_cb(struct l_dbus_message *message,
-								void *user_data)
+static void create_join_complete_reply_cb(bool failed, void *user_data)
 {
 	struct mesh_node *node = user_data;
 
-	if (l_dbus_message_is_error(message)) {
+	l_debug("create_join_complete_reply_cb");
+
+	if (failed) {
 		node_remove(node);
 		return;
 	}
@@ -713,13 +714,14 @@ static void create_node_ready_cb(void *user_data, int status,
 	path = node_get_app_path(node);
 	token = node_get_token(node);
 
+	l_debug("Calling JoinComplete (create)");
 	msg = l_dbus_message_new_method_call(dbus, owner, path,
 						MESH_APPLICATION_INTERFACE,
 						"JoinComplete");
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
-	l_dbus_send_with_reply(dbus, msg,
-				create_join_complete_reply_cb, node, NULL);
+	dbus_send_with_timeout(dbus, msg, create_join_complete_reply_cb,
+								node, 30);
 }
 
 static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
-- 
2.21.1

