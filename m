Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329ED3C457F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928483; cv=none; b=TH7gBHTVJO5nWkWeKXRh22ZywxV2cOyFEr4K8ShfeHwStAVezzw96BEvYtueAcDWFpYGNZGgr8f906nUdHWM4AgXJ8WiTiDsAjwBr7uUfiCnRJSWNmyGCecOppDNyJccpQw5khgT606x1995IXJxnW3c7ch/aHuXvRuFPLSRN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928483; c=relaxed/simple;
	bh=piEE9qdMdClggu+nbZxv+RdYs/oqXG/0LGSl99OsSXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNdgXHIim8C6iPHXEae9L7tSLQvHHRfMHxwM3KaWEHNk1ogRno333w03YSTKvP2tEiqFbQnQ56umIok4N4sZWUuM0iagTny7E7P7eGj2FsKjh7Iysc6YrEV1cObBQLpFlLwUirMTo04HfNAD0XULzDXPkpoRAP1NztnPdaO3w3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=pmL4qUud; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="pmL4qUud"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2193218f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780928479; x=1781533279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivFXMAG1oVTSYgCQMXX/wy+piVYGhEqVqWSY/WVmKFg=;
        b=pmL4qUud70ZSJ3Y3c2nQjjkeWXJBzKl59wgWr+aOreIgU/Mybgrp6eSOUYWqSdv1O1
         P0JYRwyC054SdPD97CfVr6hFk39vhpy9KpJs8dQqT3SRPQUDFJIfYYHy9X1rCE3RLj37
         c6bSy78H8Q/b5ybAISnzLvZyrAqyfTaLff3w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928479; x=1781533279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivFXMAG1oVTSYgCQMXX/wy+piVYGhEqVqWSY/WVmKFg=;
        b=ZW8NRvGf75CTh77EPZsCIX8rT4nzaBhuavwlhuOwkNv3T3bZmgeiSZafYRDHWqgKWr
         wyKExGw7uLxJ3eViGWCTMVsnbV4e62EFxaFz/vTIkXrAJ7Tz0bgo/T0/rBZi2LflRHxT
         J8VVnQ4+2vqWVfjyzm+nptY7Vdvwa9yl1Hof3NvevXdawTWTaUohqDXe/1uIdEJgfDHr
         qLC2e8NRCuRuoAnSqmlR2nY6A3GBOwLAd+fP6GKOt+Fp9maY/HYAHhrcro+unCtVTTQl
         Yguy5cXhaUsdhy+bvGIUJFLKrwGfT8wfh9bPsV4IWKWZ6543B2EAwuVVUp2ind7a8sDP
         WEsA==
X-Gm-Message-State: AOJu0YxrF8DnGHnEnLw8sg8xXjxysowrQkCrS0/HDhxUy+57lXzlvrZA
	oxFH4p/VJCh+yWlIegm5TKR6d6YFm1KEBelTt82udpLpP+QOo8aDKsz4m3UYZPZJ3G9dOQQtRpH
	esPUW
X-Gm-Gg: Acq92OETtsZtABM1BMyMe+NwoWeAuq2BVCwJz5WQMC2BAQO/tSXUkBQ+wmjaZXwHKMg
	D0ld06MiZ7y/GN3+HVbBOF82MLWpKBlyB1rqmKiXv/5op7pXwAPGDVpfzCtJfzv9zEik6Eh1Iqv
	04PCaIIEVRc+X5UjmQw68lhTinWwXLKiAhlXEyb7cWR3NPG6gG8P3Ho66XmWDi4ZNq6k2QwBkOK
	eh+epz24yeWJNHG3uAXzAm5UKkQj6PEQHfcy8KWL8bWb8oBudFAIN3KvNs/4oGi9HVOEZ9SMUDK
	0jGM4iB5LGt/rg6ZHXQTsI5QihPJRPTbfGB/qCKjdihJFFWBoXHJG/zzLsZma6HtyhJ7bL7wJ+s
	KvEyTPai4r9NZkOAOTVUjlL1eBGYUtDIpeAkZR0LL8DnF5/chlu584J3bmfQ6tDH0gPb6rnq9kN
	Q3OxjphY164COMq+IrYJY9ILE74RwhVD1LlEsUhiDPXgsqpkqLvQkvXA==
