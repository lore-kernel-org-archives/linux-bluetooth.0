Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] l2test: add support to the fixed channels
Date: Mon, 12 Jul 2010 18:31:14 -0300
Message-Id: <1278970274-916-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 0bb46f3..17883a9 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -85,9 +85,10 @@ static int max_transmit = 3;
 static long data_size = -1;
 static long buffer_size = 2048;
 
-/* Default addr and psm */
+/* Default addr and psm and cid */
 static bdaddr_t bdaddr;
 static unsigned short psm = 10;
+static unsigned short cid = 0;
 
 /* Default number of frames to send (-1 = infinite) */
 static int num_frames = -1;
@@ -287,7 +288,12 @@ static int do_connect(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
-	addr.l2_psm = htobs(psm);
+	if (cid)
+		addr.l2_cid = htobs(cid);
+	else if (psm)
+		addr.l2_psm = htobs(psm);
+	else
+		goto error;
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
 		syslog(LOG_ERR, "Can't connect: %s (%d)",
@@ -351,7 +357,12 @@ static void do_listen(void (*handler)(int sk))
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	bacpy(&addr.l2_bdaddr, &bdaddr);
-	addr.l2_psm = htobs(psm);
+	if (cid)
+		addr.l2_cid = htobs(cid);
+	else if (psm)
+		addr.l2_psm = htobs(psm);
+	else
+		goto error;
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
@@ -437,6 +448,7 @@ static void do_listen(void (*handler)(int sk))
 	}
 
 	psm = btohs(addr.l2_psm);
+	cid = btohs(addr.l2_cid);
 
 	syslog(LOG_INFO, "Waiting for connection on psm %d ...", psm);
 
@@ -1063,7 +1075,7 @@ static void usage(void)
 		"\t-z information request\n");
 
 	printf("Options:\n"
-		"\t[-b bytes] [-i device] [-P psm]\n"
+		"\t[-b bytes] [-i device] [-P psm] [-J cid]\n"
 		"\t[-I imtu] [-O omtu]\n"
 		"\t[-L seconds] enable SO_LINGER\n"
 		"\t[-W seconds] enable deferred setup\n"
@@ -1092,7 +1104,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1256,6 +1268,10 @@ int main(int argc, char *argv[])
 			txwin_size = atoi(optarg);
 			break;
 
+		case 'J':
+			cid = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.1

