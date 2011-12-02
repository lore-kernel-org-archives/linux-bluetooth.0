Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 1/5] Time Profile: add Reference Time Update Service
Date: Fri,  2 Dec 2011 14:34:06 -0400
Message-Id: <1322850850-18019-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the Reference Time Update Service (RTUS). From the spec:

"This service defines how a client can request an update from a
reference time source from a time server using the Generic Attribute
Profile (GATT)."
---
 time/server.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 time/server.h |   19 +++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/time/server.c b/time/server.c
index 5c32dc2..4958fd3 100644
--- a/time/server.c
+++ b/time/server.c
@@ -39,8 +39,11 @@
 #include "server.h"
 
 #define CURRENT_TIME_SVC_UUID		0x1805
+#define REF_TIME_UPDATE_SVC_UUID	0x1806
 
 #define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
+#define TIME_UPDATE_CTRL_CHR_UUID	0x2A16
+#define TIME_UPDATE_STAT_CHR_UUID	0x2A17
 #define CT_TIME_CHR_UUID		0x2A2B
 
 static int encode_current_time(uint8_t value[10])
@@ -130,9 +133,53 @@ static void register_current_time_service(void)
 				GATT_OPT_INVALID);
 }
 
+static uint8_t time_update_control(struct attribute *a, gpointer user_data)
+{
+	DBG("handle 0x%04x", a->handle);
+
+	if (a->len != 1)
+		DBG("Invalid control point value size: %d", a->len);
+
+	return 0;
+}
+
+static uint8_t time_update_status(struct attribute *a, gpointer user_data)
+{
+	uint8_t value[2];
+
+	DBG("handle 0x%04x", a->handle);
+
+	value[0] = UPDATE_STATE_IDLE;
+	value[1] = UPDATE_RESULT_SUCCESSFUL;
+	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static void register_reference_time_update_service(void)
+{
+	/* Reference Time Update service */
+	gatt_service_add(GATT_PRIM_SVC_UUID, REF_TIME_UPDATE_SVC_UUID,
+				/* Time Update control point */
+				GATT_OPT_CHR_UUID, TIME_UPDATE_CTRL_CHR_UUID,
+				GATT_OPT_CHR_PROPS,
+					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+							time_update_control,
+
+				/* Time Update status */
+				GATT_OPT_CHR_UUID, TIME_UPDATE_STAT_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+							time_update_status,
+
+				GATT_OPT_INVALID);
+}
+
 int time_server_init(void)
 {
 	register_current_time_service();
+	register_reference_time_update_service();
 
 	return 0;
 }
diff --git a/time/server.h b/time/server.h
index 621bf2b..12b47ed 100644
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
 int time_server_init(void);
 void time_server_exit(void);
-- 
1.7.0.4

