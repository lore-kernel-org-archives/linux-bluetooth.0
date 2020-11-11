Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2CBC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A37F21D7F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NiV36MuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgKKAhm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgKKAhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 19:37:42 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3311C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:37:41 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so434603pfd.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NP0uXnQpDMvvvr1LzLUWVS0ENVEshMsBZYTdr7cqAbU=;
        b=NiV36MuJ/9JMcP/Xo4CI3f6OZIpuulRLrfKAbOkPzyswtnmKUOSJ6wC3UwSSnlQZfV
         YHZeLbegEB4CEkQcOGa9HesEZgCxS6+h7gM5COuZsrdca1v8cl+T9d9EYN6Z5Mrp0E+m
         c2RatK/CtVWREF3boYy91vSYAaTQxd5kYFHXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NP0uXnQpDMvvvr1LzLUWVS0ENVEshMsBZYTdr7cqAbU=;
        b=ShAkkh5DIEcbz5zquiNYMrtPP5DzIycRZRhj6KcAhVc3jnV6Y3+LjYz5EBiQLLJfnt
         3rOj374DV0duG3qbg6bUdRGWF7TLNbvItutbh2sjjyUtl3tD1jr4IB7X5PNTF+Udjqsv
         Sve2eZAxNAj3ucRdlFzYrVcvsqJb20/yg+RHShC74sy/4JkBPYdKiKQx8Z+7HMr5Yh80
         BjJS6eYaGAf24FVcfqPiR5dHHDjf0sXFBEkinjltO2OEijRmJ9VbDkjRlpEb0cke/AdE
         hPjBKUIxmYwx7v197yZ3DF8gUgSUjThDtrm1aRzzmEcrzqZUyEBvPoyPZhXcz4w/G3xG
         l9SA==
X-Gm-Message-State: AOAM530UgE0et19fEEFUZNMor4E8GjpTznJ5JWCo5mGINiaZlyPWtAwS
        VOUxqLZFSubtxg7XMMOVU7H77HhMzvMlPA==
X-Google-Smtp-Source: ABdhPJwtkCU/9xahn7aBwW1gYMpmDzAIJndlev7sqTttQO3980yS+UCaUK5+cYuunRoYV7uvKEDMrA==
X-Received: by 2002:a17:90a:f993:: with SMTP id cq19mr902483pjb.173.1605055061282;
        Tue, 10 Nov 2020 16:37:41 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id b16sm180655pju.16.2020.11.10.16.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:37:40 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ 1/7] battery: Add the internal Battery API
Date:   Tue, 10 Nov 2020 16:37:14 -0800
Message-Id: <20201111003720.1727-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111003720.1727-1-sonnysasaka@chromium.org>
References: <20201111003720.1727-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds an API for internal BlueZ code to expose battery
information to org.bluez.Battery1 interface. The motivation behind this
is that there is going to be other places than GATT BAS handler that
exposes battery information, for example internal plugins and the
BatteryProvider1 D-Bus API for external clients.

Reviewed-by: Daniel Winkler <danielwinkler@google.com>

---
 Makefile.am   |   3 +-
 src/battery.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/battery.h |  15 ++++
 3 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 src/battery.c
 create mode 100644 src/battery.h

