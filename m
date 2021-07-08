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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1CBC07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6369061C69
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhGHG0Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGHG0X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D7C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d29-20020aa797bd0000b02903147a50038aso3125600pfq.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=89CsUx6ZxjoLORyodXtlUrvys2/HZJi76DGq4cY+uvk=;
        b=QeOnthgZNHbA2UwGTN5d4Wzcp5z9TVZ7Qr9U9yOGw/xTIwagoEebEkHH8ya7NrNvdV
         /eLYRZU38GqPhTkTEEa8c8WDuKxRo2BR9yosTaaS49v5Tldp0co8bxNMGuXzM/w0u3Xv
         9B60yLXCUk/mxJvF9xQTwk3cHbncRkmLcmvF2238hRwHtE7Zl2H8hmIY/hfsMGPQRmij
         yXx8AoaG4y6XlZkBPaUnaA/Eazl47LyrQL/Lfw+/YDQlGTkfAYvCFTWFVE/t6mUZotTR
         nbZ7lp4+nEfx9VGYj+HH4Evmd2mfNl+v8vpTPDsXVTYHxIuKOCN1fb74MF/v7Yh8KzO6
         ZsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=89CsUx6ZxjoLORyodXtlUrvys2/HZJi76DGq4cY+uvk=;
        b=GsnbmjUDA6fkU+XMCMxeUlrwBztNwk9lFhBjH795y5qLgjfJQLCvuMS6wZnWIidceQ
         sPCVelWuxcYgGBRC90QyRF+x/HiEQ8mko1yINSAUy2fbyQEEG7dkQh+MrGZvh1UB1Sp1
         T5NI3/MQjMW9iMSeXtBvMr5c8tc4mipnAXsPY0GhuPAUF9NTFWeXbiolBSeTvF37l012
         67m9rET86Ie5ACfQPXikvtOWX8EMaNlPxVZkgm6HVGY9t0hvOVDfxqdw3Esj1js3zY8G
         Ft+Lzn10hThylPRba7C5qoFQIH9ZNA63u2rjIrb0yIk4tmrZhTLGlvuKC6jLAL9O41Gd
         a5Yg==
X-Gm-Message-State: AOAM530x6qauh0ctWUCaU0tBZMr4QERB+u0Zca2lAe7ojzu5xoWGTuh5
        RREUIjLmOslZN4U7BSg9gp8n6IL1Ig81j1mg6nqcwEgTmuLPbRHtuHoV0mouNVhEq51xVWxZm2Z
        fZE+mbzbZZQ9KxIUk8vWyQpNG1pHYF2byqOIY8DfspeG6xAR2l2Xm5IA0tVeHfNQbvHXRTzkHOZ
        1rQWCoMaaY9to=
X-Google-Smtp-Source: ABdhPJxpokYe/KYcUMl+bHf7P/4sp0oJkpzMhNn8IcwknRMKQupFVOA7I0NxdQ2zuJLvWo32GBmmO5myfslE8WIWQQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a17:902:e843:b029:129:acb4:2464 with
 SMTP id t3-20020a170902e843b0290129acb42464mr10262571plg.77.1625725421797;
 Wed, 07 Jul 2021 23:23:41 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:05 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.5.I699a3837a5a18d9f889635300f6c717879f19dd2@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 05/14] core: add device state and state callbacks
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This implements functions to register/unregister state changed callback
functions, the functions will be called when a device's state changed.
Currently the state only shows initializing, available and removing,
which is enough for plugins to register dbus objects upon device
creation and unregister it upon device removal.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/device.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h | 13 +++++++++++
 2 files changed, 77 insertions(+)