X-Received: by 2002:adf:fa10:0:b0:44f:9b70:2996 with SMTP id ffacd0b85a97d-4603063d92fmr20764787f8f.21.1780928479274;
        Mon, 08 Jun 2026 07:21:19 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm95753087f8f.29.2026.06.08.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:21:19 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] gatt-client: Add PreferredNotifyType property
Date: Mon,  8 Jun 2026 16:20:50 +0200
Message-ID: <20260608142050.3742000-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a characteristic supports both notifications and indications the
CCC we always register for notifications, leaving no way to choose
indications from D-Bus.

Add PreferredNotifyType (string, "notification"/"indication") to
org.bluez.GattCharacteristic1, only present when both flags are set.
StartNotify() and AcquireNotify() honor it on the next CCC write.
---
 doc/org.bluez.GattCharacteristic.rst | 21 +++++++
 src/gatt-client.c                    | 85 ++++++++++++++++++++++++++++
 src/shared/gatt-client.c             | 31 +++++++++-
 src/shared/gatt-client.h             |  3 +
 4 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index 805f39593..f7e541590 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -401,3 +401,24 @@ uint16 MTU [read-only]
 
 Characteristic MTU, this is valid both for **ReadValue()** and **WriteValue()**
 but either method can use long procedures when supported.
+
+string PreferredNotifyType [readwrite, optional, experimental]
+``````````````````````````````````````````````````````````````
+
+Selects whether **StartNotify()** and **AcquireNotify()** enable notifications
+or indications when the characteristic supports both. Only present when both
+"notify" and "indicate" flags are set.
+
+Possible values:
+
+:"notification":
+
+	Enable notifications (CCC = 0x0001). Default.
+
+:"indication":
+
+	Enable indications (CCC = 0x0002).
+
+Note: the preference applies on the next CCC write. If another client has
+already enabled the CCC on this characteristic, the existing setting is kept
+and the new preference takes effect only after the last subscriber stops.
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3baf95c4f..29564a87d 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -115,6 +115,7 @@ struct characteristic {
 	struct queue *descs;
 
 	bool notifying;
+	bool prefer_indicate;
 	struct queue *notify_clients;
 };
 
@@ -1595,6 +1596,9 @@ static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
 	if (!client)
 		return btd_error_failed(msg, "Failed allocate notify session");
 
