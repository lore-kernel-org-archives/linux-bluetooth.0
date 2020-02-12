Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D42C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A2420661
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 13:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6hBqDKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBLN3n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:29:43 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33341 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLN3n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 08:29:43 -0500
Received: by mail-pl1-f202.google.com with SMTP id bd7so1176700plb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a0w08ijI1bBuSp26GAvfYQVAuoXdK5WuLwYaVgwyb70=;
        b=Y6hBqDKaID5ACQjZ1rK2pigmKkBLsv2O8MuWwaVpFjrP5Sns00XE04+sEIVpycZqFO
         RwvesdCOY47WPoGFw9QfHfuvKlFjWs2PkZ2CgWY/33I4EBL4VYRblX2gYSiLUD62YV8C
         CbPWNyQbm3VbjofIgS99vdD5aW8L1D6geRWVKiZ8BNCNJRY0DzYEUhHBFVdKPmGy889U
         uqRwGi5tMueAMzeoJG205i6dyXYNQclDusffZuMHh2IM0Q4ob8W0Anu6cEloyyM8uP4c
         Jxghkd+0jTwL0lHDSP57ihshfHDXpGLX3/KUkBUkwFzEuLTkRuwkr80hDkoxTUKwFMHf
         2ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a0w08ijI1bBuSp26GAvfYQVAuoXdK5WuLwYaVgwyb70=;
        b=OIFlyLORwSrFx1JClFYfQkz88Ck5ssYKCcRnZiEqZM666RQjR/n/6CNpJwZF4j9lWn
         bR8rYP6FjSBioK6TEhTln2thpZkM0bD8ph2rtstAoyzCCgV3Tj5y7mdEoxVlfz7EyeTc
         RF5j0wG3NUnbxIcrYghGO8ISzO7DC1+7260bY5TNBtfKtBdt3g8RChLvtId8FZmY8v2r
         WUiILgFbDOyV1QMME4oBUZRi9g/D1vtWF+6wYb5i8Sdf7av2JYmtROnV3HAIr7TgVNly
         Z5LgrNQsYw1HyUAWGO2aH/DKj2QBxF1/AoVFLMRWzJ0xs5KLLZPohzSoIKB8dtiwyZcp
         pgRg==
X-Gm-Message-State: APjAAAXHUMhy9g3fpxJKeU/LGjrL7AEtdraAIEyd9j3YpEWyhIBSxlQr
        iiR22+AoE6JIYP4D+8GZPQIU6bwT6MzLrp3Il4slufURuEJe6l8GlhM5eMrIrsE2KGkvRHiJheu
        xunzM27XrvxE78IGtmX5r8n5GKO4vN4H/EmON2g+RYPH6APfGIH7Ky/i+cd71VOQNWZVkcfyC9i
        hbI6fvGWX9hv8=
X-Google-Smtp-Source: APXvYqxhbn+UhFgELRnwbO6OgVbRIS72CcUS9cdJoG3OYX0zJZATQ7LMuHpwWHEONW1jSloD7k8rJQKVNHqXLjpnTA==
X-Received: by 2002:a63:705e:: with SMTP id a30mr12119424pgn.182.1581514182022;
 Wed, 12 Feb 2020 05:29:42 -0800 (PST)
Date:   Wed, 12 Feb 2020 21:29:33 +0800
Message-Id: <20200212212729.Bluez.v2.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [Bluez PATCH v2] core: Add new policy for Just-Works repairing
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

Changes in v2:
- let RequestAuthorization handle the situation
- remove the changes in client/

 src/agent.c   | 16 ++++++++++++++++
 src/hcid.h    |  8 ++++++++
 src/main.c    | 27 +++++++++++++++++++++++++++
 src/main.conf |  5 +++++
 4 files changed, 56 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index e0ffcd22f..e013ec85f 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -773,12 +773,28 @@ int agent_request_authorization(struct agent *agent, struct btd_device *device,
 						GDestroyNotify destroy)
 {
 	struct agent_request *req;
+	DBusError dbus_err;
 	int err;
 
 	err = agent_has_request(agent, device, AGENT_REQUEST_AUTHORIZATION);
 	if (err)
 		return err;
 
+	/* Just-Works repairing policy */
+	if (device_is_paired(device, BDADDR_BREDR) ||
+				device_is_paired(device, BDADDR_LE_PUBLIC)) {
+		if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
+			dbus_error_init(&dbus_err);
+			dbus_set_error_const(&dbus_err,
+					ERROR_INTERFACE ".Rejected", NULL);
+			cb(agent, &dbus_err, user_data);
+			return 0;
+		} else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
+			cb(agent, NULL, user_data);
+			return 0;
+		}
+	}
+
 	DBG("Calling Agent.RequestAuthorization: name=%s, path=%s",
 						agent->owner, agent->path);
 
diff --git a/src/hcid.h b/src/hcid.h
index adea85ce2..bcd2b9fa1 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -35,6 +35,12 @@ typedef enum {
 	BT_GATT_CACHE_NO,
 } bt_gatt_cache_t;
 
+enum {
+	JW_REPAIRING_NEVER,
+	JW_REPAIRING_CONFIRM,
+	JW_REPAIRING_ALWAYS,
+} jw_repairing_t;
+
 struct main_opts {
 	char		*name;
 	uint32_t	class;
@@ -58,6 +64,8 @@ struct main_opts {
 	uint16_t	gatt_mtu;
 
 	uint8_t		key_size;
+
+	jw_repairing_t	jw_repairing;
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index 1a6ab36a3..d67f469f1 100644
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
 
+static jw_repairing_t parse_jw_repairing(const char *jw_repairing)
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
2.25.0.225.g125e21ebc7-goog

