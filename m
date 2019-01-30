Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E89BC282D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306F20833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2ULQV9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfA3Nyj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:39 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40903 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbfA3Nyj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:39 -0500
Received: by mail-ed1-f42.google.com with SMTP id g22so19038565edr.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=l3vi55se2iGaHn5bSyhGSaYW7EvIBcCfUOxjtKm51Os=;
        b=u2ULQV9E96vqxNBkSUYLI2bRrTqOWmZnPG7WNBxaNTyshIDOx7UMwtBPe1Wlzqk7Qr
         joDuFti+IwyNuotC3pFDM5z+mIRghAd9rZazjK7hs0GKURrpsyNPLcG3ZER3fzgbMYTM
         +QJ1/PnpxMlEIDqb0UfqbErgHGKwK2ljAZ07rayT0CLgcO97Koztk9w1kDqNmN17Z0v6
         cgkM8wsAaWREafOm46mBAGPSBZSExgYbAoOltSGoXxkxjKcs60YXiHKIOeQZctqbnZP4
         IgBj9YZzfv+0F2dy1rmUCB072qeyy2VGfAUgR779QpcWNfWHOgHo/cFbnUJV1cmDIUqn
         riWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=l3vi55se2iGaHn5bSyhGSaYW7EvIBcCfUOxjtKm51Os=;
        b=czpYdtGsSCpjxiXh9P7y9kzNVnXpkRZHQmN81+4U7Lg4YVBsC254i2q4nI5D0wx2+3
         MKUwTn9OV/sgMJaCXrAtowQRkjiTtqXw7sTUESkrvJIhBPnPwcK618jWEf4je/TUwqiU
         bv9SNvSpezdO51NqcDgU6xXSMdLZ9EXgVcHfVKDZ+6I9sh38zqp6qzbJN9KbSiQG/Mt9
         ca4/P9zXTibPBkq3949CVsuF5rFZYl/wubYeJXEdWe5oU73dSygsGUfCdxYTvrwnCH3j
         JVBgvEA2FAfdOsNlRoNtv9f2fFbKx5rYuOLG+F4Ia/5T/aeYDJcugjVk3xdZ2FFz26WN
         21sg==
X-Gm-Message-State: AJcUukeAnYXZ9hsiQK+lBq0lUS3vR7efLzbCgujM7kb0lVxcMH8odzkD
        vEAotGr1QU2U7sGGBF9l/lJpJCV3
X-Google-Smtp-Source: ALg8bN79/PwuHIorRG5xeUDzNWbqKky0J2jRzCmFqdaDCRWLSUuDOuVr8uKEiPNYyDxZJ2GecrV4QQ==
X-Received: by 2002:a50:8f44:: with SMTP id 62mr29483018edy.264.1548856477294;
        Wed, 30 Jan 2019 05:54:37 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] client: Enable list-attributes to print local attributes
Date:   Wed, 30 Jan 2019 15:54:23 +0200
Message-Id: <20190130135424.2091-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable passing "local" to list-attributes to print the attributes
registered locally:

> list-attributes local
Primary Service (Handle 0x0400)
	/org/bluez/app/service0x74ccb0
	0x1820
	Internet Protocol Support
---
 client/gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 client/main.c | 15 ++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 42fe795d7..8e06e793f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -414,8 +414,50 @@ static void list_attributes(const char *path, GList *source)
 	}
 }
 
+static void list_descs(GList *descs)
+{
+	GList *l;
+
+	for (l = descs; l; l = g_list_next(l)) {
+		struct desc *desc = l->data;
+
+		print_desc(desc, NULL);
+	}
+}
+
+static void list_chrcs(GList *chrcs)
+{
+	GList *l;
+
+	for (l = chrcs; l; l = g_list_next(l)) {
+		struct chrc *chrc = l->data;
+
+		print_chrc(chrc, NULL);
+
+		list_descs(chrc->descs);
+	}
+}
+
+static void list_services(void)
+{
+	GList *l;
+
+	for (l = local_services; l; l = g_list_next(l)) {
+		struct service *service = l->data;
+
+		print_service(service, NULL);
+
+		list_chrcs(service->chrcs);
+	}
+}
+
 void gatt_list_attributes(const char *path)
 {
+	if (path && !strcmp(path, "local")) {
+		list_services();
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
 	list_attributes(path, services);
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
diff --git a/client/main.c b/client/main.c
index 07c8ec008..16433f96d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1905,12 +1905,21 @@ static void cmd_disconn(int argc, char *argv[])
 static void cmd_list_attributes(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
+	const char *path;
+
+	if (argc > 1 && !strcmp(argv[1], "local")) {
+		path = argv[1];
+		goto done;
+	}
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	gatt_list_attributes(g_dbus_proxy_get_path(proxy));
+	path = g_dbus_proxy_get_path(proxy);
+
+done:
+	gatt_list_attributes(path);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -2596,8 +2605,8 @@ static const struct bt_shell_menu gatt_menu = {
 	.name = "gatt",
 	.desc = "Generic Attribute Submenu",
 	.entries = {
-	{ "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
-							dev_generator },
+	{ "list-attributes", "[dev/local]", cmd_list_attributes,
+				"List attributes", dev_generator },
 	{ "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
 				"Select attribute", attribute_generator },
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
-- 
2.17.2

