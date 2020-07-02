Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ACCC433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A6C20760
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 18:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HxuUPhip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGBSCM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgGBSCM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 14:02:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848FC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2020 11:02:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so16164320iob.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2020 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PhEY+ZLmgzCOdXaoAmlFY6h7wEgm4AErb9qvafvGMiM=;
        b=HxuUPhipxqBckpMBVK/bvcxHX7JLyRH3ekGJZnJVovoFYP4nVz734pEpCQzLS/YVCh
         soUiQTwzBIYcetILqZrKXHJqxyUots4KojV4muOslHISdEYFeqRhxFtYET3tdkDkhtvz
         ivWQkZegip1ibgkG+5FaLP9EjyDmJrCtH7vsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PhEY+ZLmgzCOdXaoAmlFY6h7wEgm4AErb9qvafvGMiM=;
        b=q/piSfzxRUCRkA7BezaqJMquoIBBHgTNNWqQ+9ETn9WosrPlB8N4mTej7wCMu26h8X
         HjvJgd/3ogP3rl8As6ax8+lmU00p/B8nJS0bc7FUdXeZRT0vSS/BmR19KIXpTN2lxnXV
         CvOuQxR4i+rL+jBwFEcDvNGZk8AzMwmm8v1JYsEVy0GRXvOjk7xiud2wWqYowf14pMcz
         z8e5tULisGNWDxZ/OtwSG8vPStIPbGBAgyBRwpGYWUythxfr0YTEfTcRteb7Hu9CKoOY
         WTv24TQwXmPyG/h2Pn/hbPz0oxGG6SqMTKxSgQGmPiZPNVPJ/HtIHFaSLGqqkEag/kNb
         XFlA==
X-Gm-Message-State: AOAM530xc+/et7hOZFibicOLSxJgoffYGHuaBHksjDbLtZJuB/q/7sC/
        TYwa3YJZi7fLHOH3MWVr5laMB8HClPn3Hg==
X-Google-Smtp-Source: ABdhPJwCzzxyJaGD/ZPW1o6GYX8vnIh/WTVLOeIJBFYfbvYx64yynbGj7r2XH2Ogq0yr47L+kBtbpA==
X-Received: by 2002:a05:6602:2d89:: with SMTP id k9mr8592389iow.41.1593712931214;
        Thu, 02 Jul 2020 11:02:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id u6sm5097647ilg.32.2020.07.02.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 11:02:10 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v3] client: Add battery percentage to info command
Date:   Thu,  2 Jul 2020 11:01:55 -0700
Message-Id: <20200702180155.24260-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABBYNZK5SyZL6mx0D2dtRqz1P7m6+JZSBXMP-xRKjNBngf-oaA@mail.gmail.com>
References: <CABBYNZK5SyZL6mx0D2dtRqz1P7m6+JZSBXMP-xRKjNBngf-oaA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the Battery Percentage to the info command based on
org.bluez.Battery1 API. Example usage:

[bluetooth]# info XX:XX:XX:XX:XX:XX
Device XX:XX:XX:XX:XX:XX (random)
        Name: ...
        Alias: ...
        ...
        Modalias: ...
        Battery Percentage: 0x64 (100)
---
 client/main.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 422da5593..c0b351aed 100644
--- a/client/main.c
+++ b/client/main.c
@@ -65,6 +65,7 @@ static struct adapter *default_ctrl;
 static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
+static GList *battery_proxies;
 
 static const char *agent_arguments[] = {
 	"on",
@@ -107,7 +108,9 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	g_list_free_full(ctrl_list, proxy_leak);
+	g_list_free_full(battery_proxies, proxy_leak);
 	ctrl_list = NULL;
+	battery_proxies = NULL;
 
 	default_ctrl = NULL;
 }
@@ -271,7 +274,7 @@ static void print_iter(const char *label, const char *name,
 		break;
 	case DBUS_TYPE_BYTE:
 		dbus_message_iter_get_basic(iter, &byte);
-		bt_shell_printf("%s%s: 0x%02x\n", label, name, byte);
+		bt_shell_printf("%s%s: 0x%02x (%d)\n", label, name, byte, byte);
 		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
@@ -309,14 +312,20 @@ static void print_iter(const char *label, const char *name,
 	}
 }
 
-static void print_property(GDBusProxy *proxy, const char *name)
+static void print_property_with_label(GDBusProxy *proxy, const char *name,
+					const char *label)
 {
 	DBusMessageIter iter;
 
 	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
 		return;
 
-	print_iter("\t", name, &iter);
+	print_iter("\t", label ? label : name, &iter);
+}
+
+static void print_property(GDBusProxy *proxy, const char *name)
+{
+	print_property_with_label(proxy, name, NULL);
 }
 
 static void print_uuid(const char *uuid)
@@ -445,6 +454,16 @@ done:
 	g_free(desc);
 }
 
+static void battery_added(GDBusProxy *proxy)
+{
+	battery_proxies = g_list_append(battery_proxies, proxy);
+}
+
+static void battery_removed(GDBusProxy *proxy)
+{
+	battery_proxies = g_list_remove(battery_proxies, proxy);
+}
+
 static void device_added(GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
@@ -539,6 +558,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		gatt_add_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
 		ad_manager_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.Battery1")) {
+		battery_added(proxy);
 	}
 }
 
@@ -630,6 +651,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		gatt_remove_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
 		ad_unregister(dbus_conn, NULL);
+	} else if (!strcmp(interface, "org.bluez.Battery1")) {
+		battery_removed(proxy);
 	}
 }
 
@@ -763,6 +786,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
+static GDBusProxy *find_battery_by_path(GList *source, const char *path)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+
+		if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
+			return proxy;
+	}
+
+	return NULL;
+}
+
 static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
 {
 	GList *list;
@@ -1606,6 +1643,7 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
+	GDBusProxy *battery_proxy;
 	DBusMessageIter iter;
 	const char *address;
 
@@ -1647,6 +1685,11 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 
+	battery_proxy = find_battery_by_path(battery_proxies,
+					g_dbus_proxy_get_path(proxy));
+	print_property_with_label(battery_proxy, "Percentage",
+					"Battery Percentage");
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-- 
2.17.1

