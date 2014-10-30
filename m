Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] tools/mcaptest: Add no close paramameter
Date: Thu, 30 Oct 2014 12:15:07 +0100
Message-Id: <1414667707-2640-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1414667707-2640-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1414667707-2640-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If parametr is given mcaptest don't exit after: receiving err, or while
MCL disconnects. This is needed while reconnecting MCL or some PTS
test cases:
TC_MCAP_CM_REC_BV_x_C - test cases branch
TC_MCAP_ERR_BI_x_C - test cases branch
---
 tools/mcaptest.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index 6d50544..42734eb 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -67,6 +67,8 @@ static int mdl_disconnect_timeout = -1;
 
 static struct mcap_mcl *mcl = NULL;
 
+static gboolean no_close = FALSE;
+
 #define REQ_CLOCK_ACC 0x1400
 
 static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
@@ -152,6 +154,9 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 	/* TODO */
 	printf("MCL disconnected\n");
 
+	if (no_close)
+		return;
+
 	g_main_loop_quit(mloop);
 }
 
@@ -176,7 +181,9 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 	if (gerr) {
 		printf("MDL error: %s\n", gerr->message);
 
-		g_main_loop_quit(mloop);
+		if (!no_close)
+			g_main_loop_quit(mloop);
+
 		return;
 	}
 
@@ -190,6 +197,9 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 		printf("Error connecting to mdl: %s\n", err->message);
 		g_error_free(err);
 
+		if (no_close)
+			return;
+
 		g_main_loop_quit(mloop);
 	}
 }
@@ -262,7 +272,9 @@ static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
 	if (err) {
 		printf("Could not connect MCL: %s\n", err->message);
 
-		g_main_loop_quit(mloop);
+		if (!no_close)
+			g_main_loop_quit(mloop);
+
 		return;
 	}
 
@@ -288,6 +300,7 @@ static void usage(void)
 		"\t-f <timeout> disconnect MDL after it's connected\n"
 		"\t-u send \'Unavailable\' on first MDL connection request\n");
 	printf("Options:\n"
+		"\t-n don't exit after mcl disconnect/err receive\n"
 		"\t-i <hcidev>        HCI device\n"
 		"\t-C <control_ch>    Control channel PSM\n"
 		"\t-D <data_ch>       Data channel PSM\n");
@@ -302,6 +315,7 @@ static struct option main_options[] = {
 	{ "connect_dl",		0, 0, 'd' },
 	{ "disconnect_dl",	1, 0, 'f' },
 	{ "unavailable_dl",	0, 0, 'u' },
+	{ "no exit mcl dis/err",0, 0, 'n' },
 	{ "control_ch",		1, 0, 'C' },
 	{ "data_ch",		1, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -323,7 +337,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghu",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghun",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -367,6 +381,11 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'n':
+			no_close = TRUE;
+
+			break;
+
 		case 'C':
 			ccpsm = atoi(optarg);
 
-- 
1.9.3

