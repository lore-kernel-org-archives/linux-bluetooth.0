Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH RFC BlueZ 2/5] Time Profile: implement generic "time provider" interface
Date: Fri,  2 Dec 2011 14:34:07 -0400
Message-Id: <1322850850-18019-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

With this new interface, it is possible to implement providers for each
supported platform.

This commit adds an initial "dummy" provider, useful for testing.
---
 .gitignore            |    1 +
 Makefile.am           |    6 +++++
 acinclude.m4          |    7 ++++++
 time/provider-dummy.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++
 time/server.c         |   17 +++++++++++----
 time/server.h         |    8 +++++++
 6 files changed, 87 insertions(+), 5 deletions(-)
 create mode 100644 time/provider-dummy.c

diff --git a/.gitignore b/.gitignore
index badd1a0..ba78b68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@ src/builtin.h
 src/bluetoothd
 audio/telephony.c
 sap/sap.c
+time/provider.c
 scripts/bluetooth.rules
 scripts/97-bluetooth.rules
 scripts/97-bluetooth-hid2hci.rules
diff --git a/Makefile.am b/Makefile.am
index 07b8626..ac562b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -226,6 +226,8 @@ if TIMEPLUGIN
 builtin_modules += time
 builtin_sources += time/main.c \
 		   time/server.h time/server.c
+
+builtin_nodist += time/provider.c
 endif
 
 if ALERTPLUGIN
@@ -344,6 +346,7 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
 			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
+			time/provider-dummy.c \
 			proximity/proximity.conf
 
 if ALSA
@@ -479,6 +482,9 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 audio/telephony.c: audio/@TELEPHONY_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
+time/provider.c: time/@TIME_PROVIDER@
+	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+
 sap/sap.c: sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
diff --git a/acinclude.m4 b/acinclude.m4
index 2097d77..5930a79 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -213,6 +213,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	dfutool_enable=no
 	datafiles_enable=yes
 	telephony_driver=dummy
+	time_provider=dummy
 	maemo6_enable=no
 	sap_driver=dummy
 	dbusoob_enable=no
@@ -252,6 +253,12 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		time_enable=${enableval}
 	])
 
+	AC_ARG_WITH(time, AC_HELP_STRING([--with-time=PROVIDER], [select time provider]), [
+		time_provider=${withval}
+	])
+
+	AC_SUBST([TIME_PROVIDER], [provider-${time_provider}.c])
+
 	AC_ARG_ENABLE(alert, AC_HELP_STRING([--enable-alert], [enable Phone Alert Profile plugin]), [
 		alert_enable=${enableval}
 	])
diff --git a/time/provider-dummy.c b/time/provider-dummy.c
new file mode 100644
index 0000000..ba0744f
--- /dev/null
+++ b/time/provider-dummy.c
@@ -0,0 +1,53 @@
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
+#include <stdint.h>
+
+#include "server.h"
+#include "log.h"
+
+int time_provider_init(void)
+{
+	DBG("");
+
+	return 0;
+}
+
+void time_provider_exit(void)
+{
+	DBG("");
+}
+
+void time_provider_status(uint8_t *state, uint8_t *result)
+{
+	*state = UPDATE_STATE_IDLE;
+	*result = UPDATE_RESULT_NOT_ATTEMPTED;
+}
+
+uint8_t time_provider_control(int op)
+{
+	DBG("");
+
+	return 0;
+}
diff --git a/time/server.c b/time/server.c
index 4958fd3..56eecb1 100644
--- a/time/server.c
+++ b/time/server.c
@@ -137,10 +137,12 @@ static uint8_t time_update_control(struct attribute *a, gpointer user_data)
 {
 	DBG("handle 0x%04x", a->handle);
 
-	if (a->len != 1)
+	if (a->len != 1) {
 		DBG("Invalid control point value size: %d", a->len);
+		return 0;
+	}
 
-	return 0;
+	return time_provider_control(a->data[0]);
 }
 
 static uint8_t time_update_status(struct attribute *a, gpointer user_data)
@@ -149,8 +151,8 @@ static uint8_t time_update_status(struct attribute *a, gpointer user_data)
 
 	DBG("handle 0x%04x", a->handle);
 
-	value[0] = UPDATE_STATE_IDLE;
-	value[1] = UPDATE_RESULT_SUCCESSFUL;
+	time_provider_status(&value[0], &value[1]);
+
 	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
 
 	return 0;
@@ -179,11 +181,16 @@ static void register_reference_time_update_service(void)
 int time_server_init(void)
 {
 	register_current_time_service();
-	register_reference_time_update_service();
+
+	if (time_provider_init() < 0)
+		DBG("error initializing time provider");
+	else
+		register_reference_time_update_service();
 
 	return 0;
 }
 
 void time_server_exit(void)
 {
+	time_provider_exit();
 }
diff --git a/time/server.h b/time/server.h
index 12b47ed..0e1f858 100644
--- a/time/server.h
+++ b/time/server.h
@@ -43,3 +43,11 @@ enum {
 
 int time_server_init(void);
 void time_server_exit(void);
+
+/* Time provider init and exit routines. Implemented by provider-*.c */
+int time_provider_init(void);
+void time_provider_exit(void);
+
+/* Time provider control and status routines. Implemented by provider-*.c */
+void time_provider_status(uint8_t *state, uint8_t *result);
+uint8_t time_provider_control(int op);
-- 
1.7.0.4

