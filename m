Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DC660231
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHQR37 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhHQR36 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 13:29:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A541C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 10:29:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so195387pjv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Exb4ZdnQcxEFjiaMw2l1Feiop5Vpk3WkbYCLKGsdP7M=;
        b=Ss1N5L3xHrBVgTNpMOtPWhEiLItdYS9Rra/5LhHaE34iK/ar5V3w4xYtwtlz8kpgGo
         inGkyiKs3f1yB6hR9vvRcmgbVXLGbx2ZQvd+AwmybiPNLLCgA9n/SmYT1pElI0S4tCcJ
         Vj4OY5DcqZYiXk63MyUhOjsQh7ySMpnrMkGNRYFtI9MS58z1fzDzeRKw0w+OpXbLHzDI
         oq/ptZ2uX8aA/98hUe2aHZIUKgpwHLhSO8RM1ausStQV0jG+SGJBatK0keNqpP5HOs+1
         AsZq01Q6AsPl/jbwOCO2va1k2DymdCQqPZm7+0mkA5OWY9oqatWEm2ardR+bx6KV9gy+
         Vpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Exb4ZdnQcxEFjiaMw2l1Feiop5Vpk3WkbYCLKGsdP7M=;
        b=Ky2KeaNIz8eBUASdRcTbM0ORD0TMuTuX85C9rpUNnEPgol4y4atav/RLZGsCS3R3Mu
         d2X4UEHH+RlBd5aZDne7bsaaOnUlffBXV1FnZ9OxvaNgafl8we9NZvX7z7ghP0JuWYU7
         M8jvqbKcrvdQInWngvePMoQwenB4mmKpI2tgrdeymoRMLkkc+XCzfjLWmvgdg0bdSivk
         ZYv0HjkvettFD1wlpUqc7CVGqNc49rj3I9vNGfw8kPv59mBP6IEM7GLUWcq/OF/YQYC1
         3TCB0UfEWxgQXGrTyYpnGWwC41hTEngl+BWh+WQbpP/fxL0i2Ggb6MOaCMhuJztehHwT
         rqOg==
X-Gm-Message-State: AOAM5318vz3HpDSI8+9rYjKFd+S7fdpMInGJlf7bWF7mLlyhx1Wy4HWt
        h7MdQigLvxMAiYQMHwqixqHGkg9vSQ6Oxc+g
X-Google-Smtp-Source: ABdhPJw4E/I5SxqSNxQ2C1vS+h70CosEw2OpYF0dEcHTIls6alVDqQVJiZps1WkgswhxQZjkjZXrgQ==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr4606540pjr.42.1629221364961;
        Tue, 17 Aug 2021 10:29:24 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id q3sm3975042pgl.23.2021.08.17.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:29:24 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [RFC PATCH BlueZ 1/1] Added GDBusMethod to notify one device of characteristic change
Date:   Tue, 17 Aug 2021 10:29:09 -0700
Message-Id: <20210817172909.18630-2-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210817172909.18630-1-bernie@allthenticate.net>
References: <20210817172909.18630-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Implementation of the method and modification of the dbus method table. 

---
 src/gatt-database.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c95f2d6..7e6b70a80 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3615,6 +3615,93 @@ static DBusMessage *manager_unregister_app(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *notify_characteristic_changed(DBusConnection *conn,
+											DBusMessage *msg, void *user_data)
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
+												 client_path);
+	if (!client_device)
+		return btd_error_does_not_exist(msg);
+
+	client_state = find_device_state(database,
+								device_get_address(client_device),
+								btd_device_get_bdaddr_type(client_device));
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

