Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 17:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiDRRwY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiDRRwX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 13:52:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220734671
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 10:49:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l2-20020a17090ad10200b001ca56de815aso300020pju.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PXEk7WuZNDqx2Pd41NAZ7vijsCFkI9XuCFmrbYz1mWY=;
        b=nVb/LyIjT4faWYEJDcI6SikweMEjPCU9TKpGPA81gVvWRO1nBk8vGrL2FniLXqNy8R
         JMbTsoSRPeGXMyka6JpEykePETHitGY/Ouwhwj1gDEn9gm0LhXrA2+ANSHUjJuZdO9V2
         h9gPBzaq8s9eHEcOXrQop9hQQvW63+jlcrokTAc3oOax8MRfNe35DjfIpJGiNxBSv0Vf
         kQArc5Mu6DDw0dn5Oa3V2E9PXZvMUJwFUQHCcEvk0lSpe9JcV7hUph9fm6VJb4eIJAps
         t3ZyeUWNs7axOg0L/cJUu8A/OfYHdGljSLxhY38x2kpwEyRxgtz2lcqD81fYrnirYB+A
         LqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PXEk7WuZNDqx2Pd41NAZ7vijsCFkI9XuCFmrbYz1mWY=;
        b=W5TfHfMJUKdWs7kF3DmzOTPEC+gTgxeqM+oaenqmm8volDjYKbmM3cOoa5UgtoUuXu
         i6OP+Qb+9KXVGf1jY/6itbNJs1QFsdyMDOdttPDmtw1Hg51GDUvOSpUpoQXbIgrnJzHe
         xtbUuWNtL4YRES/Nk0QdpY7w1WEFodFr4fy6l1TY0Jnml7b63R1G8npbvDYxqH/WEAvF
         B1fDJty8BpLA6erffDvAG0Jjt+oC1y3h+xBqWk1ND78UTILFs48JBguko4HzN6u/QOeT
         D9r1nPkyAV8HizqKk2zemAudYLBxi0IheKoJim5JDtOecdYJ4pjQb7gPgsJIidPygjwo
         A74A==
X-Gm-Message-State: AOAM5328yh2NrW2Pr7FbUG36+wzG45DdLrjzg+cQ/ZBLEYc1XzgAk5r9
        Zp6TueNsTJelRwfB5E35w1/zlAAFdPwIaErGHXNNvGmO8nmhO586Xc3wGKtqxDe3sPidxSqjb1n
        +OU6F3J+J4qkTDyexL19UVXhcHRNVdvqCd8be8goasLCwCxUYI1Bkdx1Y0gykxEwi7MnbTJzYT6
        hF
X-Google-Smtp-Source: ABdhPJzJ4YS/z+QcfQ9lpIm0jvNEFZgl6iIJTNu815yZnOVz3qoI2Q/maWlYEiK1kbT0fOwaaCUS8IN4Xnlc
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:3b85:b0:1d2:8450:49ad with SMTP id
 pc5-20020a17090b3b8500b001d2845049admr8870550pjb.156.1650304183930; Mon, 18
 Apr 2022 10:49:43 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:49:29 +0000
In-Reply-To: <20220418174929.2777339-1-jiangzp@google.com>
Message-Id: <20220418174914.Bluez.v2.2.I29a0e38364a8d5854342019b607fa049c74248a3@changeid>
Mime-Version: 1.0
References: <20220418174929.2777339-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [Bluez PATCH v2 2/2] client: Add bonded-devices and show Bonded flag
 in info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add "bonded-devices" to the menu and show the "Bonded" property for
command "info".

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

(no changes since v1)

Changes in v1:
- Show the status of the "Bonded" flag in bluetoothctl
- Add option to show list of bonded devices

 client/main.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/client/main.c b/client/main.c
index 589268c3a68c..45c89a1de37b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1090,6 +1090,32 @@ static void cmd_paired_devices(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_bonded_devices(int argc, char *argv[])
+{
+	GList *ll;
+
+	if (check_default_ctrl() == FALSE)
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	for (ll = g_list_first(default_ctrl->devices);
+			ll; ll = g_list_next(ll)) {
+		GDBusProxy *proxy = ll->data;
+		DBusMessageIter iter;
+		dbus_bool_t bonded;
+
+		if (g_dbus_proxy_get_property(proxy, "Bonded", &iter) == FALSE)
+			continue;
+
+		dbus_message_iter_get_basic(&iter, &bonded);
+		if (!bonded)
+			continue;
+
+		print_device(proxy, NULL);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void generic_callback(const DBusError *error, void *user_data)
 {
 	char *str = user_data;
@@ -1781,6 +1807,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Appearance");
 	print_property(proxy, "Icon");
 	print_property(proxy, "Paired");
+	print_property(proxy, "Bonded");
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
@@ -3116,6 +3143,8 @@ static const struct bt_shell_menu main_menu = {
 	{ "devices",      NULL,       cmd_devices, "List available devices" },
 	{ "paired-devices", NULL,     cmd_paired_devices,
 					"List paired devices"},
+	{ "bonded-devices", NULL,     cmd_bonded_devices,
+					"List bonded devices"},
 	{ "system-alias", "<name>",   cmd_system_alias,
 					"Set controller alias" },
 	{ "reset-alias",  NULL,       cmd_reset_alias,
-- 
2.36.0.rc0.470.gd361397f0d-goog

