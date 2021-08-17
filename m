Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5978FC4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAD16103A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 19:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhHQTN0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQTNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 15:13:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFD9C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 12:12:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so359105pjl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V84uFWH9Y7qj+zEdOZu407KCCT8ODRzTaQ9eKjpPUAE=;
        b=1CA8ICtW4kR1syRIaC020UGVwYLnPO44fNuhkeki2FnKqRX1PY8oMfC35bdPqHVuo+
         7nBJ4LAp80NgVMqrqF9/ckuhNF7ffASzvdwB2NYdKdSJif20D71uQatC0YONEpk+faeB
         UsJgwbtWms8cuRdKet6Qk5bcA3j2xrmH+hq8L6J3IOcyBHp8hdNDfOLcJqQP7MXOKgqn
         pwgvLfyhLlYzO4sUUaw1RmAeRukN1Sm9KvqflET138UJF5ZIkLi58FucgHF5LXjjUeyC
         MCKQ2lZwB9OvzGwbWlzgVeiZ6ePt8vDFrrR/XOcUliE0reZc6KMWKH4H8FHVRTCy2e0h
         c2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V84uFWH9Y7qj+zEdOZu407KCCT8ODRzTaQ9eKjpPUAE=;
        b=MnK+fp9S+xyn2OYHtRkzb4J79k4B9dMphtsqmCxmKQObvtkkub059yac1AOO6bDnT8
         v4NGtnImS2NY1fEPxXymRrANOi5oJHgcZfPJat5JO13UObsmMifHGUHFdcQnLmwEbjPw
         B8XXB9OG8gKW5lsGqob4kpMdUAc/wh6lxNkqH5f8PUn5q3gfegq/ujOvVRroVOkWQ1a0
         ZdSi+plx/TIJPcMM/3URiZ1t4zSA1UXXoV5oJ1v4VAmpVu6emOfnZeGKjO44R/fFT1qj
         7y5t3feaS8jI0T3bGRAveDTvXjRLGjDr5iRnZF+MqY6qjWUeROljrWI5X2VOny06oHBw
         ldIg==
X-Gm-Message-State: AOAM53202nxExrwlQSSJBUbO7p7MdnKqfv3+kTSMSe+23RpUo+u7ST7i
        8gHvryjnuq5bxeq1r+28zSXJFtS4AHaMDkwC
X-Google-Smtp-Source: ABdhPJyEZnzGVHCSiHsWd25iWJ04CWkGgujeiOYXaeFVIGnGhWKsAJOEx1wiMltfOXH7QXkv6z7ayw==
X-Received: by 2002:a63:5ec2:: with SMTP id s185mr4827614pgb.221.1629227571610;
        Tue, 17 Aug 2021 12:12:51 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id ob6sm2814461pjb.4.2021.08.17.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:12:51 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [RFC PATCH v3 BlueZ] Added GDBusMethod to notify one device of characteristic change
Date:   Tue, 17 Aug 2021 12:12:45 -0700
Message-Id: <20210817191245.10846-2-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210817191245.10846-1-bernie@allthenticate.net>
References: <20210817191245.10846-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Updated implementation, fixed local formatting issue. Includes new 
method and addition to method table.

---
 src/gatt-database.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c95f2d6..8dcd5dd51 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3615,6 +3615,93 @@ static DBusMessage *manager_unregister_app(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *notify_characteristic_changed(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	uint8_t *value = NULL;
+	int value_len = 0;
+	DBusMessageIter args;
+	DBusMessageIter array;
+	const char *characteristic_path;
+	const char *client_path;
+	const char *application_path;
+	struct svc_match_data match_data;
+	const char *sender = dbus_message_get_sender(msg);
+	struct gatt_app *app;
+	struct external_service *service;
+	struct external_chrc *chrc;
+	struct notify notify;
+	struct device_state *client_state;
+	struct btd_device *client_device;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_get_basic(&args, &application_path);
+
+	dbus_message_iter_next(&args);
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_get_basic(&args, &client_path);
+
+	dbus_message_iter_next(&args);
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_get_basic(&args, &characteristic_path);
+
+	dbus_message_iter_next(&args);
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+
+	dbus_message_iter_recurse(&args, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &value_len);
+
+	match_data.path = application_path;
+	match_data.sender = sender;
+	app = queue_find(database->apps, match_app, &match_data);
+	if (!app)
+		return btd_error_does_not_exist(msg);
+
+
+	service = queue_find(app->services, match_service_by_chrc,
+					  characteristic_path);
+	if (!service)
+		return btd_error_does_not_exist(msg);
+
+
+	chrc = queue_find(service->chrcs, match_chrc, characteristic_path);
+	if (!chrc)
+		return btd_error_agent_not_available(msg);
+
+
+	client_device = btd_adapter_find_device_by_path(database->adapter,
+								 client_path);
+	if (!client_device)
+		return btd_error_does_not_exist(msg);
+
+	client_state = find_device_state(database,
+				device_get_address(client_device),
+				btd_device_get_bdaddr_type(client_device));
+	if (!client_state)
+		return btd_error_does_not_exist(msg);
+
+
+	notify.handle = gatt_db_attribute_get_handle(chrc->attrib);
+	notify.ccc_handle = gatt_db_attribute_get_handle(chrc->ccc);
+	notify.database = database;
+	notify.value = value;
+	notify.len = value_len;
+	notify.conf = conf_cb;
+
+	send_notification_to_device(client_state, &notify);
+	DBG("Notification/Indication sent to %s.", client_path);
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_ASYNC_METHOD("RegisterApplication",
 					GDBUS_ARGS({ "application", "o" },
@@ -3623,6 +3710,12 @@ static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_ASYNC_METHOD("UnregisterApplication",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, manager_unregister_app) },
+	{ GDBUS_ASYNC_METHOD("NotifyCharacteristicChanged",
+					GDBUS_ARGS({"application", "o" },
+					{ "device", "o" },
+					{ "characteristic_path", "o"},
+					{ "value", "ay"}),
+					NULL, notify_characteristic_changed) },
 	{ }
 };
 
-- 
2.17.1

