Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] l2test: add flushable cmd line options
Date: Thu, 27 Jan 2011 15:39:40 +0200
Message-Id: <1296135580-8108-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

---
 test/l2test.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 17883a9..ed19679 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -90,6 +90,9 @@ static bdaddr_t bdaddr;
 static unsigned short psm = 10;
 static unsigned short cid = 0;
 
+/* Flushable packet mode */
+static int unsigned flushable = 2;
+
 /* Default number of frames to send (-1 = infinite) */
 static int num_frames = -1;
 
@@ -301,6 +304,19 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Set flushable mode, when mode is incorrect pass through,
+	 shall we handle bugs? */
+	if (flushable < 2) {
+		opt = flushable;
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_FLUSHABLE,
+					&opt, sizeof(opt)) < 0) {
+			syslog(LOG_ERR, "Can't %s flushable mode: %s (%d)",
+					flushable? "set" : "reset",
+					strerror(errno), errno);
+			goto error;
+		}
+	}
+
 	/* Get current options */
 	memset(&opts, 0, sizeof(opts));
 	optlen = sizeof(opts);
@@ -1087,6 +1103,7 @@ static void usage(void)
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
+		"\t[-f mode] Flushable mode\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-U] use sock stream\n"
@@ -1104,7 +1121,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:f:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1268,6 +1285,10 @@ int main(int argc, char *argv[])
 			txwin_size = atoi(optarg);
 			break;
 
+		case 'f':
+			flushable = atoi(optarg);
+			break;
+
 		case 'J':
 			cid = atoi(optarg);
 			break;
-- 
1.7.1

