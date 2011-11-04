Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] Time Profile: add Current Time Service
Date: Fri,  4 Nov 2011 11:59:27 -0400
Message-Id: <1320422368-23820-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the Current Time Service (CTS). From the spec:

"This service defines how the current time can be exposed using the
Generic Attribute Profile (GATT)."
---
 time/server.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/time/server.c b/time/server.c
index 89cc460..0e2de2a 100644
--- a/time/server.c
+++ b/time/server.c
@@ -26,10 +26,85 @@
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
 
+#define CURRENT_TIME_SVC_UUID		0x1805
+
+#define CT_TIME_CHR_UUID		0x2A2B
+
+static int encode_current_time(uint8_t value[10])
+{
+	struct timespec tp;
+	struct tm tm;
+
+	if (clock_gettime(CLOCK_REALTIME, &tp) == -1) {
+		int err = errno;
+
+		error("clock_gettime: %s", strerror(err));
+		return -err;
+	}
+
+	if (localtime_r(&tp.tv_sec, &tm) == NULL) {
+		error("localtime_r() failed");
+		/* localtime_r() does not set errno */
+		return -EINVAL;
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
+	return 0;
+}
+
+static uint8_t current_time_read(struct attribute *a, gpointer user_data)
+{
+	uint8_t value[10];
+
+	if (encode_current_time(value) < 0)
+		return ATT_ECODE_IO;
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

