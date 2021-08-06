Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C55C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A634A611B0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 09:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbhHFJjL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbhHFJjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 05:39:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C5C061798
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 02:38:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o38-20020a17090a0a29b02901772cd97277so10048490pjo.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8IPkfJKLaht0GqlRiH05vPkqQ7WMlNLkm6GbILAI3no=;
        b=tWPclWRStpoyjqstcBunVYqJZYERFby6NSDSPTEh94DQYJwbENWTZTBNN9LFgnO5gB
         D2Q1pjLwQ+NPaWPeyLEHIBHkyhxDBKTXlAhcJIwHi1qTIoAIXzu/3iAHi9FALuYNaUTN
         IjUo9MKwRdihlBTdWQT92+mwRj1H+JKEHe/W3VAXLXAD5PnBeH5FVaKxiUUJ0os3UjFi
         7iJfaYnGLzFHZZUhvVa8iefkF8PI4U2eDKZZwfvCAkoJUqSEk8JLSm66oP9vQqecacJ7
         NIIPJXTioX9/1kmJihANaH6+mzSeidRnSA9pOHBa2mGSx+ZHOK3GCeErWEw3mlFjstUo
         7IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8IPkfJKLaht0GqlRiH05vPkqQ7WMlNLkm6GbILAI3no=;
        b=FH2TZEU1TfWkHUTirGN96bPB2hQAVGaoGMFlLwezwbyk/Qc5ySqHiX83Bpf0hjwbIY
         45W7uRMmT9naUv8bATMTSqJE94Ynrb5mVnnZQyJ2J91D+KbIpk9wBeplaVYYnDFKCQWl
         I++EQ8pRqkAFGPrngcit2zm4wbTBUclO0jpBqzzt80X24AgLCkAO3kzbb7cM6N3KQ8YM
         fKF7MFJgr+xAsW4141Q/dwRIscWhDKENPjn44ADXWy1s12Vrl2ytiOTEdj3twiek+nz9
         ZRpjP6eluZxZzveyNyg/Wu2tkf9/i56CKPcXPwf9sM6KKm/3KL7ulVJUwIuI9V+FCGQw
         WjJQ==
X-Gm-Message-State: AOAM530Fz15jeI7Bcj4Pxisa7/aJYW16gqC+Gs1TtBCtZ38FUisJqLLL
        2DJ1z4U0Yfi/t91dbzDvVFqdkDZZKlT2+6u+KbhA3d7d4Huf+83w0kOV+Y/UMgyJ0fphABIltR9
        BGm8VgSRwBnfvElZCSZ1CBaKlvq1KrppPQHdrr/pfq9hs/EaEOxO6vATLQhh2s61g96y4x4qt2p
        aCghAyZlTPVgg=
X-Google-Smtp-Source: ABdhPJypFCNiIAoRMgcRNhy/jR4GejvRB19fvR5MiYZOYi/plzrxuhKmrPvAvZY534B2fX43q9sMxWSRGqJt/OioJQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:85ab:3c41:db28:3381])
 (user=howardchung job=sendgmr) by 2002:a17:90a:f683:: with SMTP id
 cl3mr19828929pjb.170.1628242733826; Fri, 06 Aug 2021 02:38:53 -0700 (PDT)
Date:   Fri,  6 Aug 2021 17:38:34 +0800
In-Reply-To: <20210806173706.v1.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Message-Id: <20210806173706.v1.3.I4f0ce40e36938756509ebe62a97929957936e648@changeid>
Mime-Version: 1.0
References: <20210806173706.v1.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v1 3/3] client: add AffectedByPolicy property
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This prints property AffectedByPolicy in device info if
org.bluez.AdminPolicyStatus1 exists.

This also rename find_battery_by_path to find_proxies_by_path to reuse
the function.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. [bluetooth] menu admin
2. [bluetooth] set-service-allowlist 1124 180A 180F 1812 1801
3. Verify only HID devices are not `Affected by Policy`
4. [bluetooth] set-service-allowlist 1108 110A 110B 110C 110D 110E 110F
1112 111E 111F 1203
5. Verify only audio devices are not `Affected by Policy`
devices are expected.

 client/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 5297760c8cec..60ccee75a1e5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -56,6 +56,7 @@ static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *battery_proxies;
+static GList *admin_devices_proxies;
 
 static const char *agent_arguments[] = {
 	"on",
@@ -542,8 +543,11 @@ static void admin_policy_status_added(GDBusProxy *proxy)
 
 	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
 
-	if (!adapter)
+	if (!adapter) {
+		admin_devices_proxies = g_list_append(admin_devices_proxies,
+									proxy);
 		return;
+	}
 
 	admin_policy_set_status_proxy(proxy);
 }
@@ -654,8 +658,11 @@ static void admin_policy_status_removed(GDBusProxy *proxy)
 
 	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
 
-	if (!adapter)
+	if (!adapter) {
+		admin_devices_proxies = g_list_remove(admin_devices_proxies,
+									proxy);
 		return;
+	}
 
 	admin_policy_set_status_proxy(NULL);
 }
@@ -837,7 +844,7 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
-static GDBusProxy *find_battery_by_path(GList *source, const char *path)
+static GDBusProxy *find_proxies_by_path(GList *source, const char *path)
 {
 	GList *list;
 
@@ -1704,6 +1711,7 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
+	GDBusProxy *admin_proxy;
 	GDBusProxy *battery_proxy;
 	DBusMessageIter iter;
 	const char *address;
@@ -1747,10 +1755,14 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 
-	battery_proxy = find_battery_by_path(battery_proxies,
+	battery_proxy = find_proxies_by_path(battery_proxies,
+					g_dbus_proxy_get_path(proxy));
+	admin_proxy = find_proxies_by_path(admin_devices_proxies,
 					g_dbus_proxy_get_path(proxy));
 	print_property_with_label(battery_proxy, "Percentage",
 					"Battery Percentage");
+	print_property_with_label(admin_proxy, "AffectedByPolicy",
+					"Affected by Policy");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.32.0.605.g8dce9f2422-goog

