Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v4 1/2] rctest: add automated test
Date: Mon,  8 Oct 2012 11:50:02 +0800
Message-Id: <1349668203-10782-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1346446228-11105-1-git-send-email-gustavo@padovan.org>
References: <1346446228-11105-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

adds -a option to enable automated tests. We use the -i option to define
the receiving side and the -a define the sending side:

./rctest -i hci0 -a hci1
---
 test/rctest.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index 2dd54de..d19e096 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -55,7 +55,8 @@ enum {
 	DUMP,
 	CONNECT,
 	CRECV,
-	LSEND
+	LSEND,
+	AUTO,
 };
 
 static unsigned char *buf;
@@ -72,6 +73,7 @@ static unsigned long delay = 0;
 
 /* Default addr and channel */
 static bdaddr_t bdaddr;
+static bdaddr_t auto_bdaddr;
 static uint16_t uuid = 0x0000;
 static uint8_t channel = 10;
 
@@ -162,7 +164,11 @@ static int do_connect(const char *svr)
 	/* Bind to local address */
 	memset(&addr, 0, sizeof(addr));
 	addr.rc_family = AF_BLUETOOTH;
-	bacpy(&addr.rc_bdaddr, &bdaddr);
+
+	if (bacmp(&auto_bdaddr, BDADDR_ANY))
+		bacpy(&addr.rc_bdaddr, &auto_bdaddr);
+	else
+		bacpy(&addr.rc_bdaddr, &bdaddr);
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
@@ -592,6 +598,23 @@ static void multi_connect_mode(int argc, char *argv[])
 	}
 }
 
+static void automated_send_recv()
+{
+	int sk;
+	char device[18];
+
+	if (fork()) {
+		do_listen(recv_mode);
+	} else {
+		ba2str(&bdaddr, device);
+
+		sk = do_connect(device);
+		if (sk < 0)
+			exit(1);
+		send_mode(sk);
+	}
+}
+
 static void usage(void)
 {
 	printf("rctest - RFCOMM testing\n"
@@ -605,7 +628,8 @@ static void usage(void)
 		"\t-u connect and receive\n"
 		"\t-n connect and be silent\n"
 		"\t-c connect, disconnect, connect, ...\n"
-		"\t-m multiple connects\n");
+		"\t-m multiple connects\n"
+		"\t-a automated test (receive hcix as parameter)\n");
 
 	printf("Options:\n"
 		"\t[-b bytes] [-i device] [-P channel] [-U uuid]\n"
@@ -629,8 +653,9 @@ int main(int argc, char *argv[])
 	int opt, sk, mode = RECV, need_addr = 0;
 
 	bacpy(&bdaddr, BDADDR_ANY);
+	bacpy(&auto_bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:U:B:N:MAESL:W:C:D:Y:T")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:N:MAESL:W:C:D:Y:T")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -669,6 +694,15 @@ int main(int argc, char *argv[])
 			need_addr = 1;
 			break;
 
+		case 'a':
+			mode = AUTO;
+
+			if (!strncasecmp(optarg, "hci", 3))
+				hci_devba(atoi(optarg + 3), &auto_bdaddr);
+			else
+				str2ba(optarg, &auto_bdaddr);
+			break;
+
 		case 'b':
 			data_size = atoi(optarg);
 			break;
@@ -805,6 +839,10 @@ int main(int argc, char *argv[])
 				exit(1);
 			dump_mode(sk);
 			break;
+
+		case AUTO:
+			automated_send_recv();
+			break;
 	}
 
 	syslog(LOG_INFO, "Exit");
-- 
1.7.11.4

