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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A834C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2332060EFF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbhHJM4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbhHJM4j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 08:56:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D88C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 05:56:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso20872410ybg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nbpf1YhaUP0VtoHewGY7WVFie2/jh/Ed6D+ftOWU5/E=;
        b=WravHOxbcHEZw698Y1E6f0+LuwG8GPIikhjELlDCnFnFwF0g+g0x+PmAIvQqZahWpy
         Jl3zTc9GfLcAIFnH7FKiiXKz1zaI22ZefEs3fm6Nl9gBdyL+BLqa0x2zeMovr9jCm9fP
         zvAKnUPRgJ688erv72G119w/f3fymShDvIZnE7Weud53SjqBajAVGxQcl2cHAdivOpH7
         ko7vUMLvtZi4aWLNlQA4NUsR/qTW+LBslZXjjYn7E+9CSjZMPw19uhZKSbqUZAa41bkt
         WpjK9sthBYiE7ACuRRGItc4Sav/s3m9gMe/Bl9v50zv1KJV5SrsBaNK1EG6BHlDHj4rU
         1T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbpf1YhaUP0VtoHewGY7WVFie2/jh/Ed6D+ftOWU5/E=;
        b=KSv0YKAd0ZFYdZa02cXWyQp9ZY0syyodg1mb111Txo20ncbG6v3EZAMvtW//brzTYt
         yMjKmnBu8jfWto9l7NrtfdF2Bsa/oYJetDwEym3W7yjzv6LAUYFuacHNBDgQNnVws0n6
         aPy7kPAC4dYwRmOiZGdzmlc2K8gYvHI9tFj8ydkT+OBMlIJK6JgcUcG0uRHzTnthFejM
         8C4Lewz+4lCnTP7cwiERHyXqyPI/pIzCNgn5j9XQD3ByW104U5M6ExfbFcMSlLxbbvdB
         yOKuXKDO5a+L1pmMRzNL4t0eMRokQy89I+ad3RDiMfsBD+Hrrv9iCnfvcpTnrmgMtG5r
         zOyw==
X-Gm-Message-State: AOAM532q8gR1KVn1lZp9V+2K1oeqBMwEL13NUivaWgdKQOoAwt2F6FMY
        q/ssWgX+MB/chplY5Ln+o7OkPmzOCsDSJpDXzrUlqygn0Mk3g3mPloQ5vOL2Rc4qzxJH8RkMIZy
        Yj5adDVgJrXAIoGXNnyAoXgNXJ5qKO3Fpp57YNcmjVs+pohbomcImbqOVBAEoMJzIrvShwnfrZ+
        T/joJt6aejVW0=
X-Google-Smtp-Source: ABdhPJxeBO9b7ESSeNZqeooHHlMWkD8g9XyTkrdvXiGlb7iTXqQGtWb9nldnE0UxpElmSKWQ0v2ywxt4azRnHfvFsg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:3ad5:58:f287:2aa7])
 (user=howardchung job=sendgmr) by 2002:a25:d450:: with SMTP id
 m77mr39407547ybf.412.1628600176981; Tue, 10 Aug 2021 05:56:16 -0700 (PDT)
Date:   Tue, 10 Aug 2021 20:56:03 +0800
In-Reply-To: <20210810205522.v2.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Message-Id: <20210810205522.v2.3.I4f0ce40e36938756509ebe62a97929957936e648@changeid>
Mime-Version: 1.0
References: <20210810205522.v2.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 3/3] client: add AffectedByPolicy property
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
2. [bluetooth] allow 1124 180A 180F 1812 1801
3. Verify only HID devices are not `Affected by Policy`
4. [bluetooth] allow 1108 110A 110B 110C 110D 110E 110F
1112 111E 111F 1203
5. Verify only audio devices are not `Affected by Policy`
devices are expected.

(no changes since v1)

 client/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 142a2c08a07f..eb8fa935397c 100644
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

