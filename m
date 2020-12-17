Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCEC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3F2396F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgLQSyl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 13:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgLQSyk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 13:54:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED92C0617A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 10:54:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id r4so15637959pls.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GPMngCbc7L/3GOBhDTFByO7qKSvuk/cQRFoAgvGeggM=;
        b=aQJitFybeJi4w6wGSRyKnT2c3H5ywEMUoHhjank2OARYimiEYr66dFoqDXS0pA1on7
         VdNTRdyhaoFZGg8r14Ak4cRGOVmSuHL1oIHo5NBM7LUtexOcOwsZUdEJp8nd6EfM5Eg1
         Ck6q0f6Z+312EN7qcqmBSoo668yqdeUOh2fjgRh3UbW6x/1EjDiUAs3f+RIlZpsv77q1
         ChLyqgOVcbYtHhLwrDJCwKfa/EYA3yQteMrlc5ILJ8irzoaNz2D6nDqTHLfoW79v3RtW
         7Rn0YwrTXCra3ImFL2S6gbGhzbEfE1cIOe/ABAGPP3IznbOEM2Pi9bHFKKrLye8Z0Snb
         2K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPMngCbc7L/3GOBhDTFByO7qKSvuk/cQRFoAgvGeggM=;
        b=bZ1wOqijNZiUrlUOtpEoh8M504Ah8n/FVp5D81/ZKnIiPS59XBouUoSiGIe9jOqMce
         UlPfmPBT6WtJDZgIdIBYJdCGwFaGc+qXM94a8kOwYxGnZodhFBaIsMI8eSm7CeIbe89j
         Fqdmsdb4xMGpspfH8ReNqy5YAclF20SyFbMkJMD9E2iFgCqvswUlLAeqycynXvdvSF7g
         0wsfVMe9zJhvMpnjM4EuVClbUQLbxVX77p8LOB6jEtLz0tAUiidnKhP/l52ATZJb3di+
         PDH95+ILsLcPSyv35dBgcBOxaRyK7RLU3uJuC+rgNb9b5PQhCKPMW76yUYRbEUwp+Qgq
         A0Fg==
X-Gm-Message-State: AOAM530y2bpOHhPFLfA/0wHxJQdZ5mHCj+JxlEcO0W8aFGC5azhVXrbI
        VyJmzXu4ifOp9aV8cH8VXCaXh8H8i7Y=
X-Google-Smtp-Source: ABdhPJymGjjC1iRlcg/D2oDNQRRJVITkumz9YrikGlOMvxApklqOdi8L+vb976FaUBPe+jKbWVTfXw==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr561095pjb.182.1608231239659;
        Thu, 17 Dec 2020 10:53:59 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p3sm5476696pjg.53.2020.12.17.10.53.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:53:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] hciemu: Add support for multiple clients
Date:   Thu, 17 Dec 2020 10:53:57 -0800
Message-Id: <20201217185357.1354172-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217185357.1354172-1-luiz.dentz@gmail.com>
References: <20201217185357.1354172-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for creating multiple clients (bthost).
---
 emulator/hciemu.c | 233 +++++++++++++++++++++++++++++++---------------
 emulator/hciemu.h |   6 ++
 2 files changed, 162 insertions(+), 77 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 961de6359..1fb0cf294 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -34,16 +34,20 @@
 #include "src/shared/queue.h"
 #include "emulator/hciemu.h"
 
+struct hciemu_client {
+	struct bthost *host;
+	struct btdev *dev;
+	guint start_source;
+	guint host_source;
+	guint source;
+};
+
 struct hciemu {
 	int ref_count;
 	enum btdev_type btdev_type;
-	struct bthost *host_stack;
-	struct btdev *master_dev;
-	struct btdev *client_dev;
-	guint host_source;
-	guint master_source;
-	guint client_source;
-	guint start_source;
+	struct btdev *dev;
+	struct queue *clients;
+	guint source;
 	struct queue *post_command_hooks;
 	char bdaddr_str[18];
 
@@ -245,70 +249,123 @@ static bool create_vhci(struct hciemu *hciemu)
 		return false;
 	}
 
-	hciemu->master_dev = btdev;
+	hciemu->dev = btdev;
 
-	hciemu->master_source = create_source_btdev(fd, btdev);
+	hciemu->source = create_source_btdev(fd, btdev);
 
 	return true;
 }
 
+struct hciemu_client *hciemu_get_client(struct hciemu *hciemu, int num)
+{
+	const struct queue_entry *entry;
+
+	if (!hciemu)
+		return NULL;
+
+	for (entry = queue_get_entries(hciemu->clients); entry;
+					entry = entry->next, num--) {
+		if (!num)
+			return entry->data;
+	}
+
+	return NULL;
+}
+
+struct bthost *hciemu_client_host(struct hciemu_client *client)
+{
+	if (!client)
+		return NULL;
+
+	return client->host;
+}
+
 struct bthost *hciemu_client_get_host(struct hciemu *hciemu)
 {
+	struct hciemu_client *client;
+
 	if (!hciemu)
 		return NULL;
 
-	return hciemu->host_stack;
+	client = hciemu_get_client(hciemu, 0);
+
+	return hciemu_client_host(client);
 }
 
