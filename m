Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/4] gatt: Add skeleton of gatt-db
Date: Thu, 24 Apr 2014 13:23:44 +0200
Message-Id: <1398338627-32588-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change adds new() and destroy() fuctions for gatt_db,
which will be used for storing local attributes.
---
 android/Android.mk   |  1 +
 android/Makefile.am  |  1 +
 src/shared/gatt-db.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h | 27 +++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 src/shared/gatt-db.c
 create mode 100644 src/shared/gatt-db.h

diff --git a/android/Android.mk b/android/Android.mk
index 40d696c..5d43a47 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -51,6 +51,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/queue.c \
 	bluez/src/shared/ringbuf.c \
 	bluez/src/shared/hfp.c \
+	bluez/src/shared/gatt-db.c \
 	bluez/src/shared/io-glib.c \
 	bluez/src/sdpd-database.c \
 	bluez/src/sdpd-service.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index cf70fab..5ab6411 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -29,6 +29,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c \
 				src/shared/hfp.h src/shared/hfp.c \
+				src/shared/gatt-db.h src/shared/gatt-db.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc-common.h \
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
new file mode 100644
index 0000000..e56b381
--- /dev/null
+++ b/src/shared/gatt-db.c
@@ -0,0 +1,47 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "src/shared/util.h"
+#include "src/shared/gatt-db.h"
+
+struct gatt_db {
+	uint16_t next_handle;
+};
+
+struct gatt_db *gatt_db_new(void)
+{
+	struct gatt_db *db;
+
+	db = new0(struct gatt_db, 1);
+	if (!db)
+		return NULL;
+
+	db->next_handle = 0x0001;
+
+	return db;
+}
+
+void gatt_db_destroy(struct gatt_db *db)
+{
+	free(db);
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
new file mode 100644
index 0000000..2901afb
--- /dev/null
+++ b/src/shared/gatt-db.h
@@ -0,0 +1,27 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct gatt_db;
+
+struct gatt_db *gatt_db_new(void);
+void gatt_db_destroy(struct gatt_db *db);
-- 
1.8.5.3

