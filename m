Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] l2test: Add option 'H' to set socket receive buffer size
Date: Thu, 5 Jan 2012 10:23:38 +0100
Message-ID: <1325755419-6157-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Size is set using SO_RCVBUF, see man 7 socket for more details.
---
 test/l2test.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 5034775..35f8ce3 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -112,6 +112,7 @@ static int reliable = 0;
 static int timestamp = 0;
 static int defer_setup = 0;
 static int priority = -1;
+static int rcvbuf = 0;
 
 static struct {
 	char	*name;
@@ -309,6 +310,21 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Set receive buffer size */
+	if (rcvbuf && setsockopt(sk, SOL_SOCKET, SO_RCVBUF,
+						&rcvbuf, sizeof(rcvbuf)) < 0) {
+		syslog(LOG_ERR, "Can't set socket rcv buf size: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	optlen = sizeof(rcvbuf);
+	if (getsockopt(sk, SOL_SOCKET, SO_RCVBUF, &rcvbuf, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get socket rcv buf size: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
 	/* Connect to remote device */
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
@@ -360,9 +376,10 @@ static int do_connect(char *svr)
 	}
 
 	syslog(LOG_INFO, "Connected [imtu %d, omtu %d, flush_to %d, "
-		"mode %d, handle %d, class 0x%02x%02x%02x, priority %d]",
+		"mode %d, handle %d, class 0x%02x%02x%02x, priority %d, rcvbuf %d]",
 		opts.imtu, opts.omtu, opts.flush_to, opts.mode, conn.hci_handle,
-		conn.dev_class[2], conn.dev_class[1], conn.dev_class[0], opt);
+		conn.dev_class[2], conn.dev_class[1], conn.dev_class[0], opt,
+		rcvbuf);
 
 	omtu = (opts.omtu > buffer_size) ? buffer_size : opts.omtu;
 	imtu = (opts.imtu > buffer_size) ? buffer_size : opts.imtu;
@@ -509,6 +526,22 @@ static void do_listen(void (*handler)(int sk))
 		/* Child */
 		close(sk);
 
+		/* Set receive buffer size */
+		if (rcvbuf && setsockopt(nsk, SOL_SOCKET, SO_RCVBUF, &rcvbuf,
+							sizeof(rcvbuf)) < 0) {
+			syslog(LOG_ERR, "Can't set rcv buf size: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+
+		optlen = sizeof(rcvbuf);
+		if (getsockopt(nsk, SOL_SOCKET, SO_RCVBUF, &rcvbuf, &optlen)
+									< 0) {
+			syslog(LOG_ERR, "Can't get rcv buf size: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+
 		/* Get current options */
 		memset(&opts, 0, sizeof(opts));
 		optlen = sizeof(opts);
@@ -553,10 +586,11 @@ static void do_listen(void (*handler)(int sk))
 		ba2str(&addr.l2_bdaddr, ba);
 		syslog(LOG_INFO, "Connect from %s [imtu %d, omtu %d, "
 				"flush_to %d, mode %d, handle %d, "
-				"class 0x%02x%02x%02x, priority %d]",
+				"class 0x%02x%02x%02x, priority %d, rcvbuf %d]",
 				ba, opts.imtu, opts.omtu, opts.flush_to,
 				opts.mode, conn.hci_handle, conn.dev_class[2],
-				conn.dev_class[1], conn.dev_class[0], opt);
+				conn.dev_class[1], conn.dev_class[0], opt,
+				rcvbuf);
 
 		omtu = (opts.omtu > buffer_size) ? buffer_size : opts.omtu;
 		imtu = (opts.imtu > buffer_size) ? buffer_size : opts.imtu;
@@ -1144,6 +1178,7 @@ static void usage(void)
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
 		"\t[-Y priority] socket priority\n"
+		"\t[-H size] Maximum receive buffer size\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-U] use sock stream\n"
@@ -1161,7 +1196,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1340,6 +1375,10 @@ int main(int argc, char *argv[])
 			cid = atoi(optarg);
 			break;
 
+		case 'H':
+			rcvbuf = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
on behalf of ST-Ericsson

