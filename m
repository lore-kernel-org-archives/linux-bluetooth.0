Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B116C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1062075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="UeC+3E6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgDHUxM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:53:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45823 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgDHUxL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 16:53:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id f8so6202662lfe.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dmoq1matlkF8+x8jlpWK2uxDi9B6sQ2NRp/AlEHi1sQ=;
        b=UeC+3E6UBeXr3M9G+pHiYFpfGYAMkd5428xaJJHoxvwWAgMNZb2r4LHDQ+jdwve+97
         DjJvb9C0PteWUOVG15exL/j1rgtaCeCLnj6Ts0OumitHzXKy+ptfOaaWjp/+f4woi1++
         QxuwwQiXlCNKvj7BYpj+mr7SK0dljsg0U0qIkgkQkRfvJPl3oiUaAkvuifr4p/x3I6Di
         BTUyWPcQIM5xiaz6usXlUPlpyM0WL0APlaizGlk2UNSwtWNS/0yZ6PerLHg2YfSx2Igx
         KoLQtNf1B5MffwxbSfhI4YLFuAfwRxlppQo/dA/PC2eg5zkK6Vm2TjKO84tkqqFbQu4a
         vnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dmoq1matlkF8+x8jlpWK2uxDi9B6sQ2NRp/AlEHi1sQ=;
        b=DwcYe5diO870oJ8uLiUSFpkIiPo4ps1V7nmcs3Yx6Oa030Y494Vu0grYx0X9bl87hr
         D3HUQFZX5i83uhh2hlUypaLvU4G5twpxiQ8R82noEwoBj6+xhYlfnnsnTHsOywu67WsR
         9ZebqcIygZ5ypbSPG4V7muNx2VrPBuSwf4vcTcQFXJAuqbiGR1tkucPMeDIyIa7fLGCp
         2rStMUXpRfon/OnJUysPalb8R9r2H1xbWe+txGAM5nP/fsXeIBaD+XgYRpXJYfyNgarb
         YyFFYwAsvvGwhoR2SKJN4QpKmH6KLXNOIbl6y9FewJj8GA8mHjeNZGgSH7wR/1+Vf+XJ
         BrSA==
X-Gm-Message-State: AGi0PuatF6N0dJuZqbTnqt0B0Isy0yHGcDntSaWcfxudUXjZDct9jkds
        NitCmAOlwZnRS0s5TsaIJ08pJ8K/SaY=
X-Google-Smtp-Source: APiQypI48wkIMKJVoDBFfsVZtrl/EuxxSQ2NmbRdWdp+Ssqju9e0RChBBflrhFm7cShYLJO8NAPvVA==
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr5320420lfo.25.1586379186802;
        Wed, 08 Apr 2020 13:53:06 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id r24sm14168976ljn.25.2020.04.08.13.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:53:06 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ 3/4] mesh: Change API to deliver tokens via JoinComplete
Date:   Wed,  8 Apr 2020 22:52:54 +0200
Message-Id: <20200408205255.45112-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
References: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
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

