Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 21/28] time: move to the profiles folder
Date: Wed,  4 Jul 2012 10:17:40 +0200
Message-Id: <1341389867-30749-22-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am            |    3 +-
 profiles/time/main.c   |   58 ++++++++++++++++++
 profiles/time/server.c |  154 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/time/server.h |   26 ++++++++
 time/main.c            |   58 ------------------
 time/server.c          |  154 ------------------------------------------------
 time/server.h          |   26 --------
 7 files changed, 240 insertions(+), 239 deletions(-)
 create mode 100644 profiles/time/main.c
 create mode 100644 profiles/time/server.c
 create mode 100644 profiles/time/server.h
 delete mode 100644 time/main.c
 delete mode 100644 time/server.c
 delete mode 100644 time/server.h

diff --git a/Makefile.am b/Makefile.am
index b816e20..3a5f616 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -224,7 +224,8 @@ builtin_sources += profiles/thermometer/main.c \
 		       	profiles/thermometer/thermometer.c \
 			profiles/alert/main.c profiles/alert/server.h \
 			profiles/alert/server.c \
-			time/main.c time/server.h time/server.c \
+			profiles/time/main.c profiles/time/server.h \
+			profiles/time/server.c \
 			plugins/gatt-example.c \
 			profiles/proximity/main.c profiles/proximity/manager.h \
 		       	profiles/proximity/manager.c \
