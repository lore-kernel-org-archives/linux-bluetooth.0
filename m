Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D18EC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4522B206E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Vv8//iXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437245AbgDNIzu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437240AbgDNIzq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:55:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26DC008748
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so12110029wmk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+E8MAsU/VToF7MpC+vzMgQnq8ejVDOjf7uiE778Eyo=;
        b=Vv8//iXZb1dTLP7nhR8g73eLsbEC3YSbXIO0aizialkvv+12RGJpAc8NGuI2g11C7A
         9NgWbxWh8QB45ife7hOl6PC+e10yycFMChb1Vv4gYEP7DJdnBFmteqXhc0QY6LbMnUHe
         IflJULVsuxAVeQWJUoCdzW6wU+yoDWIjOKh0e4GMnjq5ZNBlMBUXsL7bGLf7Wy1guKWk
         wJn3fvdQO8Gxx6Io2EjNLSCsLKKLZd+QNwZl6SQZ+7DmLRKCLvjUe5WCOOtlrzD9E4HS
         3zVwIAbEJiN5rcHN+ZjXimgODnJPsJL3FT/k0+wNVBB97WDm8ihzS+drMqdb9moNbpv9
         5RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+E8MAsU/VToF7MpC+vzMgQnq8ejVDOjf7uiE778Eyo=;
        b=UPhFdH9nmp3C+rBZofZJE/qE2rpks7yAX8E5tXeFFfTHKcqWL1haQtEVigcjq5Oqaq
         M8r5iDGxWpGGcIBH50psZmHz27OOUGE+Iw6HaP/gnF73mqy5jY6kbnI6Wtg/LDIO5sjM
         +tlasG2qmmz3hhrSSgiEpBXWaIzvCduFK8kdIeN/c68bEJn+X1RhwmzG1tAjPAFYxcbI
         rpWa5dS7PRLO8cSIZuZWWYC7j4FsvZeMHcDVHfIrGninYiPV2+NeVpxaFCXdrWCjeVTo
         aNzRXcTzG78/sVz/FPlPrH+bFbedRV6whsrM0/QWYcIsekgI8/VrgERHUXHCYFhqI6Z0
         gkgQ==
X-Gm-Message-State: AGi0Pubp3UhRVl1g2R+jbdDygXUpSu1pWdi6vp04djuns4xDY+1xgz6T
        a3OriRKmvFbA36GyzEJm8VMX1aRCbSk=
X-Google-Smtp-Source: APiQypKUM3hfqc+1Oh3thbNMM4ySEAQSXWXWOeji+r15Znnw0JnNcsltUfZJBRfWAIyJNNweacTJbw==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr22272032wmd.88.1586854543200;
        Tue, 14 Apr 2020 01:55:43 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w83sm18361553wmb.37.2020.04.14.01.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 01:55:42 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ v5 2/4] mesh: Change API to deliver tokens via JoinComplete
Date:   Tue, 14 Apr 2020 10:55:55 +0200
Message-Id: <20200414085557.23464-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
References: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/mesh.c | 68 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 9b3768b69..01e39e916 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -430,6 +430,20 @@ static void send_join_failed(const char *owner, const char *path,
 	free_pending_join_call(true);
 }
 
+static void prov_join_complete_reply_cb(struct l_dbus_message *message,
+								void *user_data)
+{
+	bool failed = false;
+
+	if (!message || l_dbus_message_is_error(message))
+		failed = true;
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
@@ -456,18 +470,16 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 		return false;
 	}
 
-	node_attach_io(join_pending->node, mesh.io);
 	token = node_get_token(join_pending->node);
 
+	l_debug("Calling JoinComplete (prov)");
 	msg = l_dbus_message_new_method_call(dbus, owner, path,
 						MESH_APPLICATION_INTERFACE,
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
@@ -662,11 +674,28 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
+static void create_join_complete_reply_cb(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct mesh_node *node = user_data;
+
+	if (!message || l_dbus_message_is_error(message)) {
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
@@ -675,20 +704,29 @@ static void create_node_ready_cb(void *user_data, int status,
 
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
+	l_debug("Calling JoinComplete (create)");
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
@@ -842,11 +880,11 @@ static void setup_network_interface(struct l_dbus_interface *iface)
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
2.20.1