-static bool create_stack(struct hciemu *hciemu)
+static gboolean start_host(gpointer user_data)
 {
-	struct btdev *btdev;
-	struct bthost *bthost;
-	int sv[2];
+	struct hciemu_client *client = user_data;
 
-	btdev = btdev_create(hciemu->btdev_type, 0x00);
-	if (!btdev)
-		return false;
+	client->start_source = 0;
 
-	bthost = bthost_create();
-	if (!bthost) {
-		btdev_destroy(btdev);
-		return false;
-	}
+	bthost_start(client->host);
+
+	return FALSE;
+}
 
-	btdev_set_command_handler(btdev, client_command_callback, hciemu);
+static void hciemu_client_destroy(void *data)
+{
+	struct hciemu_client *client = data;
 
-	if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
-								0, sv) < 0) {
-		bthost_destroy(bthost);
-		btdev_destroy(btdev);
-		return false;
-	}
+	if (client->start_source)
+		g_source_remove(client->start_source);
 
-	hciemu->client_dev = btdev;
-	hciemu->host_stack = bthost;
+	g_source_remove(client->host_source);
+	g_source_remove(client->source);
 
-	hciemu->client_source = create_source_btdev(sv[0], btdev);
-	hciemu->host_source = create_source_bthost(sv[1], bthost);
+	bthost_destroy(client->host);
+	btdev_destroy(client->dev);
 
-	return true;
+	free(client);
 }
 
-static gboolean start_stack(gpointer user_data)
+static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu)
 {
-	struct hciemu *hciemu = user_data;
+	struct hciemu_client *client;
+	int sv[2];
+	static uint8_t id;
 
-	hciemu->start_source = 0;
+	client = new0(struct hciemu_client, 1);
+	if (!client)
+		return NULL;
 
-	bthost_start(hciemu->host_stack);
+	client->dev = btdev_create(hciemu->btdev_type, id++);
+	if (!client->dev) {
+		free(client);
+		return NULL;
+	}
 
-	return FALSE;
+	client->host = bthost_create();
+	if (!client->host) {
+		btdev_destroy(client->dev);
+		free(client);
+		return NULL;
+	}
+
+	btdev_set_command_handler(client->dev, client_command_callback, client);
+
+	if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
+								0, sv) < 0) {
+		bthost_destroy(client->host);
+		btdev_destroy(client->dev);
+		return NULL;
+	}
+
+	client->source = create_source_btdev(sv[0], client->dev);
+	client->host_source = create_source_bthost(sv[1], client->host);
+	client->start_source = g_idle_add(start_host, client);
+
+	return client;
 }
 
-struct hciemu *hciemu_new(enum hciemu_type type)
+struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
 {
+
 	struct hciemu *hciemu;
 
+	if (!num)
+		return NULL;
+
 	hciemu = new0(struct hciemu, 1);
 	if (!hciemu)
 		return NULL;
@@ -348,19 +405,27 @@ struct hciemu *hciemu_new(enum hciemu_type type)
 		return NULL;
 	}
 
-	if (!create_stack(hciemu)) {
-		g_source_remove(hciemu->master_source);
-		btdev_destroy(hciemu->master_dev);
-		queue_destroy(hciemu->post_command_hooks, NULL);
-		free(hciemu);
-		return NULL;
-	}
+	hciemu->clients = queue_new();
+
+	while (num--) {
+		struct hciemu_client *client = hciemu_client_new(hciemu);
 
-	hciemu->start_source = g_idle_add(start_stack, hciemu);
+		if (!client) {
+			queue_destroy(hciemu->clients, hciemu_client_destroy);
+			break;
+		}
+
+		queue_push_tail(hciemu->clients, client);
+	}
 
 	return hciemu_ref(hciemu);
 }
 
+struct hciemu *hciemu_new(enum hciemu_type type)
+{
+	return hciemu_new_num(type, 1);
+}
+
 struct hciemu *hciemu_ref(struct hciemu *hciemu)
 {
 	if (!hciemu)
@@ -380,17 +445,10 @@ void hciemu_unref(struct hciemu *hciemu)
 		return;
 
 	queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
+	queue_destroy(hciemu->clients, hciemu_client_destroy);
 
-	if (hciemu->start_source)
-		g_source_remove(hciemu->start_source);
-
-	g_source_remove(hciemu->host_source);
-	g_source_remove(hciemu->client_source);
-	g_source_remove(hciemu->master_source);
-
-	bthost_destroy(hciemu->host_stack);
-	btdev_destroy(hciemu->client_dev);
-	btdev_destroy(hciemu->master_dev);
+	g_source_remove(hciemu->source);
+	btdev_destroy(hciemu->dev);
 
 	free(hciemu);
 }
@@ -419,6 +477,15 @@ static void btdev_client_debug(const char *str, void *user_data)
 					"btdev[bthost]: %s", str);
 }
 
