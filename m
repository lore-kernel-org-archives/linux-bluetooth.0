Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 2/3] android/hid: Add a ascii2hex utility
Date: Thu,  7 Nov 2013 11:27:00 +0200
Message-Id: <1383816421-18878-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383816421-18878-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383816421-18878-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data from few interfaces on HAL is in ascii format but it should be
in hex format. This conversion utility does that job.
---
 android/Android.mk  |  1 +
 android/Makefile.am |  2 +-
 android/utils.c     | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/utils.h     |  3 +++
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 android/utils.c

diff --git a/android/Android.mk b/android/Android.mk
index d76dfaf..9493f89 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -27,6 +27,7 @@ LOCAL_SRC_FILES := \
 	ipc.c ipc.h \
 	a2dp.c \
 	pan.c \
+	utils.c \
 	../src/log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 8619641..eb0c8d7 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -9,7 +9,7 @@ noinst_PROGRAMS += android/bluetoothd
 android_bluetoothd_SOURCES = android/main.c \
 				src/log.c \
 				android/hal-msg.h \
-				android/utils.h \
+				android/utils.h android/utils.c \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
 				src/glib-helper.h src/glib-helper.c \
diff --git a/android/utils.c b/android/utils.c
new file mode 100644
index 0000000..9179a6f
--- /dev/null
+++ b/android/utils.c
@@ -0,0 +1,60 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include "utils.h"
+
+static inline uint8_t ascii2hex_c(uint8_t ascii)
+{
+	return g_ascii_isdigit(ascii) ? (ascii - '0') :
+				(g_ascii_toupper(ascii) - 'A' + 10);
+}
+
+int ascii2hex(const uint8_t *ascii, int ascii_len, uint8_t *hex)
+{
+	uint8_t h;
+	int i;
+
+	if (!ascii || !hex)
+		return -1;
+
+	i = 0;
+
+	while (i < ascii_len) {
+		h = ascii2hex_c(ascii[i++]) << 4;
+
+		if (!(i < ascii_len)) {
+			*hex++ = h;
+			break;
+		}
+
+		h |= ascii2hex_c(ascii[i++]);
+		*hex++ = h;
+	}
+
+	return 0;
+}
diff --git a/android/utils.h b/android/utils.h
index 5b009bc..2ec3fc1 100644
--- a/android/utils.h
+++ b/android/utils.h
@@ -21,6 +21,7 @@
  *
  */
 
+#include "lib/bluetooth.h"
 
 static inline void android2bdaddr(const void *buf, bdaddr_t *dst)
 {
@@ -31,3 +32,5 @@ static inline void bdaddr2android(const bdaddr_t *src, void *buf)
 {
 	baswap(buf, src);
 }
+
+int ascii2hex(const uint8_t *ascii, int ascii_len, uint8_t *hex);
-- 
1.8.3.2

