Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: =?UTF-8?q?=5BRFC=20v2=20obexd=2001/11=5D=20fuse=3A=20Add=20initial=20obexfuse=20files=2C=20fuse=20main=20and=20options=20parse?=
Date: Sun, 28 Oct 2012 02:29:16 +0200
Message-Id: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   54 +++++++++++++++++++++++++
 fuse/helpers.h  |   48 ++++++++++++++++++++++
 fuse/obexfuse.c |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 0 deletions(-)
 create mode 100644 fuse/helpers.c
 create mode 100644 fuse/helpers.h
 create mode 100644 fuse/obexfuse.c

diff --git a/fuse/helpers.c b/fuse/helpers.c
new file mode 100644
index 0000000..c36072d
--- /dev/null
+++ b/fuse/helpers.c
@@ -0,0 +1,54 @@
+/*
+ *  OBEX Filesystem in Userspace
+ *
+ *  Copyright (C) 2012  Michał Poczwardowski <dmp0x7c5@gmail.com>
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
+#include <gobex/gobex.h>
+#include <btio/btio.h>
+
+#include <glib.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/rfcomm.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#define BT_RX_MTU 32767
+#define BT_TX_MTU 32767
+
+#include "helpers.h"
+
+#define OBEX_FTP_UUID \
+	"\xF9\xEC\x7B\xC4\x95\x3C\x11\xD2\x98\x4E\x52\x54\x00\xDC\x9E\x09"
+#define OBEX_FTP_UUID_LEN 16
+
+#define OBEX_FTP_LS "x-obex/folder-listing"
+
+struct gobexhlp_request {
+	gchar *name;
+	gboolean complete;
+};
+
+struct gobexhlp_location {
+	gchar *dir;
+	gchar *file;
+};
diff --git a/fuse/helpers.h b/fuse/helpers.h
new file mode 100644
index 0000000..142403f
--- /dev/null
+++ b/fuse/helpers.h
@@ -0,0 +1,48 @@
+/*
+ *  OBEX Filesystem in Userspace
+ *
+ *  Copyright (C) 2012  Michał Poczwardowski <dmp0x7c5@gmail.com>
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
+#include <gobex/gobex.h>
+#include <glib.h>
+
+struct gobexhlp_request;
+
+struct gobexhlp_buffer {
+	void *data;
+	gsize tmpsize;
+	gsize size;
+	gboolean edited;
+};
+
+struct gobexhlp_session {
+	GObex *obex;
+	GList *lsfiles;
+	GIOChannel *io;
+	GHashTable *file_stat;
+	gchar *setpath;
+	struct gobexhlp_request *request;
+	struct gobexhlp_buffer *buffer;
+	gboolean vtouch;
+	gchar *vtouch_path;
+	gboolean rtouch;
+	int status;
+	GError *err;
+};
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
new file mode 100644
index 0000000..fe4f4da
--- /dev/null
+++ b/fuse/obexfuse.c
@@ -0,0 +1,119 @@
+/*
+ *  OBEX Filesystem in Userspace
+ *
+ *  Copyright (C) 2012  Michał Poczwardowski <dmp0x7c5@gmail.com>
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
+#define FUSE_USE_VERSION 26
+
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <fuse.h>
+#include <fuse/fuse_opt.h>
+
+#include "helpers.h"
+
+struct options {
+	char* dststr;
+	char* srcstr;
+} options;
+
+#define GOBEXFUSE_OPT_KEY(t, p, v) { t, offsetof(struct options, p), v }
+
+enum
+{
+   KEY_VERSION,
+   KEY_HELP,
+};
+
+static struct fuse_opt obexfuse_opts[] =
+{
+	GOBEXFUSE_OPT_KEY("--target=%s",dststr, 0),
+	GOBEXFUSE_OPT_KEY("-t %s",	dststr, 0),
+	GOBEXFUSE_OPT_KEY("--source=%s",srcstr, 0),
+	GOBEXFUSE_OPT_KEY("-s %s",	srcstr, 0),
+
+	FUSE_OPT_KEY("-V",             KEY_VERSION),
+	FUSE_OPT_KEY("--version",      KEY_VERSION),
+	FUSE_OPT_KEY("-h",             KEY_HELP),
+	FUSE_OPT_KEY("--help",         KEY_HELP),
+	FUSE_OPT_END
+};
+
+static struct fuse_operations obexfuse_oper = {
+};
+
+static int obexfuse_opt_proc(void *data, const char *arg, int key,
+					struct fuse_args *outargs)
+{
+	switch (key) {
+	case KEY_HELP:
+		g_printerr("Usage: %s mountpoint [options]\n"
+				"\n"
+				"general options:\n"
+				"    -o opt,[opt...]  mount options\n"
+				"    -h   --help      print help\n"
+				"    -V   --version   print version\n"
+				"\n"
+				"obexfuse options:\n"
+				"    -t   --target    target btaddr "
+				"(mandatory)\n"
+				"    -s   --source    source btaddr\n"
+				"\n"
+				, outargs->argv[0]);
+		fuse_opt_add_arg(outargs, "-ho");
+		fuse_main(outargs->argc, outargs->argv, &obexfuse_oper, NULL);
+		exit(1);
+	case KEY_VERSION:
+		g_print("obexfuse upon:\n");
+		fuse_opt_add_arg(outargs, "--version");
+		fuse_main(outargs->argc, outargs->argv, &obexfuse_oper, NULL);
+		exit(0);
+	}
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int retfuse;
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+
+	memset(&options, 0, sizeof(struct options));
+
+	if (fuse_opt_parse(&args, &options, obexfuse_opts,
+				obexfuse_opt_proc) == -1)
+		return -EINVAL;
+
+	if (options.dststr == NULL) {
+		g_printerr("Target not specified\n");
+		return -EINVAL;
+	}
+
+	g_thread_init(NULL);
+
+	fuse_opt_add_arg(&args, "-s"); /* force single threaded mode */
+	retfuse = fuse_main(args.argc, args.argv, &obexfuse_oper, NULL);
+
+	fuse_opt_free_args(&args);
+	return retfuse;
+}
-- 
1.7.8.6

