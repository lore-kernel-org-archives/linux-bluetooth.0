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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EE9C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A36160EB2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhG2I57 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhG2I56 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3AFC061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so6204483yba.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gqdjgkdvhVGOQ8cQC92B+9Kplw3M+NU1zcw9w0/LQHU=;
        b=RWfhKqZOLJO2fU+Z7zybLDpYHtC8u0yQq0GG2eIVj7dTeNlS2sX/+33o7NTIG+5QJx
         O4FONA5hMtBXBquTYZwFpq5+kHddF2l7onUp1D6lU9MhIxy/XW1bHk1By5ZyqK5LPh/W
         5zliv/h07r7lZ3yF0pAi0Q9N+3BmHa/65HYfFT7I87/x9Tcy8sR45VSZaYzGvG5H/yh6
         UMgVr2IYUZGhy3ri8MtOYXQ9f1wbEa1g5LUg/Sn417KWgr+ryCKruDf1Hk9fWjwCNmXd
         WLGjEwycvLWF/4ssRpCwmQ5j+zPBulZzxCPdD2wr0vEkB8qmQd1WyikCMX4h8AotBCtZ
         5KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gqdjgkdvhVGOQ8cQC92B+9Kplw3M+NU1zcw9w0/LQHU=;
        b=KCCsexju4BkTzU3oiWtUUjBNQp5KEtal8PyjsIOWMVCghwpqVCJei/mTIvt/XRLN/c
         5Bt8vnuh26fWt/NL7nc+0aSGyg3StMd/20cdoBKrjdvBHGaaVYdb3+Ifn4LS3UPr5UDL
         55JLxiK23+YC3fbBNHAsaJSZKq4lqbgwMP0T7ekf7Xn3sh1v7o/b3rewRoYHYvp/rGrA
         eKDFrfdpWnWCJ3f2trUYv5DewJLRVpbavCdZEL1Kc0Wf4eveSXTsUEtjuwelPxaIRqLX
         x/qQHHlkW/p+fxLkeJq7glLnTtcPG4obymSEdYWrgZ31Vhp5UOyfLAkriEg24H7AorgQ
         igvA==
X-Gm-Message-State: AOAM532/4/qhS6SbxseetgoXpvFyPVQUz7M5wmLTOdD18WzhwqiJltim
        EXtiADSbbE4kqn4WbF5W1isI4u/rlO/MgbpyM6NbhZecZl88RcykOOZvkTSK0mKytFu5lBDVRGL
        SmqZ/byx9+eYc0Aeqf4IYCEtYmhp9OsK6fhD/VQbdCWXQBYVC6SE3K4YLOBAQW9gO/Hckvf9zN5
        E3sbZ89VhEZ8Q=
X-Google-Smtp-Source: ABdhPJw/tvuCiDtMz6BZN1VOfXqWyEA9CsX28gIyYCNUbigS2M5M0j3WJdwmVTZy9vJOzyID21Q1N6Vvt+7YlpJk0A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:ac3:: with SMTP id
 186mr5586031ybk.436.1627549075110; Thu, 29 Jul 2021 01:57:55 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:49 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.11.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 11/13] plugins/admin: add AffectedByPolicy property
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds property to indicate if a device has any service that is being
blocked by admin policy.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. Set ServiceAllowList to []
2. Verify AffectedByPolicy of K830 is False
3. Set ServiceAllowList to
   ["1800"]
4. Verify AffectedByPolicy of K830 is False
5. Set ServiceAllowList to ["1800","1801","180A","180F","1812"]
6. Verify AffectedByPolicy of K830 is True

(no changes since v1)

 plugins/admin.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 37dae77ac448..653195a0e20b 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -46,6 +46,7 @@ static struct btd_admin_policy {
 struct device_data {
 	struct btd_device *device;
 	char *path;
+	bool affected;
 };
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -139,6 +140,27 @@ static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
 	return true;
 }
 
+static void update_device_affected(void *data, void *user_data)
+{
+	struct device_data *dev_data = data;
+	bool affected;
+
+	if (!dev_data) {
+		error("Unexpected NULL device_data when updating device");
+		return;
+	}
+
+	affected = !btd_device_all_services_allowed(dev_data->device);
+
+	if (affected == dev_data->affected)
+		return;
+
+	dev_data->affected = affected;
+
+	g_dbus_emit_property_changed(dbus_conn, dev_data->path,
+			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
+}
+
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -167,6 +189,8 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					ADMIN_POLICY_STATUS_INTERFACE,
 					"ServiceAllowList");
 
+	queue_foreach(devices, update_device_affected, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -226,6 +250,28 @@ static bool device_data_match(const void *a, const void *b)
 	return data->device == dev;
 }
 
+static gboolean property_get_affected_by_policy(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct device_data *data = user_data;
+
+	if (!data) {
+		error("Unexpected error: device_data is NULL");
+		return FALSE;
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&data->affected);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable admin_policy_device_properties[] = {
+	{ "AffectedByPolicy", "b", property_get_affected_by_policy },
+	{ }
+};
+
 static void free_device_data(void *data)
 {
 	struct device_data *device_data = data;
@@ -308,11 +354,33 @@ static void admin_policy_device_added(struct btd_adapter *adapter,
 
 	data->device = device;
 	data->path = g_strdup(device_get_path(device));
+	data->affected = !btd_device_all_services_allowed(data->device);
+
+	if (!g_dbus_register_interface(dbus_conn, data->path,
+					ADMIN_POLICY_STATUS_INTERFACE,
+					NULL, NULL,
+					admin_policy_device_properties,
+					data, remove_device_data)) {
+		btd_error(btd_adapter_get_index(adapter),
+			"Admin Policy Status interface init failed on path %s",
+						device_get_path(device));
+		free_device_data(data);
+		return;
+	}
+
 	queue_push_tail(devices, data);
 
 	DBG("device_data for %s added", data->path);
 }
 
+static void unregister_device_data(void *data, void *user_data)
+{
+	struct device_data *dev_data = data;
+
+	g_dbus_unregister_interface(dbus_conn, dev_data->path,
+						ADMIN_POLICY_STATUS_INTERFACE);
+}
+
 static void admin_policy_device_removed(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
@@ -321,7 +389,7 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 	data = queue_find(devices, device_data_match, device);
 
 	if (data)
-		remove_device_data(data);
+		unregister_device_data(data, NULL);
 }
 
 static struct btd_adapter_driver admin_policy_driver = {
@@ -347,7 +415,8 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_destroy(devices, free_device_data);
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
-- 
2.32.0.554.ge1b32706d8-goog

