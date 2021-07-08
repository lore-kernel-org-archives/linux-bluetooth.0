Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30170C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A8461C59
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGHG0s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhGHG0s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:48 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DCC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:24:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o11-20020a62f90b0000b02902db3045f898so3132729pfh.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VyXHTtvy32iIeRBIdw6ZHes2fzV1g/gDjPGzdkXsXsY=;
        b=oczNY2z89CYZ76FNlU5tn/jpfXqsZZ4rAGpq6uxthuJFOFNf4BRG/qTttDoNJTG6A6
         6i1wsZXilibxuzTUoevMyqz0WUFLhdujPPFJNV+85AJR+mqjaYfKxpY/JGGSOzcsae24
         3WYTcAfj058+xGEXJL92XX9ftHWqAAqZArDowxxptfYoSQkTg7VzZkXe6LgM7P2tVqgU
         6rJEEspe2eO6JyzWUtLCT47uqelRzdLaM4iFeswmdDNuZyypvD2qUorKAIG5ymnLP6ca
         MoATUx+eum+MMqZfmrMgdostv7bJJ8M3uvYbn7PCqyRXPmK+oZgHx+5Jhl7BIzAli5ay
         AUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VyXHTtvy32iIeRBIdw6ZHes2fzV1g/gDjPGzdkXsXsY=;
        b=cf48z+KqHyGEYnJV1gut1MSnNldxYje/Ds/se+fwWxYybJtt6BbPBPsZGtFl9vJEWF
         0yQOi8HX6h9yAT7jhj9z8YsGi92K7g+rJq0Y3YQmpg2OsX4cYToKIvRmEvcum+TlFgrb
         fk6leAplBZ+qkO5W9Cv3gkka3vlq0m1QYLOTWeC/KUBS+JY93+gluRO4vJkz/kE/MSuV
         +GxRTrIIIVZIDuJvdvRAIOIS6WffrGmv1t4ID42vSe0u293fkEswFqIzsFJ1Qd32mjlD
         8ZTV1LDGJOoNWO0dyfIr0EoID4WQH5EGrb/BjQvW6dpoaMAn8qZxd7Cl2EPAVKyL6qnF
         UTGw==
X-Gm-Message-State: AOAM530sT8qGqobTPcQsDe2l90wxMZzfGgdUQDBv2UGUp/Mh+SHvF1y8
        eCxf6MF39ZqxsX5M6GuMomaUm9tKhM4LgSk916dWJOK0MkOJTNQsTUBOzYcWIcGd1QdhPJvRd7i
        uj+q0CcQQaEqOk23JkzV3dbIGagB30Pxd5lnrwEr2/Lg7vMEIVaeuS0iOBQZJEmRSI00O3dshyq
        YB/1sSauVS/KI=
X-Google-Smtp-Source: ABdhPJzyHLAoPUWeakqN2PnzBSWtuqDIOoFn4j6/uibxDq5T/DoXCi37FNY+7RcVKrCWQ64NOyHFRpwPW30Z3yE0wA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a62:bd14:0:b029:2de:8bf7:2df8 with
 SMTP id a20-20020a62bd140000b02902de8bf72df8mr29365345pff.60.1625725446900;
 Wed, 07 Jul 2021 23:24:06 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:12 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.12.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 12/14] plugins/admin_policy: add AffectedByPolicy property
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
   ["1800","1801","180A","180F","1812",
    "00010000-0000-1000-8000-011f2000046d"
4. Verify AffectedByPolicy of K830 is False
5. Set ServiceAllowList to ["1800","1801","180A","180F","1812"]
6. Verify AffectedByPolicy of K830 is True

 plugins/admin_policy.c | 78 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index 852e79aaa07a..be4ba096a8b9 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
@@ -44,6 +44,7 @@ static struct btd_admin_policy {
 struct device_data {
 	struct btd_device *device;
 	char *path;
+	bool affected;
 };
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -137,6 +138,27 @@ static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
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
+	affected = btd_device_all_services_allowed(dev_data->device);
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
@@ -164,6 +186,8 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 				adapter_get_path(policy_data->adapter),
 				ADMIN_POLICY_SET_INTERFACE, "ServiceAllowList");
 
+	queue_foreach(devices, update_device_affected, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -266,6 +290,29 @@ static bool device_data_match(const void *a, const void *b)
 	return data->device == dev;
 }
 
+static gboolean property_get_affected_by_policy(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct device_data *data = user_data;
+	dbus_bool_t affected;
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
 static void free_device_data(struct device_data *data)
 {
 	g_free(data->path);
@@ -299,11 +346,33 @@ static void add_device_data(struct btd_device *device)
 
 	data->device = device;
 	data->path = g_strdup(device_get_path(device));
+	data->affected = btd_device_all_services_allowed(data->device);
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
 static void admin_policy_device_state_cb(struct btd_device *device,
 					enum btd_device_state_t new_state,
 					void *user_data)
@@ -321,7 +390,7 @@ static void admin_policy_device_state_cb(struct btd_device *device,
 		data = queue_find(devices, device_data_match, device);
 
 		if (data)
-			remove_device_data(data);
+			unregister_device_data(data, NULL);
 		break;
 	}
 }
@@ -339,6 +408,9 @@ static int admin_policy_init(void)
 	dbus_conn = btd_get_dbus_connection();
 	devices = queue_new();
 
+	device_cb_id = btd_device_add_state_cb(admin_policy_device_state_cb,
+									NULL);
+
 	device_cb_id = btd_device_add_state_cb(admin_policy_device_state_cb,
 									NULL);
 
@@ -350,9 +422,11 @@ static void admin_policy_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_destroy(devices, free_device_data);
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
 	btd_device_remove_state_cb(device_cb_id);
 
+	btd_device_remove_state_cb(device_cb_id);
 	if (policy_data)
 		admin_policy_free(policy_data);
 }
-- 
2.32.0.93.g670b81a890-goog

