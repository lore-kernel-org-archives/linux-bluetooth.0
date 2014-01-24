Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 1/2] monitor: Add stubs for monitoring bluetoothd's journal entries
Date: Fri, 24 Jan 2014 19:41:51 -0200
Message-Id: <1390599712-1609-2-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
References: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to have the output of bluetoothd in the same
place as the rest of the data that is being monitored, this
has the potencial to make it easier to know what bluetoothd
action caused which events.
---
 Makefile.tools    |  3 ++-
 configure.ac      |  7 +++++++
 monitor/journal.c | 33 +++++++++++++++++++++++++++++++++
 monitor/journal.h | 24 ++++++++++++++++++++++++
 monitor/main.c    | 13 ++++++++++++-
 5 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 monitor/journal.c
 create mode 100644 monitor/journal.h

diff --git a/Makefile.tools b/Makefile.tools
index 52e49fb..42f7e4e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -20,6 +20,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 					monitor/btsnoop.h monitor/btsnoop.c \
 					monitor/ellisys.h monitor/ellisys.c \
 					monitor/control.h monitor/control.c \
+					monitor/journal.h monitor/journal.c \
 					monitor/packet.h monitor/packet.c \
 					monitor/vendor.h monitor/vendor.c \
 					monitor/lmp.h monitor/lmp.c \
@@ -32,7 +33,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 					monitor/analyze.h monitor/analyze.c \
 					src/shared/util.h src/shared/util.c \
 					src/shared/queue.h src/shared/queue.c
-monitor_btmon_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
+monitor_btmon_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@ @SYSTEMD_JOURNAL_LIBS@
 endif
 
 if EXPERIMENTAL
diff --git a/configure.ac b/configure.ac
index f607d7a..abd65cf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -178,6 +178,13 @@ AC_ARG_ENABLE(systemd, AC_HELP_STRING([--disable-systemd],
 		[disable systemd integration]), [enable_systemd=${enableval}])
 AM_CONDITIONAL(SYSTEMD, test "${enable_systemd}" != "no")
 
+if (test "${enable_systemd}" != "no"); then
+	PKG_CHECK_MODULES(SYSTEMD_JOURNAL, libsystemd-journal, dummy=yes,
+				AC_MSG_ERROR(libsystemd-journal is required))
+	AC_SUBST(SYSTEMD_JOURNAL_CFLAGS)
+	AC_SUBST(SYSTEMD_JOURNAL_LIBS)
+fi
+
 AC_ARG_WITH([systemdsystemunitdir],
 			AC_HELP_STRING([--with-systemdsystemunitdir=DIR],
 			[path to systemd system unit directory]),
diff --git a/monitor/journal.c b/monitor/journal.c
new file mode 100644
index 0000000..ecc7dac
--- /dev/null
+++ b/monitor/journal.c
@@ -0,0 +1,33 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation
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
+#include <errno.h>
+
+#include <systemd/sd-journal.h>
+
+#include "journal.h"
+
+int journal_monitor(void)
+{
+	return -ENOSYS;
+}
diff --git a/monitor/journal.h b/monitor/journal.h
new file mode 100644
index 0000000..895db02
--- /dev/null
+++ b/monitor/journal.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation
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
+int journal_monitor(void);
diff --git a/monitor/main.c b/monitor/main.c
index e7ee3e4..6fb1d28 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -38,6 +38,8 @@
 #include "analyze.h"
 #include "ellisys.h"
 #include "control.h"
+#include "btsnoop.h"
+#include "journal.h"
 
 static void signal_callback(int signum, void *user_data)
 {
@@ -64,6 +66,7 @@ static void usage(void)
 		"\t-T, --date             Show time and date information\n"
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
+		"\t-j, --journal          Show bluetoothd journal logs\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -78,6 +81,7 @@ static const struct option main_options[] = {
 	{ "sco",     no_argument,	NULL, 'S' },
 	{ "ellisys", required_argument, NULL, 'E' },
 	{ "todo",    no_argument,       NULL, '#' },
+	{ "journal", no_argument,       NULL, 'j' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -91,6 +95,7 @@ int main(int argc, char *argv[])
 	const char *analyze_path = NULL;
 	const char *ellisys_server = NULL;
 	unsigned short ellisys_port = 0;
+	bool journal = false;
 	const char *str;
 	sigset_t mask;
 
@@ -101,7 +106,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "r:w:a:s:i:tTSE:vh",
+		opt = getopt_long(argc, argv, "r:w:a:s:i:tTSE:jvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -150,6 +155,9 @@ int main(int argc, char *argv[])
 			packet_todo();
 			lmp_todo();
 			return EXIT_SUCCESS;
+		case 'j':
+			journal = true;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
@@ -200,6 +208,9 @@ int main(int argc, char *argv[])
 	if (ellisys_server)
 		ellisys_enable(ellisys_server, ellisys_port);
 
+	if (journal)
+		journal_monitor();
+
 	if (control_tracing() < 0)
 		return EXIT_FAILURE;
 
-- 
1.8.5.3

