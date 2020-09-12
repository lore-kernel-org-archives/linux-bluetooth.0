Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62EAC433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9595721734
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRvq+xze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgILGwg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgILGwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:52:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C4C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:52:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kk9so2733111pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NscPETvDxS800m3xtngM2kzXRvW04Lroe1FFyy7LBW0=;
        b=hRvq+xze8IMPfZMNAW8A7fDQtMTUHYZGyAgJmu3NOh2Ihcr9wCkM9wFSAeSyxK0JcG
         /SP6956u19NGvqLfNH4Ek1QFCmm6rYQ3LfsyD2GQKPI58JAHHG1ikexP6qTzxrSEgBE1
         PudIj0YQGUAgzl1UtBnOcurA5XFKf5Mu/K3fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NscPETvDxS800m3xtngM2kzXRvW04Lroe1FFyy7LBW0=;
        b=IqkR3Gn5KyTRy0KfaUkssPrbU9Y6w09AWrv3FSxIlqVR5ahQlYUtK6cr+5GcjJgzwk
         kNxvO9kZuh8Fwn1EFv+Ge8TZZ0AifTda0YqbEnZcznrKaWnfuxXFPpZ6xDvdbvvJtkgB
         FtmP2a1S6GF8WZigjYQtLkfmqEzwLJgsbglVs+a4kC9teci1lLUFf28Nez+EOwfteofl
         3kj5qNSAvrCcixDOoYOJYYkXQ7Ji7zOh3yICXeVlE0zLgtXiuDNCZC2OV8+wjaorI2iF
         wPtcEmeN5jYPZJ+rA949UphQpOTt6xW6ySUTSpdwXacVt+FjX5QytA7V764k+dq5yu6m
         rIlA==
X-Gm-Message-State: AOAM530mZKozB3Wk2NWMEa4VYC6IZ/t6PTTNMWapD4mvKABFYuhbvf0W
        zY2k+QhgfXNcmRF8NHkO3PNMXuoYXwGXMQ==
X-Google-Smtp-Source: ABdhPJzeESfe7REojwZehpK9CCbJZ6vLan84u9Sgv9/Wcx8jWQtQeTaqJefsQQFrp9/LlKZRnk/BOA==
X-Received: by 2002:a17:90b:905:: with SMTP id bo5mr4730756pjb.73.1599893552246;
        Fri, 11 Sep 2020 23:52:32 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id hg16sm3440913pjb.37.2020.09.11.23.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:52:31 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 4/8] adv_monitor: Implement RegisterMonitor()
Date:   Fri, 11 Sep 2020 23:51:25 -0700
Message-Id: <20200911235104.BlueZ.v5.4.I19ff9cdbd40fe453db0e81aec8bf94dd9490dce3@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
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
index 48aa6838d..b9bffe9ba 100644
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
@@ -154,6 +314,7 @@ static struct btd_adv_monitor_manager *manager_new(
 	manager->adapter = adapter;
 	manager->mgmt = mgmt_ref(mgmt);
 	manager->adapter_id = btd_adapter_get_index(adapter);
+	manager->apps = queue_new();
 
 	return manager;
 }
@@ -163,6 +324,8 @@ static void manager_free(struct btd_adv_monitor_manager *manager)
 {
 	mgmt_unref(manager->mgmt);
 
+	queue_destroy(manager->apps, app_destroy);
+
 	free(manager);
 }
 
-- 
2.26.2

