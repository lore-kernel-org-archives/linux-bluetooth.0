Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@gmail.com,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v0 01/18] gatt: Add stub for gatt.{c, h} files
Date: Thu,  9 Jan 2014 13:38:06 -0300
Message-Id: <1389285503-19348-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
 <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

These files implement functions to manipulate ATT transactions, and expose
functions to allow other entities to manage GATT based services.
---
 Makefile.am |  1 +
 src/gatt.c  | 38 ++++++++++++++++++++++++++++++++++++++
 src/gatt.h  | 26 ++++++++++++++++++++++++++
 src/main.c  |  4 ++++
 4 files changed, 69 insertions(+)
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h

diff --git a/Makefile.am b/Makefile.am
index 23516b9..de7cdc2 100644
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
index 91d90b4..fccc838 100644
--- a/src/main.c
+++ b/src/main.c
@@ -55,6 +55,7 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "profile.h"
+#include "gatt.h"
 #include "systemd.h"
 
 #define BLUEZ_NAME "org.bluez"
@@ -545,6 +546,8 @@ int main(int argc, char *argv[])
 
 	g_dbus_set_flags(gdbus_flags);
 
+	gatt_init();
+
 	if (option_compat == TRUE)
 		sdp_flags |= SDP_SERVER_COMPAT;
 
@@ -595,6 +598,7 @@ int main(int argc, char *argv[])
 	btd_profile_cleanup();
 	btd_agent_cleanup();
 	btd_device_cleanup();
+	gatt_cleanup();
 
 	adapter_cleanup();
 
-- 
1.8.3.1

