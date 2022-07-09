Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C01CCA47C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 18:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGISfb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGISfa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 14:35:30 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3CC2E6B1
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 11:35:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 23so2320486qtt.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIwXpSyKXIgmIioZTZOXSEhMUp325xa1rERIPflklm4=;
        b=Ff34es/VANYmPfU22rqwPZ/j1tVOEDCcKMB650K55K06HyoTOZDyvpkFUubZIOEZFe
         /e3h3ATPLexttzS5L8B3H5o6xjRIsVPNg/JkPSitg0Oz3ETQzzGl5KcJQFSt9OpCdgUr
         dLDTUfmDxnHv4WavW6OylXaqUR3FC52pAfRGKt6REf60/uBKuCVF15TCpXGcOilfrhDk
         6LwJhexCnqRC5RvTj2VFV7CVQfOyXStBP8m+DdZtwGVoWDiJ3Cy+0Bdwm0yrAhjPw1Dz
         i05K0m6SSHBdYXL23yHLBNfKoQH8JBNclyfi9Fp86tRBjmO2ahoPqOJb4Xif8sk3CgYd
         YJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIwXpSyKXIgmIioZTZOXSEhMUp325xa1rERIPflklm4=;
        b=Lnz1CuWq6LJu1RBQ1pYVz0sBfNhoqbHr2UH7ADS6NYo5joOPGX4SbtnlDWeYc4Wh+C
         glb348RsVF37WXd/cESrY6tYMIHQD15av+0PTUy1/ebU7Xjkkt66q2/LI94t5Pny/aqh
         qOY1KfJqHK2nh8V44hyuuz/AF60SjQQq7VkxKSN69KvZPpZvis+wZZBm64l7UF9Tse88
         hoJSKgQ450x3mjSTMkkwZ5XmeBW+w5X/xNaThiZfNmud28fh+trVk6oxdEbSTxRCpq0P
         iDfbz23tpJSu3vT5MFsSPgGJ4PXuPpRVWtxKMLAnMkiE44HTSvF+pT5b7dV4lEeclx3K
         rPGA==
X-Gm-Message-State: AJIora8g2Pqm92+Jo1fHMVPjg61VVYwQQYsPmhRHEF876zBg8/TsrQhd
        IykiffzrQxS+0KIKn1fZHTTT4zFl/r7gYnvS
X-Google-Smtp-Source: AGRyM1s7YxTZC2XRlcVxZxDXIA06rBTq16zx6IWZ8RlLhWJOFlrc7aP9L5OnjO7fHlRFEuSNk7AKoA==
X-Received: by 2002:a05:622a:6098:b0:2f0:f0d2:b5f0 with SMTP id hf24-20020a05622a609800b002f0f0d2b5f0mr8268828qtb.583.1657391728998;
        Sat, 09 Jul 2022 11:35:28 -0700 (PDT)
Received: from robotnik.. ([209.23.56.93])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8580a000000b00304e2e4bf1esm1865961qtg.88.2022.07.09.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 11:35:28 -0700 (PDT)
From:   shwoseph <shwoseph@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     shwoseph@gmail.com
Subject: [PATCH BlueZ 1/1] [v2] ExcludeAdapter configuration setting for input profile
Date:   Sat,  9 Jul 2022 14:35:24 -0400
Message-Id: <20220709183524.13900-2-shwoseph@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220709183524.13900-1-shwoseph@gmail.com>
References: <20220709183524.13900-1-shwoseph@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/input/device.c   | 22 ++++++++++++++++++++++
 profiles/input/device.h   |  4 ++++
 profiles/input/input.conf |  4 ++++
 profiles/input/manager.c  | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index e2ac6ea60..0192e7977 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -82,6 +82,8 @@ struct input_device {
 static int idle_timeout = 0;
 static bool uhid_enabled = false;
 static bool classic_bonded_only = false;
+static char **exclude_adapters;
+static gsize num_exclude_adapters;
 
 void input_set_idle_timeout(int timeout)
 {
@@ -103,6 +105,26 @@ bool input_get_classic_bonded_only(void)
 	return classic_bonded_only;
 }
 
+char **input_get_exclude_adapters(void)
+{
+	return exclude_adapters;
+}
+
+void input_set_exclude_adapters(char **adapters)
+{
+	exclude_adapters = adapters;
+}
+
+gsize input_get_num_exclude_adapters(void)
+{
+	return num_exclude_adapters;
+}
+
+void input_set_num_exclude_adapters(gsize num)
+{
+	num_exclude_adapters = num;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
 static int uhid_disconnect(struct input_device *idev);
diff --git a/profiles/input/device.h b/profiles/input/device.h
index cf0389417..04fe41e2d 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -19,6 +19,10 @@ void input_enable_userspace_hid(bool state);
 void input_set_classic_bonded_only(bool state);
 bool input_get_classic_bonded_only(void);
 void input_set_auto_sec(bool state);
+char **input_get_exclude_adapters(void);
+void input_set_exclude_adapters(char **address);
+gsize input_get_num_exclude_adapters(void);
+void input_set_num_exclude_adapters(gsize address);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 4c70bc561..c8ec5ee30 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -24,3 +24,7 @@
 # Enables upgrades of security automatically if required.
 # Defaults to true to maximize device compatibility.
 #LEAutoSecurity=true
+
+# Exclude adapters
+# Disables input plugin on adapters with specified bdaddrs
+#ExcludeAdapters=00:00:00:00:00:00,00:00:00:00:00:01
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 92789a003..ca687b726 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -32,7 +32,23 @@
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	return server_start(btd_adapter_get_address(adapter));
+	const bdaddr_t *address;
+	char addr[18];
+	char **exclude_adapters;
+	gsize num_exclude_adapters;
+	
+	address = btd_adapter_get_address(adapter);
+	ba2str(address, addr);
+	exclude_adapters = input_get_exclude_adapters();
+	num_exclude_adapters = input_get_num_exclude_adapters();
+
+	for (gsize i = 0; i < num_exclude_adapters; i++) {
+		if (strcmp(addr, exclude_adapters[i])) {
+			return 0;
+		}
+	}
+	
+	return server_start(address);
 }
 
 static void hid_server_remove(struct btd_profile *p,
@@ -83,6 +99,9 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
+		char *exclude_adapters_str;
+		char **exclude_adapters;
+		gsize num_exclude_adapters;
 		gboolean uhid_enabled, classic_bonded_only, auto_sec;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
@@ -121,6 +140,19 @@ static int input_init(void)
 		} else
 			g_clear_error(&err);
 
+		g_key_file_set_list_separator(config, ',');
+		
+		exclude_adapters_str = g_key_file_get_string(config, "General",
+				"ExcludeAdapters", &err);
+		exclude_adapters = g_key_file_get_string_list(config, "General",
+				"ExcludeAdapters", &num_exclude_adapters, &err);
+
+		if (!err) {
+			DBG("input.conf: ExcludeAdapters=%s", exclude_adapters_str);
+			input_set_exclude_adapters(exclude_adapters);
+			input_set_num_exclude_adapters(num_exclude_adapters);
+		} else
+			g_clear_error(&err);
 	}
 
 	btd_profile_register(&input_profile);
-- 
2.32.0

