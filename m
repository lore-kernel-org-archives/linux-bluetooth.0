Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 08/14] time: move to the profiles folder
Date: Mon,  9 Jul 2012 18:10:30 -0300
Message-Id: <1341868236-9704-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341868236-9704-1-git-send-email-gustavo@padovan.org>
References: <1341868236-9704-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am             |    5 +-
 profiles/time/main.c    |   58 ++++++++++++
 profiles/time/manager.c |   49 ++++++++++
 profiles/time/manager.h |   26 ++++++
 profiles/time/server.c  |  234 +++++++++++++++++++++++++++++++++++++++++++++++
 profiles/time/server.h  |   45 +++++++++
 time/main.c             |   58 ------------
 time/manager.c          |   49 ----------
 time/manager.h          |   26 ------
 time/server.c           |  234 -----------------------------------------------
 time/server.h           |   45 ---------
 11 files changed, 415 insertions(+), 414 deletions(-)
 create mode 100644 profiles/time/main.c
 create mode 100644 profiles/time/manager.c
 create mode 100644 profiles/time/manager.h
 create mode 100644 profiles/time/server.c
 create mode 100644 profiles/time/server.h
 delete mode 100644 time/main.c
 delete mode 100644 time/manager.c
 delete mode 100644 time/manager.h
 delete mode 100644 time/server.c
 delete mode 100644 time/server.h

diff --git a/Makefile.am b/Makefile.am
index c8b2475..7e23f5f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -222,8 +222,9 @@ builtin_sources += profiles/thermometer/main.c \
 		       	profiles/thermometer/thermometer.c \
 			profiles/alert/main.c profiles/alert/server.h \
 			profiles/alert/server.c \
-			time/main.c time/server.h time/server.c \
-			time/manager.h time/manager.c \
+			profiles/time/main.c profiles/time/server.h \
+			profiles/time/server.c profiles/time/manager.c \
+			profiles/time/manager.h \
 			plugins/gatt-example.c \
 			profiles/proximity/main.c profiles/proximity/manager.h \
 		       	profiles/proximity/manager.c \
