Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE2C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE2020679
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4/YBZI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgKKAho (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgKKAho (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 19:37:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37321C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:37:43 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so414347pfq.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTvIzX7GCozO99X7SEFRSY0nTaCgNWs0wH/hjeI4kek=;
        b=f4/YBZI+DKZ1ZvVbh2YioWA7eoFuzLLiumXIJEUb+VNO0KmeCkEFJC1ClO4esW8F6V
         VdUUKZEqdwnmq7SlGYEw17Psc4sXExfGnlFr6/Hz3iSWGYdGGwqq9yjUALUgz6ngIJx5
         i8EZsf9j1wGSiZkaZ7a5My9ZK6ECbHB1q7JLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTvIzX7GCozO99X7SEFRSY0nTaCgNWs0wH/hjeI4kek=;
        b=iatVJtVU4zi1mcl7u8tr0WTvJ9/eYQyGs2ixUOMqYgX+4RUW5WFfxSe/kxqr+rlqSx
         Es1yBwQdCLuZuVGB+kv43raDkgUn4Ff7QoStZisglNrcqRUxNkdarwmk5iEO3j1N8O82
         eE4VDXP+9ku4tqKA+z/PxlhxUagOkSVbpCLc4P5vCkTGKBCqhYhxZYmOo5zMk406Io7D
         0C4E73V/Y6j5gQpjJo97fhYn1cFPpPs25sbcp7gT5SRILzJccEC8WeEQaJAFdqUruZm6
         vndmlStP4Z/Mpc5WFYbwtZz3JG0Xvh7p0iRuG1zKimqKdLD/BD0c338dbYN7CMGhMTeS
         LVVw==
X-Gm-Message-State: AOAM533e8n3DWCTLrQrfdXmKzqBgbIaOv0sF5i2PHvyEBIa0gf81FqZb
        IPKjnAYrhzaVb29oBTlqqm74XSqTHgCvOA==
X-Google-Smtp-Source: ABdhPJyZcybGsuHrZWKO7UAlCGGo6JmXnVqpoND0v0KQkxQpKkRSWeQHGzPZ2QP2YxMuq8ZsDG4M0A==
X-Received: by 2002:a17:90a:aa09:: with SMTP id k9mr980019pjq.190.1605055062596;
        Tue, 10 Nov 2020 16:37:42 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id b16sm180655pju.16.2020.11.10.16.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:37:41 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ 2/7] profiles/battery: Refactor to use battery library
Date:   Tue, 10 Nov 2020 16:37:15 -0800
Message-Id: <20201111003720.1727-3-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111003720.1727-1-sonnysasaka@chromium.org>
References: <20201111003720.1727-1-sonnysasaka@chromium.org>
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

