Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] Add option 'Y' to set socket priority for rctest
Date: Thu,  3 Nov 2011 17:15:38 +0200
Message-Id: <1320333340-27112-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
References: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Priority is set using SO_PRIORITY, see man 7 socket for more details.
---
 test/rctest.c |   48 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index 9754f52..b8acfb7 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -85,6 +85,7 @@ static int socktype = SOCK_STREAM;
 static int linger = 0;
 static int timestamp = 0;
 static int defer_setup = 0;
+static int priority = -1;
 
 static float tv2fl(struct timeval tv)
 {
@@ -232,9 +233,22 @@ static int do_connect(const char *svr)
 		//goto error;
 	}
 
-	syslog(LOG_INFO, "Connected [handle %d, class 0x%02x%02x%02x]",
-		conn.hci_handle,
-		conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);
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
+	syslog(LOG_INFO, "Connected [handle %d, class 0x%02x%02x%02x, "
+			"priority %d]", conn.hci_handle, conn.dev_class[2],
+			conn.dev_class[1], conn.dev_class[0], opt);
 
 	return sk;
 
@@ -298,6 +312,13 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+	if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &priority,
+						sizeof(priority)) < 0) {
+		syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
+						strerror(errno), errno);
+		goto error;
+	}
+
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR,"Can not listen on the socket: %s (%d)",
@@ -348,10 +369,18 @@ static void do_listen(void (*handler)(int sk))
 			//goto error;
 		}
 
+		optlen = sizeof(priority);
+		if (getsockopt(nsk, SOL_SOCKET, SO_PRIORITY, &opt, &optlen) < 0) {
+			syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+
 		ba2str(&addr.rc_bdaddr, ba);
-		syslog(LOG_INFO, "Connect from %s [handle %d, class 0x%02x%02x%02x]",
-			ba, conn.hci_handle,
-			conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);
+		syslog(LOG_INFO, "Connect from %s [handle %d, "
+				"class 0x%02x%02x%02x, priority %d]",
+				ba, conn.hci_handle, conn.dev_class[2],
+				conn.dev_class[1], conn.dev_class[0], opt);
 
 #if 0
 		/* Enable SO_TIMESTAMP */
@@ -584,6 +613,7 @@ static void usage(void)
 		"\t[-N num] number of frames to send\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
+		"\t[-Y priority] socket priority\n"
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
@@ -598,7 +628,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:U:B:N:MAESL:W:C:D:T")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:U:B:N:MAESL:W:C:D:Y:T")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -701,6 +731,10 @@ int main(int argc, char *argv[])
 			delay = atoi(optarg) * 1000;
 			break;
 
+		case 'Y':
+			priority = atoi(optarg);
+			break;
+
 		case 'T':
 			timestamp = 1;
 			break;
-- 
1.7.6.4

