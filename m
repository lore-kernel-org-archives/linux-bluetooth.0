Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 06/18] Add support for creating devices from stored types
Date: Tue, 21 Dec 2010 19:26:28 -0200
Message-Id: <1292966800-6264-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a way to restore devices from their types.
---
 src/adapter.c |   28 ++++++++++++++++++++++++++++
 src/device.c  |    8 ++++++++
 src/device.h  |    1 +
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ea81722..9c57bea 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1906,6 +1906,31 @@ static void create_stored_device_from_blocked(char *key, char *value,
 	}
 }
 
+static void create_stored_device_from_types(char *key, char *value,
+							void *user_data)
+{
+	GSList *l;
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *device;
+	uint8_t type;
+
+	type = strtol(value, NULL, 16);
+
+	l = g_slist_find_custom(adapter->devices,
+				key, (GCompareFunc) device_address_cmp);
+	if (l) {
+		device = l->data;
+		device_set_type(device, type);
+		return;
+	}
+
+	device = device_create(connection, adapter, key, type);
+	if (device) {
+		device_set_temporary(device, FALSE);
+		adapter->devices = g_slist_append(adapter->devices, device);
+	}
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -1933,6 +1958,9 @@ static void load_devices(struct btd_adapter *adapter)
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "types");
+	textfile_foreach(filename, create_stored_device_from_types, adapter);
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/device.c b/src/device.c
index ca2c5bc..d67f804 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1767,6 +1767,14 @@ uint8_t device_get_auth(struct btd_device *device)
 	return device->auth;
 }
 
+void device_set_type(struct btd_device *device, device_type_t type)
+{
+	if (!device)
+		return;
+
+	device->type = type;
+}
+
 static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index 74b968c..7820636 100644
--- a/src/device.h
+++ b/src/device.h
@@ -66,6 +66,7 @@ gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_cap(struct btd_device *device, uint8_t cap);
+void device_set_type(struct btd_device *device, device_type_t type);
 uint8_t device_get_cap(struct btd_device *device);
 void device_set_auth(struct btd_device *device, uint8_t auth);
 uint8_t device_get_auth(struct btd_device *device);
-- 
1.7.3.4

