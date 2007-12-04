Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 5 Dec 2007 00:25:38 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20071204232538.GA23003@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Subject: [Bluez-devel] [PATCH] audio - ignore permission denied errors on
	avctp and avdtp sockets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi

The attached patch ignores permission denied errors from the bind on
avctp and avdtp sockets. This bind is only allowed for root since some
kernel versions and disabling is better than failing completely if run
without root priviledges.

Bastian

-- 
Each kiss is as the first.
		-- Miramanee, Kirk's wife, "The Paradise Syndrome",
		   stardate 4842.6

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=diff

Index: audio/avdtp.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/avdtp.c,v
retrieving revision 1.60
diff -u -r1.60 avdtp.c
--- audio/avdtp.c	3 Dec 2007 22:41:29 -0000	1.60
+++ audio/avdtp.c	4 Dec 2007 23:21:00 -0000
@@ -364,6 +364,7 @@
 static GSList *local_seps = NULL;
 
 static GIOChannel *avdtp_server = NULL;
+static gboolean avdtp_server_failed;
 
 static GSList *sessions = NULL;
 
@@ -2866,23 +2867,22 @@
 	return TRUE;
 }
 
-static GIOChannel *avdtp_server_socket(void)
+static int avdtp_server_socket(GIOChannel **io)
 {
 	int sock, lm;
 	struct sockaddr_l2 addr;
-	GIOChannel *io;
 
 	sock = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sock < 0) {
 		error("AVDTP server socket: %s (%d)", strerror(errno), errno);
-		return NULL;
+		return -1;
 	}
 
 	lm = L2CAP_LM_SECURE;
 	if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &lm, sizeof(lm)) < 0) {
 		error("AVDTP server setsockopt: %s (%d)", strerror(errno), errno);
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
 	memset(&addr, 0, sizeof(addr));
@@ -2891,25 +2891,31 @@
 	addr.l2_psm = htobs(AVDTP_PSM);
 
 	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		if (errno == EACCES) {
+			info("AVDTP server bind failed, disabling support");
+			close(sock);
+			return 0;
+		}
+
 		error("AVDTP server bind: %s", strerror(errno), errno);
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
 	if (listen(sock, 4) < 0) {
 		error("AVDTP server listen: %s", strerror(errno), errno);
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
-	io = g_io_channel_unix_new(sock);
-	if (!io) {
+	*io = g_io_channel_unix_new(sock);
+	if (!*io) {
 		error("Unable to allocate new io channel");
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
-	return io;
+	return 1;
 }
 
 const char *avdtp_strerror(struct avdtp_error *err)
@@ -2972,12 +2978,17 @@
 
 int avdtp_init(void)
 {
-	if (avdtp_server)
+	int ret;
+
+	if (avdtp_server || avdtp_server_failed)
 		return 0;
 
-	avdtp_server = avdtp_server_socket();
-	if (!avdtp_server)
-		return -1;
+	ret = avdtp_server_socket(&avdtp_server);
+
+	if (ret <= 0) {
+		avdtp_server_failed = TRUE;
+		return ret;
+	}
 
 	g_io_add_watch(avdtp_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			(GIOFunc) avdtp_server_cb, NULL);
Index: audio/control.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/control.c,v
retrieving revision 1.11
diff -u -r1.11 control.c
--- audio/control.c	27 Nov 2007 09:15:16 -0000	1.11
+++ audio/control.c	4 Dec 2007 23:21:01 -0000
@@ -99,6 +99,7 @@
 static uint32_t ct_record_id = 0;
 
 static GIOChannel *avctp_server = NULL;
+static gboolean avctp_server_failed;
 
 static GSList *sessions = NULL;
 
@@ -309,23 +310,22 @@
 	return ret;
 }
 
-static GIOChannel *avctp_server_socket(void)
+static int avctp_server_socket(GIOChannel **io)
 {
 	int sock, lm;
 	struct sockaddr_l2 addr;
-	GIOChannel *io;
 
 	sock = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sock < 0) {
 		error("AVCTP server socket: %s (%d)", strerror(errno), errno);
-		return NULL;
+		return -1;
 	}
 
 	lm = L2CAP_LM_SECURE;
 	if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &lm, sizeof(lm)) < 0) {
 		error("AVCTP server setsockopt: %s (%d)", strerror(errno), errno);
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
 	memset(&addr, 0, sizeof(addr));
@@ -334,25 +334,31 @@
 	addr.l2_psm = htobs(AVCTP_PSM);
 
 	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		if (errno == EACCES) {
+			info("AVCTP server bind failed, disabling control support");
+			close(sock);
+			return 0;
+		}
+
 		error("AVCTP server bind: %s", strerror(errno), errno);
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
 	if (listen(sock, 4) < 0) {
 		error("AVCTP server listen: %s", strerror(errno), errno);
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
-	io = g_io_channel_unix_new(sock);
-	if (!io) {
+	*io = g_io_channel_unix_new(sock);
+	if (!*io) {
 		error("Unable to allocate new io channel");
 		close(sock);
-		return NULL;
+		return -1;
 	}
 
-	return io;
+	return 1;
 }
 
 static struct avctp *find_session(bdaddr_t *src, bdaddr_t *dst)
@@ -964,8 +970,9 @@
 int avrcp_init(DBusConnection *conn)
 {
 	sdp_buf_t buf;
+	int ret;
 
-	if (avctp_server)
+	if (avctp_server || avctp_server_failed)
 		return 0;
 
 	connection = dbus_connection_ref(conn);
@@ -996,9 +1003,12 @@
 		return -1;
 	}
 
-	avctp_server = avctp_server_socket();
-	if (!avctp_server)
-		return -1;
+	ret = avctp_server_socket(&avctp_server);
+
+	if (ret <= 0) {
+		avctp_server_failed = TRUE;
+		return ret;
+	}
 
 	g_io_add_watch(avctp_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			(GIOFunc) avctp_server_cb, NULL);
Index: audio/sink.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/sink.c,v
retrieving revision 1.38
diff -u -r1.38 sink.c
--- audio/sink.c	3 Dec 2007 22:41:29 -0000	1.38
+++ audio/sink.c	4 Dec 2007 23:21:03 -0000
@@ -46,6 +46,14 @@
 
 #define STREAM_SETUP_RETRY_TIMER 2000
 
+#ifndef MIN
+# define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
+
+#ifndef MAX
+# define MAX(x, y) ((x) > (y) ? (x) : (y))
+#endif
+
 struct pending_request {
 	DBusConnection *conn;
 	DBusMessage *msg;

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--SUOF0GtieIMvvwua--
