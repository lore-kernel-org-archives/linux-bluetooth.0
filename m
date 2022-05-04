Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E86C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378512AbiEDVNo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378505AbiEDVNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 17:13:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B29515B1
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:10:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o7-20020a17090a0a0700b001d93c491131so3457174pjo.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MWNKAKX9vwd2owSFK0FSrCSLpumWwv3K0/Q5OZyz5qk=;
        b=sGs59LiIiKOLTxv/kTkmJ3bKYKBofcYxA2I20ZtZn5abQ8flboigOUii7He9W8ck6n
         THC3oXmfTFRNcrUoH2ynXZ8KpgC8a9pr/N2ovo72B5L/Ys6ACLr4z2ORQlj4nn8SOpgv
         vHdUI2NOL4vnyLsy5qt2Ur6G2qoc2wX3vfREZGMbV9u5TUo6/hsMmngsHQtmpBeCPoXD
         wCW7RaJBu13RXoa9Hh09p9tndI/RqwU6l1sT0to5D1AGQn6iBCULM6z33lsR0U8lUeZt
         RPJzHmyLPj42flEqCcmxtp6nD9bjAw+clqtpTj/AYu5FpRWVzxnt4jXg1SgJuYEbPj9X
         DmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MWNKAKX9vwd2owSFK0FSrCSLpumWwv3K0/Q5OZyz5qk=;
        b=CqHfAt9ZoIB8cFig/tw0FgX2XFys06vDA92Oowge63yePmi404ewZeNHLQc3j5pRqP
         aKGRXiGTqqFXfrblBCDmxW0G3ixqyk2J0NKTlhzjDG26A4Q0Fkvyc5SKOcrtc/dLcWjx
         LcXaFtjp0UM6RznYjQZqGUmeyCHseEogZT4x2ZWJWvM8JaayCsbOD/8AMkZd+7/zxdnb
         NU5jUsS/xBwVAIOSSqQHaBCK6NM/cP4yTeutAcllV45fTjn9ZFRPxcEUovf3UbOXOVS+
         hH3lcImcoGIuNfNbQaSja001CTks6Ty4/1OnXLNIX+iE1eqJyiWhvH3tGY+o6L9vO+hU
         Zf7w==
X-Gm-Message-State: AOAM5306z1noIsDkn5m+f+GmhMIeU30ru5DkWXUqYfgYfcfuB5xVUtXY
        f/FixxEApKj2cBmJRa9sujHlSZXbqUpPFDTajXkpvJ0wh00I7KdR0h7CVOmwqXKprEkac3QY/sv
        jy4FbboLdSCrJUCyjwmUILhhNm+DZQkUSTSnygp38rzQfgmHzKiGi9DqD6uFUdSDlH7ihNk2PtW
        lT
X-Google-Smtp-Source: ABdhPJwNEzvFWDM4r4fpycu+8VUef2LDNxccpBTFfOuzuPF804NxInBNPYcJkNffLqd0hW9IsTVMV+NBe54E
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a62:d415:0:b0:50d:baaf:4156 with SMTP id
 a21-20020a62d415000000b0050dbaaf4156mr22663081pfh.28.1651698606298; Wed, 04
 May 2022 14:10:06 -0700 (PDT)
Date:   Wed,  4 May 2022 14:09:48 -0700
In-Reply-To: <20220504210948.2968827-1-jiangzp@google.com>
Message-Id: <20220504140941.Bluez.v3.3.I29a0e38364a8d5854342019b607fa049c74248a3@changeid>
Mime-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [Bluez PATCH v3 3/3] client: Add filter to devices and show Bonded in info
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

Use the property name as optional filters to the command "devices" and
show the "Bonded" property for the command "info".

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v3:
- Add an optional argument to the devices command to filter device list
- Remove paired-devices command

Changes in v1:
- Show the status of the "Bonded" flag in bluetoothctl
- Add option to show list of bonded devices

 client/main.c | 72 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/client/main.c b/client/main.c
index 29a2f882e5c8..58678224f93f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -95,6 +95,14 @@ static const char *ad_arguments[] = {
 	NULL
 };
 
+static const char * const device_arguments[] = {
+	"Paired",
+	"Bonded",
+	"Trusted",
+	"Connected",
+	NULL
+};
+
 static void proxy_leak(gpointer data)
 {
 	printf("Leaking proxy %p\n", data);
@@ -929,6 +937,28 @@ static gboolean check_default_ctrl(void)
 	return TRUE;
 }
 
+static gboolean parse_argument_devices(int argc, char *argv[],
+				       const char * const *arg_table,
+				       const char **option)
+{
+	const char * const *opt;
+
+	if (argc < 2) {
+		*option = NULL;
+		return TRUE;
+	}
+
+	for (opt = arg_table; opt && *opt; opt++) {
+		if (strcmp(argv[1], *opt) == 0) {
+			*option = *opt;
+			return TRUE;
+		}
+	}
+
+	bt_shell_printf("Invalid argument %s\n", argv[1]);
+	return FALSE;
+}
+
 static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
 					const char *msg, dbus_bool_t *value,
 					const char **option)
@@ -1068,22 +1098,11 @@ static void cmd_select(int argc, char *argv[])
 static void cmd_devices(int argc, char *argv[])
 {
 	GList *ll;
+	const char *property;
 
-	if (check_default_ctrl() == FALSE)
-		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-
-	for (ll = g_list_first(default_ctrl->devices);
-			ll; ll = g_list_next(ll)) {
-		GDBusProxy *proxy = ll->data;
-		print_device(proxy, NULL);
-	}
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-}
-
-static void cmd_paired_devices(int argc, char *argv[])
-{
-	GList *ll;
+	if (!parse_argument_devices(argc, argv, device_arguments,
+					&property))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (check_default_ctrl() == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -1092,15 +1111,17 @@ static void cmd_paired_devices(int argc, char *argv[])
 			ll; ll = g_list_next(ll)) {
 		GDBusProxy *proxy = ll->data;
 		DBusMessageIter iter;
-		dbus_bool_t paired;
+		dbus_bool_t status;
 
-		if (g_dbus_proxy_get_property(proxy, "Paired", &iter) == FALSE)
-			continue;
-
-		dbus_message_iter_get_basic(&iter, &paired);
-		if (!paired)
-			continue;
+		if (property) {
+			if (g_dbus_proxy_get_property(proxy,
+					property, &iter) == FALSE)
+				continue;
 
+			dbus_message_iter_get_basic(&iter, &status);
+			if (!status)
+				continue;
+		}
 		print_device(proxy, NULL);
 	}
 
@@ -1787,6 +1808,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Appearance");
 	print_property(proxy, "Icon");
 	print_property(proxy, "Paired");
+	print_property(proxy, "Bonded");
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
@@ -3170,9 +3192,9 @@ static const struct bt_shell_menu main_menu = {
 							ctrl_generator },
 	{ "select",       "<ctrl>",   cmd_select, "Select default controller",
 							ctrl_generator },
-	{ "devices",      NULL,       cmd_devices, "List available devices" },
-	{ "paired-devices", NULL,     cmd_paired_devices,
-					"List paired devices"},
+	{ "devices",      "[Paired/Bonded/Trusted/Connected]", cmd_devices,
+					"List available devices, with an "
+					"optional property as the filter" },
 	{ "system-alias", "<name>",   cmd_system_alias,
 					"Set controller alias" },
 	{ "reset-alias",  NULL,       cmd_reset_alias,
-- 
2.36.0.464.gb9c8b46e94-goog