diff --git a/profiles/time/main.c b/profiles/time/main.c
new file mode 100644
index 0000000..d876725
--- /dev/null
+++ b/profiles/time/main.c
@@ -0,0 +1,58 @@
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
+#include <stdint.h>
+#include <glib.h>
+#include <errno.h>
+
+#include "plugin.h"
+#include "hcid.h"
+#include "log.h"
+#include "server.h"
+
+static int time_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return time_server_init();
+}
+
+static void time_exit(void)
+{
+	if (!main_opts.gatt_enabled)
+		return;
+
+	time_server_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(time, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			time_init, time_exit)
diff --git a/profiles/time/server.c b/profiles/time/server.c
new file mode 100644
index 0000000..13a7bbe
--- /dev/null
+++ b/profiles/time/server.c
@@ -0,0 +1,154 @@
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
+#include <glib.h>
+#include <time.h>
+#include <errno.h>
+#include <bluetooth/uuid.h>
+#include <adapter.h>
+
+#include "gattrib.h"
+#include "att.h"
+#include "gatt.h"
+#include "att-database.h"
+#include "attrib-server.h"
+#include "gatt-service.h"
+#include "log.h"
+#include "server.h"
+
+#define CURRENT_TIME_SVC_UUID		0x1805
+
+#define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
+#define CT_TIME_CHR_UUID		0x2A2B
+
+static int encode_current_time(uint8_t value[10])
+{
+	struct timespec tp;
+	struct tm tm;
+
+	if (clock_gettime(CLOCK_REALTIME, &tp) == -1) {
+		int err = -errno;
+
+		error("clock_gettime: %s", strerror(-err));
+		return err;
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
+static uint8_t current_time_read(struct attribute *a,
+				 struct btd_device *device, gpointer user_data)
+{
+	uint8_t value[10];
+
+	if (encode_current_time(value) < 0)
+		return ATT_ECODE_IO;
+
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static uint8_t local_time_info_read(struct attribute *a,
+				struct btd_device *device, gpointer user_data)
+{
+	uint8_t value[2];
+
+	DBG("a=%p", a);
+
+	tzset();
+
+	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
+	 * for the local time or not. The offset is unknown. */
+	value[0] = daylight ? 0xff : 0x00;
+
+	/* Convert POSIX "timezone" (seconds West of GMT) to Time Profile
+	 * format (offset from UTC in number of 15 minutes increments). */
+	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
+
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static void register_current_time_service(void)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, CURRENT_TIME_SVC_UUID);
+
+	/* Current Time service */
+	/* FIXME: Provide the adapter in next function */
+	gatt_service_add(NULL, GATT_PRIM_SVC_UUID, &uuid,
+				/* CT Time characteristic */
+				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+						current_time_read, NULL,
+
+				/* Local Time Information characteristic */
+				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+						local_time_info_read, NULL,
+
+				GATT_OPT_INVALID);
+}
+
+int time_server_init(void)
+{
+	register_current_time_service();
+
+	return 0;
+}
+
+void time_server_exit(void)
+{
+}
diff --git a/profiles/time/server.h b/profiles/time/server.h
new file mode 100644
index 0000000..621bf2b
--- /dev/null
+++ b/profiles/time/server.h
@@ -0,0 +1,26 @@
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
+int time_server_init(void);
+void time_server_exit(void);
diff --git a/time/main.c b/time/main.c
deleted file mode 100644
index d876725..0000000
--- a/time/main.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation
- *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdint.h>
-#include <glib.h>
-#include <errno.h>
-
-#include "plugin.h"
-#include "hcid.h"
-#include "log.h"
-#include "server.h"
-
-static int time_init(void)
-{
-	if (!main_opts.gatt_enabled) {
-		DBG("GATT is disabled");
-		return -ENOTSUP;
-	}
-
-	return time_server_init();
-}
-
-static void time_exit(void)
-{
-	if (!main_opts.gatt_enabled)
-		return;
-
-	time_server_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(time, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-			time_init, time_exit)
diff --git a/time/server.c b/time/server.c
deleted file mode 100644
index 13a7bbe..0000000
--- a/time/server.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation
- *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <glib.h>
-#include <time.h>
-#include <errno.h>
-#include <bluetooth/uuid.h>
-#include <adapter.h>
-
-#include "gattrib.h"
-#include "att.h"
-#include "gatt.h"
-#include "att-database.h"
-#include "attrib-server.h"
-#include "gatt-service.h"
-#include "log.h"
-#include "server.h"
-
-#define CURRENT_TIME_SVC_UUID		0x1805
-
-#define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
-#define CT_TIME_CHR_UUID		0x2A2B
-
-static int encode_current_time(uint8_t value[10])
-{
-	struct timespec tp;
-	struct tm tm;
-
-	if (clock_gettime(CLOCK_REALTIME, &tp) == -1) {
-		int err = -errno;
-
-		error("clock_gettime: %s", strerror(-err));
-		return err;
-	}
-
-	if (localtime_r(&tp.tv_sec, &tm) == NULL) {
-		error("localtime_r() failed");
-		/* localtime_r() does not set errno */
-		return -EINVAL;
-	}
-
-	att_put_u16(1900 + tm.tm_year, &value[0]); /* Year */
-	value[2] = tm.tm_mon + 1; /* Month */
-	value[3] = tm.tm_mday; /* Day */
-	value[4] = tm.tm_hour; /* Hours */
-	value[5] = tm.tm_min; /* Minutes */
-	value[6] = tm.tm_sec; /* Seconds */
-	value[7] = tm.tm_wday == 0 ? 7 : tm.tm_wday; /* Day of Week */
-	/* From Time Profile spec: "The number of 1/256 fractions of a second."
-	 * In 1s there are 256 fractions, in 1ns there are 256/10^9 fractions.
-	 * To avoid integer overflow, we use the equivalent 1/3906250 ratio. */
-	value[8] = tp.tv_nsec / 3906250; /* Fractions256 */
-	value[9] = 0x00; /* Adjust Reason */
-
-	return 0;
-}
-
-static uint8_t current_time_read(struct attribute *a,
-				 struct btd_device *device, gpointer user_data)
-{
-	uint8_t value[10];
-
-	if (encode_current_time(value) < 0)
-		return ATT_ECODE_IO;
-
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
-
-	return 0;
-}
-
-static uint8_t local_time_info_read(struct attribute *a,
-				struct btd_device *device, gpointer user_data)
-{
-	uint8_t value[2];
-
-	DBG("a=%p", a);
-
-	tzset();
-
-	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
-	 * for the local time or not. The offset is unknown. */
-	value[0] = daylight ? 0xff : 0x00;
-
-	/* Convert POSIX "timezone" (seconds West of GMT) to Time Profile
-	 * format (offset from UTC in number of 15 minutes increments). */
-	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
-
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
-
-	return 0;
-}
-
-static void register_current_time_service(void)
-{
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, CURRENT_TIME_SVC_UUID);
-
-	/* Current Time service */
-	/* FIXME: Provide the adapter in next function */
-	gatt_service_add(NULL, GATT_PRIM_SVC_UUID, &uuid,
-				/* CT Time characteristic */
-				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-							ATT_CHAR_PROPER_NOTIFY,
-				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						current_time_read, NULL,
-
-				/* Local Time Information characteristic */
-				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
-				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						local_time_info_read, NULL,
-
-				GATT_OPT_INVALID);
-}
-
-int time_server_init(void)
-{
-	register_current_time_service();
-
-	return 0;
-}
-
-void time_server_exit(void)
-{
-}
diff --git a/time/server.h b/time/server.h
deleted file mode 100644
index 621bf2b..0000000
--- a/time/server.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation
- *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int time_server_init(void);
-void time_server_exit(void);
-- 
1.7.10.2

