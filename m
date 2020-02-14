Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97AC35242
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 03:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC9D2073C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 03:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcXdtEjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBNDp2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:45:28 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34616 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgBNDp2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 22:45:28 -0500
Received: by mail-qk1-f201.google.com with SMTP id w29so5258532qkw.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 19:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6qbpgdTzDrZBcCeIVAk76xd4HcBGyIruze/p5knIPA8=;
        b=kcXdtEjXlLMdu1LxA7oON38zI5qJ4kmmR5b6CidRjsas1DslE8/OT9YkyzV0qArC/A
         7ZgtcyKqeirKWtKQq4JD2nktFkoraCD+L6FP1cGXrEYBbD3InodPbOeciqfjVzqXWTxr
         py3xD7XLil5bRwg3Og0Fn2Q7ywkvDONBWCrq/U8qHWtZtbXQ6Uy+c/sgJqFQvSa4T15X
         0AaK4dKjT5C+PJ8VGUXRSl6w+KiMJ0eidKggTgMh7DRk7iyNSrzFIYeow8vO1/1fWCU8
         CfCJ9mBtg2MlP4EAxJN5cSPUzo3LSAlayXSIkzwIPvKSCaQpNBYERMq5Ow2+U8h5tjA0
         ih7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6qbpgdTzDrZBcCeIVAk76xd4HcBGyIruze/p5knIPA8=;
        b=hpPBgmoQclsHpXoY0qaPGDxDnjOSYh6Byj9b0O5O/sdd3xSsWH+xEuMhvr7/1Corli
         vENUyBI8ZTvjj0ZWEZeoBAAsyC9Txcj4dZ6yEBhWGncZ8YAu48zU2MbroPSX3JvSvLI7
         ZJ8TOxKTA/AlpICiraklgCqo/aLxIQ5/OwM4Y4f37L4zzcxvvUxGFMGts1NNucmFNlAL
         vBfCIo6wNBo/AHreIrN+AqgdmgdtDb4zmZLwdmNBVBpuuSfD54+fD6OdXV3Xw0RxH2h6
         tEzr6tn5VnUomqpGB668sOMmXZOjLuBOOyjhAHAb1fOKrhx2qOQEeTaepXUAPBmMhwOy
         6CLA==
X-Gm-Message-State: APjAAAUpXYVaaPB5USAPDb8iCNcgDj6v3Ew7ZQYFc3GYw5PnjX7M3KX6
        gJQLW/bHXZcAvwI85Pd2ZzYpeiYPw+XY5pb47D4GrSQZQJ4s1frhdorxTZv7VzrVwuI2RqFHaNo
        d8WUEBSCuFJMWGC2z1LYtfR0Zgr9Qhqiiw0om5+a1/1mcIOwIueiVkV+2LsUXnPNwJG6QeUnl6U
        W5KHO0JUqmg34=
X-Google-Smtp-Source: APXvYqz/aLCwhDfK9+jLau3JtGnjL2XGxeB3baxbH8wzGbio4YyGBP/lz6tBqs8N6u7RNQ/OEEeYsJ57QRovSlbkow==
X-Received: by 2002:a37:a717:: with SMTP id q23mr713489qke.169.1581651926203;
 Thu, 13 Feb 2020 19:45:26 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:45:20 +0800
Message-Id: <20200214114350.Bluez.v3.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v3] core: Add new policy for Just-Works repairing
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        "howardchung@google.com" <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "howardchung@google.com" <howardchung@google.com>

When kernel find out that the incoming Just-Works pairing is
initiated by a paired device, it is user space's responsibility to
decide the next action.

This patch includes the following:
- add JustWorksRepairing policy as an option in main.conf
- handle the confirmation request from kernel
---
The Just-Works repairing policy could be one of the following:
- never: default; reject the repairing immediately.
- confirm: prompt a confirmation dialog to user.
- always: always accept the repairing.

