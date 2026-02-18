Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BB2F6911
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404741; cv=none; b=iQ52j9O1QO7R4eYZExLG1CiNuyY5htuGrJdXLbgri6UGKOjj4NJenajBNQ+T1ek42XzwKv5utJvdLKrm/9ld1KQAdReHi3FCJ1W5hW3xA7s/NRDPfFMubxVSaVOjyIZQBJm1HSUGMyCieO/suPPSMQeWYGhEiSh7PoS8EXdshks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404741; c=relaxed/simple;
	bh=23WCkPwwd69gHyJ5yRwfVq2R9uKH5/eM5pTY6cDC8Cs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvB2QwGuOGu/dorqAKf+zjc4mYQNQ5y42R5qGq3HaQY/kLkfzj4pw0MTqlPV9Y66IOH0P1QCdrlz40XqrqeD9AcZblMT+o7orfybKcmjlJeIHrDCDjRXGWpUwUUJCYpbo4BRkhBTpAUUvXwkajuZ1Qqg0455jNKdfaskQ+Q8OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hxjAyp3a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hxjAyp3a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771404731;
	bh=23WCkPwwd69gHyJ5yRwfVq2R9uKH5/eM5pTY6cDC8Cs=;
	h=From:To:Subject:Date:From;
	b=hxjAyp3aawxoc2/gucEd7dExUgWZOLmOeI8iJJaeWGOCsgXUQTMv9xgqkH7UeLqeB
	 WB+Q8KdK1U2PvZDsDZ82UT/BijKz2hZzm3VRV/xO2rM9w1IQiwsdUcYBWEB0ZP2j3l
	 q0VVFK0xKrDUIitpFaaLoqvSigMyQJs6q7GkNIdKVth3FLB+s4gS+Y1oCcjxOXMvjF
	 gwquLxQul6aZoy85PUsEjIYPQuhq4679t7r8j+28cxsZ/QlRrhFAfq2CXN8oTEr8g/
	 icqn3pMVihiN/QvdcxRoNeP+9f1F3j/aeoQs9EEk0K6L+mGSIznGWLpC96bVbMUdmg
	 arWl1DVxroj4A==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-cC3f-1f1f-43a6-bf9b.rev.sfr.net [IPv6:2a02:8428:af44:1001:cc3f:1f1f:43a6:bf9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A564417E12A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 09:52:11 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] client/btpclient: Add GATT support to get Device name
Date: Wed, 18 Feb 2026 09:52:06 +0100
Message-ID: <20260218085206.498756-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add GATT support to btpclient so the it can read the "Device Name"
characteristic (UUID 0x2A00) from the DBus interface resolved during
device connection.

The device connected event is postponed until ServicesResolved property
is set to true to ensure that the services, characteristics and
descriptors lists has been fully populated.

This allows to pass GAP/IDLE/NAMP/BV-01-C.
---
v1 -> v2: Fix memory leak
v2 -> v3:
 - Rebase to client/btpclient
 - store attributes informations
 - postponed connection event after services are resolved
 - Rework it to read UUID to get real attribute value

 Makefile.tools               |   3 +-
 client/btpclient/btpclient.c | 239 ++++++++++++++++++++++++++++++++++-
 client/btpclient/btpclient.h |   9 ++
 client/btpclient/core.c      |  14 ++
 client/btpclient/gap.c       |  22 +++-
 client/btpclient/gatt.c      | 215 +++++++++++++++++++++++++++++++
 client/btpclient/gatt.h      |  13 ++
 src/shared/btp.h             |  24 ++++
 8 files changed, 534 insertions(+), 5 deletions(-)
 create mode 100644 client/btpclient/gatt.c
 create mode 100644 client/btpclient/gatt.h

diff --git a/Makefile.tools b/Makefile.tools
index 589f7c94f..a7da6554c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -589,7 +589,8 @@ client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
 				client/btpclient/btpclient.h \
 				src/shared/btp.c src/shared/btp.h \
 				client/btpclient/core.c client/btpclient/core.h \
