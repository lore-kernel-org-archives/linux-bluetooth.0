Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB992072F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgFJRL2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:11:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:8724 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbgFJRL0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:11:26 -0400
IronPort-SDR: tYzWGL7u3TsdFOPN5ONbTIvRWdPvbz8ODRNjGaU7ZdTFbTm+0U11qSbler7z4tN06+9SqreZog
 z8q2cATD1Ufw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:11:25 -0700
IronPort-SDR: jUFI16AUutUZPSfFzBKFtSVtKsMz9V9NhZ9blTmVp402au5sgmUp2xIztDJZR6qiiqtOpHHzKe
 CaBge59u2BUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="259340096"
Received: from unknown (HELO ingas-nuc1.sea.intel.com) ([10.254.72.48])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2020 10:11:25 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 4/5] mesh: Add timeout to GetManagedObjects call
Date:   Wed, 10 Jun 2020 10:11:20 -0700
Message-Id: <20200610171121.46910-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610171121.46910-1-inga.stotland@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Switch to using dbus_send_with_timeout when making a request
to get managed objects from an application.
---
 mesh/node.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index d1d4da23d..7ec06437b 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1459,7 +1459,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	struct keyring_net_key net_key;
 	uint8_t dev_key[16];
 
-	if (l_dbus_message_is_error(msg)) {
+	if (!msg || l_dbus_message_is_error(msg)) {
 		l_error("Failed to get app's dbus objects");
 		goto fail;
 	}
@@ -1616,8 +1616,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 fail:
 	/* Handle failed requests */
-	if (node)
-		node_remove(node);
+	node_remove(node);
 
 	if (req->type == REQUEST_TYPE_JOIN)
 		req->join_ready_cb(NULL, NULL);
@@ -1628,6 +1627,20 @@ fail:
 		l_free(req->import);
 }
 
+static void send_managed_objects_request(const char *destination,
+						const char *path,
+						struct managed_obj_request *req)
+{
+	struct l_dbus_message *msg;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(), destination, path,
+						L_DBUS_INTERFACE_OBJECT_MANAGER,
+						"GetManagedObjects");
+	l_dbus_message_set_arguments(msg, "");
+	dbus_send_with_timeout(dbus_get_bus(), msg, get_managed_objects_cb,
+					req, l_free, DEFAULT_DBUS_TIMEOUT);
+}
+
 /* Establish relationship between application and mesh node */
 void node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data)
@@ -1661,11 +1674,7 @@ void node_attach(const char *app_root, const char *sender, uint64_t token,
 	req->attach = node;
 	req->type = REQUEST_TYPE_ATTACH;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_root,
-					L_DBUS_INTERFACE_OBJECT_MANAGER,
-					"GetManagedObjects", NULL,
-					get_managed_objects_cb,
-					req, l_free);
+	send_managed_objects_request(sender, app_root, req);
 }
 
 /* Create a temporary pre-provisioned node */
@@ -1681,11 +1690,7 @@ void node_join(const char *app_root, const char *sender, const uint8_t *uuid,
 	req->join_ready_cb = cb;
 	req->type = REQUEST_TYPE_JOIN;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_root,
-					L_DBUS_INTERFACE_OBJECT_MANAGER,
-					"GetManagedObjects", NULL,
-					get_managed_objects_cb,
-					req, l_free);
+	send_managed_objects_request(sender, app_root, req);
 }
 
 void node_import(const char *app_root, const char *sender, const uint8_t *uuid,
@@ -1715,11 +1720,7 @@ void node_import(const char *app_root, const char *sender, const uint8_t *uuid,
 
 	req->type = REQUEST_TYPE_IMPORT;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_root,
-						L_DBUS_INTERFACE_OBJECT_MANAGER,
-						"GetManagedObjects", NULL,
-						get_managed_objects_cb,
-						req, l_free);
+	send_managed_objects_request(sender, app_root, req);
 }
 
 void node_create(const char *app_root, const char *sender, const uint8_t *uuid,
@@ -1735,11 +1736,7 @@ void node_create(const char *app_root, const char *sender, const uint8_t *uuid,
 	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_root,
-					L_DBUS_INTERFACE_OBJECT_MANAGER,
-					"GetManagedObjects", NULL,
-					get_managed_objects_cb,
-					req, l_free);
+	send_managed_objects_request(sender, app_root, req);
 }
 
 static void build_element_config(void *a, void *b)
-- 
2.26.2

