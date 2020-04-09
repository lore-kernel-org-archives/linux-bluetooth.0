Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB32C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16D22074F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="J+BTQcLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgDITrq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:47:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46101 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDITrq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 15:47:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so943761ljg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dmoq1matlkF8+x8jlpWK2uxDi9B6sQ2NRp/AlEHi1sQ=;
        b=J+BTQcLihISDkbQJXV/aih0AEC/dMbJrjWejR5gdFSRXCZEs7WCgsuSQWth726uaF0
         KAccMC5I1pquZgXBfjcbug0pRjLOXzPuNau30VsiByw/cD02CTLd2CGoNGKBfAohh8on
         twsmbYBnajOiRdkSLTCRrzvqtOxpHeNZb3zOkdxabJkqzpaKkfo6B8YqhdCP8ucz5wdC
         /tMz+U5PB5I17/fo8+so8llhhEvD3awzFmUAEIZ8/zH3sPSBNFuv8VXKOrpU3fDN65Er
         jPMR3OS4yrFTFpFlT5OMcKeB79cdXb+00gvpzgTc+2ESavEdEXkcvINW/bFhxFJEWIhR
         fQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dmoq1matlkF8+x8jlpWK2uxDi9B6sQ2NRp/AlEHi1sQ=;
        b=dPIKbRaEjpMZ3DsegIBmZkfGUylfW60uVXDX6ku1sAzvnrAdUnMe0deNKZ0sAtccil
         O9U2JfWim0pK/7t6o5cwickeh5Z65YaHpykT0EAv7Pd15GiWIM+JRJb43aATidSvYx5D
         j4YnYHAtA3wEd7fjLDO9E5VH566p2JR3Tafpx1dwCxE2bxVEGcFhDzdYiKsVuTV+XMpr
         jZzaiKTuN7zTCJWTr4ecAeCtR5ncp2Q4lSy4vj6ksBqNax+iU3eUprMtoQc+fnUjfXhI
         Kbkkvj1xheJt71zIT2Tt2D7KcsGM/xQPQ1qtY8CHN2ZlvJzWbSfu064wYhyxWygvR3pX
         srMw==
X-Gm-Message-State: AGi0PuYIPyCon4by3ftfQzBdJk3tr05eSPlvCjYcn0S9g9t4GFpLVbQU
        nHQU07PegoR7a0kTQqUFrFEKuKUuLIg=
X-Google-Smtp-Source: APiQypK16Rdx1flkdlpYpzrKdyGBRAV2GVqlpFI/KZqP3G7O6WXHKgHHm1AmvHU0FzmrG1updFKWdw==
X-Received: by 2002:a2e:9e8f:: with SMTP id f15mr867028ljk.172.1586461664578;
        Thu, 09 Apr 2020 12:47:44 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id l13sm15915895ljc.84.2020.04.09.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:47:44 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ v2 3/4] mesh: Change API to deliver tokens via JoinComplete
Date:   Thu,  9 Apr 2020 21:47:32 +0200
Message-Id: <20200409194733.18039-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
References: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
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
index a9d5d5dea..6ffeb0c2b 100644
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
2.26.0