+	bt_gatt_client_set_notify_prefer_indicate(gatt, chrc->value_handle,
+							chrc->prefer_indicate);
+
 	client->notify_id = bt_gatt_client_register_notify(gatt,
 						chrc->value_handle,
 						register_notify_io_cb,
@@ -1673,6 +1677,9 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 
 	op = async_dbus_op_new(msg, client);
 
+	bt_gatt_client_set_notify_prefer_indicate(gatt, chrc->value_handle,
+							chrc->prefer_indicate);
+
 	client->notify_id = bt_gatt_client_register_notify(gatt,
 						chrc->value_handle,
 						register_notify_cb, notify_cb,
@@ -1719,6 +1726,76 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean
+characteristic_get_prefer_notify_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct characteristic *chrc = data;
+	const char *str = chrc->prefer_indicate ? "indication" : "notification";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
+static void
+characteristic_set_prefer_notify_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					GDBusPendingPropertySet id, void *data)
+{
+	struct characteristic *chrc = data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	const char *str;
+	bool prefer;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &str);
+
+	if (!strcmp(str, "notification"))
+		prefer = false;
+	else if (!strcmp(str, "indication"))
+		prefer = true;
+	else {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	if (chrc->prefer_indicate == prefer) {
+		g_dbus_pending_property_success(id);
+		return;
+	}
+
+	chrc->prefer_indicate = prefer;
+
+	if (gatt)
+		bt_gatt_client_set_notify_prefer_indicate(gatt,
+						chrc->value_handle, prefer);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
+					GATT_CHARACTERISTIC_IFACE,
+					"PreferredNotifyType");
+
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean
+characteristic_prefer_notify_type_exists(const GDBusPropertyTable *property,
+					void *data)
+{
+	struct characteristic *chrc = data;
+
+	return (chrc->props & BT_GATT_CHRC_PROP_NOTIFY) &&
+				(chrc->props & BT_GATT_CHRC_PROP_INDICATE);
+}
+
 static const GDBusPropertyTable characteristic_properties[] = {
 	{ "Handle", "q", characteristic_get_handle },
 	{ "UUID", "s", characteristic_get_uuid, NULL, NULL },
@@ -1733,6 +1810,10 @@ static const GDBusPropertyTable characteristic_properties[] = {
 	{ "NotifyAcquired", "b", characteristic_get_notify_acquired, NULL,
 				characteristic_notify_acquired_exists },
 	{ "MTU", "q", characteristic_get_mtu, NULL, characteristic_mtu_exists },
+	{ "PreferredNotifyType", "s", characteristic_get_prefer_notify_type,
+				characteristic_set_prefer_notify_type,
+				characteristic_prefer_notify_type_exists,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -2282,6 +2363,10 @@ static void register_notify(void *data, void *user_data)
 	op = new0(struct async_dbus_op, 1);
 	op->data = notify_client;
 
+	bt_gatt_client_set_notify_prefer_indicate(client->gatt,
+					notify_client->chrc->value_handle,
+					notify_client->chrc->prefer_indicate);
+
 	notify_client->notify_id = bt_gatt_client_register_notify(client->gatt,
 					notify_client->chrc->value_handle,
 					register_notify_cb, notify_cb,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a6abe8ac2..403d22758 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -217,6 +217,7 @@ struct notify_chrc {
 	uint16_t properties;
 	unsigned int notify_id;
 	int notify_count;  /* Reference count of registered notify callbacks */
+	bool prefer_indicate;
 
 	/* Pending calls to register_notify are queued here so that they can be
 	 * processed after a write that modifies the CCC descriptor.
@@ -1671,9 +1672,13 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 
 	if (enable) {
 		/* Try to enable notifications or indications based on
-		 * whatever the characteristic supports.
+		 * whatever the characteristic supports. If both are
+		 * available honor the per-chrc prefer_indicate flag.
 		 */
-		if (properties & BT_GATT_CHRC_PROP_NOTIFY)
+		if (notify_data->chrc->prefer_indicate &&
+				(properties & BT_GATT_CHRC_PROP_INDICATE))
+			value = cpu_to_le16(0x0002);
+		else if (properties & BT_GATT_CHRC_PROP_NOTIFY)
 			value = cpu_to_le16(0x0001);
 		else if (properties & BT_GATT_CHRC_PROP_INDICATE)
 			value = cpu_to_le16(0x0002);
@@ -3838,6 +3843,28 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 							user_data, destroy);
 }
 
+bool bt_gatt_client_set_notify_prefer_indicate(struct bt_gatt_client *client,
+						uint16_t value_handle,
+						bool prefer)
+{
+	struct notify_chrc *chrc;
+
+	if (!client || !client->db || !value_handle)
+		return false;
+
+	chrc = queue_find(client->notify_chrcs, match_notify_chrc_value_handle,
+						UINT_TO_PTR(value_handle));
+	if (!chrc) {
+		chrc = notify_chrc_create(client, value_handle);
+		if (!chrc)
+			return false;
+	}
+
+	chrc->prefer_indicate = prefer;
+
+	return true;
+}
+
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id)
 {
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 63cf99500..0d08f8014 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -124,6 +124,9 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id);
+bool bt_gatt_client_set_notify_prefer_indicate(struct bt_gatt_client *client,
+						uint16_t value_handle,
+						bool prefer);
 
 bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
 int bt_gatt_client_get_security(struct bt_gatt_client *client);
-- 
2.43.0

