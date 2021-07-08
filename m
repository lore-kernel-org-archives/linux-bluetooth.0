Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E6C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2752161C59
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhGHG0p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhGHG0p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:45 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC2C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:24:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id eo5-20020ad459450000b02902d60d0f0744so387057qvb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TJCDUU+XB3aEdDYTTNZHmC5Pd9cnwtGzJfl+G0OsRkk=;
        b=oH38xudHwDoFduby2q7apvV+9KLZxTLhTIKbNSXv2mgzDsS+FyysqOjloIqhOM4YAd
         JqBfDVhRavczML0nujtpTtQpwnpqV57m9qxpO7tN8uTzed1U0Rlgb94msKpXktQb7Atd
         fbgZL8sTzZz2c9wOZKGwdcNoEurejMvfIXD5enDmUIF2Lww1BroKo3wne6BaqhufeVk/
         wnMJRwgEudpkXwZGT3C1TldkUg+Sewp1TDL18mN6fcRQNsO0MHizubatOBRXECkOzFsm
         mbZnHU1qTkh0fQoZlMmC82OaYvNkN9YiR6U6kIfk+14Uc/Pvoc8lXr1AVYc26NE6mtXz
         3ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TJCDUU+XB3aEdDYTTNZHmC5Pd9cnwtGzJfl+G0OsRkk=;
        b=K+UTEIqFjKOG+SZFmyWNLZ2DDEZwgUBwhJBCNT/GBAX6wPlKYXQuU9Tt27QvbpaxQx
         0OKnjvr0lVZoYWGAW3fFXciUIS0Rdd1RM88YgG007OHFuROeA1qH4uyy0ZljJ506Tj+o
         ulQGVdlPQ43s4gkPRJTTI0wJZsmj8xM/Prtbu3+QeYpzpIL8sMAzK7O7iHrO9QK4jKF4
         n4kGHffQSpyMI5wIiDvKu2tsN88rthomKsL8hDmtS27dNgwTdoTdod+qOOJK/ZftJsqZ
         rs5NTQDdtHQW6DIuFR9go9HoY8iscfbzzvqXQY990C6yrUGr7bNJSkYujxvaz0DXaL1y
         LBQw==
X-Gm-Message-State: AOAM530ZcwuzitKDqLXmUC2OAA85A54R9NSP7vhc7tpfa/b5oOOxs8jv
        Ml2cFB6rXRgV7waxfuxFxwbS3i3Dbdg6Ot6Wwn/iuLRBBeu4/cSd8fVIKJUpEKoOFSurROB1uAL
        NBBsDg/HLB+6mSFwBCzlwXphdKKT4SFEzqPAXU6cJ7pUQfiZcQTVwNZRjzf8JufOKCVBF3TJIdt
        RPy0ZxY495o0s=
X-Google-Smtp-Source: ABdhPJyk4LY8QX0NwWBlmTHQxoOU46RfDX9Jr/V2azCqJPcw8ta7+G6l9uPXlansLmQmivNexh6ggbV4s5hRrI4hDA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a0c:c249:: with SMTP id
 w9mr28296697qvh.32.1625725443110; Wed, 07 Jul 2021 23:24:03 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:11 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.11.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 11/14] plugins/admin_policy: add device state callback
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This registers a device state callback function. It will be used to
implement "AffectedByPolicy" property which indicates if there is any
service in a device that is being blocked by admin policy.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. start discovery using UI
2. verify device_data were added by checking system log
3. stop discovery
4. verify device_data were removed after a few seconds by checking
system log

 plugins/admin_policy.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index c5ad31f761d9..852e79aaa07a 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -20,6 +20,7 @@
 
 #include "src/adapter.h"
 #include "src/dbus-common.h"
+#include "src/device.h"
 #include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
@@ -30,6 +31,8 @@
 #define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
 
 static DBusConnection *dbus_conn;
+static struct queue *devices; /* List of struct device_data objects */
+static unsigned int device_cb_id;
 
 /* |policy_data| has the same life cycle as btd_adapter */
 static struct btd_admin_policy {
@@ -38,6 +41,11 @@ static struct btd_admin_policy {
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
@@ -245,6 +253,79 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	return 0;
 }
 
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
+static void free_device_data(struct device_data *data)
+{
+	g_free(data->path);
+	g_free(data);
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
+static void admin_policy_device_state_cb(struct btd_device *device,
+					enum btd_device_state_t new_state,
+					void *user_data)
+{
+	struct device_data *data = NULL;
+
+	switch (new_state) {
+	case BTD_DEVICE_STATE_INITIALIZING:
+		warn("Unexpected new state %d", new_state);
+		return;
+	case BTD_DEVICE_STATE_AVAILABLE:
+		add_device_data(device);
+		break;
+	case BTD_DEVICE_STATE_REMOVING:
+		data = queue_find(devices, device_data_match, device);
+
+		if (data)
+			remove_device_data(data);
+		break;
+	}
+}
+
 static struct btd_adapter_driver admin_policy_driver = {
 	.name	= "admin_policy",
 	.probe	= admin_policy_adapter_probe,
@@ -256,6 +337,10 @@ static int admin_policy_init(void)
 	DBG("");
 
 	dbus_conn = btd_get_dbus_connection();
+	devices = queue_new();
+
+	device_cb_id = btd_device_add_state_cb(admin_policy_device_state_cb,
+									NULL);
 
 	return btd_register_adapter_driver(&admin_policy_driver);
 }
@@ -265,6 +350,8 @@ static void admin_policy_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
+	queue_destroy(devices, free_device_data);
+	btd_device_remove_state_cb(device_cb_id);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
-- 
2.32.0.93.g670b81a890-goog

