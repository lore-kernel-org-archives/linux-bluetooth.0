Return-Path: <SRS0=P4FJ=4D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A4C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Feb 2020 03:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6002084E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Feb 2020 03:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjzwy+PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBODol (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:44:41 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49827 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgBODol (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Feb 2020 22:44:41 -0500
Received: by mail-vk1-f202.google.com with SMTP id v134so4128058vkd.16
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2020 19:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=83oH/fzq13UKVNBOgHxwIm4YPXPt0pRNeULTouC05KQ=;
        b=jjzwy+PAJlynA8W8G5fbt0lRs2AM2ecqqK7dH2X820a+tCWcIBZxYK1IhBNXQau1Ld
         SLR17lxmNU9+oMEaVqx6CWsRYZ2YoIszYHtKJsAaVygpPiF2jjH2J6om2OhRqe0mYRkK
         +Yph1BDzGgKApuVpAqb46+ARkj5d212lNsf/21CDZMmb57xPCUopEqzHh46MuifGmouU
         7p89BrLO7Pfz29RxdYK95/EMpIelY6fMhlnRrFjiLGpTOFr8P5u5DsZMkGqUz7zH7EZ7
         H50Op+u+Qe7PzZ/98E6BxZkKY30UrdJIasLVVUsEoi1ffOq2I5G99HDckZc9b926UPwQ
         5yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=83oH/fzq13UKVNBOgHxwIm4YPXPt0pRNeULTouC05KQ=;
        b=cAfeyggjgHVNiVjazdZz10wR/3Bms+8aAY7+OBuhpx2dX/0+Xga7wOsTdLzp/YFfxx
         jfXim7lSXS+RIDlq1aaoaFaj5Frh2uFGKkyCiu1KdKbvJ5fA0/52cflvGF0tJL3f88X3
         xe47m92WeSzQzYgc9Wtg38IQXCALnDtXDruNKjW1QPUQn42Ms/lP3by0ZJQWif85wspT
         3T+bomc96Kpi+9dGtraKBMzrNY8W3hRYsW8paBrvsclVY6cP4ThlGbRDGnndKRMKFaje
         L5Y6YpGX2ZqhmPl/u2wh7Zb/POB/iVsMatZuAwu7/YPuxO0/i5iyF1WfHFovxZCpQMpk
         OdlA==
X-Gm-Message-State: APjAAAVzMEoNxkS5kvbh2O9EOlnUm93DFKhjFmYstT/QIPo1uvgE621F
        ITxL/QhwlgjVhIPA4YxASNSMb3mK7yuC7wfnvh+6xSh1PBilWc3ixr0d73VR10VwB7uISoY96RP
        w3tQjkc00qyrTcvI4OKf44CDuQSPfNws/X2H9JthUimkRbGsVZY/YVJbmIXa/A8RW/iwY7POl1Z
        J1sJ2ZdbT6joI=
X-Google-Smtp-Source: APXvYqz/a6anbwj9nGpeK78vfZAIszc0hM2dSn8KiJk5Fc1rq2jA7LCMvEEUFOUkRiLVcEXsPz26zECe9OiqfBGNrg==
X-Received: by 2002:a1f:1bc3:: with SMTP id b186mr1081012vkb.96.1581738280241;
 Fri, 14 Feb 2020 19:44:40 -0800 (PST)
Date:   Sat, 15 Feb 2020 11:44:33 +0800
Message-Id: <20200215114408.Bluez.v4.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v4] core: Add new policy for Just-Works repairing
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

Changes in v4:
- optimize the code in src/device.c

Changes in v3:
- move the check from src/agent.c to src/device.c
- fix the enum declaration in src/hcid.h

Changes in v2:
- let RequestAuthorization handle the situation
- remove the changes in client/

 src/device.c  | 15 +++++++++++++++
 src/hcid.h    |  8 ++++++++
 src/main.c    | 27 +++++++++++++++++++++++++++
 src/main.conf |  5 +++++
 4 files changed, 55 insertions(+)

diff --git a/src/device.c b/src/device.c
index a4fe10980..a8f4c22f3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6141,6 +6141,21 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
 	struct authentication_req *auth;
 	int err;
 
+	/* Just-Works repairing policy */
+	if (confirm_hint && device_is_paired(device, type)) {
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

