Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] time: Add Reference Time Update Service
Date: Wed, 20 Jun 2012 14:14:21 -0400
Message-Id: <1340216061-24778-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1340216061-24778-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1340216061-24778-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the Reference Time Update Service (RTUS). From the spec:

"This service defines how a client can request an update from a
reference time source from a time server using the Generic Attribute
Profile (GATT)."

This a initial dummy implementation, which always reports success (for
testing purposes).
---
 time/server.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 time/server.h |   19 +++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/time/server.c b/time/server.c
index 52bd778..be6e196 100644
--- a/time/server.c
+++ b/time/server.c
@@ -42,8 +42,11 @@
 #include "server.h"
 
 #define CURRENT_TIME_SVC_UUID		0x1805
+#define REF_TIME_UPDATE_SVC_UUID	0x1806
 
 #define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
+#define TIME_UPDATE_CTRL_CHR_UUID	0x2A16
+#define TIME_UPDATE_STAT_CHR_UUID	0x2A17
 #define CT_TIME_CHR_UUID		0x2A2B
 
 static int encode_current_time(uint8_t value[10])
@@ -141,6 +144,69 @@ static gboolean register_current_time_service(struct btd_adapter *adapter)
 				GATT_OPT_INVALID);
 }
 
+static uint8_t time_update_control(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	DBG("handle 0x%04x", a->handle);
+
+	if (a->len != 1)
+		DBG("Invalid control point value size: %d", a->len);
+
+	switch (a->data[0]) {
+	case GET_REFERENCE_UPDATE:
+		DBG("Get Reference Update");
+		break;
+	case CANCEL_REFERENCE_UPDATE:
+		DBG("Cancel Reference Update");
+		break;
+	default:
+		DBG("Unknown command: 0x%02x", a->data[0]);
+	}
+
+	return 0;
+}
+
+static uint8_t time_update_status(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t value[2];
+
+	DBG("handle 0x%04x", a->handle);
+
+	value[0] = UPDATE_STATE_IDLE;
+	value[1] = UPDATE_RESULT_SUCCESSFUL;
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static gboolean register_ref_time_update_service(struct btd_adapter *adapter)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, REF_TIME_UPDATE_SVC_UUID);
+
+	/* Reference Time Update service */
+	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+				/* Time Update control point */
+				GATT_OPT_CHR_UUID, TIME_UPDATE_CTRL_CHR_UUID,
+				GATT_OPT_CHR_PROPS,
+					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+						time_update_control, adapter,
+
+				/* Time Update status */
+				GATT_OPT_CHR_UUID, TIME_UPDATE_STAT_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+						time_update_status, adapter,
+
+				GATT_OPT_INVALID);
+}
+
 int time_server_init(struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
@@ -152,6 +218,11 @@ int time_server_init(struct btd_adapter *adapter)
 		return -EIO;
 	}
 
+	if (!register_ref_time_update_service(adapter)) {
+		error("Reference Time Update Service could not be registered");
+		return -EIO;
+	}
+
 	return 0;
 }
 
diff --git a/time/server.h b/time/server.h
index 69cf114..c7b997d 100644
--- a/time/server.h
+++ b/time/server.h
@@ -22,5 +22,24 @@
  *
  */
 
+enum {
+	UPDATE_RESULT_SUCCESSFUL = 0,
+	UPDATE_RESULT_CANCELED = 1,
+	UPDATE_RESULT_NO_CONN = 2,
+	UPDATE_RESULT_ERROR = 3,
+	UPDATE_RESULT_TIMEOUT = 4,
+	UPDATE_RESULT_NOT_ATTEMPTED = 5,
+};
+
+enum {
+	UPDATE_STATE_IDLE = 0,
+	UPDATE_STATE_PENDING = 1,
+};
+
+enum {
+	GET_REFERENCE_UPDATE = 1,
+	CANCEL_REFERENCE_UPDATE = 2,
+};
+
 int time_server_init(struct btd_adapter *adapter);
 void time_server_exit(struct btd_adapter *adapter);
-- 
1.7.9.5

