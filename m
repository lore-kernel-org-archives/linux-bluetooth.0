Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 4/6] scotest: Add option for SCO voice setting
Date: Fri,  5 Jul 2013 17:46:45 +0200
Message-Id: <1373039207-20959-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btiotest.c |    3 ++-
 tools/scotest.c  |   40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 580e7a5..50e3bae 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -445,7 +445,8 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 	g_io_channel_unref(rc_srv);
 }
 
-static void sco_connect(const char *src, const char *dst, int disconn, int voice)
+static void sco_connect(const char *src, const char *dst, int disconn,
+								int voice)
 {
 	struct io_data *data;
 	GError *err = NULL;
diff --git a/tools/scotest.c b/tools/scotest.c
index a40e395..7148be6 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -58,6 +58,7 @@ static long data_size = 672;
 static bdaddr_t bdaddr;
 
 static int defer_setup = 0;
+static int voice = 0;
 
 static float tv2fl(struct timeval tv)
 {
@@ -68,6 +69,7 @@ static int do_connect(char *svr)
 {
 	struct sockaddr_sco addr;
 	struct sco_conninfo conn;
+	struct bt_voice opts;
 	socklen_t optlen;
 	int sk;
 
@@ -90,6 +92,15 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* SCO voice setting */
+	memset(&opts, 0, sizeof(opts));
+	opts.setting = voice;
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &opts, sizeof(opts)) < 0) {
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
+	struct bt_voice opts;
 	int len;
 
+	/* SCO voice setting */
+	memset(&opts, 0, sizeof(opts));
+	opts.setting = voice;
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &opts, sizeof(opts)) < 0)
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
+	struct bt_voice opts;
 	long total;
 	int len;
 
+	/* SCO voice setting */
+	memset(&opts, 0, sizeof(opts));
+	opts.setting = voice;
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &opts, sizeof(opts)) < 0)
+		syslog(LOG_ERR, "Can't set socket options: %s (%d)",
+							strerror(errno), errno);
+
 	if (defer_setup) {
 		len = read(sk, buf, sizeof(buf));
 		if (len < 0)
@@ -271,7 +298,9 @@ static void recv_mode(int sk)
 				if (r < 0)
 					syslog(LOG_ERR, "Read failed: %s (%d)",
 							strerror(errno), errno);
-				return;
+				if (errno != ENOTCONN)
+					return;
+				r = 0;
 			}
 			total += r;
 		}
@@ -381,7 +410,8 @@ static void usage(void)
 		"\t-n connect and be silent (client)\n"
 		"Options:\n"
 		"\t[-b bytes]\n"
-		"\t[-W seconds] enable deferred setup\n");
+		"\t[-W seconds] enable deferred setup\n"
+		"\t[-V voice] select SCO voice setting (0x0060 cvsd, 0x0003 transparent)\n");
 }
 
 int main(int argc ,char *argv[])
@@ -389,7 +419,7 @@ int main(int argc ,char *argv[])
 	struct sigaction sa;
 	int opt, sk, mode = RECV;
 
-	while ((opt = getopt(argc, argv, "rdscmnb:W:")) != EOF) {
+	while ((opt = getopt(argc, argv, "rdscmnb:W:V:")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -423,6 +453,10 @@ int main(int argc ,char *argv[])
 			defer_setup = atoi(optarg);
 			break;
 
+		case 'V':
+			voice = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.9.5

