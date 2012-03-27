Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 4/4] eir: Read GAP appearance from advertising data
Date: Tue, 27 Mar 2012 09:29:38 -0400
Message-Id: <1332854978-26072-5-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was introduced on Core Specification Supplement (CSS) v1.
---
 src/adapter.c |   11 +++++++++++
 src/eir.c     |    9 +++++++++
 src/eir.h     |    2 ++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7a2214a..3c7c6d8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2698,6 +2698,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 
 	if (dev->type != ADDR_TYPE_BREDR) {
 		gboolean broadcaster;
+		uint16_t app;
 
 		if (dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
 			broadcaster = FALSE;
@@ -2706,8 +2707,14 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 
 		dev->legacy = FALSE;
 
+		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
+								&app) == 0)
+			icon = gap_appearance_to_icon(app);
+
 		emit_device_found(adapter->path, paddr,
 				"Address", DBUS_TYPE_STRING, &paddr,
+				"Class", DBUS_TYPE_UINT32, &dev->class,
+				"Icon", DBUS_TYPE_STRING, &icon,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Alias", DBUS_TYPE_STRING, &alias,
@@ -2837,6 +2844,10 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	if (dev_class != 0)
 		write_remote_class(&adapter->bdaddr, bdaddr, dev_class);
 
+	if (eir_data.appearance != 0)
+		write_remote_appearance(&adapter->bdaddr, bdaddr,
+							eir_data.appearance);
+
 	if (eir_data.name != NULL && eir_data.name_complete)
 		write_device_name(&adapter->bdaddr, bdaddr, eir_data.name);
 
diff --git a/src/eir.c b/src/eir.c
index 419f444..b9ecf31 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -108,6 +108,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
 		uint8_t data_len, *data = &eir_data[2];
+		uint16_t *u16;
 
 		/* Check for the end of EIR */
 		if (field_len == 0)
@@ -164,6 +165,14 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 			if (data_len < 3)
 				break;
 			memcpy(eir->dev_class, data, 3);
+			break;
+
+		case EIR_GAP_APPEARANCE:
+			if (data_len < 2)
+				break;
+			u16 = (uint16_t *) data;
+			eir->appearance = btohs(bt_get_unaligned(u16));
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 13311ef..f712be5 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -34,6 +34,7 @@
 #define EIR_TX_POWER                0x0A  /* transmit power level */
 #define EIR_CLASS_OF_DEV            0x0D  /* Class of Device */
 #define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 
 struct uuid_info {
 	uuid_t uuid;
@@ -45,6 +46,7 @@ struct eir_data {
 	int flags;
 	char *name;
 	uint8_t dev_class[3];
+	uint16_t appearance;
 	gboolean name_complete;
 };
 
-- 
1.7.5.4

