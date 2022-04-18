Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 04:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiDREaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDREaP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 00:30:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00315FD2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Apr 2022 21:27:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z5-20020a170902ccc500b0015716eaec65so6997678ple.14
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Apr 2022 21:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+/eC90OaFPtCaXAVUOvO7KkKJSMFfPnaKQl89qkOnoY=;
        b=JpgwfDr9QKb74zaKNLlZ5FX7qM9UP3OyCKpZcfjbb3VC5TbuQs20xuegayANnytjTU
         T7R2IM88bX6gF+PAcYgmhREqbNQ1DhFST2q7RsOoX0Gx2N2OHAIVcacam8rcxQUoDz3p
         D9iG+azHvB6LaRjGIBhQA6ywqqugb6RmgM/0b7Y/XUJN5cTay8uQPiQjOAKAMnVsKyGz
         9sFnvJ4FCsleZugm36HgD0NwCFfO5YNn/Yt/ES5SkC1ll0dEq+GgjWy5eSRqXiFoM3I0
         2FuVpx3Eyxsujg5E7N2Zx5yRdt5iKFZruN3r8l1RtLlgFErPdbmERR54XJfdyZZO5VaN
         G6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+/eC90OaFPtCaXAVUOvO7KkKJSMFfPnaKQl89qkOnoY=;
        b=bPCct7NVXAKoh20MGNXxZDzLaXjERupMr5RYmH888CCraOxgjuL/+gqdDr6jGY5l4R
         e9CnAT5IYv7DzPQgXbclfpXWWyG7CmLPw1OLocgy/IPiXiBAUCwn8WlS0xGI7cx2Fszt
         8ND66qfnI8JGRdhGlDdg/LJAggKBpO8gvvRDR3i2Cl1269SF0jUsel1Cu0IdirRFUoIu
         3ksiRgKqMjbj74F7CjoyW/8uUj6QwDOn+CNzd1OdP2MaOERd7pIxQQOtzMN6sJGd38AK
         mpF5ml+GGCPjcB51hSV/56VuZs7NyBKYw8fD/UTkkEu0YSl71t6Ga46av3WkdsjLnJH4
         o2kw==
X-Gm-Message-State: AOAM531AuqOMMNadye7kPgvcgHVa1zTXGHIBu4ls67M3PkrTiLo5UTne
        uME5007DzZ6oU8TqHTdnRMWPXwhbNZwUIirVNYJX5xfy2isBdHC9AiixQ55kKdJlrqFi8uPBL5A
        P+yNM/rRqhFpBhks+SwSE0cjP9Q6ZakWacQT7lsy/ivIrfYSx1m5BhS632crZfPbwXqs+muJstp
        W9
X-Google-Smtp-Source: ABdhPJyqXxjkslAkH7VvijgNdyr++bSq0nNT1V68dKbOL3CSWY9Duw2oohhd3ioEtYGM9Yz2P9msAoth5ncE
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:1e10:b0:1ce:8478:ea09 with SMTP id
 pg16-20020a17090b1e1000b001ce8478ea09mr16642389pjb.134.1650256057494; Sun, 17
 Apr 2022 21:27:37 -0700 (PDT)
Date:   Mon, 18 Apr 2022 04:26:34 +0000
In-Reply-To: <20220418042635.2567170-1-jiangzp@google.com>
Message-Id: <20220418042629.Bluez.v1.2.I29a0e38364a8d5854342019b607fa049c74248a3@changeid>
Mime-Version: 1.0
References: <20220418042635.2567170-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [Bluez PATCH v1 2/2] client: Add bonded-devices and show Bonded flag
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

