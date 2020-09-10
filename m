Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA64BC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E678208A9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ja9giBZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIJXRK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:17:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D300BC061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:17:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s65so4123536pgb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqPIB5nqb0Ac+Qss3diCOrBXw8J/be3CkEyRsnuvTz4=;
        b=ja9giBZDpeA4DNIIwPPcsfo2hPRecx7vem9YbG1ceuKuaHdueteUwPxw7+ExfBqTcY
         FWzij1hpAbLyqpPR4WB//ed0/wAfeYrOUHUMHbGHuLjTgDa94AR2/FSq5Ai4WtT5CgKR
         jX77TtuIvKsM5ZTex1ZlvlIIrWBXbQROH/zqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqPIB5nqb0Ac+Qss3diCOrBXw8J/be3CkEyRsnuvTz4=;
        b=SoH8p2f0nSHP61atepjrRHL7Qpu7LNLZgqOepGwXDGkibbQ2icxin0r+k0I/mGlc2i
         Ge9NL+kTT2Q7TdBqwoNngXbyCQVJYNVx4i+jEa81qZAmAu7PyQrdL4Z2Ip6nbq44s6bN
         K0VeorgLVBmsoqUwChToUsm1JvQJRWRsoeW5g8a9ZtBFiAoKJk5+9YkGzmZcbUWUMJX2
         9yb/fIyLsGwgHkAu5DFKvGJ60iCmLeScwghPK1nOJtib8nTm1AHAJObz4Chp+nZagiu8
         rKSPYyzi7hu8n41IibRN4MgZeOaNouwHPt5USKr8CyNAX2Xi5KQtDDaxdE++EnQSDXk/
         +eDQ==
X-Gm-Message-State: AOAM533q6v1391bqUH0+9rwe2hIwHjFJ0rYRDfY6o+OUpQw3Q/m61KyX
        qLubXp55RLsLGeMfCG+hSlzA42ziYcScWg==
X-Google-Smtp-Source: ABdhPJzY3B2TV0SuF9CNu2GfnNEbYepbDHG2Q6uptZdrSQf/7bYhvQMznDxc7MTpVOGxe/g6qmRdgA==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr7434236pfr.96.1599779824476;
        Thu, 10 Sep 2020 16:17:04 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k29sm76790pgf.21.2020.09.10.16.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 16:17:03 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 4/8] adv_monitor: Implement RegisterMonitor()
Date:   Thu, 10 Sep 2020 16:15:48 -0700
Message-Id: <20200910161528.BlueZ.v4.4.I19ff9cdbd40fe453db0e81aec8bf94dd9490dce3@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the RegisterMonitor() method handler of ADV monitor
manager interface.

The following tests were performed.
- Issue a RegisterMonitor() call with a valid path and expect a
success as return.
- Issue a RegisterMonitor() call with an invalid path and expect
org.bluez.Error.InvalidArguments as return.
- Issue two Registermonitor() calls with the same path and expect
org.bluez.Error.AlreadyExists.
- Verify the values of the registered paths with logging.
- Verify D-Bus disconnection callback was triggered when the client detach
from D-Bus.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v2)

Changes in v2:
- Use new0() instead of g_new0()
- Remove the reset of app members

 src/adv_monitor.c | 165 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index fc37b0145..abc1bf228 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -22,7 +22,9 @@
 #endif
 
 #define _GNU_SOURCE
+#include <errno.h>
 #include <stdint.h>
+#include <string.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -34,7 +36,9 @@
 #include "adapter.h"
 #include "dbus-common.h"
 #include "log.h"
+#include "src/error.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
 #include "src/shared/util.h"
 
 #include "adv_monitor.h"
@@ -50,12 +54,168 @@ struct btd_adv_monitor_manager {
 	uint32_t enabled_features;	/* MGMT_ADV_MONITOR_FEATURE_MASK_* */
 	uint16_t max_num_monitors;
 	uint8_t max_num_patterns;
+
+	struct queue *apps;	/* apps who registered for Adv monitoring */
+};
+
+struct adv_monitor_app {
+	struct btd_adv_monitor_manager *manager;
+	char *owner;
+	char *path;
+
+	DBusMessage *reg;
+	GDBusClient *client;
 };
 
