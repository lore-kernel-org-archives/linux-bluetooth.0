Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v7 02/11] gatt: Add stub for gatt.{c, h} files
Date: Wed, 19 Feb 2014 15:51:24 -0300
Message-Id: <1392835893-6723-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1B88D85B-35F3-47BB-ACAD-872E6C4F0A79@holtmann.org>
 <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

These files implement functions to handle ATT transactions, and expose
functions to allow other entities to manage GATT based services. It
is a replacement for src/attrib-server.c.
---
 Makefile.am |  1 +
 src/gatt.c  | 38 ++++++++++++++++++++++++++++++++++++++
 src/gatt.h  | 26 ++++++++++++++++++++++++++
 src/main.c  | 15 ++++++++++-----
 4 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h

diff --git a/Makefile.am b/Makefile.am
index 11f2aa1..6bbf63b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -146,6 +146,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/profile.h src/profile.c \
 			src/service.h src/service.c \
+			src/gatt.h src/gatt.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c \
diff --git a/src/gatt.c b/src/gatt.c
new file mode 100644
index 0000000..06619f0
--- /dev/null
+++ b/src/gatt.c
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
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
+#include "gatt.h"
+
+void gatt_init(void)
+{
+
+}
+
+void gatt_cleanup(void)
+{
+
+}
diff --git a/src/gatt.h b/src/gatt.h
new file mode 100644
index 0000000..3a320b4
--- /dev/null
+++ b/src/gatt.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
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
+void gatt_init(void);
+
+void gatt_cleanup(void);
diff --git a/src/main.c b/src/main.c
index 91d90b4..b3136fc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -55,6 +55,7 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "profile.h"
+#include "gatt.h"
 #include "systemd.h"
 
 #define BLUEZ_NAME "org.bluez"
@@ -531,6 +532,13 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (option_experimental)
+		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+
+	g_dbus_set_flags(gdbus_flags);
+
+	gatt_init();
+
 	if (adapter_init() < 0) {
 		error("Adapter handling initialization failed");
 		exit(1);
@@ -540,11 +548,6 @@ int main(int argc, char *argv[])
 	btd_agent_init();
 	btd_profile_init();
 
-	if (option_experimental)
-		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
-
-	g_dbus_set_flags(gdbus_flags);
-
 	if (option_compat == TRUE)
 		sdp_flags |= SDP_SERVER_COMPAT;
 
@@ -598,6 +601,8 @@ int main(int argc, char *argv[])
 
 	adapter_cleanup();
 
+	gatt_cleanup();
+
 	rfkill_exit();
 
 	stop_sdp_server();
-- 
1.8.3.1

