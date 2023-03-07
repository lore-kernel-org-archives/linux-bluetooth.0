Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E01FC678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCGWZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCGWZU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4966B47430
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:24:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso152164pjs.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDk89JeAshy+PSg7OOFte0Xd+S6Ux3KmprwIlkATpDI=;
        b=FBwqFhAHFgR6wsWvuAnhBGycF8D5kNbK5X7OP4HbXFDLlC9qlWYsKicNLiWWkdQvkD
         CL7XA99eldEteBWgJ49F0rgdh/1B49ZZlGVvd3Pp62qkHszrx5JduNttYE4V74j50VX7
         GW4olBtDj/kKhzYq2n9bBQ+daYWJDCylkbuZ0EzdsvbANBXDJWCvNMQYEYTzUqyF9/TV
         aKPqehs3BVZgs3ph80CbTsV3FkWfirWC9aHSoUC44E163NzlaOMWG84V2V/cBgFO+iux
         BT5a7WQ0x5CUCrznAVq5B+JA+PmRhRroyIpb5SgNk3BXrZAwvZFUccOzZOCecgzQ+ec4
         nfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDk89JeAshy+PSg7OOFte0Xd+S6Ux3KmprwIlkATpDI=;
        b=cvCck61Shiz8F/XIeevxed1CA2nL284pvkyDKwzZ0feHmOl75HOfZyBgNN2KVyQGNz
         DS3b7vyrPpcGN10XuQDT/5O4rURlDF322806cDQNyMTUfqpxydlrriTBr6EBwSyHuwnI
         0u7kNhp49XYic2p2I7zHteaTx8GcBLkmeI54bjmbBjoYRXnObfnVbgsTV6Ka5a+K7VXB
         i2aD5C5NVAGEYhKN5V0pJIbJwO2QpVQJFbUGWOgZbzQxW3tD7j6mk8FqEYtfbIDSJ3MF
         vLHRCqZk1P/3IZ0N/ZVIOgOLLnID8XqDv/DfcCL1zMYeoS8oJbhmN+vfaksu6qgMKiAl
         cZMQ==
X-Gm-Message-State: AO0yUKVFhTp/lNCVdDTPrZVNO9wtLIq8cF+OyJOSxvw0UyFCcxrFMwdY
        /9gS9O4dPWny3IZG+eF2do+wJyqrQz4=
X-Google-Smtp-Source: AK7set8NbU3ZXqm3WmI/XcUScqs6e8SFEk+MDCdN0bHRM+AG4Wn94xio7z6yi/R7SdfHCGyxeZgA8A==
X-Received: by 2002:a17:902:dac3:b0:19a:a6ec:6721 with SMTP id q3-20020a170902dac300b0019aa6ec6721mr19997524plx.16.1678227869502;
        Tue, 07 Mar 2023 14:24:29 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 05/12] core: Add initial implementation of DeviceSet interface
Date:   Tue,  7 Mar 2023 14:24:15 -0800
Message-Id: <20230307222422.2608483-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
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
 src/device.c  | 283 +++++++++++++++++++++++++++++++++++++-
 src/device.h  |  11 +-
 src/set.c     | 371 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/set.h     |  20 +++
 6 files changed, 683 insertions(+), 11 deletions(-)
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
index cb16d37c1ae1..df50ce7b4f6c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -64,6 +64,7 @@
 #include "storage.h"
 #include "eir.h"
 #include "settings.h"