-				client/btpclient/gap.c client/btpclient/gap.h
+				client/btpclient/gap.c client/btpclient/gap.h \
+				client/btpclient/gatt.c client/btpclient/gatt.h
 client_btpclient_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 client/btpclient/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index e46d2366f..ee46966dc 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -22,10 +22,12 @@
 #include <ell/ell.h>
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
 #include "core.h"
 #include "gap.h"
+#include "gatt.h"
 
 static struct l_dbus *dbus;
 
@@ -46,7 +48,6 @@ struct btp_agent *get_agent(void)
 	return &ag;
 }
 
-
 static bool match_dev_addr_type(const char *addr_type_str, uint8_t addr_type)
 {
 	if (addr_type == BTP_GAP_ADDR_PUBLIC && strcmp(addr_type_str, "public"))
@@ -202,6 +203,112 @@ struct btp_device *find_device_by_proxy(struct l_dbus_proxy *proxy)
 	return NULL;
 }
 
+static bool match_device_service_path(const void *device, const void *path)
+{
+	const struct btp_device *dev = device;
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(dev->services); entry;
+							entry = entry->next) {
+		struct gatt_attribute *attribute = entry->data;
+		struct l_dbus_proxy *proxy = attribute->proxy;
+
+		if (!strcmp(l_dbus_proxy_get_path(proxy), path))
+			return true;
+	}
+
+	return false;
+}
+
+static struct btp_device *find_device_by_service_path(const char *path)
+{
+	const struct l_queue_entry *entry;
+	struct btp_device *device;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		device = l_queue_find(adapter->devices,
+					match_device_service_path, path);
+		if (device)
+			return device;
+	}
+
+	return NULL;
+}
+
+static bool match_device_service_proxy(const void *device, const void *proxy)
+{
+	const struct btp_device *dev = device;
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(dev->services); entry;
+							entry = entry->next) {
+		struct gatt_attribute *attribute = entry->data;
+
+		if (attribute->proxy == proxy)
+			return true;
+	}
+
+	return false;
+}
+
+static struct btp_device *find_device_by_service_proxy(
+						struct l_dbus_proxy *proxy)
+{
+	const struct l_queue_entry *entry;
+	struct btp_device *device;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		device = l_queue_find(adapter->devices,
+					match_device_service_proxy, proxy);
+		if (device)
+			return device;
+	}
+
+	return NULL;
+}
+
+static bool match_device_characteristic_path(const void *device,
+							const void *path)
+{
+	const struct btp_device *dev = device;
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(dev->characteristics); entry;
+							entry = entry->next) {
+		struct gatt_attribute *attribute = entry->data;
+		struct l_dbus_proxy *proxy = attribute->proxy;
+
+		if (!strcmp(l_dbus_proxy_get_path(proxy), path))
+			return true;
+	}
+
+	return false;
+}
+
+static struct btp_device *find_device_by_characteristic_path(const char *path)
+{
+	const struct l_queue_entry *entry;
+	struct btp_device *device;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		device = l_queue_find(adapter->devices,
+				match_device_characteristic_path, path);
+		if (device)
+			return device;
+	}
+
+	return NULL;
+}
+
 static void signal_handler(uint32_t signo, void *user_data)
 {
 	switch (signo) {
@@ -215,6 +322,9 @@ static void signal_handler(uint32_t signo, void *user_data)
 
 static void btp_device_free(struct btp_device *device)
 {
+	l_queue_destroy(device->services, l_free);
+	l_queue_destroy(device->characteristics, l_free);
+	l_queue_destroy(device->descriptors, l_free);
 	l_free(device);
 }
 
@@ -306,6 +416,9 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 		device = l_new(struct btp_device, 1);
 		device->proxy = proxy;
+		device->services = l_queue_new();
+		device->characteristics = l_queue_new();
+		device->descriptors = l_queue_new();
 
 		l_queue_push_tail(adapter->devices, device);
 
@@ -346,6 +459,100 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 		return;
 	}
+
+	if (!strcmp(interface, "org.bluez.GattService1")) {
+		char *str;
+		struct btp_device *device;
+		struct gatt_attribute *attribute;
+
+		if (!l_dbus_proxy_get_property(proxy, "Device", "o", &str))
+			return;
+
+		device = find_device_by_path(str);
+		if (!device)
+			return;
+
+		attribute = l_new(struct gatt_attribute, 1);
+		attribute->proxy = proxy;
+		if (!l_dbus_proxy_get_property(proxy, "Handle", "q",
+						&attribute->handle)) {
+			l_free(attribute);
+			return;
+		}
+		if (!l_dbus_proxy_get_property(proxy, "UUID", "s", &str)) {
+			l_free(attribute);
+			return;
+		}
+		if (bt_string_to_uuid(&attribute->uuid, str)) {
+			l_free(attribute);
+			return;
+		}
+
+		l_queue_push_tail(device->services, attribute);
+	}
+
+	if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		struct btp_device *device;
+		struct gatt_attribute *attribute;
+		char *str;
+
+		if (!l_dbus_proxy_get_property(proxy, "Service", "o", &str))
+			return;
+
+		device = find_device_by_service_path(str);
+		if (!device)
+			return;
+
+		attribute = l_new(struct gatt_attribute, 1);
+		attribute->proxy = proxy;
+		if (!l_dbus_proxy_get_property(proxy, "Handle", "q",
+						&attribute->handle)) {
+			l_free(attribute);
+			return;
+		}
+		if (!l_dbus_proxy_get_property(proxy, "UUID", "s", &str)) {
+			l_free(attribute);
+			return;
+		}
+		if (bt_string_to_uuid(&attribute->uuid, str)) {
+			l_free(attribute);
+			return;
+		}
+
+		l_queue_push_tail(device->characteristics, attribute);
+	}
+
+	if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
+		struct btp_device *device;
+		struct gatt_attribute *attribute;
+		char *str;
+
+		if (!l_dbus_proxy_get_property(proxy, "Characteristic", "o",
+									&str))
+			return;
+
+		device = find_device_by_characteristic_path(str);
+		if (!device)
+			return;
+
+		attribute = l_new(struct gatt_attribute, 1);
+		attribute->proxy = proxy;
+		if (!l_dbus_proxy_get_property(proxy, "Handle", "q",
+						&attribute->handle)) {
+			l_free(attribute);
+			return;
+		}
+		if (!l_dbus_proxy_get_property(proxy, "UUID", "s", &str)) {
+			l_free(attribute);
+			return;
+		}
+		if (bt_string_to_uuid(&attribute->uuid, str)) {
+			l_free(attribute);
+			return;
+		}
+
+		l_queue_push_tail(device->descriptors, attribute);
+	}
 }
 
 static bool device_match_by_proxy(const void *a, const void *b)