Changes in v3:
- move the check from src/agent.c to src/device.c
- fix the enum declaration in src/hcid.h

Changes in v2:
- let RequestAuthorization handle the situation
- remove the changes in client/

 src/device.c  | 16 ++++++++++++++++
 src/hcid.h    |  8 ++++++++
 src/main.c    | 27 +++++++++++++++++++++++++++
 src/main.conf |  5 +++++
 4 files changed, 56 insertions(+)

diff --git a/src/device.c b/src/device.c
index a4fe10980..a9cda47b3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6141,6 +6141,22 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
 	struct authentication_req *auth;
 	int err;
 
+	/* Just-Works repairing policy */
+	if (confirm_hint && (device_is_paired(device, BDADDR_BREDR) ||
+				device_is_paired(device, BDADDR_LE_PUBLIC))) {
+		if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
+			btd_adapter_confirm_reply(device->adapter,
+						  &device->bdaddr,
+						  type, FALSE);
+			return 0;
+		} else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
+			btd_adapter_confirm_reply(device->adapter,
+						  &device->bdaddr,
+						  type, TRUE);
+			return 0;
+		}
+	}
+
 	auth = new_auth(device, type, AUTH_TYPE_CONFIRM, FALSE);
 	if (!auth)
 		return -EPERM;
diff --git a/src/hcid.h b/src/hcid.h
index adea85ce2..ca405fde4 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -35,6 +35,12 @@ typedef enum {
 	BT_GATT_CACHE_NO,
 } bt_gatt_cache_t;
 
+enum jw_repairing_t {
+	JW_REPAIRING_NEVER,
+	JW_REPAIRING_CONFIRM,
+	JW_REPAIRING_ALWAYS,
+};
+
 struct main_opts {
 	char		*name;
 	uint32_t	class;
@@ -58,6 +64,8 @@ struct main_opts {
 	uint16_t	gatt_mtu;
 
 	uint8_t		key_size;
+
+	enum jw_repairing_t jw_repairing;
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index 1a6ab36a3..fc8c869fc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -93,6 +93,7 @@ static const char *supported_options[] = {
 	"MultiProfile",
 	"FastConnectable",
 	"Privacy",
+	"JustWorksRepairing",
 	NULL
 };
 
@@ -193,6 +194,20 @@ static bt_gatt_cache_t parse_gatt_cache(const char *cache)
 	}
 }
 
+static enum jw_repairing_t parse_jw_repairing(const char *jw_repairing)
+{
+	if (!strcmp(jw_repairing, "never")) {
+		return JW_REPAIRING_NEVER;
+	} else if (!strcmp(jw_repairing, "confirm")) {
+		return JW_REPAIRING_CONFIRM;
+	} else if (!strcmp(jw_repairing, "always")) {
+		return JW_REPAIRING_ALWAYS;
+	} else {
+		return JW_REPAIRING_NEVER;
+	}
+}
+
+
 static void check_options(GKeyFile *config, const char *group,
 						const char **options)
 {
@@ -331,6 +346,18 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
+	str = g_key_file_get_string(config, "General",
+						"JustWorksRepairing", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+		main_opts.jw_repairing = JW_REPAIRING_NEVER;
+	} else {
+		DBG("just_works_repairing=%s", str);
+		main_opts.jw_repairing = parse_jw_repairing(str);
+		g_free(str);
+	}
+
 	str = g_key_file_get_string(config, "General", "Name", &err);
 	if (err) {
 		DBG("%s", err->message);
diff --git a/src/main.conf b/src/main.conf
index 40687a755..bb5ff5b15 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -72,6 +72,11 @@
 # Defaults to "off"
 # Privacy = off
 
+# Specify the policy to the JUST-WORKS repairing initiated by peer
+# Possible values: "never", "confirm", "always"
+# Defaults to "never"
+#JustWorksRepairing = never
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.25.0.265.gbab2e86ba0-goog

