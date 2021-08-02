Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70577C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE560EE8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhHBGNm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhHBGNl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:41 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11028C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:33 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j13-20020a0cf30d0000b029032dd803a7edso12084375qvl.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8kh0kYIyDfN7IZp2L3gpiT2YN98Q7N2b0Om3iMdzQt4=;
        b=RuGt/MNm67bF6vxiHRD8a1UYSrzjeC6CPvaVyiWf7cT5u5z6CqEThIxYgFzfuBScMV
         uRClN1sIT6qy45YZIWkg/C0l45dNhUCqBu6m87XtdhlPgwtKfikiKFl3ZDg59dG+jyKb
         oFya43kcXiibfS1ec8sjuO2DksXML/8yXfM7YROIWEGJkRukhZt2opAmhFC86NzC5yDF
         +WxKgg9aEphIxF2BP9kyfitHwnpSen8l+qlf7ABovH4kh6vH3vuXf2Zqw5weerkAM139
         c4v5iNEnnF4j+d+0tmi4zXjaQnM7z7xqGWHeuaLMEJfW1V/WUTjdIfFqKvIcTUyv+YHW
         GwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kh0kYIyDfN7IZp2L3gpiT2YN98Q7N2b0Om3iMdzQt4=;
        b=OlEVWKtD5LAX0iL2qgTNkvtRewyZegOG2nt8LvDwAXbx8P3sRpCzk0sYOs63nw7dfh
         tKx94JEaOnynIrYiSpGXxvglxCZaPKI2f7C/COiV2sqyBU+jHJ3EUyDq1csK5+itqZoq
         TdrFaWhc1b+ITSktkykk57hanqQSmLzaSngPEa2A88J+qnk5utX2C8AjdCGUm7/ZtbxS
         xyibk2RJjQ5qN3AUPqbQjjzIT9CMQRICHylr9q6+jHntmJC2F4jeMadrZgG8oxijfsRt
         DKl9u3Yy54fNcU3UFURKrTniU0vupXtBLpDMQCp/yyjqLnyC5tSmnKv8oLy7EoX/hrj5
         v9Nw==
X-Gm-Message-State: AOAM531Ryn7A61Gw3MGaHgPLqubnujyCQutc1pRrrrybjkHJQi8Cia9j
        a0l45TFQk5HuSH6BHX4Ij5lFRzddHeOENvvpDZ4gPll9pNjuFFo4JCpqDxLljD2xBVPjaEmigAm
        qn9w5lJ5BgVzA3PsFl3V7DKjf2zovo4o31FfGV8l8dVceGFFOTqCF5ySisoG+4VBlCObPWsul5U
        CMAlUT1ng6qR8=
X-Google-Smtp-Source: ABdhPJxGkp8e93DniHMpgeI1GMadMAGo1FRr7xCoPDsxoL5rq0OmhlYT7w7rYpp6B9K4N0HRbkmi2d23J9g1aN/kEA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a05:6214:184e:: with SMTP id
 d14mr14916917qvy.13.1627884812212; Sun, 01 Aug 2021 23:13:32 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:47 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.10.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 10/13] plugins/admin: add device callbacks
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