diff --git a/Makefile.am b/Makefile.am
index 56279c4ba..b19c1d40f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -294,7 +294,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c \
-			src/adv_monitor.h src/adv_monitor.c
+			src/adv_monitor.h src/adv_monitor.c \
+			src/battery.h src/battery.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/battery.c b/src/battery.c
new file mode 100644
index 000000000..b2adf41fa
--- /dev/null
+++ b/src/battery.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Google LLC
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdint.h>
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+#include "lib/bluetooth.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "dbus-common.h"
+#include "adapter.h"
+#include "log.h"
+
+#define BATTERY_INTERFACE "org.bluez.Battery1"
+
+#define BATTERY_MAX_PERCENTAGE 100
+
+struct btd_battery {
+	char *path; /* D-Bus object path, owns pointer */
+	uint8_t percentage; /* valid between 0 to 100 inclusively */
+};
+
+static struct queue *batteries = NULL;
+
+static void battery_add(struct btd_battery *battery) {
+	if (!batteries)
+		batteries = queue_new();
+
+	queue_push_head(batteries, battery);
+}
+
+static void battery_remove(struct btd_battery *battery) {
+	queue_remove(batteries, battery);
+	if (queue_isempty(batteries)) {
+		queue_destroy(batteries, NULL);
+		batteries = NULL;
+	}
+}
+
+static bool match_path(const void *data, const void *user_data)
+{
+	const struct btd_battery *battery = data;
+	const char *path = user_data;
+
+	return g_strcmp0(battery->path, path) == 0;
+}
+
+static struct btd_battery *battery_new(const char *path)
+{
+	struct btd_battery *battery;
+
+	battery = new0(struct btd_battery, 1);
+	battery->path = g_strdup(path);
+	battery->percentage = UINT8_MAX;
+
+	return battery;
+}
+
+static void battery_free(struct btd_battery *battery)
+{
+	if (battery->path)
+		g_free(battery->path);
+
+	free(battery);
+}
+
+static gboolean property_percentage_get(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_battery *battery = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+				       &battery->percentage);
+
+	return TRUE;
+}
+
+static gboolean property_percentage_exists(const GDBusPropertyTable *property,
+					   void *data)
+{
+	struct btd_battery *battery = data;
+
+	return battery->percentage <= BATTERY_MAX_PERCENTAGE;
+}
+
+static const GDBusPropertyTable battery_properties[] = {
+	{ "Percentage", "y", property_percentage_get, NULL,
+	  property_percentage_exists },
+	{}
+};
+
+struct btd_battery *btd_battery_register(const char *path)
+{
+	struct btd_battery *battery;
+
+	DBG("path = %s", path);
+
+	if (queue_find(batteries, match_path, path)) {
+		error("error registering battery: path exists");
+		return NULL;
+	}
+
+	if (!g_str_has_prefix(path, "/")) {
+		error("error registering battery: invalid D-Bus object path");
+		return NULL;
+	}
+
+	battery = battery_new(path);
+	battery_add(battery);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), battery->path,
+				       BATTERY_INTERFACE, NULL, NULL,
+				       battery_properties, battery, NULL)) {
+		error("error registering D-Bus interface for %s",
+		      battery->path);
+
+		battery_remove(battery);
+		battery_free(battery);
+
+		return NULL;
+	}
+
+	DBG("registered Battery object: %s", battery->path);
+
+	return battery;
+}
+
+bool btd_battery_unregister(struct btd_battery *battery)
+{
+	DBG("path = %s", battery->path);
+
+	if (!queue_find(batteries, NULL, battery)) {
+		error("error unregistering battery: "
+		      "battery %s is not registered",
+		      battery->path);
+		return false;
+	}
+
+	if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
+					 battery->path, BATTERY_INTERFACE)) {
+		error("error unregistering battery %s from D-Bus interface",
+		      battery->path);
+		return false;
+	}
+
+	battery_remove(battery);
+	battery_free(battery);
+
+	return true;
+}
+
+bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
+{
+	DBG("path = %s", battery->path);
+
+	if (!queue_find(batteries, NULL, battery)) {
+		error("error updating battery: battery is not registered");
+		return false;
+	}
+
+	if (percentage > BATTERY_MAX_PERCENTAGE) {
+		error("error updating battery: percentage is not valid");
+		return false;
+	}
+
+	if (battery->percentage == percentage)
+		return true;
+
+	battery->percentage = percentage;
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), battery->path,
+				     BATTERY_INTERFACE, "Percentage");
+
+	return true;
+}
diff --git a/src/battery.h b/src/battery.h
new file mode 100644
index 000000000..9c69b7afa
--- /dev/null
+++ b/src/battery.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Google LLC
+ *
+ *
+ */
+
+struct btd_battery;
+
+struct btd_battery *btd_battery_register(const char *path);
+bool btd_battery_unregister(struct btd_battery *battery);
+bool btd_battery_update(struct btd_battery *battery, uint8_t percentage);
-- 
2.26.2

