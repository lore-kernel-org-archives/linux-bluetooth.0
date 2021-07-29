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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73AFC43214
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB05B60F23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhG2DOU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbhG2DOU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:14:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88720C061799
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:14:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r23-20020a17090aa097b0290176fc47a8b7so8822778pjp.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8kh0kYIyDfN7IZp2L3gpiT2YN98Q7N2b0Om3iMdzQt4=;
        b=g3R8A9C5/7kH3cLTaAYHzyOrRoXKut+3WANNbiF3Bl2d/Rm5WTdrFvd7KmpevxOs3M
         p86KC7xAdzabDoCrmWvkstt4Lhlscr35ZZgsKK10CFMsBbe5Gqtm+5O9gZymH1HULaKF
         d9xkrDcv3xJcFf7rUaqFvMPcWs3/88p1uGQOaSxDQBs18E6eqIMKytEXJK/S2aLzOzxb
         uZrj/IgJaI27Cp5o3/WhM5wTtNwRjkiIUdmOxGw39QsaI3qHkKWZrgMRf2Orec7xqBZt
         0JIoivWS8HNCmbsrRYsqNOzipSR0EQnf95LS1FQrILd7ZxoASjNYVH9zWytn+ZE674FI
         e4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kh0kYIyDfN7IZp2L3gpiT2YN98Q7N2b0Om3iMdzQt4=;
        b=Nr4u7NHfS9qKrMyOuNWNbycy+LnboYvA2HNAqsc7Za7FbUDUh5m+uomyDmyBeyR2GL
         gvV5hhvEoZID/S7cTJvgS20AaFj+lG+sW/29HoPnZo/F1oh3Wf0gN+2dsiSe/p2OAbDT
         /aYkFnq8X3Vne+oT9cQQWK/GG5araNHWC4qwZsCt6J5YbI+CpHfp8Sj0f8lNjcyGgpL1
         wjdpudcrmbkawyOn61vjT9WViY98TmRBqMh0g9bijwcyOp3jrLM3stUV2XSuM535FHn9
         hM3wuLHnkTIuxZUxfyZTF7vnlDQgnZSpHefBySyV33BhBnMwqEnNaAN22nDVZuTpXN4s
         D6ew==
X-Gm-Message-State: AOAM530LJXVNmmG46gy0ZKnUnojGXcpj7mc0+898Gq0GvLCmTl/cy6y0
        KbbTP1Tls6u3r/WewrqrO6AsDl4wBQ2q6QBSbv1QkE+jQIA1B8sa52E42O9+xHSPMs1XxD9iGO/
        M9e+aro0QIE+th05AfedNxgbP5nzg3+jcdrxMWEEqGjejBdEanoVw7tnPe51NyZl7TaCzyF9sbv
        vTs3P1lGbqpUo=
X-Google-Smtp-Source: ABdhPJyOti3KUeprVWWeuRyBygvbrFwQZzc8YeDEyJU+F8Mf71drQeq59mljTgSUbGLoLeI3e+o9NaWHFqbnZcy2XQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:aa7:90cd:0:b029:333:baa9:87b7 with
 SMTP id k13-20020aa790cd0000b0290333baa987b7mr2907329pfk.23.1627528454586;
 Wed, 28 Jul 2021 20:14:14 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:56 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.10.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 10/13] plugins/admin: add device callbacks
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

 plugins/admin.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/plugins/admin.c b/plugins/admin.c
index d89a77c8a123..37dae77ac448 100644
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
-- 
2.32.0.554.ge1b32706d8-goog

