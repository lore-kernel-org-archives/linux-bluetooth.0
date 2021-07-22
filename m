Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F17C63799
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A273E60551
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGVGn5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhGVGnv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:51 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27BFC06179C
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:55 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id eo14-20020ad4594e0000b02902fc3fd31414so3174573qvb.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nr7d5kbdJgplVMKnxiv3ENfoURCVEJT+N1sNUQI5FVE=;
        b=CqR6KTfvGq5czm54ovQsXwtakNlwTB5Wi5bVSaZz5x1YqomXRl7YtQCV7w8m4RRoeg
         9WZTZDqydjNJF7EUeGLLMLENGMptE6efyu1tWvmPZGtQAzU4Pg/XBkFB70qQTHKZcaNk
         YOVBZ6Vpnt7OoqnHhrw+xu8Z3mmCjQ8DymvyLRnwitgWKrLKvPIPT1nxcQdHe41lgm2k
         tLSjDWLA3GFMwfgC6vAwKGkMOFI7WXC1Jz8R8c6oijc5yLniWHQDj7q0RAl3L9hrOlfr
         uwxpWDUFjOsQO9Nl8EN235a0cxWhHxp8D7c9/DtnbL+fk8gfRSFOnvSN5yi0OEHKw4Yj
         is+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nr7d5kbdJgplVMKnxiv3ENfoURCVEJT+N1sNUQI5FVE=;
        b=quBKoqH/hGJ1OS+cNJ39sbq6u1w+2GsOK+R6IOhk9K2VHTqYo3Uag/DAmigIeT8AIS
         dFcNtDJus3vSGxKPvoqPidGZwLN5VvRY2uKLbmxlJrFRWpucbYVJOAuf1Tp8dwiJzLvU
         EnAP8vHa0ZhRL3BcjPKRf2dnYt54dbehlT5sawc8rnGowyr2v2xNJSgWaPIL8kWPVMgg
         I6j48E+c12feS+QTMAZGml2mJgWe+WzBjQh0/aaoasPgRcV6HMWrsQ9cWDgTvtQ8vw+L
         ap4yVKL79EVUtqZjVrZDgkun72oYHbAY5yT+B7gTULVYLN+nQClAyj4IFzNvqWF5zNmM
         X0rA==
X-Gm-Message-State: AOAM532emDExsW9dWbYTM9G99VSwRIjS3uFgWGLNwSZwwEe+nROoM7li
        fddvlfVnYaqpUNsC4MnXBmTbFSh2wc7vqElH/MAqdItgkrU1T1dPtXFKJZMWCDyGVaw7JC3tcYH
        qujHEPW57USic0W858MIO4pKwgCPSiUrVAM98ivrnCFbUZ5aZUODaTBxMWHTiUXX5TmluxQD1tj
        Pb4SNQZgds1xs=
X-Google-Smtp-Source: ABdhPJzBzG7MKa2SFYt+maT59CwMSgbzi44V/S3TiQUd6BY3gcatg5ZU4nJUbEqYaXAdp7Q/Mfbnzny0mmOR0QxM8Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a0c:f850:: with SMTP id
 g16mr39589670qvo.5.1626938634690; Thu, 22 Jul 2021 00:23:54 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:18 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.8.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 08/11] plugins/admin_policy: listen for device add
 and remove
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds an D-BUS client to listen for DeviceAdd and DeviceRemove. It
is necessary for implementation of "AffectedByPolicy" property since it
needs to register an interface for each device object and unregister it
once the device gets removed.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. start discovery using UI
2. verify device_data were added by checking system log
3. stop discovery
4. verify device_data were removed after a few seconds by checking
system log

(no changes since v1)

 plugins/admin_policy.c | 154 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 150 insertions(+), 4 deletions(-)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 270d42366cd6..73d695ef976b 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -20,6 +20,7 @@
 
 #include "src/adapter.h"
 #include "src/dbus-common.h"
+#include "src/device.h"
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
@@ -29,7 +30,12 @@
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
 #define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
 
+#define DBUS_BLUEZ_SERVICE		"org.bluez"
+#define BTD_DEVICE_INTERFACE		"org.bluez.Device1"
+
 static DBusConnection *dbus_conn;
