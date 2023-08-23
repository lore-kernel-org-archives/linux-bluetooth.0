Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795EFC27C40
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 20:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjHWUuo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjHWUue (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 16:50:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFBB10D8
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 13:50:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7925f7d5142so26074039f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692823831; x=1693428631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UsPp+xbVzCYKQo0/lcOt8d2P3tVnz34/NiijQi3jd0=;
        b=gJvaK656DRFxXaMfjp5+kZeWpvjqyTXeJX0NBYXcqjn6srVLwmAxnwgwPwNwmiV95u
         z8dbLzeh+ThnvbWzzBmwJfiSgxZVOb92YYfUKfIj+QYM0aC3FPAJF3KMWZTeX1Hfvp5n
         1UgDS0BwQaU514I/bdcWPi1bMB6O2ZlQ1Lv51OW6hQiPmp8Am7NBvLdsjWSvL7BkdmzM
         S/NRSc6mIN62seXYriXFDw3QqeTPVxttzme0VZD2cgSJ1yRJPK3JL9houd9L4AjMx6c2
         CG0Kx8qmqlIYfr6a1oNSXekbiaWDOjqB33hl9iWNXJm5OCTDC//LjMFukQmzPNas5NYD
         LDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692823831; x=1693428631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UsPp+xbVzCYKQo0/lcOt8d2P3tVnz34/NiijQi3jd0=;
        b=F7DKge6/Vg3MK03HX10/vW5HJ/qXMU6HYAxr6KdzEv+gK6cSrbtC2V4WHyOipk87MN
         9OdPUIARMyTqcSqTbQRFSc4O8qNEowdFGk/rkiX4iU/hBGIEqc3vWmUG1a3h7356sdBd
         ltw6kUSRxwDiL/f1h5GfnLsolqtCMG/2nZ4e96A9Fc2ReCGB7lIJOdWYfbrTnYyIJJa9
         i5F9vwGrebuRASlyjZyCF8ccAA3IKSjwMeFnKna78fa2oLahvMYSPT6c/s0u7sAhjjP5
         tDSOTsxnpum0Ee9wfNfINj1AjdXKjM6hs/dpHny3LWeDrc4TiSMY6aO9zCckwiCfyqI6
         jh4g==
X-Gm-Message-State: AOJu0YwLSDgQPFb5+A2mOWzNVFp/I0x7CgZt23ghSg+/LMvg+1LJOfq7
        /8lM1VFvug8l88vvMruvU8rl4GBdyhM=
X-Google-Smtp-Source: AGHT+IGoXr8dI57fK4ZThNQ5fEpNTfWMgWr3eA/LrH0OjKKVcOoD36kT9o+9Z7qAQrpKCKa5bm5NYQ==
X-Received: by 2002:a6b:f00e:0:b0:792:6963:df30 with SMTP id w14-20020a6bf00e000000b007926963df30mr1353812ioc.0.1692823830950;
        Wed, 23 Aug 2023 13:50:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id gn16-20020a0566382c1000b0042b3a328ee0sm2802476jab.166.2023.08.23.13.50.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:50:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Add agent auto argument support
Date:   Wed, 23 Aug 2023 13:50:28 -0700
Message-ID: <20230823205028.3903879-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds "auto" capability which behaves like "on" but instead of
asking user to confirm/autorize it automatically accepts, which is
not secure to be used thus a warning is printed when user selects it.

Usage:

  [bluetoothctl]# agent auto
  Warning: setting auto response is not secure, it bypass user
  confirmation/authorization, it shall only be used for test automation.

  or

  client/bluetoothctl -a auto
---
 client/agent.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-
 client/main.c  |  3 +-
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index c8e1560e74a8..35b404114873 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -258,7 +258,7 @@ static DBusMessage *cancel_request(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static const GDBusMethodTable methods[] = {
+static const GDBusMethodTable agent_methods[] = {
 	{ GDBUS_METHOD("Release", NULL, NULL, release_agent) },
 	{ GDBUS_ASYNC_METHOD("RequestPinCode",
 			GDBUS_ARGS({ "device", "o" }),
@@ -286,6 +286,78 @@ static const GDBusMethodTable methods[] = {
 	{ }
 };
 
+static DBusMessage *auto_confirmation(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device;
+	dbus_uint32_t passkey;
+
+	bt_shell_printf("Request confirmation\n");
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+				DBUS_TYPE_UINT32, &passkey, DBUS_TYPE_INVALID);
+
+	bt_shell_printf("Confirm passkey %06u (auto)", passkey);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *auto_authorization(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device;
+
+	bt_shell_printf("Request authorization\n");
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+							DBUS_TYPE_INVALID);
+
+	bt_shell_printf("Accept pairing (auto)");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *auto_authorize_service(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device, *uuid;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+				DBUS_TYPE_STRING, &uuid, DBUS_TYPE_INVALID);
+
+	bt_shell_printf("Authorize service %s (auto)", uuid);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable auto_methods[] = {
+	{ GDBUS_METHOD("Release", NULL, NULL, release_agent) },
+	{ GDBUS_ASYNC_METHOD("RequestPinCode",
+			GDBUS_ARGS({ "device", "o" }),
+			GDBUS_ARGS({ "pincode", "s" }), request_pincode) },
+	{ GDBUS_METHOD("DisplayPinCode",
+			GDBUS_ARGS({ "device", "o" }, { "pincode", "s" }),
+			NULL, display_pincode) },
+	{ GDBUS_ASYNC_METHOD("RequestPasskey",
+			GDBUS_ARGS({ "device", "o" }),
+			GDBUS_ARGS({ "passkey", "u" }), request_passkey) },
+	{ GDBUS_METHOD("DisplayPasskey",
+			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" },
+							{ "entered", "q" }),
+			NULL, display_passkey) },
+	{ GDBUS_ASYNC_METHOD("RequestConfirmation",
+			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" }),
+			NULL, auto_confirmation) },
+	{ GDBUS_ASYNC_METHOD("RequestAuthorization",
+			GDBUS_ARGS({ "device", "o" }),
+			NULL, auto_authorization) },
+	{ GDBUS_ASYNC_METHOD("AuthorizeService",
+			GDBUS_ARGS({ "device", "o" }, { "uuid", "s" }),
+			NULL,  auto_authorize_service) },
+	{ GDBUS_METHOD("Cancel", NULL, NULL, cancel_request) },
+	{ }
+};
+
 static void register_agent_setup(DBusMessageIter *iter, void *user_data)
 {
 	const char *path = AGENT_PATH;
@@ -319,6 +391,8 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 						const char *capability)
 
 {
+	const GDBusMethodTable *methods = agent_methods;
+
 	if (agent_registered == TRUE) {
 		bt_shell_printf("Agent is already registered\n");
 		return;
@@ -326,6 +400,14 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 
 	agent_capability = capability;
 
+	if (!strcasecmp(agent_capability, "auto")) {
+		bt_shell_printf("Warning: setting auto response is not secure, "
+				"it bypass user confirmation/authorization, it "
+				"shall only be used for test automation.\n");
+		agent_capability = "";
+		methods = auto_methods;
+	}
+
 	if (g_dbus_register_interface(conn, AGENT_PATH,
 					AGENT_INTERFACE, methods,
 					NULL, NULL, NULL, NULL) == FALSE) {
diff --git a/client/main.c b/client/main.c
index 0eac5bdf5015..a1c536c638d9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -66,6 +66,7 @@ static GList *battery_proxies;
 static const char *agent_arguments[] = {
 	"on",
 	"off",
+	"auto",
 	"DisplayOnly",
 	"DisplayYesNo",
 	"KeyboardDisplay",
@@ -3096,7 +3097,7 @@ static const struct bt_shell_menu main_menu = {
 							NULL },
 	{ "discoverable-timeout", "[value]", cmd_discoverable_timeout,
 					"Set discoverable timeout", NULL },
-	{ "agent",        "<on/off/capability>", cmd_agent,
+	{ "agent",        "<on/off/auto/capability>", cmd_agent,
 				"Enable/disable agent with given capability",
 							capability_generator},
 	{ "default-agent",NULL,       cmd_default_agent,
-- 
2.41.0

