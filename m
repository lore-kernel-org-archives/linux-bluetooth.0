Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A33C0650E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 07:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325B218A4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGDHkn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:40:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:28007 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfGDHkn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 03:40:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 00:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="158217438"
Received: from ingas-nuc1.sea.intel.com ([10.254.86.21])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2019 00:40:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Use l_dbus_message...() APIs in more consistent fashion
Date:   Thu,  4 Jul 2019 00:40:40 -0700
Message-Id: <20190704074040.18260-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes checks for the return values of l_dbus_message...()
calls in the few places where we can rely on ell to handle error
cases gracefully.
---
 mesh/dbus.c  | 20 ++++++++++----------
 mesh/dbus.h  |  2 +-
 mesh/model.c | 33 +++++++++------------------------
 3 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index 2b700a1ad..6b9694ab7 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -113,29 +113,29 @@ bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
 	return false;
 }
 
-bool dbus_append_byte_array(struct l_dbus_message_builder *builder,
+void dbus_append_byte_array(struct l_dbus_message_builder *builder,
 						const uint8_t *data, int len)
 {
 	int i;
 
-	if (!l_dbus_message_builder_enter_array(builder, "y"))
-		return false;
+	if (!builder)
+		return;
 
-	for (i = 0; i < len; i++)
-		if (!l_dbus_message_builder_append_basic(builder, 'y',
-				data + i))
-			return false;
+	l_dbus_message_builder_enter_array(builder, "y");
 
-	if (!l_dbus_message_builder_leave_array(builder))
-		return false;
+	for (i = 0; i < len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y', data + i);
 
-	return true;
+	l_dbus_message_builder_leave_array(builder);
 }
 
 void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 					const char *key, const char *signature,
 					const void *data)
 {
+	if (!builder)
+		return;
+
 	l_dbus_message_builder_enter_dict(builder, "sv");
 	l_dbus_message_builder_append_basic(builder, 's', key);
 	l_dbus_message_builder_enter_variant(builder, signature);
diff --git a/mesh/dbus.h b/mesh/dbus.h
index 879649452..e7643a59d 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -22,7 +22,7 @@
 
 bool dbus_init(struct l_dbus *dbus);
 struct l_dbus *dbus_get_bus(void);
-bool dbus_append_byte_array(struct l_dbus_message_builder *builder,
+void dbus_append_byte_array(struct l_dbus_message_builder *builder,
 						const uint8_t *data, int len);
 void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 					const char *key, const char *signature,
diff --git a/mesh/model.c b/mesh/model.c
index e4a7ba94e..b605d0148 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -249,10 +249,9 @@ static void config_update_model_pub_period(struct mesh_node *node,
 								&period);
 
 	l_dbus_message_builder_leave_array(builder);
-	if (l_dbus_message_builder_finalize(builder))
-		l_dbus_send(dbus, msg);
-
+	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
+	l_dbus_send(dbus, msg);
 }
 
 static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
@@ -291,10 +290,9 @@ static void config_update_model_bindings(struct mesh_node *node,
 	append_dict_uint16_array(builder, mod->bindings, "Bindings");
 
 	l_dbus_message_builder_leave_array(builder);
-	if (l_dbus_message_builder_finalize(builder))
-		l_dbus_send(dbus, msg);
-
+	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
+	l_dbus_send(dbus, msg);
 }
 
 static void forward_model(void *a, void *b)
@@ -714,28 +712,15 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 
 	builder = l_dbus_message_builder_new(msg);
 
-	if (!l_dbus_message_builder_append_basic(builder, 'q', &src))
-		goto error;
-
-	if (!l_dbus_message_builder_append_basic(builder, 'q', &key_idx))
-		goto error;
+	l_dbus_message_builder_append_basic(builder, 'q', &src);
+	l_dbus_message_builder_append_basic(builder, 'q', &key_idx);
+	l_dbus_message_builder_append_basic(builder, 'b', &is_sub);
 
-	if (!l_dbus_message_builder_append_basic(builder, 'b', &is_sub))
-		goto error;
-
-	if (!dbus_append_byte_array(builder, data, size))
-		goto error;
-
-	if (!l_dbus_message_builder_finalize(builder))
-		goto error;
+	dbus_append_byte_array(builder, data, size);
 
+	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 	l_dbus_send(dbus, msg);
-	return;
-
-error:
-	l_dbus_message_builder_destroy(builder);
-	l_dbus_message_unref(msg);
 }
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-- 
2.21.0

