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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF0C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F87860E78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhHKHJd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhHKHJd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 03:09:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B66C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:09:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c196-20020ae9edcd0000b02903c9e325c3b2so815707qkg.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3Zxj33TTjkKhOKutgoM7B02duZHtVt6F+j0ORgUTiLQ=;
        b=HmkirzI418P3VU5vFedRa4npsvpcxumSuDAX5Sr3B24qfp0hp9Ujfc8zaED3uNy5Pv
         bNkAag411bSQ7K9M0NKjBzH52MvYsThdVu4WistHD3uvcUsRlsA/fTMjD50AAls9gwuC
         7Tqnx+xQ8k2Vey3vJq6NOyw71+H/PEpk8PI0FXAoWXksS54Zh2iXi7o4U3E6Fu2G0vyU
         bkl7w/fxHKOon8FBxRrv/jv4Ko4VwUpAZDhJQ6lrj6/Y8fVa3Ptz2TxKZ6oITnu9/Pt3
         qHlSdwszpXsjWEyVmXakJNjq84Hui4E+dIrBOlMXYNawkZ/azqfuh7bAs/3fOFWoU3xn
         SjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3Zxj33TTjkKhOKutgoM7B02duZHtVt6F+j0ORgUTiLQ=;
        b=aYdfgCagsxZf9Vwrw05Rn87+hmeAsIFtbQyST/HQClGUPpgqBtdHnRsAsELxVRWlp5
         oLUfA6TxBP3Wy5LZxHYAnWEtG+KFazLiOnTovghDyQVR4TF/umDLPTvHtw4U1ddwdGL6
         am2XlgvOB7qg6AePa7UnX2oj53hcnMajtOxJafVN9X32XejrwjyWMHJTklgljFzqIzw4
         s9emcx1l0fhlEZ9LMp1szAaOfFFcXroUdsE417kUB9679Eprtz1pe011elo+8PzHEVSo
         d9qCy4beEIjCcyU/ydu2WoY0qryUPGtWJTfm5SGn4nhtVvRulccSCxfEtXtExHL5G1Dt
         uR7g==
X-Gm-Message-State: AOAM532Twqn0dkpgZaGbtNzjrX740A9szhzJ+Yn7XSmy2/w+k0RY5Ocp
        MJ1sr1Oia3DstsMEZrMSbYgep+Ct6QRxRWxMX8PEpcaihmOlvkd72na+7TZX9o+Tf8eSIEiXxFR
        0so2UNRvK9sLz42yotOFt+u+yJreH7QnSLXyFGYCj3lVfZjIrm1K9aD9TybgNQIwSOQmhrIFzMm
        nVqGhV5wIdhlU=
X-Google-Smtp-Source: ABdhPJxA3rr5mxO5fHnJApypJpyG/hcTKpnOpdkVP3RxqDtwIo7dB4fbMLZ+rzZ6fzJ2UsT2ubeKzA22vrSx4kEMsg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:42fe:de1a:97f8:9006])
 (user=howardchung job=sendgmr) by 2002:a05:6214:240a:: with SMTP id
 fv10mr21897457qvb.11.1628665749451; Wed, 11 Aug 2021 00:09:09 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:08:57 +0800
In-Reply-To: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Message-Id: <20210811150752.v3.3.I4f0ce40e36938756509ebe62a97929957936e648@changeid>
Mime-Version: 1.0
References: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v3 3/3] client: add AffectedByPolicy property
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
index a983066eda34..506602bbdb6d 100644
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

