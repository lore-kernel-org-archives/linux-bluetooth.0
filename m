Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213BBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 00:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC8060F46
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 00:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhHQAO0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhHQAOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 20:14:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD8C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 17:13:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so1781128pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MGZuWOUTDLvIDDXJRmZjkgiJBDbA7j6D4um1/jBiMVM=;
        b=gwNcL68rpfKn1GSQbAnUHZqxUe3Sh8Dho+ZAlbfblGOQV4cUFfn9y0rUPNax2LkkyK
         7dr/3zWFFNzBkl9WCLIGvYgZie9CKDLmZ/qktkT2EJ75OCONjYdkdEBDrvptzgPTPEob
         f/XpFw/YfwGvyJUv0Y0bCWQKx7Acgt+3j+53WK75p9IvpRbNViOrMv0S/bhB6pQQ2hx2
         r8Hyo15GZQ9ws8lQgeP2CSaGEOVGOnmfTulDQ2zMCDN4l0fSapdB7U98CHfh21oBwPji
         AgjnHTtGarJdlWnhF+NTHzCYxMxltWVyjVvkxrcNBhEXr2usPtWg4ifrQMihAFPkdZ7F
         RFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MGZuWOUTDLvIDDXJRmZjkgiJBDbA7j6D4um1/jBiMVM=;
        b=fQPQWt8hNENMa58hW3RlFxV8Vn5kcBd3IZMM5BRjKnjN5tDvrR7wGc0W64ufyxSsRW
         AoyHt7SDZMcaWaTrmOyrkKNYt8fUhSi1GtPXTDpwXIz4bPkCTV5OLd2nEMpf6/5bPs6e
         DrqXbaS1UBHyLUPYNQHYJg7IMhWhndGSyIkYcUVONQO/5c45ZOSFLKWmsow98nFWSewM
         gT403LrUreoAW/76WFjxxHyXPcou1EHKEzsuUtHdXkbMF98R87ySOqHktDnH8FHZbNDe
         P7kG+5VgVfAg85Vt3xXKW9y/iJjp1j89NbCJ/+AMMEqCnu4nVcSi8VZoTbiJPqMjSGsc
         g8PQ==
X-Gm-Message-State: AOAM5339X4mHWFzqXH8/NE/HHo+vtTVU9xKYykaCJ56Hb98nNBsVIJrx
        MqET14CJuyyRxIfd9itbrZQ+HCWSDoOK8pRm
X-Google-Smtp-Source: ABdhPJxZPGQjxPHTq0jRVyn0MXZA8h8aZtzQifPBqgJ12wRA18OHp00KR5KPT+GJT1pCo6QeWXC4sQ==
X-Received: by 2002:a63:100e:: with SMTP id f14mr681860pgl.188.1629159231407;
        Mon, 16 Aug 2021 17:13:51 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id e4sm336977pgt.22.2021.08.16.17.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:13:51 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [PATCH BlueZ] Added GDBusMethod to notify one device of characteristic change
Date:   Mon, 16 Aug 2021 17:13:41 -0700
Message-Id: <20210817001341.10780-1-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello maintainers,

This patch adds a method to be called over DBus to be able to send a
notification or indication to only one device rather than all connected
devices as a peripheral.

This is motivated by similar functionality in the corebluetooth API with
CBPeripheralManager's updateValue() method as well as the Android API's
notifyCharacteristicChanged() method.

I implemented the method in the gatt database file as that was where the
send_notification_to_devices method was implemented which has
similar functionality. The params for the method were picked to be able
to get the data needed to populate the notify struct and fetch the
device state from the gatt database in order to call
send_notification_to_device.

---
 src/gatt-database.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c95f2d6..08609d3a4 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3615,6 +3615,97 @@ static DBusMessage *manager_unregister_app(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *notify_characteristic_changed(DBusConnection *conn,
+                                                  DBusMessage *msg, void *user_data)
+{
+    struct btd_gatt_database *database = user_data;
+    uint8_t *value = NULL;
+    int value_len = 0;
+    DBusMessageIter args;
+    DBusMessageIter array;
+    DBusMessage *reply;
+    bdaddr_t device_bdaddr;
+    const char *characteristic_path;
+    const char *client_path;
+    const char *application_path;
+    struct svc_match_data match_data;
+    const char *sender = dbus_message_get_sender(msg);
+    struct gatt_app *app;
+    struct external_service *service;
+    struct external_chrc *chrc;
+    struct notify notify;
+    struct device_state *client_state;
+    struct btd_device *client_device;
+
+    if (!dbus_message_iter_init(msg, &args)) {
+        return btd_error_invalid_args(msg);
+    }
+
+    if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH) {
+        return btd_error_invalid_args(msg);
+    }
+    dbus_message_iter_get_basic(&args, &application_path);
+
+    dbus_message_iter_next(&args);
+    if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH) {
+        return btd_error_invalid_args(msg);
+    }
+    dbus_message_iter_get_basic(&args, &client_path);
+
+    dbus_message_iter_next(&args);
+    if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH) {
+        return btd_error_invalid_args(msg);
+    }
+    dbus_message_iter_get_basic(&args, &characteristic_path);
+
+    dbus_message_iter_next(&args);
+    if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY) {
+        return btd_error_invalid_args(msg);
+    }
+
+    dbus_message_iter_recurse(&args, &array);
+    dbus_message_iter_get_fixed_array(&array, &value, &value_len);
+
+    match_data.path = application_path;
+    match_data.sender = sender;
+    app = queue_find(database->apps, match_app, &match_data);
+    if (!app) {
+        return btd_error_does_not_exist(msg);
+    }
+
+    service = queue_find(app->services, match_service_by_chrc, characteristic_path);
+    if(!service) {
+        return btd_error_does_not_exist(msg);
+    }
+
+    chrc = queue_find(service->chrcs, match_chrc, characteristic_path);
+    if(!chrc) {
+        return btd_error_agent_not_available(msg);
+    }
+
+    client_device = btd_adapter_find_device_by_path(database->adapter, client_path);
+    if (!client_device){
+        return btd_error_does_not_exist(msg);
+    }
+    client_state = find_device_state(database,
+                                     device_get_address(client_device),
+                                     btd_device_get_bdaddr_type(client_device));
+    if (!client_state) {
+        return btd_error_does_not_exist(msg);
+    }
+
+    notify.handle = gatt_db_attribute_get_handle(chrc->attrib);
+    notify.ccc_handle = gatt_db_attribute_get_handle(chrc->ccc);
+    notify.database = database;
+    notify.value = value;
+    notify.len = value_len;
+    notify.conf = conf_cb;
+
+    send_notification_to_device(client_state, &notify);
+    DBG("Notification/Indication sent to %s.", client_path);
+    return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_ASYNC_METHOD("RegisterApplication",
 					GDBUS_ARGS({ "application", "o" },
@@ -3623,6 +3714,12 @@ static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_ASYNC_METHOD("UnregisterApplication",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, manager_unregister_app) },
+	{ GDBUS_ASYNC_METHOD("NotifyCharacteristicChanged",
+                    GDBUS_ARGS( {"application", "o" },
+                    { "device", "o" },
+                    { "characteristic_path", "o"},
+                    { "value", "ay"}),
+                    NULL, notify_characteristic_changed) },
 	{ }
 };
 
-- 
2.17.1

