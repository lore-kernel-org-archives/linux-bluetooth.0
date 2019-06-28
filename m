Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD31CC4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 08:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B0206E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 08:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gaoDmieN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF1I1n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:27:43 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:38539 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfF1I1n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 04:27:43 -0400
Received: by mail-lj1-f180.google.com with SMTP id r9so5127203ljg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPtlqgJhhPI0Ml58nczibfwbvRYL1c9Z6Vyx1ODALro=;
        b=gaoDmieN+/UCOITOjh8Xc9efpisqJxrgS6/OozfHyV3fkHGQqP0tQYyXCnMALf1Cza
         HaTCZ2rIeq0OZy0KdSfQGrzrnbjiDfKdmqSnCSdqKTQtiBHEZ2QQWPbev7iqa1LALJxK
         T6+qhjG31hfSgVfRWG+TEJKlaF7irTAbzjC+3msIKWoCB5zkjrFwwrFpEvVI7sqhzFv3
         hkoOCH8clxeGqbX96J00yrgcbmK9Q9LKCzn9KI+A0E7OS6kQ9lq3b9gzhNki5Yqb9xxW
         5P32Yk4sJ9Mi4LKqcphEkq3jjfkOkWVtSrSVand1zFEunFD/GD/NrNi3RWK7l6l634fq
         b0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPtlqgJhhPI0Ml58nczibfwbvRYL1c9Z6Vyx1ODALro=;
        b=tmDrf+SjfsYT9RhV5l3PCDPQlTVWWdfE675CCHqK7bL4mfyGIpPQHO/KFb7kVbjXwy
         DrevllAYKZxepxFXjV3j2tE6Q47cK/k4/IZB1ppsJJuhAZLgQe3wisskC+1shxbTf1vh
         44jfsa0riXrwrk5cFVg5Ruv1WpTN39MQvZ6I5P4XQT/GsZnJa1zvZdBZD4Z2xDrGfoIg
         HpXBuX95HS9tKCDj9yRFPgI7/Wh1kdKrBc2+aEyoB/4x7qPIOOP7BtmVcV9MGOB9e/lH
         6WOvS2mW6/ozZmYk6mvd93tyWgAuPu0taJ5bJIhduvw/YJ52TU3oPcgwo021fNCQZVpo
         xJKQ==
X-Gm-Message-State: APjAAAWcXdj0C6VQB0flrOC3kkK8MPBOZNE1147rt0FmY71mNhg0ika+
        oN17s8XrP+55hHDgRQxGoM5MuZsxKko=
X-Google-Smtp-Source: APXvYqwMu0jSHs1m33vtZ1N4Tw3cK4tXpAVq0GVZHUsmfwbZ5+0KYBfmsJOl/EaOeyLzoqXAI5KVCQ==
X-Received: by 2002:a2e:9754:: with SMTP id f20mr5322194ljj.151.1561710460545;
        Fri, 28 Jun 2019 01:27:40 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g4sm408098lfb.31.2019.06.28.01.27.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 01:27:39 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Register D-Bus management interface
Date:   Fri, 28 Jun 2019 10:27:34 +0200
Message-Id: <20190628082734.18809-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190628082734.18809-1-michal.lowas-rzechonek@silvair.com>
References: <20190628082734.18809-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When application Attach()es itself, start exposing both Node1 and
Management1 D-Bus interfaces.
---
 mesh/node.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 45383b7d5..a2ac747a1 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -259,9 +259,14 @@ static void free_node_resources(void *data)
 	if (node->disc_watch)
 		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
 
-	if (node->path)
+	if (node->path) {
 		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
 							MESH_NODE_INTERFACE);
+
+		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
+					       MESH_MANAGEMENT_INTERFACE);
+	}
+
 	l_free(node->path);
 
 	l_free(node);
@@ -434,6 +439,7 @@ void node_cleanup_all(void)
 {
 	l_queue_destroy(nodes, cleanup_node);
 	l_dbus_unregister_interface(dbus_get_bus(), MESH_NODE_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), MESH_MANAGEMENT_INTERFACE);
 }
 
 bool node_is_provisioned(struct mesh_node *node)
@@ -1024,7 +1030,11 @@ static bool register_node_object(struct mesh_node *node)
 								"%s", uuid);
 
 	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
-					MESH_NODE_INTERFACE, node))
+						MESH_NODE_INTERFACE, node))
+		return false;
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
+					MESH_MANAGEMENT_INTERFACE, node))
 		return false;
 
 	return true;
@@ -1046,6 +1056,9 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	if (node->path) {
 		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
 							MESH_NODE_INTERFACE);
+
+		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
+						MESH_MANAGEMENT_INTERFACE);
 		l_free(node->app_path);
 		node->app_path = NULL;
 	}
-- 
2.19.1

