Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/2] scotest: Add deferred setup option
Date: Mon, 19 Nov 2012 16:50:43 +0100
Message-Id: <1353340244-16443-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/scotest.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/test/scotest.c b/test/scotest.c
index de65edf..a40e395 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -57,6 +57,8 @@ static long data_size = 672;
 
 static bdaddr_t bdaddr;
 
+static int defer_setup = 0;
+
 static float tv2fl(struct timeval tv)
 {
 	return (float)tv.tv_sec + (float)(tv.tv_usec/1000000.0);
@@ -147,6 +149,14 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+	/* Enable deferred setup */
+	if (defer_setup && setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
+				&defer_setup, sizeof(defer_setup)) < 0) {
+		syslog(LOG_ERR, "Can't enable deferred setup : %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR,"Can not listen on the socket: %s (%d)",
@@ -181,8 +191,10 @@ static void do_listen(void (*handler)(int sk))
 		if (getsockopt(nsk, SOL_SCO, SCO_CONNINFO, &conn, &optlen) < 0) {
 			syslog(LOG_ERR, "Can't get SCO connection information: %s (%d)",
 							strerror(errno), errno);
-			close(nsk);
-			goto error;
+			if (!defer_setup) {
+				close(nsk);
+				goto error;
+			}
 		}
 
 		ba2str(&addr.sco_bdaddr, ba);
@@ -190,6 +202,18 @@ static void do_listen(void (*handler)(int sk))
 			ba, conn.hci_handle,
 			conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);
 
+		/* Handle deferred setup */
+		if (defer_setup) {
+			syslog(LOG_INFO, "Waiting for %d seconds",
+							abs(defer_setup) - 1);
+			sleep(abs(defer_setup) - 1);
+
+			if (defer_setup < 0) {
+				close(nsk);
+				goto error;
+			}
+		}
+
 		handler(nsk);
 
 		syslog(LOG_INFO, "Disconnect");
@@ -207,6 +231,15 @@ static void dump_mode(int sk)
 {
 	int len;
 
+	if (defer_setup) {
+		len = read(sk, buf, sizeof(buf));
+		if (len < 0)
+			syslog(LOG_ERR, "Initial read error: %s (%d)",
+						strerror(errno), errno);
+		else
+			syslog(LOG_INFO, "Initial bytes %d", len);
+	}
+
 	syslog(LOG_INFO,"Receiving ...");
 	while ((len = read(sk, buf, data_size)) > 0)
 		syslog(LOG_INFO, "Recevied %d bytes", len);
@@ -216,6 +249,16 @@ static void recv_mode(int sk)
 {
 	struct timeval tv_beg,tv_end,tv_diff;
 	long total;
+	int len;
+
+	if (defer_setup) {
+		len = read(sk, buf, sizeof(buf));
+		if (len < 0)
+			syslog(LOG_ERR, "Initial read error: %s (%d)",
+						strerror(errno), errno);
+		else
+			syslog(LOG_INFO, "Initial bytes %d", len);
+	}
 
 	syslog(LOG_INFO, "Receiving ...");
 
@@ -328,14 +371,17 @@ static void usage(void)
 {
 	printf("scotest - SCO testing\n"
 		"Usage:\n");
-	printf("\tscotest <mode> [-b bytes] [bd_addr]\n");
+	printf("\tscotest <mode> [options] [bd_addr]\n");
 	printf("Modes:\n"
 		"\t-d dump (server)\n"
 		"\t-c reconnect (client)\n"
 		"\t-m multiple connects (client)\n"
 		"\t-r receive (server)\n"
 		"\t-s connect and send (client)\n"
-		"\t-n connect and be silent (client)\n");
+		"\t-n connect and be silent (client)\n"
+		"Options:\n"
+		"\t[-b bytes]\n"
+		"\t[-W seconds] enable deferred setup\n");
 }
 
 int main(int argc ,char *argv[])
@@ -343,7 +389,7 @@ int main(int argc ,char *argv[])
 	struct sigaction sa;
 	int opt, sk, mode = RECV;
 
-	while ((opt=getopt(argc,argv,"rdscmnb:")) != EOF) {
+	while ((opt = getopt(argc, argv, "rdscmnb:W:")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -373,6 +419,10 @@ int main(int argc ,char *argv[])
 			data_size = atoi(optarg);
 			break;
 
+		case 'W':
+			defer_setup = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.9.5

