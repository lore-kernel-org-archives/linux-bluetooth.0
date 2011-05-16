Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 01/12] Move EIR related functions to a new file
Date: Mon, 16 May 2011 17:49:50 -0300
Message-Id: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am      |    2 +-
 plugins/hciops.c |  170 +----------------------------
 src/eir.c        |  320 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h        |   42 +++++++
 src/event.c      |  126 +---------------------
 src/sdpd.h       |   14 ---
 6 files changed, 369 insertions(+), 305 deletions(-)
 create mode 100644 src/eir.c
 create mode 100644 src/eir.h

diff --git a/Makefile.am b/Makefile.am
index caffbe2..175f8c9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -251,7 +251,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
 			src/event.h src/event.c \
-			src/oob.h src/oob.c
+			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
diff --git a/plugins/hciops.c b/plugins/hciops.c
index af638c8..07643a1 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -51,6 +51,7 @@
 #include "event.h"
 #include "manager.h"
 #include "oob.h"
+#include "eir.h"
 
 #define DISCOV_HALTED 0
 #define DISCOV_INQ 1
@@ -84,11 +85,6 @@ enum {
 	PENDING_NAME,
 };
 
-struct uuid_info {
-	uuid_t uuid;
-	uint8_t svc_hint;
-};
-
 struct bt_conn {
 	struct dev_info *dev;
 	bdaddr_t bdaddr;
@@ -1435,167 +1431,6 @@ static void read_local_features_complete(int index,
 		init_adapter(index);
 }
 
-#define SIZEOF_UUID128 16
-
-static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
-{
-	int i, k, uuid_count = 0;
-	uint16_t len = *eir_len;
-	uint8_t *uuid128;
-	gboolean truncated = FALSE;
-
-	/* Store UUIDs in place, skip 2 bytes to write type and length later */
-	uuid128 = ptr + 2;
-
-	for (; list; list = list->next) {
-		struct uuid_info *uuid = list->data;
-		uint8_t *uuid128_data = uuid->uuid.value.uuid128.data;
-
-		if (uuid->uuid.type != SDP_UUID128)
-			continue;
-
-		/* Stop if not enough space to put next UUID128 */
-		if ((len + 2 + SIZEOF_UUID128) > EIR_DATA_LENGTH) {
-			truncated = TRUE;
-			break;
-		}
-
-		/* Check for duplicates, EIR data is Little Endian */
-		for (i = 0; i < uuid_count; i++) {
-			for (k = 0; k < SIZEOF_UUID128; k++) {
-				if (uuid128[i * SIZEOF_UUID128 + k] !=
-					uuid128_data[SIZEOF_UUID128 - 1 - k])
-					break;
-			}
-			if (k == SIZEOF_UUID128)
-				break;
-		}
-
-		if (i < uuid_count)
-			continue;
-
-		/* EIR data is Little Endian */
-		for (k = 0; k < SIZEOF_UUID128; k++)
-			uuid128[uuid_count * SIZEOF_UUID128 + k] =
-				uuid128_data[SIZEOF_UUID128 - 1 - k];
-
-		len += SIZEOF_UUID128;
-		uuid_count++;
-	}
-
-	if (uuid_count > 0 || truncated) {
-		/* EIR Data length */
-		ptr[0] = (uuid_count * SIZEOF_UUID128) + 1;
-		/* EIR Data type */
-		ptr[1] = truncated ? EIR_UUID128_SOME : EIR_UUID128_ALL;
-		len += 2;
-		*eir_len = len;
-	}
-}
-
-static void create_ext_inquiry_response(int index, uint8_t *data)
-{
-	struct dev_info *dev = &devs[index];
-	GSList *l;
-	uint8_t *ptr = data;
-	uint16_t eir_len = 0;
-	uint16_t uuid16[EIR_DATA_LENGTH / 2];
-	int i, uuid_count = 0;
-	gboolean truncated = FALSE;
-	size_t name_len;
-
-	name_len = strlen(dev->name);
-
-	if (name_len > 0) {
-		/* EIR Data type */
-		if (name_len > 48) {
-			name_len = 48;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
-
-		/* EIR Data length */
-		ptr[0] = name_len + 1;
-
-		memcpy(ptr + 2, dev->name, name_len);
-
-		eir_len += (name_len + 2);
-		ptr += (name_len + 2);
-	}
-
-	if (dev->tx_power != 0) {
-		*ptr++ = 2;
-		*ptr++ = EIR_TX_POWER;
-		*ptr++ = (uint8_t) dev->tx_power;
-		eir_len += 3;
-	}
-
-	if (dev->did_vendor != 0x0000) {
-		uint16_t source = 0x0002;
-		*ptr++ = 9;
-		*ptr++ = EIR_DEVICE_ID;
-		*ptr++ = (source & 0x00ff);
-		*ptr++ = (source & 0xff00) >> 8;
-		*ptr++ = (dev->did_vendor & 0x00ff);
-		*ptr++ = (dev->did_vendor & 0xff00) >> 8;
-		*ptr++ = (dev->did_product & 0x00ff);
-		*ptr++ = (dev->did_product & 0xff00) >> 8;
-		*ptr++ = (dev->did_version & 0x00ff);
-		*ptr++ = (dev->did_version & 0xff00) >> 8;
-		eir_len += 10;
-	}
-
-	/* Group all UUID16 types */
-	for (l = dev->uuids; l != NULL; l = g_slist_next(l)) {
-		struct uuid_info *uuid = l->data;
-
-		if (uuid->uuid.type != SDP_UUID16)
-			continue;
-
-		if (uuid->uuid.value.uuid16 < 0x1100)
-			continue;
-
-		if (uuid->uuid.value.uuid16 == PNP_INFO_SVCLASS_ID)
-			continue;
-
-		/* Stop if not enough space to put next UUID16 */
-		if ((eir_len + 2 + sizeof(uint16_t)) > EIR_DATA_LENGTH) {
-			truncated = TRUE;
-			break;
-		}
-
-		/* Check for duplicates */
-		for (i = 0; i < uuid_count; i++)
-			if (uuid16[i] == uuid->uuid.value.uuid16)
-				break;
-
-		if (i < uuid_count)
-			continue;
-
-		uuid16[uuid_count++] = uuid->uuid.value.uuid16;
-		eir_len += sizeof(uint16_t);
-	}
-
-	if (uuid_count > 0) {
-		/* EIR Data length */
-		ptr[0] = (uuid_count * sizeof(uint16_t)) + 1;
-		/* EIR Data type */
-		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
-
-		ptr += 2;
-		eir_len += 2;
-
-		for (i = 0; i < uuid_count; i++) {
-			*ptr++ = (uuid16[i] & 0x00ff);
-			*ptr++ = (uuid16[i] & 0xff00) >> 8;
-		}
-	}
-
-	/* Group all UUID128 types */
-	if (eir_len <= EIR_DATA_LENGTH - 2)
-		eir_generate_uuid128(dev->uuids, ptr, &eir_len);
-}
-
 static void update_ext_inquiry_response(int index)
 {
 	struct dev_info *dev = &devs[index];
@@ -1614,7 +1449,8 @@ static void update_ext_inquiry_response(int index)
 
 	memset(&cp, 0, sizeof(cp));
 
-	create_ext_inquiry_response(index, cp.data);
+	eir_create(dev->name, dev->tx_power, dev->did_vendor, dev->did_product,
+					dev->did_version, dev->uuids, cp.data);
 
 	if (memcmp(cp.data, dev->eir, sizeof(cp.data)) == 0)
 		return;
diff --git a/src/eir.c b/src/eir.c
new file mode 100644
index 0000000..d827c7e
--- /dev/null
+++ b/src/eir.c
@@ -0,0 +1,320 @@
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
+#include <errno.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+
+#include "glib-helper.h"
+#include "eir.h"
+
+#define EIR_FLAGS                   0x01  /* flags */
+#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
+#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
+#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
+#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT              0x08  /* shortened local name */
+#define EIR_NAME_COMPLETE           0x09  /* complete local name */
+#define EIR_TX_POWER                0x0A  /* transmit power level */
+#define EIR_DEVICE_ID               0x10  /* device ID */
+
+int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length)
+{
+	uint16_t len = 0;
+	size_t total;
+	size_t uuid16_count = 0;
+	size_t uuid32_count = 0;
+	size_t uuid128_count = 0;
+	uint8_t *uuid16 = NULL;
+	uint8_t *uuid32 = NULL;
+	uint8_t *uuid128 = NULL;
+	uuid_t service;
+	char *uuid_str;
+	unsigned int i;
+
+	eir->flags = -1;
+
+	/* No EIR data to parse */
+	if (eir_data == NULL || eir_length == 0)
+		return 0;
+
+	while (len < eir_length - 1) {
+		uint8_t field_len = eir_data[0];
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		switch (eir_data[1]) {
+		case EIR_UUID16_SOME:
+		case EIR_UUID16_ALL:
+			uuid16_count = field_len / 2;
+			uuid16 = &eir_data[2];
+			break;
+		case EIR_UUID32_SOME:
+		case EIR_UUID32_ALL:
+			uuid32_count = field_len / 4;
+			uuid32 = &eir_data[2];
+			break;
+		case EIR_UUID128_SOME:
+		case EIR_UUID128_ALL:
+			uuid128_count = field_len / 16;
+			uuid128 = &eir_data[2];
+			break;
+		case EIR_FLAGS:
+			eir->flags = eir_data[2];
+			break;
+		case EIR_NAME_SHORT:
+		case EIR_NAME_COMPLETE:
+			if (g_utf8_validate((char *) &eir_data[2],
+							field_len - 1, NULL))
+				eir->name = g_strndup((char *) &eir_data[2],
+								field_len - 1);
+			else
+				eir->name = g_strdup("");
+			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
+			break;
+		}
+
+		len += field_len + 1;
+		eir_data += field_len + 1;
+	}
+
+	/* Bail out if got incorrect length */
+	if (len > eir_length)
+		return -EINVAL;
+
+	total = uuid16_count + uuid32_count + uuid128_count;
+
+	/* No UUIDs were parsed, so skip code below */
+	if (!total)
+		return 0;
+
+	/* Generate uuids in SDP format (EIR data is Little Endian) */
+	service.type = SDP_UUID16;
+	for (i = 0; i < uuid16_count; i++) {
+		uint16_t val16 = uuid16[1];
+
+		val16 = (val16 << 8) + uuid16[0];
+		service.value.uuid16 = val16;
+		uuid_str = bt_uuid2string(&service);
+		eir->services = g_slist_append(eir->services, uuid_str);
+		uuid16 += 2;
+	}
+
+	service.type = SDP_UUID32;
+	for (i = uuid16_count; i < uuid32_count + uuid16_count; i++) {
+		uint32_t val32 = uuid32[3];
+		int k;
+
+		for (k = 2; k >= 0; k--)
+			val32 = (val32 << 8) + uuid32[k];
+
+		service.value.uuid32 = val32;
+		uuid_str = bt_uuid2string(&service);
+		eir->services = g_slist_append(eir->services, uuid_str);
+		uuid32 += 4;
+	}
+
+	service.type = SDP_UUID128;
+	for (i = uuid32_count + uuid16_count; i < total; i++) {
+		int k;
+
+		for (k = 0; k < 16; k++)
+			service.value.uuid128.data[k] = uuid128[16 - k - 1];
+
+		uuid_str = bt_uuid2string(&service);
+		eir->services = g_slist_append(eir->services, uuid_str);
+		uuid128 += 16;
+	}
+
+	return 0;
+}
+
+#define SIZEOF_UUID128 16
+
+static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
+{
+	int i, k, uuid_count = 0;
+	uint16_t len = *eir_len;
+	uint8_t *uuid128;
+	gboolean truncated = FALSE;
+
+	/* Store UUIDs in place, skip 2 bytes to write type and length later */
+	uuid128 = ptr + 2;
+
+	for (; list; list = list->next) {
+		struct uuid_info *uuid = list->data;
+		uint8_t *uuid128_data = uuid->uuid.value.uuid128.data;
+
+		if (uuid->uuid.type != SDP_UUID128)
+			continue;
+
+		/* Stop if not enough space to put next UUID128 */
+		if ((len + 2 + SIZEOF_UUID128) > EIR_DATA_LENGTH) {
+			truncated = TRUE;
+			break;
+		}
+
+		/* Check for duplicates, EIR data is Little Endian */
+		for (i = 0; i < uuid_count; i++) {
+			for (k = 0; k < SIZEOF_UUID128; k++) {
+				if (uuid128[i * SIZEOF_UUID128 + k] !=
+					uuid128_data[SIZEOF_UUID128 - 1 - k])
+					break;
+			}
+			if (k == SIZEOF_UUID128)
+				break;
+		}
+
+		if (i < uuid_count)
+			continue;
+
+		/* EIR data is Little Endian */
+		for (k = 0; k < SIZEOF_UUID128; k++)
+			uuid128[uuid_count * SIZEOF_UUID128 + k] =
+				uuid128_data[SIZEOF_UUID128 - 1 - k];
+
+		len += SIZEOF_UUID128;
+		uuid_count++;
+	}
+
+	if (uuid_count > 0 || truncated) {
+		/* EIR Data length */
+		ptr[0] = (uuid_count * SIZEOF_UUID128) + 1;
+		/* EIR Data type */
+		ptr[1] = truncated ? EIR_UUID128_SOME : EIR_UUID128_ALL;
+		len += 2;
+		*eir_len = len;
+	}
+}
+
+void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
+			uint16_t did_product, uint16_t did_version,
+			GSList *uuids, uint8_t *data)
+{
+	GSList *l;
+	uint8_t *ptr = data;
+	uint16_t eir_len = 0;
+	uint16_t uuid16[EIR_DATA_LENGTH / 2];
+	int i, uuid_count = 0;
+	gboolean truncated = FALSE;
+	size_t name_len;
+
+	name_len = strlen(name);
+
+	if (name_len > 0) {
+		/* EIR Data type */
+		if (name_len > 48) {
+			name_len = 48;
+			ptr[1] = EIR_NAME_SHORT;
+		} else
+			ptr[1] = EIR_NAME_COMPLETE;
+
+		/* EIR Data length */
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, name, name_len);
+
+		eir_len += (name_len + 2);
+		ptr += (name_len + 2);
+	}
+
+	if (tx_power != 0) {
+		*ptr++ = 2;
+		*ptr++ = EIR_TX_POWER;
+		*ptr++ = (uint8_t) tx_power;
+		eir_len += 3;
+	}
+
+	if (did_vendor != 0x0000) {
+		uint16_t source = 0x0002;
+		*ptr++ = 9;
+		*ptr++ = EIR_DEVICE_ID;
+		*ptr++ = (source & 0x00ff);
+		*ptr++ = (source & 0xff00) >> 8;
+		*ptr++ = (did_vendor & 0x00ff);
+		*ptr++ = (did_vendor & 0xff00) >> 8;
+		*ptr++ = (did_product & 0x00ff);
+		*ptr++ = (did_product & 0xff00) >> 8;
+		*ptr++ = (did_version & 0x00ff);
+		*ptr++ = (did_version & 0xff00) >> 8;
+		eir_len += 10;
+	}
+
+	/* Group all UUID16 types */
+	for (l = uuids; l != NULL; l = g_slist_next(l)) {
+		struct uuid_info *uuid = l->data;
+
+		if (uuid->uuid.type != SDP_UUID16)
+			continue;
+
+		if (uuid->uuid.value.uuid16 < 0x1100)
+			continue;
+
+		if (uuid->uuid.value.uuid16 == PNP_INFO_SVCLASS_ID)
+			continue;
+
+		/* Stop if not enough space to put next UUID16 */
+		if ((eir_len + 2 + sizeof(uint16_t)) > EIR_DATA_LENGTH) {
+			truncated = TRUE;
+			break;
+		}
+
+		/* Check for duplicates */
+		for (i = 0; i < uuid_count; i++)
+			if (uuid16[i] == uuid->uuid.value.uuid16)
+				break;
+
+		if (i < uuid_count)
+			continue;
+
+		uuid16[uuid_count++] = uuid->uuid.value.uuid16;
+		eir_len += sizeof(uint16_t);
+	}
+
+	if (uuid_count > 0) {
+		/* EIR Data length */
+		ptr[0] = (uuid_count * sizeof(uint16_t)) + 1;
+		/* EIR Data type */
+		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
+
+		ptr += 2;
+		eir_len += 2;
+
+		for (i = 0; i < uuid_count; i++) {
+			*ptr++ = (uuid16[i] & 0x00ff);
+			*ptr++ = (uuid16[i] & 0xff00) >> 8;
+		}
+	}
+
+	/* Group all UUID128 types */
+	if (eir_len <= EIR_DATA_LENGTH - 2)
+		eir_generate_uuid128(uuids, ptr, &eir_len);
+}
diff --git a/src/eir.h b/src/eir.h
new file mode 100644
index 0000000..c7699eb
--- /dev/null
+++ b/src/eir.h
@@ -0,0 +1,42 @@
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
+#define EIR_DATA_LENGTH  240
+
+struct uuid_info {
+	uuid_t uuid;
+	uint8_t svc_hint;
+};
+
+struct eir_data {
+	GSList *services;
+	int flags;
+	char *name;
+	gboolean name_complete;
+};
+
+int eir_parse(struct eir_data *eir, uint8_t *eir_data, size_t eir_length);
+void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
+			uint16_t did_product, uint16_t did_version,
+			GSList *uuids, uint8_t *data);
diff --git a/src/event.c b/src/event.c
index 141a04e..dc1b659 100644
--- a/src/event.c
+++ b/src/event.c
@@ -58,13 +58,7 @@
 #include "storage.h"
 #include "event.h"
 #include "sdpd.h"
