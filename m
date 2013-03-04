Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] core: Move rfkill_init and rfkill_cleanup to rfkill.h
Date: Mon,  4 Mar 2013 15:58:30 +0200
Message-Id: <1362405510-8685-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362405510-8685-1-git-send-email-luiz.dentz@gmail.com>
References: <1362405510-8685-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am  |  3 ++-
 src/hcid.h   |  3 ---
 src/main.c   |  1 +
 src/rfkill.c |  2 +-
 src/rfkill.h | 24 ++++++++++++++++++++++++
 5 files changed, 28 insertions(+), 5 deletions(-)
 create mode 100644 src/rfkill.h

diff --git a/Makefile.am b/Makefile.am
index f75b8d6..0451ff8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,7 +127,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/systemd.h src/systemd.c \
-			src/rfkill.c src/hcid.h src/sdpd.h \
+			src/rfkill.c src/rfkill.h \
+			src/hcid.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
 			src/attrib-server.h src/attrib-server.c \
diff --git a/src/hcid.h b/src/hcid.h
index 294e844..ae478e7 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -41,7 +41,4 @@ struct main_opts {
 
 extern struct main_opts main_opts;
 
-void rfkill_init(void);
-void rfkill_exit(void);
-
 void btd_exit(void);
diff --git a/src/main.c b/src/main.c
index 23d598f..f2d0983 100644
--- a/src/main.c
+++ b/src/main.c
@@ -57,6 +57,7 @@
 #include "profile.h"
 #include "systemd.h"
 #include "plugin.h"
+#include "rfkill.h"
 
 #define BLUEZ_NAME "org.bluez"
 
diff --git a/src/rfkill.c b/src/rfkill.c
index 70588c0..583400b 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -37,7 +37,7 @@
 
 #include "log.h"
 #include "adapter.h"
-#include "hcid.h"
+#include "rfkill.h"
 
 enum rfkill_type {
 	RFKILL_TYPE_ALL = 0,
diff --git a/src/rfkill.h b/src/rfkill.h
new file mode 100644
index 0000000..b1d50a7
--- /dev/null
+++ b/src/rfkill.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013 Intel Corporation
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
+void rfkill_init(void);
+void rfkill_exit(void);
-- 
1.8.1.2

