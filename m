Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC BlueZ 4/4] l2test: Add option to inform the address type
Date: Wed,  4 Apr 2012 17:16:11 -0300
Message-Id: <1333570571-29650-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds 'V' option to inform the address type. Possible values
are: 0 (BR/EDR), 1 (LE Public), and 2 (LE Random).
---
 test/l2test.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index ae81aec..9085d3e 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -87,6 +87,7 @@ static long buffer_size = 2048;
 
 /* Default addr and psm and cid */
 static bdaddr_t bdaddr;
+static unsigned char bdaddr_type;
 static unsigned short psm = 0x1011;
 static unsigned short cid = 0;
 
@@ -362,6 +363,7 @@ static int do_connect(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 	if (cid)
 		addr.l2_cid = htobs(cid);
 	else if (psm)
@@ -1020,6 +1022,7 @@ static void info_request(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
 		perror("Can't connect socket");
@@ -1167,6 +1170,7 @@ static void do_pairing(char *svr)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	str2ba(svr, &addr.l2_bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
 		perror("Can't connect socket");
@@ -1224,7 +1228,8 @@ static void usage(void)
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
 		"\t[-M] become master\n"
-		"\t[-T] enable timestamps\n");
+		"\t[-T] enable timestamps\n"
+		"\t[-V] Set address type: 0 (BR/EDR), 1 (LE Public), 2 (LE Random)\n");
 }
 
 int main(int argc, char *argv[])
@@ -1235,7 +1240,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 
 	while ((opt = getopt(argc, argv, "rdscuwmntqxyzpb:a:"
-		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:RUGAESMT")) != EOF) {
+		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:V:RUGAESMT")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -1430,6 +1435,10 @@ int main(int argc, char *argv[])
 			rcvbuf = atoi(optarg);
 			break;
 
+		case 'V':
+			bdaddr_type = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.8.5

