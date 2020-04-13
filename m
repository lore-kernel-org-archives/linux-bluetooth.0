Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132BDC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF41B2063A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgDMRqR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:46:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:34773 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgDMRqQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:46:16 -0400
IronPort-SDR: fZOBuP2yrbAqiu6Z731NImA1KOUaLiN0kM/bzhjtj1MbznU7ZrUFlJc2NAwJQKhNJCl+FD56dL
 Fwff19b0CF/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:46:15 -0700
IronPort-SDR: dYTebL6JME9Hwc6GZXzU1xK+0V28LjVjLGJT9AzxdKgAeseyGsgWwEs8FMwe+CxzOuuhhfhMMN
 YdZWuOm6KW1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399680039"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.135.23.176])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 10:46:14 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v4 4/4] mesh: Add Time-outs to critical dbus send-with-replies
Date:   Mon, 13 Apr 2020 10:45:35 -0700
Message-Id: <20200413174535.21488-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413174535.21488-1-brian.gix@intel.com>
References: <20200413174535.21488-1-brian.gix@intel.com>
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
 mesh/dbus.c | 40 ++++++++++++++++++++++++++++++++++++++++
 mesh/dbus.h |  6 ++++++
 mesh/mesh.c | 19 ++++++++++++-------
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index 6b9694ab7..bf0f73bd9 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -37,6 +37,14 @@ struct error_entry {
 	const char *default_desc;
 };
 
+struct send_info {
+	struct l_dbus *dbus;
+	struct l_timeout *timeout;
+	l_dbus_message_func_t cb;
+	void *user_data;
+	uint32_t serial;
+};
+
 /*
  * Important: The entries in this table follow the order of
  * enumerated values in mesh_error (file error.h)
@@ -143,3 +151,35 @@ void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_variant(builder);
 	l_dbus_message_builder_leave_dict(builder);
 }
+
+static void send_reply(struct l_dbus_message *message, void *user_data)
+{
+	struct send_info *info = user_data;
+
+	l_timeout_remove(info->timeout);
+	info->cb(message, info->user_data);
+	l_free(info);
+}
+
+static void send_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct send_info *info = user_data;
+
+	l_dbus_cancel(info->dbus, info->serial);
+	send_reply(NULL, info);
+}
+
+void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
+						l_dbus_message_func_t cb,
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
+	info->timeout = l_timeout_create(seconds, send_timeout, info, NULL);
+}
diff --git a/mesh/dbus.h b/mesh/dbus.h
index e7643a59d..aafb85f6b 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -20,6 +20,8 @@
 #define BLUEZ_MESH_PATH "/org/bluez/mesh"
 #define BLUEZ_MESH_SERVICE "org.bluez.mesh"
 
+#define DEFAULT_DBUS_TIMEOUT	30
+
 bool dbus_init(struct l_dbus *dbus);
 struct l_dbus *dbus_get_bus(void);
 void dbus_append_byte_array(struct l_dbus_message_builder *builder,
@@ -31,3 +33,7 @@ bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
 							const char *match);
 struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 						const char *description);
+void dbus_send_with_timeout(struct l_dbus *dbus, struct l_dbus_message *msg,
+						l_dbus_message_func_t cb,
+						void *user_data,
+						unsigned int seconds);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 8c9aa9187..58a124313 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -430,9 +430,12 @@ static void send_join_failed(const char *owner, const char *path,
 }
 
 static void prov_join_complete_reply_cb(struct l_dbus_message *message,
-								void *user_data)
+                                                               void *user_data)
 {
-	bool failed = l_dbus_message_is_error(message);
+	bool failed = false;
+
+	if (!message || l_dbus_message_is_error(message))
+		failed = true;
 
 	if (!failed)
 		node_attach_io(join_pending->node, mesh.io);
@@ -468,13 +471,14 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 
 	token = node_get_token(join_pending->node);
 
+	l_debug("Calling JoinComplete (prov)");
 	msg = l_dbus_message_new_method_call(dbus, owner, path,
 						MESH_APPLICATION_INTERFACE,
 						"JoinComplete");
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
-	l_dbus_send_with_reply(dbus, msg,
-				prov_join_complete_reply_cb, NULL, NULL);
+	dbus_send_with_timeout(dbus, msg, prov_join_complete_reply_cb,
+						NULL, DEFAULT_DBUS_TIMEOUT);
 
 	return true;
 }
@@ -673,7 +677,7 @@ static void create_join_complete_reply_cb(struct l_dbus_message *message,
 {
 	struct mesh_node *node = user_data;
 
-	if (l_dbus_message_is_error(message)) {
+	if (!message || l_dbus_message_is_error(message)) {
 		node_remove(node);
 		return;
 	}
@@ -713,13 +717,14 @@ static void create_node_ready_cb(void *user_data, int status,
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
+						node, DEFAULT_DBUS_TIMEOUT);
 }
 
 static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
-- 
2.21.1