diff --git a/profiles/time/main.c b/profiles/time/main.c
new file mode 100644
index 0000000..9ef5bf1
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
+#include "manager.h"
+
+static int time_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return time_manager_init();
+}
+
+static void time_exit(void)
+{
+	if (!main_opts.gatt_enabled)
+		return;
+
+	time_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(time, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			time_init, time_exit)
diff --git a/profiles/time/manager.c b/profiles/time/manager.c
new file mode 100644
index 0000000..285c7b1
--- /dev/null
+++ b/profiles/time/manager.c
@@ -0,0 +1,49 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nokia Corporation
+ *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
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
+#include "adapter.h"
+#include "manager.h"
+#include "server.h"
+
+struct btd_adapter_driver time_server_driver = {
+	.name = "gatt-time-server",
+	.probe = time_server_init,
+	.remove = time_server_exit,
+};
+
+int time_manager_init(void)
+{
+	btd_register_adapter_driver(&time_server_driver);
+
+	return 0;
+}
+
+void time_manager_exit(void)
+{
+	btd_unregister_adapter_driver(&time_server_driver);
+}
diff --git a/profiles/time/manager.h b/profiles/time/manager.h
new file mode 100644
index 0000000..74641d6
--- /dev/null
+++ b/profiles/time/manager.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nokia Corporation
+ *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
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
+int time_manager_init(void);
+void time_manager_exit(void);
diff --git a/profiles/time/server.c b/profiles/time/server.c
new file mode 100644
index 0000000..be6e196
--- /dev/null
+++ b/profiles/time/server.c
@@ -0,0 +1,234 @@
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
+#define REF_TIME_UPDATE_SVC_UUID	0x1806
+
+#define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
+#define TIME_UPDATE_CTRL_CHR_UUID	0x2A16
+#define TIME_UPDATE_STAT_CHR_UUID	0x2A17
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
+	struct btd_adapter *adapter = user_data;
+	uint8_t value[10];
+
+	if (encode_current_time(value) < 0)
+		return ATT_ECODE_IO;
+
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static uint8_t local_time_info_read(struct attribute *a,
+				struct btd_device *device, gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
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
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static gboolean register_current_time_service(struct btd_adapter *adapter)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, CURRENT_TIME_SVC_UUID);
+
+	/* Current Time service */
+	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+				/* CT Time characteristic */
+				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+						current_time_read, adapter,
+
+				/* Local Time Information characteristic */
+				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+						local_time_info_read, adapter,
+
+				GATT_OPT_INVALID);
+}
+
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
+int time_server_init(struct btd_adapter *adapter)
+{
+	const char *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	if (!register_current_time_service(adapter)) {
+		error("Current Time Service could not be registered");
+		return -EIO;
+	}
+
+	if (!register_ref_time_update_service(adapter)) {
+		error("Reference Time Update Service could not be registered");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void time_server_exit(struct btd_adapter *adapter)
+{
+	const char *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+}
diff --git a/profiles/time/server.h b/profiles/time/server.h
new file mode 100644
index 0000000..c7b997d
--- /dev/null
+++ b/profiles/time/server.h
@@ -0,0 +1,45 @@
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
+int time_server_init(struct btd_adapter *adapter);
+void time_server_exit(struct btd_adapter *adapter);
diff --git a/time/main.c b/time/main.c
deleted file mode 100644
index 9ef5bf1..0000000
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
-#include "manager.h"
-
-static int time_init(void)
-{
-	if (!main_opts.gatt_enabled) {
-		DBG("GATT is disabled");
-		return -ENOTSUP;
-	}
-
-	return time_manager_init();
-}
-
-static void time_exit(void)
-{
-	if (!main_opts.gatt_enabled)
-		return;
-
-	time_manager_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(time, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-			time_init, time_exit)
diff --git a/time/manager.c b/time/manager.c
deleted file mode 100644
index 285c7b1..0000000
--- a/time/manager.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Nokia Corporation
- *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
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
-#include "adapter.h"
-#include "manager.h"
-#include "server.h"
-
-struct btd_adapter_driver time_server_driver = {
-	.name = "gatt-time-server",
-	.probe = time_server_init,
-	.remove = time_server_exit,
-};
-
-int time_manager_init(void)
-{
-	btd_register_adapter_driver(&time_server_driver);
-
-	return 0;
-}
-
-void time_manager_exit(void)
-{
-	btd_unregister_adapter_driver(&time_server_driver);
-}
diff --git a/time/manager.h b/time/manager.h
deleted file mode 100644
index 74641d6..0000000
--- a/time/manager.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Nokia Corporation
- *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
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
-int time_manager_init(void);
-void time_manager_exit(void);
diff --git a/time/server.c b/time/server.c
deleted file mode 100644
index be6e196..0000000
--- a/time/server.c
+++ /dev/null
@@ -1,234 +0,0 @@
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
-#define REF_TIME_UPDATE_SVC_UUID	0x1806
-
-#define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
-#define TIME_UPDATE_CTRL_CHR_UUID	0x2A16
-#define TIME_UPDATE_STAT_CHR_UUID	0x2A17
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
-	struct btd_adapter *adapter = user_data;
-	uint8_t value[10];
-
-	if (encode_current_time(value) < 0)
-		return ATT_ECODE_IO;
-
-	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
-
-	return 0;
-}
-
-static uint8_t local_time_info_read(struct attribute *a,
-				struct btd_device *device, gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
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
-	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
-
-	return 0;
-}
-
-static gboolean register_current_time_service(struct btd_adapter *adapter)
-{
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, CURRENT_TIME_SVC_UUID);
-
-	/* Current Time service */
-	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
-				/* CT Time characteristic */
-				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-							ATT_CHAR_PROPER_NOTIFY,
-				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						current_time_read, adapter,
-
-				/* Local Time Information characteristic */
-				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
-				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						local_time_info_read, adapter,
-
-				GATT_OPT_INVALID);
-}
-
-static uint8_t time_update_control(struct attribute *a,
-						struct btd_device *device,
-						gpointer user_data)
-{
-	DBG("handle 0x%04x", a->handle);
-
-	if (a->len != 1)
-		DBG("Invalid control point value size: %d", a->len);
-
-	switch (a->data[0]) {
-	case GET_REFERENCE_UPDATE:
-		DBG("Get Reference Update");
-		break;
-	case CANCEL_REFERENCE_UPDATE:
-		DBG("Cancel Reference Update");
-		break;
-	default:
-		DBG("Unknown command: 0x%02x", a->data[0]);
-	}
-
-	return 0;
-}
-
-static uint8_t time_update_status(struct attribute *a,
-						struct btd_device *device,
-						gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	uint8_t value[2];
-
-	DBG("handle 0x%04x", a->handle);
-
-	value[0] = UPDATE_STATE_IDLE;
-	value[1] = UPDATE_RESULT_SUCCESSFUL;
-	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
-
-	return 0;
-}
-
-static gboolean register_ref_time_update_service(struct btd_adapter *adapter)
-{
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, REF_TIME_UPDATE_SVC_UUID);
-
-	/* Reference Time Update service */
-	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
-				/* Time Update control point */
-				GATT_OPT_CHR_UUID, TIME_UPDATE_CTRL_CHR_UUID,
-				GATT_OPT_CHR_PROPS,
-					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
-				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
-						time_update_control, adapter,
-
-				/* Time Update status */
-				GATT_OPT_CHR_UUID, TIME_UPDATE_STAT_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
-				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-						time_update_status, adapter,
-
-				GATT_OPT_INVALID);
-}
-
-int time_server_init(struct btd_adapter *adapter)
-{
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	if (!register_current_time_service(adapter)) {
-		error("Current Time Service could not be registered");
-		return -EIO;
-	}
-
-	if (!register_ref_time_update_service(adapter)) {
-		error("Reference Time Update Service could not be registered");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-void time_server_exit(struct btd_adapter *adapter)
-{
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-}
diff --git a/time/server.h b/time/server.h
deleted file mode 100644
index c7b997d..0000000
--- a/time/server.h
+++ /dev/null
@@ -1,45 +0,0 @@
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
-enum {
-	UPDATE_RESULT_SUCCESSFUL = 0,
-	UPDATE_RESULT_CANCELED = 1,
-	UPDATE_RESULT_NO_CONN = 2,
-	UPDATE_RESULT_ERROR = 3,
-	UPDATE_RESULT_TIMEOUT = 4,
-	UPDATE_RESULT_NOT_ATTEMPTED = 5,
-};
-
-enum {
-	UPDATE_STATE_IDLE = 0,
-	UPDATE_STATE_PENDING = 1,
-};
-
-enum {
-	GET_REFERENCE_UPDATE = 1,
-	CANCEL_REFERENCE_UPDATE = 2,
-};
-
-int time_server_init(struct btd_adapter *adapter);
-void time_server_exit(struct btd_adapter *adapter);
-- 
1.7.10.2