+struct app_match_data {
+	const char *owner;
+	const char *path;
+};
+
+/* Replies to an app's D-Bus message and unref it */
+static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
+{
+	if (!app || !app->reg || !reply)
+		return;
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(app->reg);
+	app->reg = NULL;
+}
+
+/* Destroys an app object along with related D-Bus handlers */
+static void app_destroy(void *data)
+{
+	struct adv_monitor_app *app = data;
+
+	if (!app)
+		return;
+
+	DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->path);
+
+	if (app->reg) {
+		app_reply_msg(app, btd_error_failed(app->reg,
+						"Adv Monitor app destroyed"));
+	}
+
+	if (app->client) {
+		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
+		g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL,
+							NULL);
+		g_dbus_client_set_ready_watch(app->client, NULL, NULL);
+		g_dbus_client_unref(app->client);
+	}
+
+	g_free(app->owner);
+	g_free(app->path);
+
+	free(app);
+}
+
+/* Handles a D-Bus disconnection event of an app */
+static void app_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct adv_monitor_app *app = user_data;
+
+	btd_info(app->manager->adapter_id, "Adv Monitor app %s disconnected "
+			"from D-Bus", app->owner);
+	if (app && queue_remove(app->manager->apps, app))
+		app_destroy(app);
+}
+
+/* Creates an app object, initiates it and sets D-Bus event handlers */
+static struct adv_monitor_app *app_create(DBusConnection *conn,
+					const char *sender, const char *path,
+					struct btd_adv_monitor_manager *manager)
+{
+	struct adv_monitor_app *app;
+
+	if (!path || !sender || !manager)
+		return NULL;
+
+	app = new0(struct adv_monitor_app, 1);
+	if (!app)
+		return NULL;
+
+	app->owner = g_strdup(sender);
+	app->path = g_strdup(path);
+	app->manager = manager;
+	app->reg = NULL;
+
+	app->client = g_dbus_client_new(conn, sender, path);
+	if (!app->client) {
+		app_destroy(app);
+		return NULL;
+	}
+
+	g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
+	g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
+	g_dbus_client_set_ready_watch(app->client, NULL, NULL);
+
+	return app;
+}
+
+/* Matches an app based on its owner and path */
+static bool app_match(const void *a, const void *b)
+{
+	const struct adv_monitor_app *app = a;
+	const struct app_match_data *match = b;
+
+	if (match->owner && strcmp(app->owner, match->owner))
+		return false;
+
+	if (match->path && strcmp(app->path, match->path))
+		return false;
+
+	return true;
+}
+
+/* Handles a RegisterMonitor D-Bus call */
+static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
+					void *user_data)
+{
+	DBusMessageIter args;
+	struct app_match_data match;
+	struct adv_monitor_app *app;
+	struct btd_adv_monitor_manager *manager = user_data;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &match.path);
+
+	if (!strlen(match.path) || !g_str_has_prefix(match.path, "/"))
+		return btd_error_invalid_args(msg);
+
+	match.owner = dbus_message_get_sender(msg);
+
+	if (queue_find(manager->apps, app_match, &match))
+		return btd_error_already_exists(msg);
+
+	app = app_create(conn, match.owner, match.path, manager);
+	if (!app) {
+		btd_error(manager->adapter_id,
+				"Failed to reserve %s for Adv Monitor app %s",
+				match.path, match.owner);
+		return btd_error_failed(msg,
+					"Failed to create Adv Monitor app");
+	}
+
+	queue_push_tail(manager->apps, app);
+
+	btd_info(manager->adapter_id, "Path %s reserved for Adv Monitor app %s",
+			match.path, match.owner);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adv_monitor_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
-					NULL, NULL) },
+					NULL, register_monitor) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, NULL) },
@@ -155,6 +315,7 @@ static struct btd_adv_monitor_manager *manager_new(
 	manager->adapter = adapter;
 	manager->mgmt = mgmt_ref(mgmt);
 	manager->adapter_id = btd_adapter_get_index(adapter);
+	manager->apps = queue_new();
 
 	return manager;
 }
@@ -164,6 +325,8 @@ static void manager_free(struct btd_adv_monitor_manager *manager)
 {
 	mgmt_unref(manager->mgmt);
 
+	queue_destroy(manager->apps, app_destroy);
+
 	free(manager);
 }
 
-- 
2.26.2