@@ -385,6 +592,36 @@ static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
 
 		return;
 	}
+
+	if (!strcmp(interface, "org.bluez.GattService1")) {
+		struct btp_device *device;
+
+		device = find_device_by_service_proxy(proxy);
+		if (!device)
+			return;
+
+		l_queue_remove(device->services, proxy);
+	}
+
+	if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		struct btp_device *device;
+
+		device = find_device_by_service_proxy(proxy);
+		if (!device)
+			return;
+
+		l_queue_remove(device->characteristics, proxy);
+	}
+
+	if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
+		struct btp_device *device;
+
+		device = find_device_by_service_proxy(proxy);
+		if (!device)
+			return;
+
+		l_queue_remove(device->descriptors, proxy);
+	}
 }
 
 static void property_changed(struct l_dbus_proxy *proxy, const char *name,
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index d412d2eb5..e26a08413 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -21,6 +21,9 @@ struct btp_device {
 	struct l_dbus_proxy *proxy;
 	uint8_t address_type;
 	bdaddr_t address;
+	struct l_queue *services;
+	struct l_queue *characteristics;
+	struct l_queue *descriptors;
 };
 
 struct btp_agent {
@@ -29,6 +32,12 @@ struct btp_agent {
 	struct l_dbus_message *pending_req;
 };
 
+struct gatt_attribute {
+	struct l_dbus_proxy *proxy;
+	uint16_t handle;
+	bt_uuid_t uuid;
+};
+
 struct l_queue *get_adapters_list(void);
 struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy *proxy);
 struct btp_adapter *find_adapter_by_index(uint8_t index);
diff --git a/client/btpclient/core.c b/client/btpclient/core.c
index c0b8d6b74..cfff131f1 100644
--- a/client/btpclient/core.c
+++ b/client/btpclient/core.c
@@ -10,10 +10,12 @@
 #include <ell/ell.h>
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
 #include "core.h"
 #include "gap.h"
+#include "gatt.h"
 
 static struct btp *btp;
 static struct l_dbus *dbus;
@@ -81,6 +83,13 @@ static void btp_core_register(uint8_t index, const void *param,
 
 		return;
 	case BTP_GATT_SERVICE:
+		if (gatt_is_service_registered())
+			goto failed;
+
+		if (!gatt_register_service(btp, dbus, client))
+			goto failed;
+
+		break;
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
 	case BTP_CORE_SERVICE:
@@ -118,6 +127,11 @@ static void btp_core_unregister(uint8_t index, const void *param,
 		gap_unregister_service();
 		break;
 	case BTP_GATT_SERVICE:
+		if (!gatt_is_service_registered())
+			goto failed;
+
+		gatt_unregister_service(btp);
+		break;
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
 	case BTP_CORE_SERVICE:
diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 85cdad631..68e029dcc 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -16,6 +16,7 @@
 #include <ell/ell.h>
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
 #include "core.h"
@@ -2381,7 +2382,7 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 	const char *str, *addr_str;
 	int16_t rssi;
 	uint8_t address_type;
-	bool connected;
+	bool connected, resolved;
 	struct l_dbus_message_iter iter, var;
 
 	ev = l_malloc(sizeof(struct btp_device_found_ev));
@@ -2481,8 +2482,11 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
 						sizeof(*ev) + ev->eir_len, ev);
 
+	/* Postponed BTP_EV_GAP_DEVICE_CONNECTED up to services are resolved */
 	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
-								connected) {
+			l_dbus_proxy_get_property(proxy, "ServicesResolved",
+							 "b", &resolved) &&
+			connected && resolved) {
 		ev_conn.address_type = address_type;
 		str2ba(addr_str, &ev_conn.address);
 
@@ -2700,12 +2704,24 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			if (!l_dbus_message_get_arguments(msg, "b", &prop))
 				return;
 
-			btp_gap_device_connection_ev(proxy, prop);
+			/* Send disconnection event and postponed connection
+			 * event up to services are resolved.
+			 */
+			if (!prop)
+				btp_gap_device_connection_ev(proxy, prop);
 		} else if (!strcmp(name, "AddressType")) {
 			/* Address property change came first along with address
 			 * type.
 			 */
 			btp_identity_resolved_ev(proxy);
+		} else if (!strcmp(name, "ServicesResolved")) {
+			bool prop;
+
+			if (!l_dbus_message_get_arguments(msg, "b", &prop))
+				return;
+
+			if (prop)
+				btp_gap_device_connection_ev(proxy, prop);
 		}
 	}
 }
