Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C79C64E7B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A77620825
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLJBsivC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgK3UED (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgK3UED (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 15:04:03 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB7C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:23 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id t12so254162pjq.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lpY+Sh0Q2EQRKqw0QFdfTD5oYIKy1v6u1iamItNIGQ=;
        b=nLJBsivCnSzLjZhspzhcAKrNWVgajfq7BHyZ9eLOkgx2D0UViFNnLtUWoxVvW/4mP6
         pCfUJhHcEnMPvzVKqmvvyS3fOloFejp1l4FQqZw/F2/YCctTcbbIY3KpeOpp8+RQTLgt
         gL7BeCpjmylcN6+SFgv7W0gycbV8+DrrjpKnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lpY+Sh0Q2EQRKqw0QFdfTD5oYIKy1v6u1iamItNIGQ=;
        b=iZ8m92GhBlNghJ4v+MJb0IP6WDeJPkMlnp70cMlf7nIB9K8+G6A0kyLLyfRbRz/Gp0
         SDOWU756grcxee9yOk3nw1QYAhoIJpYGbpfuzFhlCmHIPrpf9qm6qAY97iXoJDgDmRfy
         2NJDh1XUosQRNm51URlRRRu4YGt0LkYiw8DLgoAg8YpjevtdVaKc0CFpwCa5EOzjydz7
         6PsIBqIQyksKx0NENKdiL7tvrscOMB7AdORQU3NcRHmaGvN3wBqP7+J8OVDqr1zBE07U
         ACggmpt4Z1AyjV8jMyjpIyhAmune0oXs5o4bm4D1h8PPasS8mNyKKtcQXIWVvxoBwp3y
         QaWg==
X-Gm-Message-State: AOAM533LjOg/zb+r47SomtZ21SMX2SVn+5GYVKvhLLZ/tyclx9eH/Gvl
        UZjj1VwzHqpWdTMA+WWaDunokOVN0YF25Q==
X-Google-Smtp-Source: ABdhPJy/bK/ll2i6XW2EwKK1wS07+jD72fttotz7A6geXYhuzc0iDlW+N90Cd/pNfpnD5ZJoyNXyfg==
X-Received: by 2002:a17:902:70cc:b029:d7:e8ad:26d4 with SMTP id l12-20020a17090270ccb02900d7e8ad26d4mr20531852plt.33.1606766601759;
        Mon, 30 Nov 2020 12:03:21 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y24sm17117184pfn.176.2020.11.30.12.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:03:21 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ v4 1/7] battery: Add the internal Battery API
Date:   Mon, 30 Nov 2020 12:03:01 -0800
Message-Id: <20201130200307.386410-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
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
 src/battery.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/battery.h |  15 ++++
 3 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 src/battery.c
 create mode 100644 src/battery.h

diff --git a/Makefile.am b/Makefile.am
index 69b95828f..95917f695 100644
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
index 000000000..87a6b91fb
--- /dev/null
+++ b/src/battery.c
@@ -0,0 +1,191 @@
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
+#include "battery.h"
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
+static void battery_add(struct btd_battery *battery)
+{
+	if (!batteries)
+		batteries = queue_new();
+
+	queue_push_head(batteries, battery);
+}
+
+static void battery_remove(struct btd_battery *battery)
+{
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

