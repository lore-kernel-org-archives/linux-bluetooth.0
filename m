Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3AEC63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC49F20857
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AC36CpPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgK3V46 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgK3V46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 16:56:58 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06027C0613D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:56:18 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b23so7253684pls.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTvIzX7GCozO99X7SEFRSY0nTaCgNWs0wH/hjeI4kek=;
        b=AC36CpPCi6wHm4Vt2I0+P1+I073aplIcuATbV3ROkK/y5tOUcRyKFqHzD5KQYbzxWS
         5UbnoesDAskOgeCsOtIb8IPDFRYrh6LBs0nmNKUf55yAc+rMA5VVsAZfg9EtXjyKhT/i
         TLA7ANk6TWtoMkh5UlrV8SXKHPAXH6tHLk2oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTvIzX7GCozO99X7SEFRSY0nTaCgNWs0wH/hjeI4kek=;
        b=mkpb/PiHtJJmvyzbD4noxCSr5xMZOhdI34fcywGr2tDqCEVXkVk+rPFY0c2BEL1gTP
         iqKLAyjJaVrnoAw+DDMUeqbiaaUbnZjlzVD/7d3Ih1YRziMWPifGonie8t7w20ANp7lO
         PlgfdhbPwxD0c6Q0FWTvVV5k3gCb0qDnyOzViyGiuMCYiZVlbBUOUjQBLESxSDKH1m/L
         PlUwhxcJBHFkA+z58qnxAKbw6ly/WmYXZpzDk1H5A4J6t5TTewP3NZJ/zy3KXnVYgNLb
         l95hUp2SFG3y4EkSWc4zpPsPd6aFNzqyniitma2Y3sU/iDGYpsbD0VHcMjjT8eu4K0ME
         DzXA==
X-Gm-Message-State: AOAM5326qvmTzxvS6gopiN4tTUf1tYu3u20TuMYTuQ4w0LsHY39UD32w
        DiLVPrVyF+eknqqSxZ/RuxPHzSRagquEXg==
X-Google-Smtp-Source: ABdhPJxtnmZpMv6zkXuft7WyDBZTjWs+XdNxx6rX0imgHttcvcZP+N0Qa2BciVEEGBkovOQxk1GHog==
X-Received: by 2002:a17:90a:4dc8:: with SMTP id r8mr982249pjl.1.1606773377249;
        Mon, 30 Nov 2020 13:56:17 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 23sm17476588pfx.210.2020.11.30.13.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:56:16 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ v5 2/7] profiles/battery: Refactor to use battery library
Date:   Mon, 30 Nov 2020 13:55:57 -0800
Message-Id: <20201130215602.386545-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130215602.386545-1-sonnysasaka@chromium.org>
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This refactors profiles/battery to use the internal battery library that
handles the D-Bus intricacies so that profiles/battery only handles the
GATT BAS concerns.

Reviewed-by: Daniel Winkler <danielwinkler@google.com>

---
 profiles/battery/battery.c | 51 +++++++++++---------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 13c80d05c..e1a61dd0b 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -23,14 +23,11 @@
 
 #include <glib.h>
 
-#include "gdbus/gdbus.h"
-
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
 
-#include "src/dbus-common.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
@@ -42,6 +39,7 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/log.h"
+#include "src/battery.h"
 #include "attrib/att.h"
 
 #define BATTERY_INTERFACE "org.bluez.Battery1"
@@ -50,7 +48,7 @@
 
 /* Generic Attribute/Access Service */
 struct batt {
-	char *path; /* D-Bus path of device */
+	struct btd_battery *battery;
 	struct btd_device *device;
 	struct gatt_db *db;
 	struct bt_gatt_client *client;
@@ -69,6 +67,8 @@ static void batt_free(struct batt *batt)
 	bt_gatt_client_unref(batt->client);
 	btd_device_unref(batt->device);
 	g_free (batt->initial_value);
+	if (batt->battery)
+		btd_battery_unregister(batt->battery);
 	g_free(batt);
 }
 
@@ -81,11 +81,9 @@ static void batt_reset(struct batt *batt)
 	batt->client = NULL;
 	g_free (batt->initial_value);
 	batt->initial_value = NULL;
-	if (batt->path) {
-		g_dbus_unregister_interface(btd_get_dbus_connection(),
-					    batt->path, BATTERY_INTERFACE);
-		g_free(batt->path);
-		batt->path = NULL;
+	if (batt->battery) {
+		btd_battery_unregister(batt->battery);
+		batt->battery = NULL;
 	}
 }
 
@@ -98,8 +96,11 @@ static void parse_battery_level(struct batt *batt,
 	if (batt->percentage != percentage) {
 		batt->percentage = percentage;
 		DBG("Battery Level updated: %d%%", percentage);
-		g_dbus_emit_property_changed(btd_get_dbus_connection(), batt->path,
-						BATTERY_INTERFACE, "Percentage");
+		if (!batt->battery) {
+			warn("Trying to update an unregistered battery");
+			return;
+		}
+		btd_battery_update(batt->battery, batt->percentage);
 	}
 }
 
@@ -115,22 +116,6 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
 	}
 }
 
-static gboolean property_get_percentage(
-					const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct batt *batt = data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &batt->percentage);
-
-	return TRUE;
-}
-
-static const GDBusPropertyTable battery_properties[] = {
-	{ "Percentage", "y", property_get_percentage },
-	{ }
-};
-
 static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 {
 	struct batt *batt = user_data;
@@ -141,13 +126,9 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 		return;
 	}
 
-	if (g_dbus_register_interface(btd_get_dbus_connection(),
-					batt->path, BATTERY_INTERFACE,
-					NULL, NULL,
-					battery_properties, batt,
-					NULL) == FALSE) {
-		error("Unable to register %s interface for %s",
-			BATTERY_INTERFACE, batt->path);
+	batt->battery = btd_battery_register(device_get_path(batt->device));
+
+	if (!batt->battery) {
 		batt_reset(batt);
 		return;
 	}
@@ -321,8 +302,6 @@ static int batt_accept(struct btd_service *service)
 		return -1;
 	}
 
-	batt->path = g_strdup (device_get_path(device));
-
 	btd_service_connecting_complete(service, 0);
 
 	return 0;
-- 
2.26.2

