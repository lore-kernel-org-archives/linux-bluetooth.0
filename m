Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBEEC6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCCB1y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCCB1v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5F55512
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i10so1153627plr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2Of84/dC13vBKBrIihDfbCxmJh18bsTTI1eyCNyix0=;
        b=EmNb3zQZWKXjdmTJDcNM1qabbPl5DLXT8x/wLOvTtU7BSVFtetBT1Ei0CsmprRGZ7c
         0kL4eOrThEB7AAvSzFIvSddpYUMRvNIrDlHGLLDNqMVqBA1PNfaEHvvt8cnByyWbfVps
         eUGuPjiE7WmQLKzfjvd0IfENUQA/UcoYqfzabCtOgGfwOo4TQ/jlDlynoKCM7E8r/i65
         HetVdHMgqhoz5YRjNT+CbTNpSCmhLDwoU5whpAYqK3+QvajJpaNCuUuGRVL+24XvEcAq
         hqsXo/f0ulUhdjxBYEVwEC1tn5TyF+kjt5BBzgqPn5msMLXKkU9JtYcRaNs5t3SohkBa
         FaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2Of84/dC13vBKBrIihDfbCxmJh18bsTTI1eyCNyix0=;
        b=uZoZUsNgWHmbbEyAPYW2PxKcULl3IrSv/Jsx5GhzYwbeMsiqwW4M89NhPqeA01nOo3
         5lplbLnsbUm2IpqGzIbJKalqFWhJAPRvY1RZsdMoH5FFOzLxgIKRBxiHUxd+BLn1ij+k
         IIJK/v7e4sQiEryncL+QK5jW/nVjXrdB0URNDmV8tJX58h/Fy+Ex8Ft8sBfxpHrHtsbe
         yyeroJXOkpNcrMz0JdBtpNJpttN7GU1acwlbi/Rj0XulXUNaJG5Gk0LO85c6k77Tau2k
         NMef0ppFlNj/4efR1sYapbbh79x3fT3HzLrW0921JpX9uPcStv2tMdOvfkLlsHRcgZ8J
         +Gaw==
X-Gm-Message-State: AO0yUKUtw2xsPrsrxPDwDWkG2nhF00Y+OddaJNqAXHXk6WZQ8Lb5CUrY
        tHbNVkQtI9FS74/WkfDMHFLiWO+6xbM=
X-Google-Smtp-Source: AK7set8oN0oOb5Be/xsOKhxHjGFxc5QpesZwbQvEQlKPOL20uAfIW1Qx8lguRLepqryxIMmJDhtKwg==
X-Received: by 2002:a17:902:e750:b0:19c:fc0a:567b with SMTP id p16-20020a170902e75000b0019cfc0a567bmr4336736plf.12.1677806867291;
        Thu, 02 Mar 2023 17:27:47 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 4/9] core: Add initial implementation of DeviceSet interface
Date:   Thu,  2 Mar 2023 17:27:37 -0800
Message-Id: <20230303012742.1386291-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial implementation of DeviceSet interface as
documented in doc/set-api.rst.
---
 Makefile.am   |   3 +-
 src/adapter.c |   6 +-
 src/device.c  | 124 ++++++++++++++++++-
 src/device.h  |  11 +-
 src/set.c     | 335 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/set.h     |  14 +++
 6 files changed, 482 insertions(+), 11 deletions(-)
 create mode 100644 src/set.c
 create mode 100644 src/set.h

diff --git a/Makefile.am b/Makefile.am
index 0e8cce249c7d..7b010c8159e9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -326,7 +326,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/eir.h src/eir.c \
 			src/adv_monitor.h src/adv_monitor.c \
 			src/battery.h src/battery.c \
