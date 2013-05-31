Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/14] build: Add bluetooth-player command line client
Date: Fri, 31 May 2013 13:55:36 +0300
Message-Id: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bluetooth-player is intended to control players connect over bluetooth.
---
 Makefile.tools            |  5 +++++
 client/bluetooth-player.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 client/bluetooth-player.c

diff --git a/Makefile.tools b/Makefile.tools
index acd403e..d7920c2 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -7,6 +7,11 @@ client_bluetoothctl_SOURCES = $(gdbus_sources) client/main.c \
 					client/agent.h client/agent.c \
 					monitor/uuid.h monitor/uuid.c
 client_bluetoothctl_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
+
+bin_PROGRAMS += client/bluetooth-player
+client_bluetooth_player_SOURCES = $(gdbus_sources) client/bluetooth-player.c \
+					client/display.c
+client_bluetooth_player_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
 
 if MONITOR
diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
new file mode 100644
index 0000000..b38861a
--- /dev/null
+++ b/client/bluetooth-player.c
@@ -0,0 +1,31 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Intel Corporation. All rights reserved.
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
+int main(int argc, char *argv[])
+{
+	return 0;
+}
-- 
1.8.1.4

