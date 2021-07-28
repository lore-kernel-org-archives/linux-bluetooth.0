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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB396101B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhG1NQe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhG1NQd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:33 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044EC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f1-20020a17090a8e81b029017720af1cf6so2887615pjo.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sf2hFRH9KhY9MANhWW43U1DGfmGMe8ygbazwQW1fTsg=;
        b=bkffiG0dBy8I4LTd7imBfR4P/LkvNAxjP2G+UfDwly5UhLlqMR+lEFv0RfjURrxOZB
         +wkdVDA2FOMT3GdMyhBzGUgT1wSQ5K+ETMul+1mM+EdjelO2d1kurX4x/EmVKPBj69q2
         QPnD+kXiqJ4jyTkl2y8iZxH60pwZUUfF0cvSqJm+OJBIkCvnmAiZI9+kd3hhGS/cAfzj
         Xk3uCXAfP6CwAIOl+WacOwd8kT18K7X2WKbzKShSHnoee6cx+7pqp7PuTbopSq19GAFS
         7VOfP38kEcUr3hUKr2FePIfJsF6wkpC4w9d3+BRrW8Tz2IIOGg4ynl7uGTFYLjwXJ3E+
         CqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sf2hFRH9KhY9MANhWW43U1DGfmGMe8ygbazwQW1fTsg=;
        b=U06GpnzXvaGbfBpL4bAs534OC8Ad3s0Zl1Cv16t2U1HvY3LSiGdsPDECKQFtRLJFgf
         k+2qmlyrgdJrmzWj4zRsCnJjx8hS2kT5bJ1DHRqR1m0GZqUuca9rZ1kiW7fITvO3vdCe
         MDaVAh+680PzzJCHKlyJ3Au//+65/P1zdscoya/8QgIWbQe+Ud522gcQ9XcWgT4XmBJS
         A/Zxy/Kp3DhyEcJQV86PpHkKqO71s7/oXC2cGfLBLQx4PrDL1W/SxClYT2DpGy48Ttul
         kpagP0JCwGbfmPOK7yuMRh0g1oOSm1f/9R/BeUimcs41jA1w3oJAypRNf/HrKNyS15TI
         f8eQ==
X-Gm-Message-State: AOAM5325GQw4fVzfsFYQF7UsqqlCfqxNQ0XrBbQ3Ek7+emZZUquvY4Z/
        rf6rQI0fVA6NLDfLltrIJpe6ZLUtpFYrp2MtaOGnO8IkWb0Wb/mcX+AgT47mK/fTnLgXso7/k4P
        SPILsTsODm9FJ5ugEk3vW/djkOKqVqI6qrnZ2S9EwouTp81azyQ7Nl4kc05ROFLUm5JC6J6TZjl
        GSpELLb87Sb3Q=
X-Google-Smtp-Source: ABdhPJxDb53dAAr775CBGu8S2Odwp0aEQce6XSCFWmrZIBLBmZx/L0Tt2idLBu6rYnAzFkSIty1YHM5EJ2AXCegcxA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a17:902:eb54:b029:12c:3612:b6e0 with
 SMTP id i20-20020a170902eb54b029012c3612b6e0mr10198568pli.33.1627478191574;
 Wed, 28 Jul 2021 06:16:31 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:26 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.10.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 10/13] plugins/admin_policy: add device callbacks
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds callbacks for device added and device removed. It is
necessary for implementation of "AffectedByPolicy" property since it
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

 plugins/admin.c        |  78 +++++++++++++++++++++
 plugins/admin_policy.c | 154 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 228 insertions(+), 4 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index d89a77c8a..37dae77ac 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -20,6 +20,7 @@
 
 #include "src/adapter.h"
 #include "src/dbus-common.h"
+#include "src/device.h"
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
@@ -29,7 +30,11 @@
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
 #define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
 
+#define DBUS_BLUEZ_SERVICE		"org.bluez"
+#define BTD_DEVICE_INTERFACE		"org.bluez.Device1"
+
 static DBusConnection *dbus_conn;
+static struct queue *devices; /* List of struct device_data objects */
 
 /* |policy_data| has the same life cycle as btd_adapter */
 static struct btd_admin_policy {
@@ -38,6 +43,11 @@ static struct btd_admin_policy {
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
@@ -203,6 +213,37 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
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
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
 	const char *adapter_path;
@@ -250,10 +291,45 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	return 0;
 }
 
+static void admin_policy_device_added(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
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
+static void admin_policy_device_removed(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
+	struct device_data *data;
+
+	data = queue_find(devices, device_data_match, device);
+
+	if (data)
+		remove_device_data(data);
+}
+
 static struct btd_adapter_driver admin_policy_driver = {
 	.name	= "admin_policy",
 	.probe	= admin_policy_adapter_probe,
 	.resume = NULL,
+	.device_added = admin_policy_device_added,
+	.device_removed = admin_policy_device_removed
 };
 
 static int admin_init(void)
@@ -261,6 +337,7 @@ static int admin_init(void)
 	DBG("");
 
 	dbus_conn = btd_get_dbus_connection();
+	devices = queue_new();
 
 	return btd_register_adapter_driver(&admin_policy_driver);
 }
@@ -270,6 +347,7 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
+	queue_destroy(devices, free_device_data);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 270d42366..73d695ef9 100644
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
2.32.0.432.gabb21c7263-goog

