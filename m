Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 1/4] GATT Time Server: add Current Time service
Date: Mon, 26 Sep 2011 17:01:34 -0400
Message-Id: <1317070897-17508-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 time/server.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/time/server.c b/time/server.c
index 89cc460..5001874 100644
--- a/time/server.c
+++ b/time/server.c
@@ -26,10 +26,75 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+#include <time.h>
+#include <errno.h>
+#include <bluetooth/uuid.h>
+
+#include "att.h"
+#include "gattrib.h"
+#include "attrib-server.h"
+#include "gatt-service.h"
+#include "log.h"
 #include "server.h"
 
+/* UUIDs not yet approved by Bluetooth SIG */
+#define CURRENT_TIME_SVC_UUID		0x1805
+
+#define CT_TIME_CHR_UUID		0x2A2B
+
+static uint8_t current_time_read(struct attribute *a, gpointer user_data)
+{
+	struct timespec tp;
+	struct tm tm;
+	uint8_t value[10];
+
+	if (clock_gettime(CLOCK_REALTIME, &tp) == -1) {
+		error("clock_gettime: %s", strerror(errno));
+		/* FIXME: add proper application error codes */
+		return ATT_ECODE_IO;
+	}
+
+	if (localtime_r(&tp.tv_sec, &tm) == NULL) {
+		error("localtime_r() failed");
+		return ATT_ECODE_IO;
+	}
+
+	att_put_u16(1900 + tm.tm_year, &value[0]); /* Year */
+	value[2] = tm.tm_mon + 1; /* Month */
+	value[3] = tm.tm_mday; /* Day */
+	value[4] = tm.tm_hour; /* Hours */
+	value[5] = tm.tm_min; /* Minutes */
+	value[6] = tm.tm_sec; /* Seconds */
+	value[7] = tm.tm_wday == 0 ? 7 : tm.tm_wday; /* Day of Week */
+	/* From Time Profile spec: "The number of 1/256 fractions of a second."
+	 * In 1s there are 256 fractions, in 1ns there are 256/10^9 fractions.
+	 * To avoid integer overflow, we use the equivalent 1/3906250 ratio. */
+	value[8] = tp.tv_nsec / 3906250; /* Fractions256 */
+	value[9] = 0x00; /* Adjust Reason */
+
+	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static void register_current_time_service(void)
+{
+	/* Current Time service */
+	gatt_service_add(GATT_PRIM_SVC_UUID, CURRENT_TIME_SVC_UUID,
+				/* CT Time characteristic */
+				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+							current_time_read,
+				GATT_OPT_INVALID);
+}
+
 int time_server_init(void)
 {
+	register_current_time_service();
+
 	return 0;
 }
 
-- 
1.7.0.4

