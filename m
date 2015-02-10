Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] tools/mcaptest: Seperate disconnect link timeout and call parameters
Date: Tue, 10 Feb 2015 18:17:28 +0100
Message-Id: <1423588650-12191-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data connection shouldn't be automatically closed if MDL disconnect
timeout parameter is given. Disconnect immediately if mdl connection is
established should be triggered with parameter giving and it should be
independent of MDL disconnect timeout parameter. MCL disconnect
possibility (after mdl disconnect) should be also controlled with
parameter independently of its disconnect timeout.

This set of parameters gives possibility to pass all PTS 6.0.1 MCAP test
cases.
---
 tools/mcaptest.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index c44750f..6aba7a5 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -71,20 +71,27 @@ static gboolean no_close = FALSE;
 
 #define REQ_CLOCK_ACC 0x1400
 
-static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
+static void mdl_close(struct mcap_mdl *mdl)
 {
 	int fd = -1;
 
 	printf("%s\n", __func__);
 
-	if (mdl_disconnect && mdl_disconnect_timeout >= 0) {
+	if (mdl_disconnect_timeout >= 0)
 		sleep(mdl_disconnect_timeout);
 
-		fd = mcap_mdl_get_fd(mdl);
+	fd = mcap_mdl_get_fd(mdl);
 
-		if (fd > 0)
-			close(fd);
-	}
+	if (fd > 0)
+		close(fd);
+}
+
+static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
+{
+	printf("%s\n", __func__);
+
+	if (mdl_disconnect)
+		mdl_close(mdl);
 }
 
 static void mdl_closed_cb(struct mcap_mdl *mdl, void *data)
@@ -94,7 +101,13 @@ static void mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 	if (mcl_disconnect && mcl_disconnect_timeout >= 0) {
 		sleep(mcl_disconnect_timeout);
 
+		printf("Closing MCAP communication link\n");
 		mcap_close_mcl(mcl, TRUE);
+
+		if (no_close)
+			return;
+
+		g_main_loop_quit(mloop);
 	}
 }
 
@@ -102,6 +115,10 @@ static void mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 {
 	/* TODO */
 	printf("%s\n", __func__);
+
+	/* Disconnecting MDL latency timeout */
+	if (mdl_disconnect_timeout >= 0)
+		sleep(mdl_disconnect_timeout);
 }
 
 static void mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
@@ -302,10 +319,12 @@ static void usage(void)
 		"\tmcaptest <control_mode> <data_mode> [options]\n");
 	printf("Control Link Mode:\n"
 		"\t-c connect <dst_addr>\n"
+		"\t-b close control link after closing data link\n"
 		"\t-e <timeout> disconnect MCL and quit after MDL is closed\n"
 		"\t-g send clock sync capability request if MCL connected\n");
 	printf("Data Link Mode:\n"
 		"\t-d connect\n"
+		"\t-a close data link immediately after being connected"
 		"\t-f <timeout> disconnect MDL after it's connected\n"
 		"\t-u send \'Unavailable\' on first MDL connection request\n");
 	printf("Options:\n"
@@ -322,6 +341,8 @@ static struct option main_options[] = {
 	{ "disconnect_cl",	1, 0, 'e' },
 	{ "synccap_req",	0, 0, 'g' },
 	{ "connect_dl",		0, 0, 'd' },
+	{ "disconnect_da",	0, 0, 'a' },
+	{ "disconnect_ca",	0, 0, 'b' },
 	{ "disconnect_dl",	1, 0, 'f' },
 	{ "unavailable_dl",	0, 0, 'u' },
 	{ "no exit mcl dis/err",0, 0, 'n' },
@@ -347,7 +368,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghun",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghunab",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -369,14 +390,22 @@ int main(int argc, char *argv[])
 
 			break;
 
-		case 'e':
+		case 'a':
+			mdl_disconnect = TRUE;
+
+			break;
+
+		case 'b':
 			mcl_disconnect = TRUE;
+
+			break;
+
+		case 'e':
 			mcl_disconnect_timeout = atoi(optarg);
 
 			break;
 
 		case 'f':
-			mdl_disconnect = TRUE;
 			mdl_disconnect_timeout = atoi(optarg);
 
 			break;
-- 
1.9.3

