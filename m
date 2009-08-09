Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 2/2] l2test: Add support to set the FCS value
Date: Sun,  9 Aug 2009 07:05:58 -0300
Message-Id: <1249812358-30344-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249812358-30344-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249812358-30344-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Passing the -f option we can set the value for FCS (a crc16 check for
l2cap packets).
---
 test/l2test.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 6ba50c3..a503f26 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -70,6 +70,9 @@ static unsigned char *buf;
 static int imtu = 672;
 static int omtu = 0;
 
+/* Default FCS option */
+static int fcs = 0x01;
+
 /* Default data size */
 static long data_size = -1;
 static long buffer_size = 2048;
@@ -220,6 +223,8 @@ static int do_connect(char *svr)
 	if (rfcmode > 0)
 		opts.mode = rfcmode;
 
+	opts.fcs = fcs;
+
 	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts)) < 0) {
 		syslog(LOG_ERR, "Can't set L2CAP options: %s (%d)",
 							strerror(errno), errno);
@@ -380,6 +385,8 @@ static void do_listen(void (*handler)(int sk))
 	if (rfcmode > 0)
 		opts.mode = rfcmode;
 
+	opts.fcs = fcs;
+
 	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts)) < 0) {
 		syslog(LOG_ERR, "Can't set L2CAP options: %s (%d)",
 							strerror(errno), errno);
@@ -1029,6 +1036,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t[-b bytes] [-i device] [-P psm]\n"
 		"\t[-I imtu] [-O omtu]\n"
+		"\t[-f fcs] use CRC16 check (default = 1)\n"
 		"\t[-L seconds] enable SO_LINGER\n"
 		"\t[-F seconds] enable deferred setup\n"
 		"\t[-B filename] use data packets from file\n"
@@ -1052,7 +1060,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnxyzpb:i:P:I:O:B:N:L:F:C:D:X:RGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnxyzpb:f:i:P:I:O:B:N:L:F:C:D:X:RGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1113,6 +1121,10 @@ int main(int argc, char *argv[])
 			data_size = atoi(optarg);
 			break;
 
+		case 'f':
+			fcs = atoi(optarg);
+			break;
+
 		case 'i':
 			if (!strncasecmp(optarg, "hci", 3))
 				hci_devba(atoi(optarg + 3), &bdaddr);
-- 
1.6.3.3