-			src/settings.h src/settings.c
+			src/settings.h src/settings.c \
+			src/set.h src/set.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/adapter.c b/src/adapter.c
index 538310c1ddc6..ae0eb364bad5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4387,8 +4387,8 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		if (dev) {
 			device_set_paired(dev, info->bdaddr_type);
 			device_set_bonded(dev, info->bdaddr_type);
-			device_set_ltk_enc_size(dev, info->enc_size);
-			device_set_ltk_enc_size(dev, info->enc_size);
+			device_set_ltk(dev, info->val, info->central,
+						info->enc_size);
 		}
 	}
 
@@ -8657,7 +8657,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, addr->type);
 	}
 
-	device_set_ltk_enc_size(device, ev->key.enc_size);
+	device_set_ltk(device, ev->key.val, ev->key.central, ev->key.enc_size);
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
 }
diff --git a/src/device.c b/src/device.c
index cb16d37c1ae1..caee2183b9d8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -64,6 +64,7 @@
 #include "storage.h"
 #include "eir.h"
 #include "settings.h"
+#include "set.h"
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		1
@@ -159,11 +160,24 @@ struct bearer_state {
 	time_t last_seen;
 };
 
+struct ltk_info {
+	uint8_t key[16];
+	bool central;
+	uint8_t enc_size;
+};
+
 struct csrk_info {
 	uint8_t key[16];
 	uint32_t counter;
 };
 
