Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 4/4] Add options to test MaxTx and TxWindow
Date: Tue, 30 Mar 2010 15:53:29 -0300
Message-Id: <1269975209-10044-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269975209-10044-3-git-send-email-padovan@profusion.mobi>
References: <1269975209-10044-1-git-send-email-padovan@profusion.mobi>
 <1269975209-10044-2-git-send-email-padovan@profusion.mobi>
 <1269975209-10044-3-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index d11992f..9413070 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -75,6 +75,12 @@ static int omtu = 0;
 /* Default FCS option */
 static int fcs = 0x01;
 
+/* Default Transmission Window */
+static int txwin_size = 63;
+
+/* Default Max Transmission */
+static int max_transmit = 3;
+
 /* Default data size */
 static long data_size = -1;
 static long buffer_size = 2048;
@@ -226,6 +232,8 @@ static int do_connect(char *svr)
 		opts.mode = rfcmode;
 
 	opts.fcs = fcs;
+	opts.txwin_size = txwin_size;
+	opts.max_tx = max_transmit;
 
 	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts)) < 0) {
 		syslog(LOG_ERR, "Can't set L2CAP options: %s (%d)",
@@ -388,6 +396,8 @@ static void do_listen(void (*handler)(int sk))
 		opts.mode = rfcmode;
 
 	opts.fcs = fcs;
+	opts.txwin_size = txwin_size;
+	opts.max_tx = max_transmit;
 
 	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts)) < 0) {
 		syslog(LOG_ERR, "Can't set L2CAP options: %s (%d)",
@@ -1064,6 +1074,8 @@ static void usage(void)
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-X mode] select retransmission/flow-control mode\n"
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
+		"\t[-Q num] Max Transmit value (default = 3)\n"
+		"\t[-Z size] Transmission Window size (default = 63)\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-U] use sock stream\n"
@@ -1081,7 +1093,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1237,6 +1249,14 @@ int main(int argc, char *argv[])
 			timestamp = 1;
 			break;
 
+		case 'Q':
+			max_transmit = atoi(optarg);
+			break;
+
+		case 'Z':
+			txwin_size = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.6.4.4
