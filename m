Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH] Add duplex test case to l2test
Date: Sun, 13 Sep 2009 07:31:23 -0300
Message-Id: <1252837883-19640-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use a SOCK_NONBLOCK to send and receive at the same time.
---
 test/l2test.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index a937905..62ad8d6 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -60,6 +60,8 @@ enum {
 	LSEND,
 	SENDDUMP,
 	LSENDDUMP,
+	LSENDRECV,
+	CSENDRECV,
 	INFOREQ,
 	PAIRING,
 };
@@ -775,6 +777,22 @@ static void senddump_mode(int sk)
 	dump_mode(sk);
 }
 
+static void send_and_recv_mode(int sk)
+{
+	int flags;
+
+	if ((flags = fcntl(sk, F_GETFL, 0)) < 0)
+		flags = 0;
+	fcntl(sk, F_SETFL, flags | O_NONBLOCK);
+
+	/* fork for duplex channel */
+	if (fork())
+		send_mode(sk);
+	else
+		recv_mode(sk);
+	return;
+}
+
 static void reconnect_mode(char *svr)
 {
 	while (1) {
@@ -1024,6 +1042,8 @@ static void usage(void)
 		"\t-w listen and send\n"
 		"\t-d listen and dump incoming data\n"
 		"\t-x listen, then send, then dump incoming data\n"
+		"\t-t listen, then send and receive at the same time\n"
+		"\t-v connect, then send and receive at the same time\n"
 		"\t-s connect and send\n"
 		"\t-u connect and receive\n"
 		"\t-n connect and be silent\n"
@@ -1060,7 +1080,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:RGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntvxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:RGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1099,6 +1119,16 @@ int main(int argc, char *argv[])
 			need_addr = 1;
 			break;
 
+		case 't':
+			mode = LSENDRECV;
+			need_addr = 1;
+			break;
+
+		case 'v':
+			mode = CSENDRECV;
+			need_addr = 1;
+			break;
+
 		case 'x':
 			mode = LSENDDUMP;
 			break;
@@ -1281,6 +1311,18 @@ int main(int argc, char *argv[])
 			do_listen(senddump_mode);
 			break;
 
+		case LSENDRECV:
+			do_listen(send_and_recv_mode);
+			break;
+
+		case CSENDRECV:
+			sk = do_connect(argv[optind]);
+			if (sk < 0)
+				exit(1);
+
+			send_and_recv_mode(sk);
+			break;
+
 		case INFOREQ:
 			info_request(argv[optind]);
 			exit(0);
-- 
1.6.3.3

