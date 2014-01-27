Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v5 16/18] gatttool: Add unix socket connect
Date: Mon, 27 Jan 2014 17:35:22 -0300
Message-Id: <1390854924-31904-17-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the initial support for GATT procedures over unix
socket transport on command line mode (one-shot command). Temporary
solution to allow local GATT procedures testing.
---
 attrib/gatttool.c | 27 ++++++++++++++++++++-------
 attrib/gatttool.h |  1 +
 attrib/utils.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 9f2ead9..cf106de 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -29,7 +29,6 @@
 #include <errno.h>
 #include <glib.h>
 #include <stdlib.h>
-#include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -53,6 +52,7 @@ static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
 static int opt_psm = 0;
+static gboolean opt_local = FALSE;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
@@ -511,6 +511,8 @@ static GOptionEntry options[] = {
 		"Specify local adapter interface", "hciX" },
 	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
 		"Specify remote Bluetooth address", "MAC" },
+	{ "local", 'L', 0, G_OPTION_ARG_NONE, &opt_local,
+		"Use unix socket transport (local communication)", NULL },
 	{ "addr-type", 't', 0, G_OPTION_ARG_STRING, &opt_dst_type,
 		"Set LE address type. Default: public", "[public | random]"},
 	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
@@ -563,6 +565,11 @@ int main(int argc, char *argv[])
 		g_clear_error(&gerr);
 	}
 
+	if (opt_local) {
+		opt_src = NULL;
+		opt_dst = NULL;
+	}
+
 	if (opt_interactive) {
 		interactive(opt_src, opt_dst, opt_dst_type, opt_psm);
 		goto done;
@@ -588,14 +595,20 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	if (opt_dst == NULL) {
-		g_print("Remote Bluetooth address required\n");
-		got_error = TRUE;
-		goto done;
+	if (opt_local)
+		chan = unix_connect(connect_cb, &gerr);
+	else {
+		if (opt_dst == NULL) {
+			g_print("Remote Bluetooth address required\n");
+			got_error = TRUE;
+			goto done;
+		}
+
+		chan = gatt_connect(opt_src, opt_dst, opt_dst_type,
+					opt_sec_level, opt_psm, opt_mtu,
+					connect_cb, &gerr);
 	}
 
-	chan = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
-					opt_psm, opt_mtu, connect_cb, &gerr);
 	if (chan == NULL) {
 		g_printerr("%s\n", gerr->message);
 		g_clear_error(&gerr);
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 8f0913c..be8e236 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -27,4 +27,5 @@ GIOChannel *gatt_connect(const char *src, const char *dst,
 			const char *dst_type, const char *sec_level,
 			int psm, int mtu, BtIOConnect connect_cb,
 			GError **gerr);
+GIOChannel *unix_connect(BtIOConnect connect_cb, GError **gerr);
 size_t gatt_attr_data_from_string(const char *str, uint8_t **data);
diff --git a/attrib/utils.c b/attrib/utils.c
index 17f02be..7d2966f 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -25,7 +25,12 @@
 #include "config.h"
 #endif
 
+#include <errno.h>
 #include <stdlib.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
@@ -101,6 +106,55 @@ GIOChannel *gatt_connect(const char *src, const char *dst,
 	return chan;
 }
 
+static gboolean unix_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	BtIOConnect connect_cb = user_data;
+	GError *gerr;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		gerr = g_error_new_literal(G_IO_CHANNEL_ERROR,
+						G_IO_CHANNEL_ERROR_FAILED,
+						"connection attempt failed");
+		connect_cb(io, gerr, user_data);
+		g_clear_error(&gerr);
+	} else {
+		connect_cb(io, NULL, user_data);
+	}
+
+	return FALSE;
+}
+
+GIOChannel *unix_connect(BtIOConnect connect_cb, GError **gerr)
+{
+	GIOChannel *io;
+	struct sockaddr_un uaddr  = {
+		.sun_family	= AF_UNIX,
+		.sun_path	= "\0/bluetooth/unix_att",
+	};
+	int sk;
+
+	sk = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC , 0);
+	if (sk < 0) {
+		g_set_error_literal(gerr, G_IO_CHANNEL_ERROR,
+				G_IO_CHANNEL_ERROR_FAILED, strerror(errno));
+		return NULL;
+	}
+
+	if (connect(sk, (struct sockaddr *) &uaddr, sizeof(uaddr)) < 0) {
+		g_set_error_literal(gerr, G_IO_CHANNEL_ERROR,
+				G_IO_CHANNEL_ERROR_FAILED, strerror(errno));
+		close(sk);
+		return NULL;
+	}
+
+	io = g_io_channel_unix_new(sk);
+	g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						unix_connect_cb, connect_cb);
+
+	return io;
+}
+
 size_t gatt_attr_data_from_string(const char *str, uint8_t **data)
 {
 	char tmp[3];
-- 
1.8.3.1

