Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2 1/4] Add skeleton for Message Access Profile plugin
Date: Thu, 10 Mar 2011 12:04:25 +0100
Message-Id: <1299755065-4816-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

This patch introduces skeleton of a plugin supporting server role side
of Bluetooth SIG profile defining procedures for exchanging message
objects.

The plugin can be compiled with different backends used for accessing
message repository. This can be selected during configure:

	./configure --with-messages=backend_name

When no backend is specified, the default dummy is chosen.

There is also a new command line option to obexd needed to start Message
Access service:

	obexd [...] --mas
---
v2: fix copyright declarations

 .gitignore               |    1 +
 Makefile.am              |   10 +++++++++-
 configure.ac             |   12 ++++++++++++
 plugins/mas.c            |   42 ++++++++++++++++++++++++++++++++++++++++++
 plugins/messages-dummy.c |   28 ++++++++++++++++++++++++++++
 plugins/messages.h       |   22 ++++++++++++++++++++++
 src/main.c               |   11 +++++++++--
 src/obex.h               |    1 +
 8 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 plugins/mas.c
 create mode 100644 plugins/messages-dummy.c
 create mode 100644 plugins/messages.h

diff --git a/.gitignore b/.gitignore
index 663240a..e3f5c3f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,7 @@ src/obexd
 src/obexd.service
 plugins/phonebook.c
 plugins/telephony.c
+plugins/messages.c
 client/obex-client
 client/obex-client.service
 test/obex-test
diff --git a/Makefile.am b/Makefile.am
index d32d613..8d8fdc6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -58,6 +58,9 @@ builtin_modules += pbap
 builtin_sources += plugins/pbap.c plugins/phonebook.h \
 			plugins/vcard.h plugins/vcard.c
 
+builtin_modules += mas
+builtin_sources += plugins/mas.c plugins/messages.h
+
 builtin_modules += irmc
 builtin_sources += plugins/irmc.c
 
@@ -65,6 +68,7 @@ builtin_modules += syncevolution
 builtin_sources += plugins/syncevolution.c
 
 builtin_nodist += plugins/phonebook.c
+builtin_nodist += plugins/messages.c
 
 libexec_PROGRAMS += src/obexd
 
@@ -137,7 +141,8 @@ CLEANFILES = $(service_DATA) $(builtin_files)
 EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) src/obex.conf \
 			src/obexd.service.in client/obex-client.service.in \
 			plugins/phonebook-dummy.c plugins/phonebook-ebook.c \
-			plugins/phonebook-tracker.c
+			plugins/phonebook-tracker.c \
+			plugins/messages-dummy.c
 
 DISTCHECK_CONFIGURE_FLAGS = --enable-client --enable-server
 
@@ -150,3 +155,6 @@ MAINTAINERCLEANFILES = Makefile.in \
 
 plugins/phonebook.c: plugins/@PHONEBOOK_DRIVER@
 	$(AM_V_GEN)$(LN_S) @abs_top_srcdir@/$< $@
+
+plugins/messages.c: plugins/@MESSAGES_DRIVER@
+	$(AM_V_GEN)$(LN_S) @abs_top_srcdir@/$< $@
diff --git a/configure.ac b/configure.ac
index 9194843..fb349ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -106,6 +106,18 @@ AC_ARG_ENABLE(debug, AC_HELP_STRING([--enable-debug],
 		CFLAGS="$CFLAGS -g"
 	fi
 ])
+
+messages_driver=dummy
+AC_ARG_WITH(messages, AC_HELP_STRING([--with-messages=DRIVER], [select messages driver]), [
+	if (test "${withval}" = "no"); then
+		messages_driver=dummy;
+	else
+		messages_driver=${withval};
+	fi
+])
+
+AC_SUBST([MESSAGES_DRIVER], [messages-${messages_driver}.c])
+
 phonebook_driver=dummy
 AC_ARG_WITH(phonebook, AC_HELP_STRING([--with-phonebook=DRIVER], [select phonebook driver]), [
 	if (test "${withval}" = "no"); then
diff --git a/plugins/mas.c b/plugins/mas.c
new file mode 100644
index 0000000..cb6dda0
--- /dev/null
+++ b/plugins/mas.c
@@ -0,0 +1,42 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
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
+#include "plugin.h"
+#include "log.h"
+
+#include "messages.h"
+
+static int mas_init(void)
+{
+	return 0;
+}
+
+static void mas_exit(void)
+{
+}
+
+OBEX_PLUGIN_DEFINE(mas, mas_init, mas_exit)
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
new file mode 100644
index 0000000..1722306
--- /dev/null
+++ b/plugins/messages-dummy.c
@@ -0,0 +1,28 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
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
+#include "messages.h"
diff --git a/plugins/messages.h b/plugins/messages.h
new file mode 100644
index 0000000..2a41ea7
--- /dev/null
+++ b/plugins/messages.h
@@ -0,0 +1,22 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
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
diff --git a/src/main.c b/src/main.c
index 1e78615..8154e3b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -84,6 +84,7 @@ static gboolean option_irmc = FALSE;
 static gboolean option_pcsuite = FALSE;
 static gboolean option_symlinks = FALSE;
 static gboolean option_syncevolution = FALSE;
+static gboolean option_mas = FALSE;
 
 static gboolean parse_debug(const char *key, const char *value,
 				gpointer user_data, GError **error)
@@ -125,6 +126,8 @@ static GOptionEntry options[] = {
 				"Enable PC Suite Services server" },
 	{ "syncevolution", 'e', 0, G_OPTION_ARG_NONE, &option_syncevolution,
 				"Enable OBEX server for SyncEvolution" },
+        { "mas", 'm', 0, G_OPTION_ARG_NONE, &option_mas,
+				"Enable Message Access server" },
 	{ NULL },
 };
 
@@ -212,9 +215,10 @@ int main(int argc, char *argv[])
 	if (option_opp == FALSE && option_ftp == FALSE &&
 				option_pbap == FALSE &&
 				option_irmc == FALSE &&
-				option_syncevolution == FALSE) {
+				option_syncevolution == FALSE &&
+				option_mas == FALSE) {
 		fprintf(stderr, "No server selected (use either "
-				"--opp, --ftp, --pbap, --irmc or --syncevolution)\n");
+				"--opp, --ftp, --pbap, --irmc, --mas, or --syncevolution)\n");
 		exit(EXIT_FAILURE);
 	}
 
@@ -278,6 +282,9 @@ int main(int argc, char *argv[])
 		obex_server_init(OBEX_SYNCEVOLUTION, NULL, TRUE, FALSE,
 							FALSE, NULL);
 
+	if (option_mas == TRUE)
+		obex_server_init(OBEX_MAS, NULL, TRUE, FALSE, FALSE, NULL);
+
 	if (!root_folder_setup(option_root, option_root_setup)) {
 		error("Unable to setup root folder %s", option_root);
 		exit(EXIT_FAILURE);
diff --git a/src/obex.h b/src/obex.h
index c3f6e3d..94274c2 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -36,6 +36,7 @@
 #define OBEX_IRMC	(1 << 5)
 #define OBEX_PCSUITE	(1 << 6)
 #define OBEX_SYNCEVOLUTION	(1 << 7)
+#define OBEX_MAS	(1 << 8)
 
 #define TARGET_SIZE 16
 
-- 
1.7.1

