Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B251AC7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 07:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjE1HpC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1HpA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 03:45:00 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A40BB
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 00:44:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso23337041fa.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685259897; x=1687851897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y15RVRYEyOjh/hOanbFuUr7VWzBxIA9q/UDiR7bVvhg=;
        b=dhTTyJ2sNYoGUBz9xsH1RfMLtbNf2lkNKLub6p5O+UDo/ib8XZ08Q94BeljVKZ5ZAo
         jrAKd+tETKejUWSIyPYIajMl5jdBMtT9FWuUDytFKQquB8miL72ngp2bnEpgWrb1yDlu
         GCVkf0wxer3YO1Czf1IYUFyXf4KM3nyJ1i7WZPGNaKzIAMObuDofKqSS1FnAzXYyLp0/
         YjJgNN2F/BXr6taoixsduAeFRw+A70t5AnoUWftb3xeMojAca0XSugT/uCdbbOMTdZ6G
         Ek7Oq2j5nb0kNdFbL3FVAdj6EVjZ/Ov64wfuWeN0y8tRri+2WXh1RVDxiSuuou3EMJpV
         uDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685259897; x=1687851897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y15RVRYEyOjh/hOanbFuUr7VWzBxIA9q/UDiR7bVvhg=;
        b=JYgokR3g3dbUaferI/CQdTz+nrPX7WiPXUxiMf/bHK9/YXDqXhgsxMyV/6QmIvKVNg
         tg8FNsTZH4XSYTaCTwS7NLErBJP5zJ1HsKyV5byR8TNx14/eOcR/n+y6VwoUYGyfAvpM
         MXrPVujDBkUeBDA61hS/ZF+cL4QxNKie/S9gh/uSi6n+CzszSmB5KFxwKS4jYWpLRamr
         QB5ydgOJ0kqKbxU9Wv+D1WRZMTwHfkSTTEHBzDixFGcsi/GIqSUDQeSIKC4Mts2hBQhw
         eU4uFw+WEyKETjAV39kIf+vlPZMLp/M+PcgX6eIg2/UPGGgLDzqL6vrPkJzyWMqUgdtg
         6/Sw==
X-Gm-Message-State: AC+VfDyTqSYKQanG91cTxPezoQEH1D6GIYXHFj9PCkWUd4fzxj0+vE2N
        npDQWVIZg8mH67JtqikB/FIRoQNCc4hZBQ==
X-Google-Smtp-Source: ACHHUZ4Ka/b3Iv5pTKLfhgz8uGozafl3dQGpasGzpn1E2gQWyRpNVM8m37efGdfUB+CUfJKqK14l6Q==
X-Received: by 2002:a2e:9c4c:0:b0:2b0:790e:95ab with SMTP id t12-20020a2e9c4c000000b002b0790e95abmr1000591ljj.31.1685259897267;
        Sun, 28 May 2023 00:44:57 -0700 (PDT)
Received: from localhost.localdomain (188.146.125.123.nat.umts.dynamic.t-mobile.pl. [188.146.125.123])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e9f4b000000b002af25598ef9sm1849095ljk.0.2023.05.28.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 00:44:56 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] battery: Check interface before getting property
Date:   Sun, 28 May 2023 09:44:45 +0200
Message-Id: <20230528074445.694554-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Client can export other interfaces than the BatteryProvide1 on the
registered object manager. So, before getting battery provider specific
property, validate that we are operating on the right interface.

This change will allow client to implement only one object manger for
media applications, players and battery providers without triggering
error message.
---
 src/battery.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/battery.c b/src/battery.c
index 88a53e80e..5c52581f3 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -288,6 +288,10 @@ static void provided_battery_added_cb(GDBusProxy *proxy, void *user_data)
 	uint8_t percentage;
 	DBusMessageIter iter;
 
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   BATTERY_PROVIDER_INTERFACE) != 0)
+		return;
+
 	if (g_dbus_proxy_get_property(proxy, "Device", &iter) == FALSE) {
 		warn("Battery object %s does not specify device path", path);
 		return;
@@ -295,10 +299,6 @@ static void provided_battery_added_cb(GDBusProxy *proxy, void *user_data)
 
 	dbus_message_iter_get_basic(&iter, &export_path);
 
-	if (strcmp(g_dbus_proxy_get_interface(proxy),
-		   BATTERY_PROVIDER_INTERFACE) != 0)
-		return;
-
 	device = btd_adapter_find_device_by_path(provider->manager->adapter,
 						 export_path);
 	if (!device || device_is_temporary(device)) {
@@ -341,15 +341,15 @@ static void provided_battery_removed_cb(GDBusProxy *proxy, void *user_data)
 	const char *export_path;
 	DBusMessageIter iter;
 
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   BATTERY_PROVIDER_INTERFACE) != 0)
+		return;
+
 	if (g_dbus_proxy_get_property(proxy, "Device", &iter) == FALSE)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &export_path);
 
-	if (strcmp(g_dbus_proxy_get_interface(proxy),
-		   BATTERY_PROVIDER_INTERFACE) != 0)
-		return;
-
 	DBG("provided battery removed %s", g_dbus_proxy_get_path(proxy));
 
 	battery = find_battery_by_path(export_path);
-- 
2.30.2

