Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0DCCA47C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 16:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGIQ1I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIQ1H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 12:27:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3872F668
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 09:27:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i21so804048qtw.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obuNpp0usGCQKPFs99U+dUR3DwSthVrPz6MBnPWFz2w=;
        b=ET0G8rSWb3prWjXCVBZ4h+u9lk49P2qpnR8pXXzxqDxbxr5M60iNRrcBApHyy9CJgW
         qybTrfTj+GTdPnCabN+oZxdt9AE8KeWPJPNufEhU+bBj1IojO499JFe/Tsr7pNorQMZ7
         /+9xfjQ8ltpL2Xeb4q7lP6labTijFuqyKmKLPGSxSh+X8ToRYJGQ9GxtQNLOseOaFAd4
         i/OyyYAUJRSYxLGf6prUpikHFv4CeLdfQZHB6IPFscrdkB40CSxB8bUo0kUinJd/mLDx
         x8rUdUHjzIGRjzWeuNogVtxSmvP2XgB+l08A5Oks3c3+9urm8k2hpYHACj7dOBCeMVmZ
         Ynhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obuNpp0usGCQKPFs99U+dUR3DwSthVrPz6MBnPWFz2w=;
        b=QO1oJoJWCF2QpE+4ILfD6oP82ybzQhWXH628qlvL0v7obvMUjQd5iqSfBP7pOzekh6
         L733KYoN/uRx1zW1EpTeeRF5CqjW23THqiUM06u6l67HtoE3CZmnAlHQ5pPlbkiy3b3V
         43aXxQEr5sGgBM0QmwzSZ9p0guc2OPCxzrFxWitBPVMaJvpB2271SXgZkie9YVtH7mPU
         c4z5in5wZclXXWqbjSoKIzMvz7GAsqV2Mj/x+b22SbO7St9lU2LKaP2/uqriK4VRa0Mk
         8NmXGFIyBXzFVZCAMdDczMVNzFQuB9b0C8gDRFHs4es2oNasFd66nmLq0gdSye5ull8z
         Wyqg==
X-Gm-Message-State: AJIora8PAa5tlwGv9zzVjEu8vfs6HfmJQPIEMNdwSG36RmNa11yK/bG4
        lDCwnzVL6fPjC4vxMETyUtWd9LwpNPJPk0rB
X-Google-Smtp-Source: AGRyM1udfpgTek0WlvNhmdLkRr8KpJdDluEkz6nwF1g0wQjGk40zt/FQXFTA+xgXdWwStRKsvLQAuQ==
X-Received: by 2002:a05:622a:60e:b0:31d:3328:352a with SMTP id z14-20020a05622a060e00b0031d3328352amr7901588qta.184.1657384023686;
        Sat, 09 Jul 2022 09:27:03 -0700 (PDT)
Received: from robotnik.. ([209.23.56.93])
        by smtp.gmail.com with ESMTPSA id bx10-20020a05622a090a00b00304ecf35b50sm1625818qtb.97.2022.07.09.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:27:03 -0700 (PDT)
From:   shwoseph <shwoseph@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     shwoseph@gmail.com
Subject: [PATCH BlueZ 1/1] ExcludeAdapter configuration setting for input profile
Date:   Sat,  9 Jul 2022 12:26:58 -0400
Message-Id: <20220709162658.1953-2-shwoseph@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220709162658.1953-1-shwoseph@gmail.com>
References: <20220709162658.1953-1-shwoseph@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/input/device.c   | 22 ++++++++++++++++++++++
 profiles/input/device.h   |  4 ++++
 profiles/input/input.conf |  4 ++++
 profiles/input/manager.c  | 36 +++++++++++++++++++++++++++++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index e2ac6ea60..ec6ed4e9a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -82,6 +82,8 @@ struct input_device {
 static int idle_timeout = 0;
 static bool uhid_enabled = false;
 static bool classic_bonded_only = false;
+static char** exclude_adapters;
+static gsize num_exclude_adapters;
 
 void input_set_idle_timeout(int timeout)
 {
@@ -103,6 +105,26 @@ bool input_get_classic_bonded_only(void)
 	return classic_bonded_only;
 }
 
+char** input_get_exclude_adapters(void)
+{
+	return exclude_adapters;
+}
+
+void input_set_exclude_adapters(char** adapters)
+{
+    exclude_adapters = adapters;
+}
+
+gsize input_get_num_exclude_adapters(void)
+{
+	return num_exclude_adapters;
+}
+
+void input_set_num_exclude_adapters(gsize num)
+{
+    num_exclude_adapters = num;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
 static int uhid_disconnect(struct input_device *idev);
diff --git a/profiles/input/device.h b/profiles/input/device.h
index cf0389417..58b95d68e 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -19,6 +19,10 @@ void input_enable_userspace_hid(bool state);
 void input_set_classic_bonded_only(bool state);
 bool input_get_classic_bonded_only(void);
 void input_set_auto_sec(bool state);
+char** input_get_exclude_adapters(void);
+void input_set_exclude_adapters(char** address);
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
index 92789a003..3715fb1ec 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -32,7 +32,25 @@
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	return server_start(btd_adapter_get_address(adapter));
+    const bdaddr_t* address;
+    char addr[18];
+    char** exclude_adapters;
+    gsize num_exclude_adapters;
+
+    address = btd_adapter_get_address(adapter);
+    ba2str(address, addr);
+    exclude_adapters = input_get_exclude_adapters();
+    num_exclude_adapters = input_get_num_exclude_adapters();
+
+    for(int i = 0; i < num_exclude_adapters; i++)
+    {
+        if(strcmp(addr, exclude_adapters[i]))
+        {
+            return 0;
+        }
+    }
+
+	return server_start(address);
 }
 
 static void hid_server_remove(struct btd_profile *p,
@@ -80,9 +98,13 @@ static int input_init(void)
 	GKeyFile *config;
 	GError *err = NULL;
 
+    DBG("CONFIGDIR: %s", CONFIGDIR);
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
+        char* exclude_adapters_str;
+        char** exclude_adapters;
+        gsize num_exclude_adapters;
 		gboolean uhid_enabled, classic_bonded_only, auto_sec;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
@@ -121,6 +143,18 @@ static int input_init(void)
 		} else
 			g_clear_error(&err);
 
+        g_key_file_set_list_separator(config, ',');
+
+        exclude_adapters_str = g_key_file_get_string(config, "General",
+                "ExcludeAdapters", &err);
+        exclude_adapters = g_key_file_get_string_list(config, "General",
+                "ExcludeAdapters", &num_exclude_adapters, &err);
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