+struct sirk_info {
+	uint8_t encrypted;
+	uint8_t key[16];
+	uint8_t size;
+	uint8_t rank;
+};
+
 enum {
 	WAKE_FLAG_DEFAULT = 0,
 	WAKE_FLAG_ENABLED,
@@ -253,7 +267,8 @@ struct btd_device {
 
 	struct csrk_info *local_csrk;
 	struct csrk_info *remote_csrk;
-	uint8_t ltk_enc_size;
+	struct ltk_info *ltk;
+	struct sirk_info *sirk;
 
 	sdp_list_t	*tmp_records;
 
@@ -386,6 +401,21 @@ static void store_csrk(struct csrk_info *csrk, GKeyFile *key_file,
 	g_key_file_set_integer(key_file, group, "Counter", csrk->counter);
 }
 
+static void store_sirk(struct sirk_info *sirk, GKeyFile *key_file)
+{
+	const char *group = "SetIdentityResolvingKey";
+	char key[33];
+	int i;
+
+	for (i = 0; i < 16; i++)
+		sprintf(key + (i * 2), "%2.2X", sirk->key[i]);
+
+	g_key_file_set_boolean(key_file, group, "Encrypted", sirk->encrypted);
+	g_key_file_set_string(key_file, group, "Key", key);
+	g_key_file_set_integer(key_file, group, "Size", sirk->size);
+	g_key_file_set_integer(key_file, group, "Size", sirk->rank);
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -483,6 +513,9 @@ static gboolean store_device_info_cb(gpointer user_data)
 	if (device->remote_csrk)
 		store_csrk(device->remote_csrk, key_file, "RemoteSignatureKey");
 
+	if (device->sirk)
+		store_sirk(device->sirk, key_file);
+
 	str = g_key_file_to_data(key_file, &length, NULL);
 	if (!g_file_set_contents(filename, str, length, &gerr)) {
 		error("Unable set contents for %s: (%s)", filename,
@@ -806,6 +839,7 @@ static void device_free(gpointer user_data)
 
 	g_free(device->local_csrk);
 	g_free(device->remote_csrk);
+	free(device->ltk);
 	g_free(device->path);
 	g_free(device->alias);
 	free(device->modalias);
@@ -1792,10 +1826,43 @@ bool device_is_disconnecting(struct btd_device *device)
 	return device->disconn_timer > 0;
 }
 
-void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
+void device_set_ltk(struct btd_device *device, const uint8_t val[16],
+				bool central, uint8_t enc_size)
 {
-	device->ltk_enc_size = enc_size;
-	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
+	if (!device->ltk)
+		device->ltk = new0(struct ltk_info, 1);
+
+	memcpy(device->ltk->key, val, sizeof(device->ltk->key));
+	device->ltk->central = central;
+	device->ltk->enc_size = enc_size;
+	bt_att_set_enc_key_size(device->att, enc_size);
+
+	if (device->sirk && device->sirk->encrypted)
+		btd_set_add_device(device, device->ltk->key, device->sirk->key,
+						device->sirk->size,
+						device->sirk->rank);
+}
+
+bool btd_device_add_set(struct btd_device *device, bool encrypted,
+				uint8_t sirk[16], uint8_t size, uint8_t rank)
+{
+	if (encrypted && !device->ltk)
+		return false;
+
+	if (!device->sirk)
+		device->sirk = new0(struct sirk_info, 1);
+
+	device->sirk->encrypted = encrypted;
+	memcpy(device->sirk->key, sirk, sizeof(device->sirk->key));
+	device->sirk->size = size;
+	device->sirk->rank = rank;
+
+	btd_set_add_device(device, encrypted ? device->ltk->key : NULL, sirk,
+							size, rank);
+
+	store_device_info(device);
+
+	return true;
 }
 
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
@@ -3290,6 +3357,39 @@ fail:
 	return NULL;
 }
 
+static struct sirk_info *load_sirk(GKeyFile *key_file)
+{
+	const char *group = "SetIdentityResolvingKey";
+	struct sirk_info *sirk;
+	char *str;
+	int i;
+
+	str = g_key_file_get_string(key_file, group, "Key", NULL);
+	if (!str)
+		return NULL;
+
+	sirk = g_new0(struct sirk_info, 1);
+
+	for (i = 0; i < 16; i++) {
+		if (sscanf(str + (i * 2), "%2hhx", &sirk->key[i]) != 1)
+			goto fail;
+	}
+
+
+	sirk->encrypted = g_key_file_get_boolean(key_file, group, "Encrypted",
+									NULL);
+	sirk->size = g_key_file_get_integer(key_file, group, "Size", NULL);
+	sirk->rank = g_key_file_get_integer(key_file, group, "Rank", NULL);
+	g_free(str);
+
+	return sirk;
+
+fail:
+	g_free(str);
+	g_free(sirk);
+	return NULL;
+}
+
 static void load_services(struct btd_device *device, char **uuids)
 {
 	char **uuid;
@@ -3430,6 +3530,12 @@ static void load_info(struct btd_device *device, const char *local,
 
 		device->local_csrk = load_csrk(key_file, "LocalSignatureKey");
 		device->remote_csrk = load_csrk(key_file, "RemoteSignatureKey");
+
+		device->sirk = load_sirk(key_file);
+		if (device->sirk && !device->sirk->encrypted)
+			btd_set_add_device(device, NULL, device->sirk->key,
+						device->sirk->size,
+						device->sirk->rank);
 	}
 
 	g_strfreev(techno);
@@ -5207,7 +5313,9 @@ static void gatt_server_init(struct btd_device *device,
 		return;
 	}
 
-	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
+	if (device->ltk)
+		bt_att_set_enc_key_size(device->att, device->ltk->enc_size);
+
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
 
 	btd_gatt_database_server_connected(database, device->server);
@@ -6928,3 +7036,9 @@ int8_t btd_device_get_volume(struct btd_device *device)
 {
 	return device->volume;
 }
+
+void btd_device_foreach_ad(struct btd_device *dev, bt_ad_func_t func,
+							void *data)
+{
+	bt_ad_foreach_data(dev->ad, func, data);
+}
diff --git a/src/device.h b/src/device.h
index 9e81fda9e948..96347ff229cc 100644
--- a/src/device.h
+++ b/src/device.h
@@ -128,8 +128,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 								bool *remove);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
-void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size);
-
+void device_set_ltk(struct btd_device *device, const uint8_t val[16],
+				bool central, uint8_t enc_size);
+bool btd_device_add_set(struct btd_device *device, bool encrypted,
+				uint8_t sirk[16], uint8_t size, uint8_t rank);
 void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 								uint16_t value);
 void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
@@ -188,3 +190,8 @@ void btd_device_cleanup(void);
 
 void btd_device_set_volume(struct btd_device *dev, int8_t volume);
 int8_t btd_device_get_volume(struct btd_device *dev);
+
+typedef void (*bt_device_ad_func_t)(void *data, void *user_data);
+
+void btd_device_foreach_ad(struct btd_device *dev, bt_device_ad_func_t func,
+							void *data);
diff --git a/src/set.c b/src/set.c
new file mode 100644
index 000000000000..6b3cd82651e6
--- /dev/null
+++ b/src/set.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+
+#include "gdbus/gdbus.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/ad.h"
+#include "src/shared/crypto.h"
+
+#include "log.h"
+#include "error.h"
+#include "adapter.h"
+#include "device.h"
+#include "dbus-common.h"
+#include "set.h"
+
+static struct queue *set_list;
+
+struct btd_device_set {
+	struct btd_adapter *adapter;
+	char *path;
+	uint8_t sirk[16];
+	uint8_t size;
+	uint8_t rank;
+	bool auto_connect;
+	struct queue *devices;
+	struct btd_device *device;
+};
+
+static DBusMessage *set_disconnect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	/* TODO */
+	return NULL;
+}
+
+static DBusMessage *set_connect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	/* TODO */
+	return NULL;
+}
+
+static const GDBusMethodTable set_methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Disconnect", NULL, NULL,
+						set_disconnect) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Connect", NULL, NULL,
+						set_connect) },
+	{}
+};
+
+static gboolean get_auto_connect(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device_set *set = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+						&set->auto_connect);
+
+	return TRUE;
+}
+
+static void set_auto_connect(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					 GDBusPendingPropertySet id, void *data)
+{
+	struct btd_device_set *set = data;
+	dbus_bool_t b;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &b);
+
+	set->auto_connect = b ? true : false;
+
+	g_dbus_pending_property_success(id);
+}
+
+static void append_device(void *data, void *user_data)
+{
+	struct btd_device *device = data;
+	const char *path = device_get_path(device);
+	DBusMessageIter *entry = user_data;
+
+	dbus_message_iter_append_basic(entry, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static gboolean get_devices(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device_set *set = data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING,
+					&entry);
+
+	queue_foreach(set->devices, append_device, &entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static gboolean get_size(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device_set *set = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &set->size);
+
+	return TRUE;
+}
+
+static gboolean get_rank(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device_set *set = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &set->rank);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable set_properties[] = {
+	{ "AutoConnect", "b", get_auto_connect, set_auto_connect, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Devices", "ao", get_devices, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Size", "y", get_size, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Rank", "y", get_rank, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{}
+};
+
+static void set_free(void *data)
+{
+	struct btd_device_set *set = data;
+
+	queue_destroy(set->devices, NULL);
+	free(set);
+}
+
+static struct btd_device_set *set_new(struct btd_device *device,
+					uint8_t sirk[16], uint8_t size,
+					uint8_t rank)
+{
+	struct btd_device_set *set;
+
+	set = new0(struct btd_device_set, 1);
+	set->adapter = device_get_adapter(device);
+	memcpy(set->sirk, sirk, sizeof(set->sirk));
+	set->size = size;
+	set->rank = rank;
+	set->auto_connect = true;
+	set->devices = queue_new();
+	queue_push_tail(set->devices, device);
+	set->path = g_strdup_printf("%s/set_%02x%02x%02x%02x%02x%02x%02x%02x"
+					"%02x%02x%02x%02x%02x%02x%02x%02x",
+					adapter_get_path(set->adapter),
+					sirk[15], sirk[14], sirk[13], sirk[12],
+					sirk[11], sirk[10], sirk[9], sirk[8],
+					sirk[7], sirk[6], sirk[5], sirk[4],
+					sirk[3], sirk[2], sirk[1], sirk[0]);
+
+	DBG("Creating set %s", set->path);
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					set->path, BTD_DEVICE_SET_INTERFACE,
+					set_methods, NULL,
+					set_properties, set,
+					set_free) == FALSE) {
+		error("Unable to register set interface");
+		set_free(set);
+		return NULL;
+	}
+
+	return set;
+}
+
+static struct btd_device_set *set_find(struct btd_device *device,
+						uint8_t sirk[16])
+{
+	struct btd_adapter *adapter = device_get_adapter(device);
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(set_list); entry; entry = entry->next) {
+		struct btd_device_set *set = entry->data;
+
+		if (set->adapter != adapter)
+			continue;
+
+		if (!memcmp(set->sirk, sirk, sizeof(set->sirk)))
+			return set;
+	}
+
+	return NULL;
+}
+
+static void set_connect_next(struct btd_device_set *set)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(set->devices); entry;
+					entry = entry->next) {
+		struct btd_device *device = entry->data;
+
+		/* Only connect one at time(?) */
+		if (!device_connect_le(device))
+			return;
+	}
+}
+
+static void set_add(struct btd_device_set *set, struct btd_device *device)
+{
+	/* Check if device is already part of the set then skip to connect */
+	if (queue_find(set->devices, NULL, device))
+		goto done;
+
+	DBG("set %s device %s", set->path, device_get_path(device));
+
+	queue_push_tail(set->devices, device);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), set->path,
+					BTD_DEVICE_SET_INTERFACE, "Devices");
+
+done:
+	/* Check if set is marked to auto-connect */
+	if (btd_device_is_connected(device) && set->auto_connect)
+		set_connect_next(set);
+}
+
+static void foreach_rsi(void *data, void *user_data)
+{
+	struct bt_ad_data *ad = data;
+	struct btd_device_set *set = user_data;
+	struct bt_crypto *crypto;
+	uint8_t res[3];
+
+	if (ad->type != BT_AD_CSIP_RSI || ad->len < 6)
+		return;
+
+	crypto = bt_crypto_new();
+	if (!crypto)
+		return;
+
+	if (!bt_crypto_sih(crypto, set->sirk, ad->data + 3, res)) {
+		bt_crypto_unref(crypto);
+		return;
+	}
+
+	bt_crypto_unref(crypto);
+
+	if (!memcmp(ad->data, res, sizeof(res)))
+		device_connect_le(set->device);
+}
+
+static void foreach_device(struct btd_device *device, void *data)
+{
+	struct btd_device_set *set = data;
+
+	/* Check if device is already part of the set then skip */
+	if (queue_find(set->devices, NULL, device))
+		return;
+
+	set->device = device;
+
+	btd_device_foreach_ad(device, foreach_rsi, set);
+}
+
+void btd_set_add_device(struct btd_device *device, uint8_t *key,
+				uint8_t sirk[16], uint8_t size, uint8_t rank)
+{
+	struct btd_device_set *set;
+
+	/* In case key has been set it means SIRK is encrypted */
+	if (key) {
+		struct bt_crypto *crypto = bt_crypto_new();
+
+		if (!crypto)
+			return;
+
+		/* sef and sdf are symmetric */
+		bt_crypto_sef(crypto, key, sirk, sirk);
+
+		bt_crypto_unref(crypto);
+	}
+
+	/* Check if DeviceSet already exists */
+	set = set_find(device, sirk);
+	if (set) {
+		set_add(set, device);
+		return;
+	}
+
+	set = set_new(device, sirk, size, rank);
+	if (!set)
+		return;
+
+	if (!set_list)
+		set_list = queue_new();
+
+	queue_push_tail(set_list, set);
+
+	/* Attempt to add devices which have matching RSI */
+	btd_adapter_for_each_device(device_get_adapter(device), foreach_device,
+									set);
+}
diff --git a/src/set.h b/src/set.h
new file mode 100644
index 000000000000..c3831ef9ca66
--- /dev/null
+++ b/src/set.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation
+ *
+ *
+ */
+
+#define BTD_DEVICE_SET_INTERFACE	"org.bluez.DeviceSet1"
+
+void btd_set_add_device(struct btd_device *device, uint8_t *ltk,
+				uint8_t sirk[16], uint8_t size, uint8_t rank);
-- 
2.39.2