+#include "set.h"
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		1
@@ -159,11 +160,25 @@ struct bearer_state {
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
+	struct btd_device_set *set;
+	uint8_t encrypted;
+	uint8_t key[16];
+	uint8_t size;
+	uint8_t rank;
+};
+
 enum {
 	WAKE_FLAG_DEFAULT = 0,
 	WAKE_FLAG_ENABLED,
@@ -253,7 +268,8 @@ struct btd_device {
 
 	struct csrk_info *local_csrk;
 	struct csrk_info *remote_csrk;
-	uint8_t ltk_enc_size;
+	struct ltk_info *ltk;
+	struct queue	*sirks;
 
 	sdp_list_t	*tmp_records;
 
@@ -386,6 +402,24 @@ static void store_csrk(struct csrk_info *csrk, GKeyFile *key_file,
 	g_key_file_set_integer(key_file, group, "Counter", csrk->counter);
 }
 
+static void store_sirk(struct sirk_info *sirk, GKeyFile *key_file,
+						uint8_t index)
+{
+	char group[28];
+	char key[33];
+	int i;
+
+	sprintf(group, "SetIdentityResolvingKey#%u", index);
+
+	for (i = 0; i < 16; i++)
+		sprintf(key + (i * 2), "%2.2X", sirk->key[i]);
+
+	g_key_file_set_boolean(key_file, group, "Encrypted", sirk->encrypted);
+	g_key_file_set_string(key_file, group, "Key", key);
+	g_key_file_set_integer(key_file, group, "Size", sirk->size);
+	g_key_file_set_integer(key_file, group, "Rank", sirk->rank);
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -483,6 +517,18 @@ static gboolean store_device_info_cb(gpointer user_data)
 	if (device->remote_csrk)
 		store_csrk(device->remote_csrk, key_file, "RemoteSignatureKey");
 
+	if (!queue_isempty(device->sirks)) {
+		const struct queue_entry *entry;
+		int i;
+
+		for (entry = queue_get_entries(device->sirks), i = 0; entry;
+						entry = entry->next, i++) {
+			struct sirk_info *sirk = entry->data;
+
+			store_sirk(sirk, key_file, i);
+		}
+	}
+
 	str = g_key_file_to_data(key_file, &length, NULL);
 	if (!g_file_set_contents(filename, str, length, &gerr)) {
 		error("Unable set contents for %s: (%s)", filename,
@@ -804,8 +850,11 @@ static void device_free(gpointer user_data)
 	if (device->eir_uuids)
 		g_slist_free_full(device->eir_uuids, g_free);
 
+	queue_destroy(device->sirks, free);
+
 	g_free(device->local_csrk);
 	g_free(device->remote_csrk);
+	free(device->ltk);
 	g_free(device->path);
 	g_free(device->alias);
 	free(device->modalias);
@@ -1607,6 +1656,62 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
+static void append_set(void *data, void *user_data)
+{
+	struct sirk_info *info = data;
+	const char *path = btd_set_get_path(info->set);
+	DBusMessageIter *iter = user_data;
+	DBusMessageIter entry, dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	g_dbus_dict_append_entry(&dict, "Rank", DBUS_TYPE_BYTE, &info->rank);
+
+	dbus_message_iter_close_container(&entry, &dict);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+static gboolean dev_property_get_set(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+
+	queue_foreach(device->sirks, append_set, &array);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean dev_property_set_exists(const GDBusPropertyTable *property,
+						void *data)
+{
+	struct btd_device *device = data;
+
+	return !queue_isempty(device->sirks);
+}
+
 static bool disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1792,10 +1897,97 @@ bool device_is_disconnecting(struct btd_device *device)
 	return device->disconn_timer > 0;
 }
 
-void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
+static void add_set(void *data, void *user_data)
 {
-	device->ltk_enc_size = enc_size;
-	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
+	struct sirk_info *sirk = data;
+	struct btd_device *device = user_data;
+	struct btd_device_set *set;
+
+	if (!sirk->encrypted)
+		return;
+
+	set = btd_set_add_device(device, device->ltk->key, sirk->key,
+							sirk->size);
+	if (!set)
+		return;
+
+	if (sirk->set != set) {
+		sirk->set = set;
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+					     DEVICE_INTERFACE, "Sets");
+	}
+}
+
+void device_set_ltk(struct btd_device *device, const uint8_t val[16],
+				bool central, uint8_t enc_size)
+{
+	if (!device->ltk)
+		device->ltk = new0(struct ltk_info, 1);
+
+	memcpy(device->ltk->key, val, sizeof(device->ltk->key));
+	device->ltk->central = central;
+	device->ltk->enc_size = enc_size;
+	bt_att_set_enc_key_size(device->att, enc_size);
+
+	/* Check if there is any set/sirk that needs decryption */
+	queue_foreach(device->sirks, add_set, device);
+}
+
+static bool match_sirk(const void *data, const void *match_data)
+{
+	const struct sirk_info *sirk = data;
+	const uint8_t *key = match_data;
+
+	return !memcmp(sirk->key, key, sizeof(sirk->key));
+}
+
+static struct sirk_info *device_add_sirk_info(struct btd_device *device,
+					      bool encrypted, uint8_t key[16],
+					      uint8_t size, uint8_t rank)
+{
+	struct sirk_info *sirk;
+
+	sirk = queue_find(device->sirks, match_sirk, key);
+	if (sirk)
+		return sirk;
+
+	sirk = new0(struct sirk_info, 1);
+	sirk->encrypted = encrypted;
+	memcpy(sirk->key, key, sizeof(sirk->key));
+	sirk->size = size;
+	sirk->rank = rank;
+
+	queue_push_tail(device->sirks, sirk);
+	store_device_info(device);
+
+	return sirk;
+}
+
+bool btd_device_add_set(struct btd_device *device, bool encrypted,
+				uint8_t key[16], uint8_t size, uint8_t rank)
+{
+	struct btd_device_set *set;
+	struct sirk_info *sirk;
+
+	if (encrypted && !device->ltk)
+		return false;
+
+	sirk = device_add_sirk_info(device, encrypted, key, size, rank);
+	if (!sirk)
+		return false;
+
+	set = btd_set_add_device(device, encrypted ? device->ltk->key : NULL,
+						key, size);
+	if (!set)
+		return false;
+
+	if (sirk->set != set) {
+		sirk->set = set;
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+					     DEVICE_INTERFACE, "Sets");
+	}
+
+	return true;
 }
 
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
@@ -2996,6 +3188,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
 				dev_property_set_wake_allowed,
 				dev_property_wake_allowed_exist },
+	{ "Sets", "a{oa{sv}}", dev_property_get_set, NULL,
+				dev_property_set_exists },
 	{ }
 };
 
@@ -3290,6 +3484,63 @@ fail:
 	return NULL;
 }
 
+static struct sirk_info *load_sirk(GKeyFile *key_file, uint8_t index)
+{
+	char group[28];
+	struct sirk_info *sirk;
+	char *str;
+	int i;
+
+	sprintf(group, "SetIdentityResolvingKey#%u", index);
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
+static void load_sirks(struct btd_device *device, GKeyFile *key_file)
+{
+	struct sirk_info *sirk;
+	uint8_t i;
+
+	for (i = 0; i < UINT8_MAX; i++) {
+		sirk = load_sirk(key_file, i);
+		if (!sirk)
+			break;
+
+		queue_push_tail(device->sirks, sirk);
+
+		/* Only add DeviceSet object if sirk does need
+		 * decryption otherwise it has to wait for the LTK in
+		 * order to decrypt.
+		 */
+		if (!sirk->encrypted)
+			btd_set_add_device(device, NULL, sirk->key,
+							sirk->size);
+	}
+}
+
 static void load_services(struct btd_device *device, char **uuids)
 {
 	char **uuid;
@@ -3430,6 +3681,8 @@ static void load_info(struct btd_device *device, const char *local,
 
 		device->local_csrk = load_csrk(key_file, "LocalSignatureKey");
 		device->remote_csrk = load_csrk(key_file, "RemoteSignatureKey");
+
+		load_sirks(device, key_file);
 	}
 
 	g_strfreev(techno);
@@ -3945,6 +4198,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	}
 
 	device->adapter = adapter;
+	device->sirks = queue_new();
 	device->temporary = true;
 
 	device->db_id = gatt_db_register(device->db, gatt_service_added,
@@ -5207,7 +5461,9 @@ static void gatt_server_init(struct btd_device *device,
 		return;
 	}
 
-	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
+	if (device->ltk)
+		bt_att_set_enc_key_size(device->att, device->ltk->enc_size);
+
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
 
 	btd_gatt_database_server_connected(database, device->server);
@@ -6760,6 +7016,14 @@ struct btd_device *btd_device_ref(struct btd_device *device)
 	return device;
 }
 
+static void remove_sirk_info(void *data, void *user_data)
+{
+	struct sirk_info *info = data;
+	struct btd_device *device = user_data;
+
+	btd_set_remove_device(info->set, device);
+}
+
 void btd_device_unref(struct btd_device *device)
 {
 	if (__sync_sub_and_fetch(&device->ref_count, 1))
@@ -6770,6 +7034,9 @@ void btd_device_unref(struct btd_device *device)
 		return;
 	}
 
+	if (!queue_isempty(device->sirks))
+		queue_foreach(device->sirks, remove_sirk_info, device);
+
 	DBG("Freeing device %s", device->path);
 
 	g_dbus_unregister_interface(dbus_conn, device->path, DEVICE_INTERFACE);
@@ -6928,3 +7195,9 @@ int8_t btd_device_get_volume(struct btd_device *device)
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
index 000000000000..5836a06b887a
--- /dev/null
+++ b/src/set.c
@@ -0,0 +1,371 @@
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
+static gboolean get_adapter(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device_set *set = data;
+	const char *path = adapter_get_path(set->adapter);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
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
+static const GDBusPropertyTable set_properties[] = {
+	{ "Adapter", "o", get_adapter, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "AutoConnect", "b", get_auto_connect, set_auto_connect, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Devices", "ao", get_devices, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Size", "y", get_size, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{}
+};
+
+static void set_free(void *data)
+{
+	struct btd_device_set *set = data;
+
+	queue_destroy(set->devices, NULL);
+	g_free(set->path);
+	free(set);
+}
+
+static struct btd_device_set *set_new(struct btd_device *device,
+					uint8_t sirk[16], uint8_t size)
+{
+	struct btd_device_set *set;
+
+	set = new0(struct btd_device_set, 1);
+	set->adapter = device_get_adapter(device);
+	memcpy(set->sirk, sirk, sizeof(set->sirk));
+	set->size = size;
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
+	if (!memcmp(ad->data, res, sizeof(res))) {
+		btd_device_set_temporary(set->device, false);
+		device_connect_le(set->device);
+	}
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
+struct btd_device_set *btd_set_add_device(struct btd_device *device,
+						uint8_t *key, uint8_t sirk[16],
+						uint8_t size)
+{
+	struct btd_device_set *set;
+
+	/* In case key has been set it means SIRK is encrypted */
+	if (key) {
+		struct bt_crypto *crypto = bt_crypto_new();
+
+		if (!crypto)
+			return NULL;
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
+		return set;
+	}
+
+	set = set_new(device, sirk, size);
+	if (!set)
+		return NULL;
+
+	if (!set_list)
+		set_list = queue_new();
+
+	queue_push_tail(set_list, set);
+
+	/* Attempt to add devices which have matching RSI */
+	btd_adapter_for_each_device(device_get_adapter(device), foreach_device,
+									set);
+
+	return set;
+}
+
+bool btd_set_remove_device(struct btd_device_set *set,
+						struct btd_device *device)
+{
+	if (!set || !device)
+		return false;
+
+	if (!queue_remove_if(set->devices, NULL, device))
+		return false;
+
+	if (!queue_isempty(set->devices)) {
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						set->path,
+						BTD_DEVICE_SET_INTERFACE,
+						"Devices");
+		return true;
+	}
+
+	if (!queue_remove(set_list, set))
+		return false;
+
+	/* Unregister if there are no devices left in the set */
+	g_dbus_unregister_interface(btd_get_dbus_connection(), set->path,
+						BTD_DEVICE_SET_INTERFACE);
+
+	return true;
+}
+
+const char *btd_set_get_path(struct btd_device_set *set)
+{
+	return set->path;
+}
diff --git a/src/set.h b/src/set.h
new file mode 100644
index 000000000000..67177e8c7946
--- /dev/null
+++ b/src/set.h
@@ -0,0 +1,20 @@
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
+struct btd_device_set;
+
+struct btd_device_set *btd_set_add_device(struct btd_device *device,
+						uint8_t *ltk, uint8_t sirk[16],
+						uint8_t size);
+bool btd_set_remove_device(struct btd_device_set *set,
+						struct btd_device *device);
+const char *btd_set_get_path(struct btd_device_set *set);
-- 
2.39.2

