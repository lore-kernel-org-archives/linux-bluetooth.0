Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B1C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD5920738
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXmLDGl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCLWin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:38:43 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44005 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLWin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:38:43 -0400
Received: by mail-pg1-f182.google.com with SMTP id u12so3777834pgb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3PftGFsHVrEBOelKu9QhVpR8NGkGeU9Y8TSH94dQmMI=;
        b=bXmLDGl0KS9Sisq7Xz2h4P7O1FyhZ70gCb6ZTwmnctdEm01IvQkX/orWiUiR004rm8
         eXLgNQ3GXv99p3a/H4EaliUbcXosotF5uH2MPp+qNWW3qbV+hhIYTKqFAikxl7XfV8sn
         GQZG5wO0XCFUV/MqoEhR5VRB7q+gaYdx8nsNtO8vNaCYe7RMzmp9BeGFV1GR3Pxu/v1V
         EASTpe1aW+z8B1lOY6jzDepqglAYzBMpLMwjeAoplSYYmudtxPSOt4oWi9QXHwpH4hdQ
         L1ufNGbS9H6fz1CjTs5wuRrOw5Rwaj7v8lOvcY1HMVNc1e8enyXvbEAfH6yb47AthVBt
         j8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PftGFsHVrEBOelKu9QhVpR8NGkGeU9Y8TSH94dQmMI=;
        b=QJR3RapGYAVpBGNYr3rJ/zXn4a/hW+t816N5JTh6VG78u4uFNxPWlQNhagcAcMdyKz
         a4/8HWxkLF8Y2FH6BDSgGGG5cw2sCfh3Sky2IcEZXfEamxCirN/WnHMFeSEyIIWo8joM
         UtfeQYpD2978kKfHSzKaH9BOJZXsIko5jnGv6cuULrz5gVnWekVXDz20uKs0NLlcgDSf
         tGM1o5UH68+y2+bjUDtX/rD7Da+oCE4nK8wtViI2KW0wqhidjid7ZPCM7R+OczhST6sr
         VHWs3mtooV6TkDFL5JAvWyNT3RfN/ONgpa6mZwAeJK0tAB1sfJMFiCj2n14ThadW9l6W
         yZug==
X-Gm-Message-State: ANhLgQ28s7e358LnOiI5dtJ80fTXuF83ynONbkGQUqVc5qHUoFs3QhZd
        H9KBrs8yFQMC3MpsspcRWyACivbxR6M=
X-Google-Smtp-Source: ADFU+vv61KaMeKBqvlxiUKaOLwK73onjurWFyOvt6lqLbKrxFI2/LwguF0HDCkEAvYNf189hmYYF9A==
X-Received: by 2002:a65:68d4:: with SMTP id k20mr10034981pgt.69.1584052722012;
        Thu, 12 Mar 2020 15:38:42 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g5sm5118190pfo.192.2020.03.12.15.38.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:38:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] input: Add LEAutoSecurity setting to input.conf
Date:   Thu, 12 Mar 2020 15:38:39 -0700
Message-Id: <20200312223839.6236-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312223839.6236-1-luiz.dentz@gmail.com>
References: <20200312223839.6236-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LEAutoSecurity can be used to enable/disable automatic upgrades of
security for LE devices, by default it is enabled so existing devices
that did not require security and were not bonded will automatically
upgrade the security.

Note: Platforms disabling this setting would require users to manually
bond the device which may require changes to the user interface to
always force bonding for input devices as APIs such as Device.Connect
will no longer work which maybe perceived as a regression.
---
 profiles/input/device.h   |  1 +
 profiles/input/hog.c      | 13 +++++++++++--
 profiles/input/input.conf |  5 +++++
 profiles/input/manager.c  | 11 ++++++++++-
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.h b/profiles/input/device.h
index 3044db673..5a077f92a 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -30,6 +30,7 @@ struct input_conn;
 void input_set_idle_timeout(int timeout);
 void input_enable_userspace_hid(bool state);
 void input_set_classic_bonded_only(bool state);
+void input_set_auto_sec(bool state);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index f0226ebbd..327a1d1c3 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -53,6 +53,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/plugin.h"
 
+#include "device.h"
 #include "suspend.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
@@ -67,8 +68,14 @@ struct hog_device {
 };
 
 static gboolean suspend_supported = FALSE;
+static bool auto_sec = true;
 static struct queue *devices = NULL;
 
+void input_set_auto_sec(bool state)
+{
+	auto_sec = state;
+}
+
 static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
 {
 	char name[248];
@@ -192,11 +199,13 @@ static int hog_accept(struct btd_service *service)
 	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
 		struct bt_gatt_client *client;
 
+		if (!auto_sec)
+			return -ECONNREFUSED;
+
 		client = btd_device_get_gatt_client(device);
 		if (!bt_gatt_client_set_security(client,
-						BT_ATT_SECURITY_MEDIUM)) {
+						BT_ATT_SECURITY_MEDIUM))
 			return -ECONNREFUSED;
-		}
 	}
 
 	/* TODO: Replace GAttrib with bt_gatt_client */
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 166aff4a4..4c70bc561 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -19,3 +19,8 @@
 # pairing/encryption.
 # Defaults to false to maximize device compatibility.
 #ClassicBondedOnly=true
+
+# LE upgrade security
+# Enables upgrades of security automatically if required.
+# Defaults to true to maximize device compatibility.
+#LEAutoSecurity=true
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 5cd27b839..bf4acb4ed 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -96,7 +96,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean uhid_enabled, classic_bonded_only;
+		gboolean uhid_enabled, classic_bonded_only, auto_sec;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
@@ -125,6 +125,15 @@ static int input_init(void)
 		} else
 			g_clear_error(&err);
 
+		auto_sec = g_key_file_get_boolean(config, "General",
+						"LEAutoSecurity", &err);
+		if (!err) {
+			DBG("input.conf: LEAutoSecurity=%s",
+					auto_sec ? "true" : "false");
+			input_set_auto_sec(auto_sec);
+		} else
+			g_clear_error(&err);
+
 	}
 
 	btd_profile_register(&input_profile);
-- 
2.21.1

