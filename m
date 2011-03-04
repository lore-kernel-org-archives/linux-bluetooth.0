Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com, Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/5] Add new UUID utility functions
Date: Fri,  4 Mar 2011 13:20:36 -0300
Message-Id: <1299255640-13599-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

New UUID functions will store the UUIDs values on host order. Byte
ordering functions are implemented somewhere else.
---
 Makefile.am |    6 +-
 lib/uuid.c  |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/uuid.h  |   61 +++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 3 deletions(-)
 create mode 100644 lib/uuid.c
 create mode 100644 lib/uuid.h

diff --git a/Makefile.am b/Makefile.am
index ec1ca97..8eb1e56 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -43,8 +43,8 @@ plugin_LTLIBRARIES =
 
 
 lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h lib/mgmt.h \
-			lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h \
-				lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
+		lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h lib/uuid.h \
+			lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
 local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
 
 include_HEADERS += $(lib_headers)
@@ -52,7 +52,7 @@ include_HEADERS += $(lib_headers)
 lib_LTLIBRARIES += lib/libbluetooth.la
 
 lib_libbluetooth_la_SOURCES = $(lib_headers) \
-					lib/bluetooth.c lib/hci.c lib/sdp.c
+			      lib/bluetooth.c lib/hci.c lib/sdp.c lib/uuid.c
 lib_libbluetooth_la_LDFLAGS = -version-info 13:5:10
 lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 
diff --git a/lib/uuid.c b/lib/uuid.c
new file mode 100644
index 0000000..6bdff12
--- /dev/null
+++ b/lib/uuid.c
@@ -0,0 +1,134 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+
+#include "uuid.h"
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+static uint128_t bluetooth_base_uuid = {
+	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
+};
+
+#define BASE_UUID16_OFFSET	2
+#define BASE_UUID32_OFFSET	0
+
+#else
+static uint128_t bluetooth_base_uuid = {
+	.data = {	0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
+};
+
+#define BASE_UUID16_OFFSET	12
+#define BASE_UUID32_OFFSET	BASE_UUID16_OFFSET
+
+#endif
+
+static void bt_uuid16_to_uuid128(const bt_uuid_t *uuid16, bt_uuid_t *uuid128)
+{
+	uint16_t data;
+
+	uuid128->value.u128 = bluetooth_base_uuid;
+	uuid128->type = BT_UUID128;
+
+	memcpy(&data, &bluetooth_base_uuid.data[BASE_UUID16_OFFSET], 2);
+	data += uuid16->value.u16;
+
+	memcpy(&uuid128->value.u128.data[BASE_UUID16_OFFSET], &data, 2);
+}
+
+static void bt_uuid32_to_uuid128(const bt_uuid_t *uuid32, bt_uuid_t *uuid128)
+{
+	uint32_t data;
+
+	uuid128->value.u128 = bluetooth_base_uuid;
+	uuid128->type = BT_UUID128;
+
+	memcpy(&data, &bluetooth_base_uuid.data[BASE_UUID32_OFFSET], 4);
+	data += uuid32->value.u32;
+
+	memcpy(&uuid128->value.u128.data[BASE_UUID32_OFFSET], &data, 4);
+}
+
+static void bt_uuid2uuid128(const bt_uuid_t *uuid, bt_uuid_t *uuid128)
+{
+	switch (uuid->type) {
+	case BT_UUID128:
+		memcpy(uuid128, uuid, sizeof(bt_uuid_t));
+		break;
+	case BT_UUID32:
+		bt_uuid32_to_uuid128(uuid, uuid128);
+		break;
+	case BT_UUID16:
+		bt_uuid16_to_uuid128(uuid, uuid128);
+		break;
+	}
+}
+
+static int bt_uuid128_cmp(const bt_uuid_t *u1, const bt_uuid_t *u2)
+{
+	return memcmp(&u1->value.u128, &u2->value.u128, sizeof(uint128_t));
+}
+
+int bt_uuid16_create(bt_uuid_t *btuuid, uint16_t value)
+{
+	memset(btuuid, 0, sizeof(bt_uuid_t));
+	btuuid->type = BT_UUID16;
+	btuuid->value.u16 = value;
+
+	return 0;
+}
+
+int bt_uuid32_create(bt_uuid_t *btuuid, uint32_t value)
+{
+	memset(btuuid, 0, sizeof(bt_uuid_t));
+	btuuid->type = BT_UUID32;
+	btuuid->value.u32 = value;
+
+	return 0;
+}
+
+int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value)
+{
+	memset(btuuid, 0, sizeof(bt_uuid_t));
+	btuuid->type = BT_UUID128;
+	btuuid->value.u128 = value;
+
+	return 0;
+}
+
+int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
+{
+	bt_uuid_t u1, u2;
+
+	bt_uuid2uuid128(uuid1, &u1);
+	bt_uuid2uuid128(uuid2, &u2);
+
+	return bt_uuid128_cmp(&u1, &u2);
+}
diff --git a/lib/uuid.h b/lib/uuid.h
new file mode 100644
index 0000000..bc9ca31
--- /dev/null
+++ b/lib/uuid.h
@@ -0,0 +1,61 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __BLUETOOTH_UUID_H
+#define __BLUETOOTH_UUID_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdint.h>
+
+typedef struct {
+	uint8_t data[16];
+} uint128_t;
+
+typedef struct {
+	enum {
+		BT_UUID16 = 16,
+		BT_UUID32 = 32,
+		BT_UUID128 = 128,
+	} type;
+	union {
+		uint16_t  u16;
+		uint32_t  u32;
+		uint128_t u128;
+	} value;
+} bt_uuid_t;
+
+int bt_uuid16_create(bt_uuid_t *btuuid, uint16_t value);
+int bt_uuid32_create(bt_uuid_t *btuuid, uint32_t value);
+int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
+
+int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __BLUETOOTH_UUID_H */
-- 
1.7.1