+static GDBusClient *dbus_client;
+static struct queue *devices; /* List of struct device_data objects */
 
 /* |policy_data| has the same life cycle as btd_adapter */
 static struct btd_admin_policy {
@@ -38,6 +44,11 @@ static struct btd_admin_policy {
 	struct queue *service_allowlist;
 } *policy_data = NULL;
 
+struct device_data {
+	struct btd_device *device;
+	char *path;
+};
+
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 {
 	struct btd_admin_policy *admin_policy = NULL;
@@ -203,8 +214,122 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
 	{ }
 };
 
+static bool device_data_match(const void *a, const void *b)
+{
+	const struct device_data *data = a;
+	const struct btd_device *dev = b;
+
+	if (!data) {
+		error("Unexpected NULL device_data");
+		return false;
+	}
+
+	return data->device == dev;
+}
+
+static bool device_data_match_by_path(const void *a, const void *b)
+{
+	const struct device_data *data = a;
+	const char *path = b;
+
+	if (!data) {
+		error("Unexpected NULL device_data");
+		return false;
+	}
+
+	return strcmp(data->path, b) == 0;
+}
+
+static void free_device_data(void *data)
+{
+	struct device_data *device_data = data;
+
+	g_free(device_data->path);
+	g_free(device_data);
+}
+
+static void remove_device_data(void *data)
+{
+	struct device_data *device_data = data;
+
+	DBG("device_data for %s removing", device_data->path);
+
+	queue_remove(devices, device_data);
+	free_device_data(device_data);
+}
+
+static void add_device_data(struct btd_device *device)
+{
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct device_data *data;
+
+	if (queue_find(devices, device_data_match, device))
+		return;
+
+	data = g_new0(struct device_data, 1);
+	if (!data) {
+		btd_error(btd_adapter_get_index(adapter),
+				"Failed to allocate memory for device_data");
+		return;
+	}
+
+	data->device = device;
+	data->path = g_strdup(device_get_path(device));
+	queue_push_tail(devices, data);
+
+	DBG("device_data for %s added", data->path);
+}
+
+static struct btd_device *find_device_by_proxy(GDBusProxy *proxy)
+{
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	struct btd_device *device;
+
+	if (strcmp(iface, BTD_DEVICE_INTERFACE) != 0)
+		return NULL;
+
+	device = btd_adapter_find_device_by_path(policy_data->adapter, path);
+
+	if (!device) {
+		btd_warn(adapter_get_path(policy_data->adapter),
+					"Device path %s is not found", path);
+	}
+
+	return device;
+}
+
+static void object_added_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct btd_device *device;
+
+	device = find_device_by_proxy(proxy);
+
+	if (!device)
+		return;
+
+	add_device_data(device);
+}
+
+static void object_removed_cb(GDBusProxy *proxy, void *user_data)
+{
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	struct device_data *data;
+
+	if (strcmp(iface, BTD_DEVICE_INTERFACE) != 0)
+		return;
+
+	data = queue_find(devices, device_data_match_by_path, path);
+
+	if (data)
+		remove_device_data(data);
+}
+
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
+	const char *adapter_path;
+
 	if (policy_data) {
 		btd_warn(policy_data->adapter_id,
 						"Policy data already exists");
@@ -216,33 +341,43 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!policy_data)
 		return -ENOMEM;
 
-	if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
+	adapter_path = adapter_get_path(adapter);
+
+	if (!g_dbus_register_interface(dbus_conn, adapter_path,
 					ADMIN_POLICY_SET_INTERFACE,
 					admin_policy_adapter_methods, NULL,
 					NULL, policy_data, admin_policy_free)) {
 		btd_error(policy_data->adapter_id,
 			"Admin Policy Set interface init failed on path %s",
-						adapter_get_path(adapter));
+								adapter_path);
 		return -EINVAL;
 	}
 
 	btd_info(policy_data->adapter_id,
 				"Admin Policy Set interface registered");
 
-	if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
+	if (!g_dbus_register_interface(dbus_conn, adapter_path,
 					ADMIN_POLICY_STATUS_INTERFACE,
 					NULL, NULL,
 					admin_policy_adapter_properties,
 					policy_data, admin_policy_free)) {
 		btd_error(policy_data->adapter_id,
 			"Admin Policy Status interface init failed on path %s",
-						adapter_get_path(adapter));
+								adapter_path);
 		return -EINVAL;
 	}
 
 	btd_info(policy_data->adapter_id,
 				"Admin Policy Status interface registered");
 
+	dbus_client = g_dbus_client_new(dbus_conn, DBUS_BLUEZ_SERVICE,
+								adapter_path);
+
+	g_dbus_client_set_proxy_handlers(dbus_client, object_added_cb,
+						object_removed_cb, NULL, NULL);
+
+	g_dbus_client_set_ready_watch(dbus_client, NULL, NULL);
+
 	return 0;
 }
 
@@ -257,6 +392,7 @@ static int admin_policy_init(void)
 	DBG("");
 
 	dbus_conn = btd_get_dbus_connection();
+	devices = queue_new();
 
 	return btd_register_adapter_driver(&admin_policy_driver);
 }
@@ -266,9 +402,19 @@ static void admin_policy_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
+	queue_destroy(devices, free_device_data);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
+
+	if (dbus_client) {
+		g_dbus_client_set_disconnect_watch(dbus_client, NULL, NULL);
+		g_dbus_client_set_proxy_handlers(dbus_client, NULL, NULL, NULL,
+									NULL);
+		g_dbus_client_set_ready_watch(dbus_client, NULL, NULL);
+		g_dbus_client_unref(dbus_client);
+		dbus_client = NULL;
+	}
 }
 
 BLUETOOTH_PLUGIN_DEFINE(admin_policy, VERSION,
-- 
2.32.0.402.g57bb445576-goog