-
-struct eir_data {
-	GSList *services;
-	int flags;
-	char *name;
-	gboolean name_complete;
-};
+#include "eir.h"
 
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_adapter **adapter,
@@ -287,120 +281,6 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
-							size_t eir_length)
-{
-	uint16_t len = 0;
-	size_t total;
-	size_t uuid16_count = 0;
-	size_t uuid32_count = 0;
-	size_t uuid128_count = 0;
-	uint8_t *uuid16 = NULL;
-	uint8_t *uuid32 = NULL;
-	uint8_t *uuid128 = NULL;
-	uuid_t service;
-	char *uuid_str;
-	unsigned int i;
-
-	eir->flags = -1;
-
-	/* No EIR data to parse */
-	if (eir_data == NULL || eir_length == 0)
-		return 0;
-
-	while (len < eir_length - 1) {
-		uint8_t field_len = eir_data[0];
-
-		/* Check for the end of EIR */
-		if (field_len == 0)
-			break;
-
-		switch (eir_data[1]) {
-		case EIR_UUID16_SOME:
-		case EIR_UUID16_ALL:
-			uuid16_count = field_len / 2;
-			uuid16 = &eir_data[2];
-			break;
-		case EIR_UUID32_SOME:
-		case EIR_UUID32_ALL:
-			uuid32_count = field_len / 4;
-			uuid32 = &eir_data[2];
-			break;
-		case EIR_UUID128_SOME:
-		case EIR_UUID128_ALL:
-			uuid128_count = field_len / 16;
-			uuid128 = &eir_data[2];
-			break;
-		case EIR_FLAGS:
-			eir->flags = eir_data[2];
-			break;
-		case EIR_NAME_SHORT:
-		case EIR_NAME_COMPLETE:
-			if (g_utf8_validate((char *) &eir_data[2],
-							field_len - 1, NULL))
-				eir->name = g_strndup((char *) &eir_data[2],
-								field_len - 1);
-			else
-				eir->name = g_strdup("");
-			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
-			break;
-		}
-
-		len += field_len + 1;
-		eir_data += field_len + 1;
-	}
-
-	/* Bail out if got incorrect length */
-	if (len > eir_length)
-		return -EINVAL;
-
-	total = uuid16_count + uuid32_count + uuid128_count;
-
-	/* No UUIDs were parsed, so skip code below */
-	if (!total)
-		return 0;
-
-	/* Generate uuids in SDP format (EIR data is Little Endian) */
-	service.type = SDP_UUID16;
-	for (i = 0; i < uuid16_count; i++) {
-		uint16_t val16 = uuid16[1];
-
-		val16 = (val16 << 8) + uuid16[0];
-		service.value.uuid16 = val16;
-		uuid_str = bt_uuid2string(&service);
-		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid16 += 2;
-	}
-
-	service.type = SDP_UUID32;
-	for (i = uuid16_count; i < uuid32_count + uuid16_count; i++) {
-		uint32_t val32 = uuid32[3];
-		int k;
-
-		for (k = 2; k >= 0; k--)
-			val32 = (val32 << 8) + uuid32[k];
-
-		service.value.uuid32 = val32;
-		uuid_str = bt_uuid2string(&service);
-		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid32 += 4;
-	}
-
-	service.type = SDP_UUID128;
-	for (i = uuid32_count + uuid16_count; i < total; i++) {
-		int k;
-
-		for (k = 0; k < 16; k++)
-			service.value.uuid128.data[k] = uuid128[16 - k - 1];
-
-		uuid_str = bt_uuid2string(&service);
-		eir->services = g_slist_append(eir->services, uuid_str);
-		uuid128 += 16;
-	}
-
-	return 0;
-}
-
 static void free_eir_data(struct eir_data *eir)
 {
 	g_slist_foreach(eir->services, (GFunc) g_free, NULL);
@@ -422,7 +302,7 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 	}
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	err = parse_eir_data(&eir_data, info->data, info->length);
+	err = eir_parse(&eir_data, info->data, info->length);
 	if (err < 0)
 		error("Error parsing advertising data: %s (%d)",
 							strerror(-err), -err);
@@ -511,7 +391,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		legacy = TRUE;
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	err = parse_eir_data(&eir_data, data, EIR_DATA_LENGTH);
+	err = eir_parse(&eir_data, data, EIR_DATA_LENGTH);
 	if (err < 0)
 		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
 
diff --git a/src/sdpd.h b/src/sdpd.h
index 471e9cc..9f5415f 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -34,20 +34,6 @@
 #define SDPDBG(fmt...)
 #endif
 
-#define EIR_DATA_LENGTH  240
-
-#define EIR_FLAGS                   0x01  /* flags */
-#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
-#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
-#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
-#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
-#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
-#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
-#define EIR_NAME_SHORT              0x08  /* shortened local name */
-#define EIR_NAME_COMPLETE           0x09  /* complete local name */
-#define EIR_TX_POWER                0x0A  /* transmit power level */
-#define EIR_DEVICE_ID               0x10  /* device ID */
-
 typedef struct request {
 	bdaddr_t device;
 	bdaddr_t bdaddr;
-- 
1.7.5.rc3

