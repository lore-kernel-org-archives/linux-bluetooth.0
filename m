Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/4] Update Device Appearance Characteristic based on device class
Date: Wed, 16 Feb 2011 21:07:29 -0200
Message-Id: <1297897651-27731-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Appearance Characteristic value is still under discussion. Temporary
solution which maps directly the device class of device(major and minor)
into Device Characteristic value without shifting the two less significant
bits reserved to Format Type. The second byte of the device class
contains the major class in the 5 less significant bits.
---
 src/adapter.c       |    7 +++++++
 src/attrib-server.c |   28 ++++++++++++++++++++++++++--
 src/attrib-server.h |    2 ++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f63d9e4..e7b2495 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -55,6 +55,7 @@
 #include "glib-helper.h"
 #include "agent.h"
 #include "storage.h"
+#include "attrib-server.h"
 #include "att.h"
 
 /* Flags Descriptions */
@@ -871,6 +872,12 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
 
 	adapter->dev_class = new_class;
 
+	if (main_opts.attrib_server) {
+		/* Removes service class */
+		class[1] = class[1] & 0x1f;
+		attrib_gap_set(GATT_CHARAC_APPEARANCE, class, 2);
+	}
+
 	emit_property_changed(connection, adapter->path,
 				ADAPTER_INTERFACE, "Class",
 				DBUS_TYPE_UINT32, &new_class);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index fe5d68c..b4df137 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -72,6 +72,8 @@ static GIOChannel *le_io = NULL;
 static GSList *clients = NULL;
 static uint32_t sdp_handle = 0;
 
+static uint16_t appearance_handle = 0x0000;
+
 static uuid_t prim_uuid = {
 			.type = SDP_UUID16,
 			.value.uuid16 = GATT_PRIM_SVC_UUID
@@ -820,16 +822,18 @@ static void register_core_services(void)
 					(uint8_t *) main_opts.name, len);
 
 	/* GAP service: device appearance characteristic */
+	appearance_handle = 0x0008;
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0008, &atval[1]);
+	att_put_u16(appearance_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
 	attrib_db_add(0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device appearance attribute */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
 	att_put_u16(appearance, &atval[0]);
-	attrib_db_add(0x0008, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(appearance_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	/* GATT service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
@@ -1001,3 +1005,23 @@ int attrib_db_del(uint16_t handle)
 
 	return 0;
 }
+
+int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
+{
+	uuid_t u16;
+	uint16_t handle;
+
+	/* FIXME: Missing Name, Privacy and Reconnection Address */
+
+	sdp_uuid16_create(&u16, uuid);
+
+	switch (uuid) {
+	case GATT_CHARAC_APPEARANCE:
+		handle = appearance_handle;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return attrib_db_update(handle, &u16, value, len);
+}
diff --git a/src/attrib-server.h b/src/attrib-server.h
index ba90ff4..252700f 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -30,3 +30,5 @@ int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 								int len);
 int attrib_db_del(uint16_t handle);
+
+int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
-- 
1.7.4.1

