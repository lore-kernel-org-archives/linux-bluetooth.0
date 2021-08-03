Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76F16104F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhHCLos (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbhHCLoN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:44:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B7C0617A3
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s123-20020a2577810000b02904f84a5c5297so22614920ybc.16
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eIRHaV79CiBWZE4HNDJBvuDirUItQNLJuh5cCV9CV78=;
        b=BVEIN4tHTePtwWCOF3Mk3r2B/CQJ8seGX5DNilsTiasX0KiXcxu7y7V2THQK6AYXEU
         +zpk0/LjEaicb1/LQMMHkAbHfTXY+ovcBUV4PpyfH2LdwKNKU/JdgA4Lihxd67Pe/u63
         RF/6e2EMU4VrJrYgcBz+uzi74tjvRJVIQFi2LI5ZFhvARbUZHaLJ/jkwuR6a7QUjJ/9X
         45jjxJrQJjBOIVhLmmGrS15rZcjwRL+MNrBjMy/9bHEtbbWnR9BQJJuE3NOHRKV534qa
         NRNDdBp5Edw21jVOSez4ORjkRUo5lWtlPWAldqsyk70zmH9IRieWjFh6LXZFy/F6Z66H
         1+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eIRHaV79CiBWZE4HNDJBvuDirUItQNLJuh5cCV9CV78=;
        b=ToSnUU+hw6s4FeuPC56oKMS/JV+hQxoBJMTsYsNo0dZ1mOCpmor+i4TiY0Q12UwyhH
         Ri4SCP7Prz7J1ovqN+YQSHIkaFmQChVFfUO0V3RbOcJhS1yZXyA1lrshN9rd7UpmWKPW
         CIcPzPdCpHTvkRdWIy4WQNsljkW/wukwXM/vl2iLTXiu89T3XnTN0kHkNI487mbu8HaX
         VtpPS0p1O/C8Do/PClocCh3xNgB3Obkag0E2H4VLWNm6Dye1+RjUA1wldKD/iVPLPTlx
         lRxsIpjaCVbJMUhPndFIkdsiAvdfS9clnDAN+hhvPLwUNaqieWoOz5+KKc1JuEgpXswy
         BFIQ==
X-Gm-Message-State: AOAM532073z1Esn14kXFrWi6VnqqqVQSNu78d1MSocqUYb43syexqbe6
        2QAcQ6cXSs8WZ9mw4oG/S8Htt+yWZYjfNmT+5olzq9gy4ESAqG+Z021puTALw+EBOWNOAaSO1Zc
        WD55cVNsUO6n7H8jKNFvlbhrw035hiKKMXKWdSJvlLZwZV9V+loPlwiBjZmdnQ5wlgI9aG2eo/x
        ufFL0j88fdedY=
X-Google-Smtp-Source: ABdhPJyxBJeSRzfhMAU7mQw6zOljPiCuFNLgf8idKtgxTATGoLeiiQTjxCtC05froJ83LY2uXEbKhBofMnni4Sj3jQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:d084:: with SMTP id
 h126mr27636787ybg.175.1627991038900; Tue, 03 Aug 2021 04:43:58 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:13 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.9.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 09/13] plugins/admin: add device callbacks
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds callbacks for device resolved and device removed. It is
necessary for implementation of "AffectedByPolicy" property since it
needs to register an interface for each device object and unregister it
once the device gets removed.
---
The following test steps were performed:
1. start discovery using UI
2. verify device_data were added by checking system log
3. stop discovery
4. verify device_data were removed after a few seconds by checking
system log

(no changes since v8)

Changes in v8:
- add device_data when we get called device_resolved instead of
  device_added. Otherwise it is possible that a device service has not
  yet been resolved so device_data->|affected| might not be correct.
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

 plugins/admin.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/plugins/admin.c b/plugins/admin.c
index d89a77c8a123..0a0d8a39ed37 100644
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
+	.device_resolved = admin_policy_device_added,
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

