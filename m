Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] scotest: Add option for SCO socket codec
Date: Wed, 28 Nov 2012 19:06:10 +0100
Message-Id: <1354125970-15609-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1354125970-15609-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1354125970-15609-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/scotest.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/test/scotest.c b/test/scotest.c
index a40e395..27df08d 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -58,6 +58,7 @@ static long data_size = 672;
 static bdaddr_t bdaddr;
 
 static int defer_setup = 0;
+static int codec = 0;
 
 static float tv2fl(struct timeval tv)
 {
@@ -68,6 +69,7 @@ static int do_connect(char *svr)
 {
 	struct sockaddr_sco addr;
 	struct sco_conninfo conn;
+	struct sco_options  opts;
 	socklen_t optlen;
 	int sk;
 
@@ -90,6 +92,15 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Add SCO options */
+	memset(&opts, 0, sizeof(opts));
+	opts.codec = codec;
+	if (setsockopt(sk, SOL_SCO, SCO_OPTIONS, &opts, sizeof(opts)) < 0) {
+		syslog(LOG_ERR, "Can't set socket options: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
 	/* Connect to remote device */
 	memset(&addr, 0, sizeof(addr));
 	addr.sco_family = AF_BLUETOOTH;
@@ -229,8 +240,16 @@ error:
 
 static void dump_mode(int sk)
 {
+	struct sco_options opts;
 	int len;
 
+	/* Add SCO options */
+	memset(&opts, 0, sizeof(opts));
+	opts.codec = codec;
+	if (setsockopt(sk, SOL_SCO, SCO_OPTIONS, &opts, sizeof(opts)) < 0)
+		syslog(LOG_ERR, "Can't set socket options: %s (%d)",
+							strerror(errno), errno);
+
 	if (defer_setup) {
 		len = read(sk, buf, sizeof(buf));
 		if (len < 0)
@@ -248,9 +267,17 @@ static void dump_mode(int sk)
 static void recv_mode(int sk)
 {
 	struct timeval tv_beg,tv_end,tv_diff;
+	struct sco_options opts;
 	long total;
 	int len;
 
+	/* Add SCO options */
+	memset(&opts, 0, sizeof(opts));
+	opts.codec = codec;
+	if (setsockopt(sk, SOL_SCO, SCO_OPTIONS, &opts, sizeof(opts)) < 0)
+		syslog(LOG_ERR, "Can't set socket options: %s (%d)",
+							strerror(errno), errno);
+
 	if (defer_setup) {
 		len = read(sk, buf, sizeof(buf));
 		if (len < 0)
@@ -381,7 +408,8 @@ static void usage(void)
 		"\t-n connect and be silent (client)\n"
 		"Options:\n"
 		"\t[-b bytes]\n"
-		"\t[-W seconds] enable deferred setup\n");
+		"\t[-W seconds] enable deferred setup\n"
+		"\t[-C codec] select codec (sco only: 0 cvsd, 1 msbc)\n");
 }
 
 int main(int argc ,char *argv[])
@@ -389,7 +417,7 @@ int main(int argc ,char *argv[])
 	struct sigaction sa;
 	int opt, sk, mode = RECV;
 
-	while ((opt = getopt(argc, argv, "rdscmnb:W:")) != EOF) {
+	while ((opt = getopt(argc, argv, "rdscmnb:W:C:")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -423,6 +451,10 @@ int main(int argc ,char *argv[])
 			defer_setup = atoi(optarg);
 			break;
 
+		case 'C':
+			codec = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.9.5