+static void hciemu_client_set_debug(void *data, void *user_data)
+{
+	struct hciemu_client *client = data;
+	struct hciemu *hciemu = user_data;
+
+	btdev_set_debug(client->dev, btdev_client_debug, hciemu, NULL);
+	bthost_set_debug(client->host, bthost_debug, hciemu, NULL);
+}
+
 bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 			void *user_data, hciemu_destroy_func_t destroy)
 {
@@ -432,9 +499,9 @@ bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 	hciemu->debug_destroy = destroy;
 	hciemu->debug_data = user_data;
 
-	btdev_set_debug(hciemu->master_dev, btdev_master_debug, hciemu, NULL);
-	btdev_set_debug(hciemu->client_dev, btdev_client_debug, hciemu, NULL);
-	bthost_set_debug(hciemu->host_stack, bthost_debug, hciemu, NULL);
+	btdev_set_debug(hciemu->dev, btdev_master_debug, hciemu, NULL);
+
+	queue_foreach(hciemu->clients, hciemu_client_set_debug, hciemu);
 
 	return true;
 }
@@ -443,10 +510,10 @@ const char *hciemu_get_address(struct hciemu *hciemu)
 {
 	const uint8_t *addr;
 
-	if (!hciemu || !hciemu->master_dev)
+	if (!hciemu || !hciemu->dev)
 		return NULL;
 
-	addr = btdev_get_bdaddr(hciemu->master_dev);
+	addr = btdev_get_bdaddr(hciemu->dev);
 	sprintf(hciemu->bdaddr_str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
 			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
 	return hciemu->bdaddr_str;
@@ -454,50 +521,62 @@ const char *hciemu_get_address(struct hciemu *hciemu)
 
 uint8_t *hciemu_get_features(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->master_dev)
+	if (!hciemu || !hciemu->dev)
 		return NULL;
 
-	return btdev_get_features(hciemu->master_dev);
+	return btdev_get_features(hciemu->dev);
 }
 
 const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->master_dev)
+	if (!hciemu || !hciemu->dev)
 		return NULL;
 
-	return btdev_get_bdaddr(hciemu->master_dev);
+	return btdev_get_bdaddr(hciemu->dev);
+}
+
+const uint8_t *hciemu_client_bdaddr(struct hciemu_client *client)
+{
+	if (!client)
+		return NULL;
+
+	return btdev_get_bdaddr(client->dev);
 }
 
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->client_dev)
+	struct hciemu_client *client;
+
+	if (!hciemu)
 		return NULL;
 
-	return btdev_get_bdaddr(hciemu->client_dev);
+	client = hciemu_get_client(hciemu, 0);
+
+	return hciemu_client_bdaddr(client);
 }
 
 uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->master_dev)
+	if (!hciemu || !hciemu->dev)
 		return 0;
 
-	return btdev_get_scan_enable(hciemu->master_dev);
+	return btdev_get_scan_enable(hciemu->dev);
 }
 
 uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->master_dev)
+	if (!hciemu || !hciemu->dev)
 		return 0;
 
-	return btdev_get_le_scan_enable(hciemu->master_dev);
+	return btdev_get_le_scan_enable(hciemu->dev);
 }
 
 void hciemu_set_master_le_states(struct hciemu *hciemu, const uint8_t *le_states)
 {
-	if (!hciemu || !hciemu->master_dev)
+	if (!hciemu || !hciemu->dev)
 		return;
 
-	btdev_set_le_states(hciemu->master_dev, le_states);
+	btdev_set_le_states(hciemu->dev, le_states);
 }
 
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
@@ -559,7 +638,7 @@ int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 		return -1;
 	}
 
-	return btdev_add_hook(hciemu->master_dev, hook_type, opcode, function,
+	return btdev_add_hook(hciemu->dev, hook_type, opcode, function,
 								user_data);
 }
 
@@ -588,5 +667,5 @@ bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 		return false;
 	}
 
-	return btdev_del_hook(hciemu->master_dev, hook_type, opcode);
+	return btdev_del_hook(hciemu->dev, hook_type, opcode);
 }
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index d0708277d..8bf2d070e 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -12,6 +12,7 @@
 #include <stdint.h>
 
 struct hciemu;
+struct hciemu_client;
 
 enum hciemu_type {
 	HCIEMU_TYPE_BREDRLE,
@@ -30,10 +31,15 @@ enum hciemu_hook_type {
 };
 
 struct hciemu *hciemu_new(enum hciemu_type type);
+struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num);
 
 struct hciemu *hciemu_ref(struct hciemu *hciemu);
 void hciemu_unref(struct hciemu *hciemu);
 
+struct hciemu_client *hciemu_get_client(struct hciemu *hciemu, int num);
+struct bthost *hciemu_client_host(struct hciemu_client *client);
+const uint8_t *hciemu_client_bdaddr(struct hciemu_client *client);
+
 typedef void (*hciemu_debug_func_t)(const char *str, void *user_data);
 typedef void (*hciemu_destroy_func_t)(void *user_data);
 bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
-- 
2.26.2

