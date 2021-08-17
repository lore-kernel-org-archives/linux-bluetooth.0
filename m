Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09B761029
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 18:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhHQSNv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhHQSNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 14:13:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F7C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 11:13:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so6731148pjz.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+mnkM4vwk+t6kiPc0+RbBcKegUYfxxgazUZu5HAUXCQ=;
        b=XyMWfOXd2p1rT6ODsRVQwdj71WT0jDZ2WUjprpjZzQ6X4Ehc2AC8Xr1xHnc5AscYaA
         kJNfE4ovvkm6qEz8nzGQ5ZJkQePg0ieW9JFPpisyarxPil4B1yt6PwEiR9T//xzujj/O
         BQT7VxUc5b+ePSMxm5yH54lWU7gyRCKSjtxhYvecv5UMwgY+hEXXkdpksfpVVU4aala5
         P0eD2OKf0xa4ZLyE6iba/a7Gyt6agoKzVsUe7JJ+/S4aF5QumON8f2C5pMUC6hzNOZ32
         OA0MYya98lQsa66UP9aX93YNiQI1rmnyV+/h3/OGGlzNdSSHhcJ9P1veWcForJp2n3JT
         8o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+mnkM4vwk+t6kiPc0+RbBcKegUYfxxgazUZu5HAUXCQ=;
        b=k42rP/DTwuS5lONQJW3fXcZkjVAH5JfNJvPSDEYy64s70oH/m4ahx6UWjXqZ4bOdL/
         iHK4rpZd/Paz5/BAfH1XAJxDEh8kqgcSCD+Tv2x1CV224lL0sQpe5TumZKlYqOT697b4
         Yn4qxpVwRYYOooqP0lcMi35IHYsI7d9uV04kYsfevGFgUvDPJdIZ6LJP+lboFmUcvgKt
         0Qc8oUyUNGdSNPTBKiL6/EQEwupROxzc905GB6up8fciP1DEfyC8d8abNxEDAsCJR4xe
         3VoZoZ5yFot4HynYbojRxeFg12WrFjJ3TGBWxfcTLyYq2vPJfMz/bj72Lxh/D6Qg8I9c
         57MQ==
X-Gm-Message-State: AOAM533aDzjqPIK2+0V3LS8ksEmY5yOa4sFiVdwdC8GWIUYIAlR9711t
        BRi3vUTsQ783tWlgagmssRlYxEufiCpZtAIB
X-Google-Smtp-Source: ABdhPJx0whsoghhny9z77FQABzmGYRZtrL1my2zFFJ9KnnuKd9Z6bdNv+Mq8FXWcLlTYqY31dMvaFg==
X-Received: by 2002:a65:5845:: with SMTP id s5mr2157590pgr.227.1629223995973;
        Tue, 17 Aug 2021 11:13:15 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id s22sm3291148pfu.52.2021.08.17.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:13:15 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [RFC PATCH BlueZ v2 1/1] Added GDBusMethod to notify one device of characteristic change
Date:   Tue, 17 Aug 2021 11:13:00 -0700
Message-Id: <20210817181300.24479-2-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210817181300.24479-1-bernie@allthenticate.net>
References: <20210817181300.24479-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Updated implementation of the method and updated method table. 

---
 src/gatt-database.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c95f2d6..8d91a7ed4 100644
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
+		return btd_error_in	valid_args(msg);
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

