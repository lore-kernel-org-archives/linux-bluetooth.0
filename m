Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7522C433E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 20:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B041B2065F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 20:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXBsIRu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGOUqi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGOUqh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 16:46:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2EC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 13:46:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cv18so2290883pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQRa/jrP5YMzzZg5j7p1SXibP/2/RV/6PXU6mTaicEo=;
        b=eXBsIRu5AQr+MLwNg4W8xgxDmLzL9FPZubP0zQrBIcHqy8Tfr26d24Ky/26EmuQ1xw
         oh5b0ymp8vN8XgQg0EOGCgs8n8V1ZLSueFaP//E6XRwdw2BQyu51eJqtzhZIQBfUN+wO
         rJIaY+X5+k1MEo1ZXJ1yEamaEKdL+iEBM3KBtpxcsX0wof33Q6NZ5Hwtp3JhNKykCiJt
         cb7mMgAVg9TV6zmNZKW6cocl3hIRCYv69gLlAPWm/ZjnK6EXZjWXqLgytPCV0tJcEW6W
         zNV+3docyDZd3ohq1svpOw9TVzXcE25m8+0pEgtW9qaoFYhTbOLKyAuz4z4E+E9/lhAo
         OMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQRa/jrP5YMzzZg5j7p1SXibP/2/RV/6PXU6mTaicEo=;
        b=TE6a35S3CzzwJMNo7Y39nWY4+DVlJnEuInky/ac8kTBX4vvcIhrWRO9YqAHeY+nVIp
         djjhffHhyqytqnk3Xi18s/T60zidyKNpqQGANYQeA4Zs50JmwYHCoElUFIignYzHUvNm
         5sAE/zJh6dxdG7hSijBGGA6Oya5QYDunycq/JotWYMbsGyiK7IR9pla0ACgTQIQ4FxUf
         7AWZ06FfcLKIaCi/cOrFHpM7nJ54oq+Gf3E1237rK6qDPLCtA9U4U8qa1QjfuccX57zt
         iwjk3ucf8P5eqwqKTPrFQKhYsy9pCaOb3VKMjJTGe9ihsE126Hg0jzMcWLb7I991q29P
         ZLrg==
X-Gm-Message-State: AOAM531eUO8LvgkD91Q8yCH1uvNX4ARgAovE5Cv8ztamAwuTp6LiW0+u
        9GeX/WkKVQ1Y/0h9kvC+9Or2kUsg5QA=
X-Google-Smtp-Source: ABdhPJwjhXp66SBfEkrA5ATqkn9+ZkKLOac0xe6yVGs06y74PQQRnnU7xbApkONuEz3ntiFtfbtMkw==
X-Received: by 2002:a17:90b:70d:: with SMTP id s13mr1457601pjz.161.1594845996847;
        Wed, 15 Jul 2020 13:46:36 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i125sm2901142pgd.21.2020.07.15.13.46.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:46:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] device: Add timer for removing temporary devices
Date:   Wed, 15 Jul 2020 13:46:34 -0700
Message-Id: <20200715204635.755599-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a timer for how long to keep temporary devices, it is updated
everytime the device is seen so devices will be removed even during an
active discovery session which means the discovering for a long period
will no longer just grow without removing devices that disappeared.
---
 src/device.c  | 34 ++++++++++++++++++++++++++++++++++
 src/hcid.h    |  1 +
 src/main.c    | 13 +++++++++++++
 src/main.conf |  5 +++++
 4 files changed, 53 insertions(+)

diff --git a/src/device.c b/src/device.c
index 0deee2707..226216235 100644
--- a/src/device.c
+++ b/src/device.c
@@ -233,6 +233,7 @@ struct btd_device {
 	bool		connectable;
 	guint		disconn_timer;
 	guint		discov_timer;
+	guint		temporary_timer;	/* Temporary/disappear timer */
 	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
@@ -698,6 +699,9 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
+	if (device->temporary_timer)
+		g_source_remove(device->temporary_timer);
+
 	if (device->connect)
 		dbus_message_unref(device->connect);
 
@@ -4232,12 +4236,34 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	store_device_info(device);
 }
 
+static gboolean device_disappeared(gpointer user_data)
+{
+	struct btd_device *dev = user_data;
+
+	dev->temporary_timer = 0;
+
+	btd_adapter_remove_device(dev->adapter, dev);
+
+	return FALSE;
+}
+
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 {
 	if (bdaddr_type == BDADDR_BREDR)
 		device->bredr_seen = time(NULL);
 	else
 		device->le_seen = time(NULL);
+
+	if (!device_is_temporary(device))
+		return;
+
+	/* Restart temporary timer */
+	if (device->temporary_timer)
+		g_source_remove(device->temporary_timer);
+
+	device->temporary_timer = g_timeout_add_seconds(main_opts.tmpto,
+							device_disappeared,
+							device);
 }
 
 /* It is possible that we have two device objects for the same device in
@@ -5610,10 +5636,18 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 
 	device->temporary = temporary;
 
+	if (device->temporary_timer) {
+		g_source_remove(device->temporary_timer);
+		device->temporary_timer = 0;
+	}
+
 	if (temporary) {
 		if (device->bredr)
 			adapter_whitelist_remove(device->adapter, device);
 		adapter_connect_list_remove(device->adapter, device);
+		device->temporary_timer = g_timeout_add_seconds(main_opts.tmpto,
+							device_disappeared,
+							device);
 		return;
 	}
 
diff --git a/src/hcid.h b/src/hcid.h
index c21ac9980..5f249ebf9 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -53,6 +53,7 @@ struct main_opts {
 	gboolean	pairable;
 	uint32_t	pairto;
 	uint32_t	discovto;
+	uint32_t	tmpto;
 	uint8_t		privacy;
 
 	struct {
diff --git a/src/main.c b/src/main.c
index bacb44197..ec7a9fbd7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -67,6 +67,7 @@
 
 #define DEFAULT_PAIRABLE_TIMEOUT       0 /* disabled */
 #define DEFAULT_DISCOVERABLE_TIMEOUT 180 /* 3 minutes */
+#define DEFAULT_TEMPORARY_TIMEOUT     30 /* 30 seconds */
 
 #define SHUTDOWN_GRACE_SECONDS 10
 
@@ -89,6 +90,7 @@ static const char *supported_options[] = {
 	"FastConnectable",
 	"Privacy",
 	"JustWorksRepairing",
+	"TemporaryTimeout",
 	NULL
 };
 
@@ -531,6 +533,16 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
+	val = g_key_file_get_integer(config, "General",
+						"TemporaryTimeout", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("tmpto=%d", val);
+		main_opts.tmpto = val;
+	}
+
 	str = g_key_file_get_string(config, "General", "Name", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -672,6 +684,7 @@ static void init_defaults(void)
 	main_opts.class = 0x000000;
 	main_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
 	main_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
+	main_opts.tmpto = DEFAULT_TEMPORARY_TIMEOUT;
 	main_opts.reverse_discovery = TRUE;
 	main_opts.name_resolv = TRUE;
 	main_opts.debug_keys = FALSE;
diff --git a/src/main.conf b/src/main.conf
index 6a6f7d4b4..f41203b96 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -77,6 +77,11 @@
 # Defaults to "never"
 #JustWorksRepairing = never
 
+# How long to keep temporary devices around
+# The value is in seconds. Default is 30.
+# 0 = disable timer, i.e. never keep temporary devices
+#TemporaryTimeout = 30
+
 [Controller]
 # The following values are used to load default adapter parameters.  BlueZ loads
 # the values into the kernel before the adapter is powered if the kernel
-- 
2.25.3

