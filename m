Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E50C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED5C61004
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhFRRPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhFRRPO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 13:15:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B215C061760
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 10:13:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z26so8141799pfj.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyIyZZ64hERPPx/N33XYjGv5tcd9Tad/Hjg2M71DmbU=;
        b=ZC6vS9GPAs8snRn0kc1fV7+KYq+iJuITTL6m9tZ0uV2iN8u9zMzZmNhM0xmR2yAwn9
         jU7sbvjmkOOkjqlVV66Ky0cIanH+iG//anVCC335cXIC1T5LhSDA/s4QLO+2rQdJH8DL
         fqOEx3dkyuqMCSN2m193Yab1YgkDK6ch5ErzUtBXtbVvd0noLJ2ZHL87S0MfidS3fy7R
         BFJMtg/aqJTAevj2M4WUVxR15ZMQ9Q9YAH4TiDuJIYSQoN7YLVOgzxn5YjuBgLQE9Fya
         dSX7vmn01CODeyIGbewAzhd0/+oJ9hVa+t9KhKS7qLyJDJB7oOkiXMavrIC0QGBMjOsW
         PSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyIyZZ64hERPPx/N33XYjGv5tcd9Tad/Hjg2M71DmbU=;
        b=kkRGMt/y2x1HPVB4lUfo4KuASqkPvwZnVpSvGARAOeLRMEuNL9+kbmJhYsZXhfjlbT
         vg93l5F8P32wyE8XQ6p0qE5SD8+LYiFzbD5Ovx41buRr04LWu4sIek+35KBfnYarAMVN
         WO692a2sroZAS3hRy8wosGYZvlPU47rCfWb7W+i4Jw+DBGzqol83LyEE4+FdSRA/gxSI
         k2XJP0SB3Ah3me+XpgR+pkBVrWMv9GkuMgk/FCmclhzw809uhJatCfJkPf4alM1OLPXr
         11pM4PdUBwkl3Mxzmticdqu2rezSxQf3d5IN/iMFucIWLMlabSRsFFYEG0G1B0XJxyrY
         2JTg==
X-Gm-Message-State: AOAM530kYvtJkEnfEAafs2+JwjOgFj85kLp4C/wzFhn9iBWKyXwMm9c+
        GlI6rGgcy0GZeJTRpBGijn7n/ydy5WDi5A==
X-Google-Smtp-Source: ABdhPJzr4wqkX7PA6Ah8cJCZVXg4YuDFZbawH6ekrWsnHuJXPla3KNim0fsXIhyfrzZsEDCIsH0Dbw==
X-Received: by 2002:aa7:8f0d:0:b029:2f5:2b72:2388 with SMTP id x13-20020aa78f0d0000b02902f52b722388mr6061509pfr.44.1624036384683;
        Fri, 18 Jun 2021 10:13:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h20sm8005448pfh.24.2021.06.18.10.13.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:13:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix enabling temporary timer when TemporaryTimeout=0
Date:   Fri, 18 Jun 2021 10:13:01 -0700
Message-Id: <20210618171301.2285511-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When TemporaryTimeout is set to 0 it is supposed to disable the
temporary timeout so devices never desappear.

Fixes: https://github.com/bluez/bluez/issues/146
---
 src/device.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index 65838f59f..faf07ba22 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2963,6 +2963,14 @@ bool btd_device_is_connected(struct btd_device *dev)
 	return dev->bredr_state.connected || dev->le_state.connected;
 }
 
+static void clear_temporary_timer(struct btd_device *dev)
+{
+	if (dev->temporary_timer) {
+		timeout_remove(dev->temporary_timer);
+		dev->temporary_timer = 0;
+	}
+}
+
 void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
@@ -2991,10 +2999,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 		return;
 
 	/* Remove temporary timer while connected */
-	if (dev->temporary_timer) {
-		timeout_remove(dev->temporary_timer);
-		dev->temporary_timer = 0;
-	}
+	clear_temporary_timer(dev);
 
 	g_dbus_emit_property_changed(dbus_conn, dev->path, DEVICE_INTERFACE,
 								"Connected");
@@ -4280,6 +4285,17 @@ static bool device_disappeared(gpointer user_data)
 	return FALSE;
 }
 
+static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
+{
+	clear_temporary_timer(dev);
+
+	if (!timeout)
+		return;
+
+	dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
+								dev, NULL);
+}
+
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 {
 	if (bdaddr_type == BDADDR_BREDR)
@@ -4291,12 +4307,7 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 		return;
 
 	/* Restart temporary timer */
-	if (device->temporary_timer)
-		timeout_remove(device->temporary_timer);
-
-	device->temporary_timer = timeout_add_seconds(btd_opts.tmpto,
-							device_disappeared,
-							device, NULL);
+	set_temporary_timer(device, btd_opts.tmpto);
 }
 
 /* It is possible that we have two device objects for the same device in
@@ -4487,10 +4498,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		disconnect_all(device);
 	}
 
-	if (device->temporary_timer > 0) {
-		timeout_remove(device->temporary_timer);
-		device->temporary_timer = 0;
-	}
+	clear_temporary_timer(device);
 
 	if (device->store_id > 0) {
 		g_source_remove(device->store_id);
@@ -5701,11 +5709,6 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 
 	device->temporary = temporary;
 
-	if (device->temporary_timer) {
-		timeout_remove(device->temporary_timer);
-		device->temporary_timer = 0;
-	}
-
 	if (temporary) {
 		if (device->bredr)
 			adapter_whitelist_remove(device->adapter, device);
@@ -5714,11 +5717,10 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 			device->disable_auto_connect = TRUE;
 			device_set_auto_connect(device, FALSE);
 		}
-		device->temporary_timer = timeout_add_seconds(btd_opts.tmpto,
-							device_disappeared,
-							device, NULL);
+		set_temporary_timer(device, btd_opts.tmpto);
 		return;
-	}
+	} else
+		clear_temporary_timer(device);
 
 	if (device->bredr)
 		adapter_whitelist_add(device->adapter, device);
-- 
2.31.1

