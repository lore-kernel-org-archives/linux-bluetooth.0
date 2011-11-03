Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] Add option 'Y' to set socket priority for l2test
Date: Thu,  3 Nov 2011 17:15:37 +0200
Message-Id: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Priority is set using SO_PRIORITY, see man 7 socket for more details.
---
 test/l2test.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 4f341c3..438d21c 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -111,6 +111,7 @@ static int linger = 0;
 static int reliable = 0;
 static int timestamp = 0;
 static int defer_setup = 0;
+static int priority = -1;
 
 static struct {
 	char	*name;
@@ -345,10 +346,23 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &priority,
+						sizeof(priority)) < 0) {
+		syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	if (getsockopt(sk, SOL_SOCKET, SO_PRIORITY, &opt, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
 	syslog(LOG_INFO, "Connected [imtu %d, omtu %d, flush_to %d, "
-				"mode %d, handle %d, class 0x%02x%02x%02x]",
+		"mode %d, handle %d, class 0x%02x%02x%02x, priority %d]",
 		opts.imtu, opts.omtu, opts.flush_to, opts.mode, conn.hci_handle,
-		conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);
+		conn.dev_class[2], conn.dev_class[1], conn.dev_class[0], opt);
 
 	omtu = (opts.omtu > buffer_size) ? buffer_size : opts.omtu;
 	imtu = (opts.imtu > buffer_size) ? buffer_size : opts.imtu;
@@ -454,6 +468,14 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+
+	if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &priority,
+						sizeof(priority)) < 0) {
+		syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR, "Can not listen on the socket: %s (%d)",
@@ -520,11 +542,20 @@ static void do_listen(void (*handler)(int sk))
 			}
 		}
 
+		optlen = sizeof(priority);
+		if (getsockopt(nsk, SOL_SOCKET, SO_PRIORITY, &opt, &optlen) < 0) {
+			syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+
 		ba2str(&addr.l2_bdaddr, ba);
-		syslog(LOG_INFO, "Connect from %s [imtu %d, omtu %d, flush_to %d, "
-					"mode %d, handle %d, class 0x%02x%02x%02x]",
-			ba, opts.imtu, opts.omtu, opts.flush_to, opts.mode, conn.hci_handle,
-			conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);
+		syslog(LOG_INFO, "Connect from %s [imtu %d, omtu %d, "
+				"flush_to %d, mode %d, handle %d, "
+				"class 0x%02x%02x%02x, priority %d]",
+				ba, opts.imtu, opts.omtu, opts.flush_to,
+				opts.mode, conn.hci_handle, conn.dev_class[2],
+				conn.dev_class[1], conn.dev_class[0], opt);
 
 		omtu = (opts.omtu > buffer_size) ? buffer_size : opts.omtu;
 		imtu = (opts.imtu > buffer_size) ? buffer_size : opts.imtu;
@@ -1111,6 +1142,7 @@ static void usage(void)
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
+		"\t[-Y priority] socket priority\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-U] use sock stream\n"
@@ -1128,7 +1160,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1255,6 +1287,10 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'Y':
+			priority = atoi(optarg);
+			break;
+
 		case 'F':
 			fcs = atoi(optarg);
 			break;
-- 
1.7.6.4