diff --git a/src/device.c b/src/device.c
index e1d82eab0988..0d7444706336 100644
--- a/src/device.c
+++ b/src/device.c
@@ -81,6 +81,13 @@
 
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
+static GSList *device_state_callbacks;
+
+struct device_state_callback {
+	btd_device_state_cb	cb;
+	void			*user_data;
+	unsigned int		id;
+};
 
 struct btd_disconnect_data {
 	guint id;
@@ -272,6 +279,8 @@ struct btd_device {
 
 	GIOChannel	*att_io;
 	guint		store_id;
+
+	enum btd_device_state_t state;
 };
 
 static const uint16_t uuid_list[] = {
@@ -4095,6 +4104,23 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 	gatt_services_changed(device);
 }
 
+static void device_change_state(struct btd_device *device,
+					enum btd_device_state_t new_state)
+{
+	GSList *l;
+	struct device_state_callback *cb_data;
+
+	if (device->state == new_state)
+		return;
+
+	for (l = device_state_callbacks; l != NULL; l = g_slist_next(l)) {
+		cb_data = l->data;
+		cb_data->cb(device, new_state, cb_data->user_data);
+	}
+
+	device->state = new_state;
+}
+
 static struct btd_device *device_new(struct btd_adapter *adapter,
 				const char *address)
 {
@@ -4158,6 +4184,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
 	device->refresh_discovery = btd_opts.refresh_discovery;
 
+	device_change_state(device, BTD_DEVICE_STATE_AVAILABLE);
+
 	return btd_device_ref(device);
 }
 
@@ -6839,6 +6867,7 @@ void btd_device_unref(struct btd_device *device)
 
 	DBG("Freeing device %s", device->path);
 
+	device_change_state(device, BTD_DEVICE_STATE_REMOVING);
 	g_dbus_unregister_interface(dbus_conn, device->path, DEVICE_INTERFACE);
 }
 
@@ -6980,3 +7009,38 @@ void btd_device_cleanup(void)
 {
 	btd_service_remove_state_cb(service_state_cb_id);
 }
+
+unsigned int btd_device_add_state_cb(btd_device_state_cb cb, void *user_data)
+{
+	struct device_state_callback *cb_data;
+	static unsigned int id;
+
+	cb_data = g_new0(struct device_state_callback, 1);
+	cb_data->cb = cb;
+	cb_data->user_data = user_data;
+	cb_data->id = ++id;
+
+	device_state_callbacks = g_slist_append(device_state_callbacks,
+								cb_data);
+
+	return cb_data->id;
+}
+
+bool btd_device_remove_state_cb(unsigned int id)
+{
+	GSList *l;
+
+	for (l = device_state_callbacks; l != NULL; l = g_slist_next(l)) {
+		struct device_state_callback *cb_data = l->data;
+
+		if (cb_data && cb_data->id == id) {
+			device_state_callbacks = g_slist_remove(
+							device_state_callbacks,
+							cb_data);
+			g_free(cb_data);
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/src/device.h b/src/device.h
index 5f615cb4b6b2..a8424aa4f098 100644
--- a/src/device.h
+++ b/src/device.h
@@ -11,8 +11,18 @@
 
 #define DEVICE_INTERFACE	"org.bluez.Device1"
 
+enum btd_device_state_t {
+	BTD_DEVICE_STATE_INITIALIZING,	/* Device object is creating */
+	BTD_DEVICE_STATE_AVAILABLE,	/* Device object is registered */
+	BTD_DEVICE_STATE_REMOVING,	/* Device object is being removed */
+};
+
 struct btd_device;
 
+typedef void (*btd_device_state_cb) (struct btd_device *device,
+					enum btd_device_state_t new_state,
+					void *user_data);
+
 struct btd_device *device_create(struct btd_adapter *adapter,
 				const bdaddr_t *address, uint8_t bdaddr_type);
 struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
@@ -179,3 +189,6 @@ bool btd_device_all_services_allowed(struct btd_device *dev);
 void btd_device_update_allowed_services(struct btd_device *dev);
 void btd_device_init(void);
 void btd_device_cleanup(void);
+
+unsigned int btd_device_add_state_cb(btd_device_state_cb cb, void *user_data);
+bool btd_device_remove_state_cb(unsigned int id);
-- 
2.32.0.93.g670b81a890-goog

