Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8874FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 19:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGITXZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGITXY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 15:23:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA71580A
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 12:23:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l26so1284962qkl.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZT6S++CL1C724LxUdqJ5ns5twannFi9zkOe00uX6HMY=;
        b=dJ31deP/QXPlaGtCY9YGIH8iFjJGR3sKaWvgjH27UnREWgdYsyhO+w4in+E020pMcy
         u3asFij+JLfZ7eWhfjFFnKZt6Fc3BTh3PJJxza5F9tlUZVRL/r/09Ej8hHhy+Uhz51tk
         Ip/Y7oDmAQfmdsza9qKH0eYmel6i9elLlqi9MYIojYMC61dzRLVjsypqbY7K5nlpUupJ
         bMHrdfhkLQ2KbcSFyTPC9O3wBZpIh+AkG3giik+eTBqHVz1ztf0It0jbta9paoz2zC0y
         mWqKsdBYi83f6V2agSvn05wZFzIPb1xZepv6wvcHBXJ9D+KHmlLyVtVko53jbmc1FtXM
         AhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZT6S++CL1C724LxUdqJ5ns5twannFi9zkOe00uX6HMY=;
        b=dzmpmJQfAJCAjAXauncoKRUw4YVuwhOWTDCije0ysoGLI+xkFWC5AtdyAHmlbbSXPs
         IvFk7rN1hltr57hITXBNiayTzEp2GCrfWSyR+JXEV7/PqRCZWRg4VInxRqRw5LHqbFB5
         Grcxms7FT4tF+0ghQTj/Cu+VQ2EgqyXANUAMsVISHB22+bBecbDS7yl+uXX1Hfqdd4Za
         fJHbEP0B+JdgERfPfvT38Ui+iSWW+Tslli9pW1PaWDNHoNn6ax0tJ00Wbpx8GnTRHb72
         /YPGwZ3nZxB5cN5LqgWoKxrxzJ9u82c4LwHHJMxY4UC0rk1cQz0n7TALoGgXPIo2JX+A
         wMUw==
X-Gm-Message-State: AJIora/wMHAuetuRv8XfPPLy6NpzwdNBQQl8gDc2vCoh1FNi7p+ilxp9
        2sWumSynw2/QrKlEMm1fnTHaMJFjgMdtMCLO
X-Google-Smtp-Source: AGRyM1u4niOrixd8ExFF60QgpWBdc0aBE2TuX74pBWV3+YL6HqhBpC7y4/jqCQZbT02112IS/we93Q==
X-Received: by 2002:a05:620a:bcb:b0:6a9:8f2a:ecf9 with SMTP id s11-20020a05620a0bcb00b006a98f2aecf9mr6773719qki.351.1657394602907;
        Sat, 09 Jul 2022 12:23:22 -0700 (PDT)
Received: from robotnik.. ([209.23.56.93])
        by smtp.gmail.com with ESMTPSA id w3-20020ac857c3000000b00317c519be8bsm1933554qta.66.2022.07.09.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 12:23:22 -0700 (PDT)
From:   shwoseph <shwoseph@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     shwoseph@gmail.com
Subject: [PATCH BlueZ 1/1] [v3] ExcludeAdapter configuration setting for input profile
Date:   Sat,  9 Jul 2022 15:23:17 -0400
Message-Id: <20220709192317.1704-2-shwoseph@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220709192317.1704-1-shwoseph@gmail.com>
References: <20220709192317.1704-1-shwoseph@gmail.com>
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
index 92789a003..b6e8f4fc1 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -32,7 +32,22 @@
 
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
+		if (strcmp(addr, exclude_adapters[i]))
+			return 0;
+	}
+
+	return server_start(address);
 }
 
 static void hid_server_remove(struct btd_profile *p,
@@ -83,6 +98,9 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
+		char *exclude_adapters_str;
+		char **exclude_adapters;
+		gsize num_exclude_adapters;
 		gboolean uhid_enabled, classic_bonded_only, auto_sec;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
@@ -121,6 +139,20 @@ static int input_init(void)
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
+			DBG("input.conf: ExcludeAdapters=%s",
+					exclude_adapters_str);
+			input_set_exclude_adapters(exclude_adapters);
+			input_set_num_exclude_adapters(num_exclude_adapters);
+		} else
+			g_clear_error(&err);
 	}
 
 	btd_profile_register(&input_profile);
-- 
2.32.0