diff --git a/client/btpclient/gatt.c b/client/btpclient/gatt.c
new file mode 100644
index 000000000..c6bb254b4
--- /dev/null
+++ b/client/btpclient/gatt.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Collabora Ltd.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+
+#include <ell/ell.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+#include "src/shared/btp.h"
+#include "btpclient.h"
+#include "gatt.h"
+
+static struct btp *btp;
+static bool gatt_service_registered;
+
+static int create_uuid(bt_uuid_t *btuuid, uint8_t len, const uint8_t *data)
+{
+	if (len == 2)
+		bt_uuid16_create(btuuid, bt_get_le16(data));
+	else if (len == 4)
+		bt_uuid32_create(btuuid, bt_get_le32(data));
+	else if (len == 16) {
+		uint128_t uint128;
+
+		btoh128((uint128_t *)data, &uint128);
+		bt_uuid128_create(btuuid, uint128);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static void btp_gatt_read_commands(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	uint16_t commands = 0;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_GATT_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	commands |= (1 << BTP_OP_GATT_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_GATT_READ_UUID);
+
+	commands = L_CPU_TO_LE16(commands);
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
+			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+}
+
+static bool match_attribute_uuid(const void *attr, const void *uuid)
+{
+	const struct gatt_attribute *attribute = attr;
+
+	return !bt_uuid_cmp(&attribute->uuid, uuid);
+}
+
+static void gatt_read_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void gatt_read_uuid_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = user_data;
+	struct btp_gatt_read_uuid_rp *rp;
+	struct l_dbus_message_iter iter;
+	uint8_t *data;
+	uint32_t n;
+	uint16_t handle, rp_len;
+	struct btp_gatt_char_value *value;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to read value (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GATT_SERVICE, adapter->index,
+							BTP_ERROR_FAIL);
+		return;
+	}
+
+	if (!l_dbus_message_get_arguments(result, "ay", &iter))
+		goto failed;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &data, &n)) {
+		l_debug("Cannot read value");
+		goto failed;
+	}
+
+	if (!l_dbus_proxy_get_property(proxy, "Handle", "q", &handle))
+		goto failed;
+
+	rp_len = sizeof(struct btp_gatt_read_uuid_rp) +
+				sizeof(struct btp_gatt_char_value) + n;
+	rp = malloc(rp_len);
+	rp->att_response = 0;
+	rp->values_count = 1;
+	value = rp->values;
+	value->handle = handle;
+	value->data_len = n;
+	memcpy(value->data, data, n);
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_UUID, adapter->index,
+								rp_len, rp);
+
+	free(rp);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, adapter->index, BTP_ERROR_FAIL);
+}
+
+static void btp_gatt_read_uuid(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_read_uuid_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	bt_uuid_t uuid;
+	struct gatt_attribute *attribute;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to read UUID */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b",
+					&prop) || !prop) {
+		goto failed;
+	}
+
+	device = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+	if (!device)
+		goto failed;
+
+	if (create_uuid(&uuid, cp->uuid_len, cp->uuid))
+		goto failed;
+
+	attribute = l_queue_find(device->characteristics, match_attribute_uuid,
+								&uuid);
+	if (!attribute)
+		attribute = l_queue_find(device->descriptors,
+							match_attribute_uuid,
+							&uuid);
+
+	if (!attribute)
+		goto failed;
+
+	l_dbus_proxy_method_call(attribute->proxy, "ReadValue",
+					gatt_read_setup, gatt_read_uuid_reply,
+					adapter, NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
+bool gatt_register_service(struct btp *btp_, struct l_dbus *dbus_,
+					struct l_dbus_client *client)
+{
+	btp = btp_;
+
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
+					btp_gatt_read_commands, NULL, NULL);
+
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_UUID,
+					btp_gatt_read_uuid, NULL, NULL);
+
+	gatt_service_registered = true;
+
+	return true;
+}
+
+void gatt_unregister_service(struct btp *btp)
+{
+	btp_unregister_service(btp, BTP_GATT_SERVICE);
+	gatt_service_registered = false;
+}
+
+bool gatt_is_service_registered(void)
+{
+	return gatt_service_registered;
+}
diff --git a/client/btpclient/gatt.h b/client/btpclient/gatt.h
new file mode 100644
index 000000000..5c0715978
--- /dev/null
+++ b/client/btpclient/gatt.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Collabora Ltd.
+ *
+ */
+
+bool gatt_register_service(struct btp *btp_, struct l_dbus *dbus_,
+					struct l_dbus_client *client);
+void gatt_unregister_service(struct btp *btp);
+bool gatt_is_service_registered(void);
diff --git a/src/shared/btp.h b/src/shared/btp.h
index ad18cfb3a..bdb5ad33e 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -285,6 +285,30 @@ struct btp_gap_identity_resolved_ev {
 	bdaddr_t identity_address;
 } __packed;
 
+struct btp_gatt_char_value {
+	uint16_t handle;
+	uint8_t data_len;
+	uint8_t data[];
+} __packed;
+
+#define BTP_OP_GATT_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_GATT_READ_UUID			0x12
+struct btp_gatt_read_uuid_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid_len;
+	uint8_t uuid[];
+} __packed;
+
+struct btp_gatt_read_uuid_rp {
+	uint8_t att_response;
+	uint8_t values_count;
+	struct btp_gatt_char_value values[];
+} __packed;
+
 struct btp;
 
 typedef void (*btp_destroy_func_t)(void *user_data);
-- 
2.43.0

