Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/7] android/mcaptest: Support MDL and MCL disconnection
Date: Thu, 26 Jun 2014 15:09:09 +0200
Message-Id: <1403788151-21025-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for MDL disconnection triggered with timeout after the
MDL is connected. It also adds MCL disconnection timeout after the MDL
has been disconnected. If less than 0 is passed as '-e' or '-f' option
parameter, disconnection is not triggered. This is needed to pass some
PTS test cases.
---
 android/mcaptest.c | 59 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/android/mcaptest.c b/android/mcaptest.c
index 8d30e4d..f1f28d9 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <getopt.h>
+#include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -56,18 +57,38 @@ static uint16_t mdlid;
 static int control_mode = MODE_LISTEN;
 static int data_mode = MODE_LISTEN;
 
+static gboolean mcl_disconnect = FALSE;
+static gboolean mdl_disconnect = FALSE;
+static int mcl_disconnect_timeout = -1;
+static int mdl_disconnect_timeout = -1;
+
 static struct mcap_mcl *mcl = NULL;
 
 static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 {
-	/* TODO */
+	int fd = -1;
+
 	printf("%s\n", __func__);
+
+	if (mdl_disconnect && mdl_disconnect_timeout >= 0) {
+		sleep(mdl_disconnect_timeout);
+
+		fd = mcap_mdl_get_fd(mdl);
+
+		if (fd > 0)
+			close(fd);
+	}
 }
 
 static void mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 {
-	/* TODO */
 	printf("%s\n", __func__);
+
+	if (mcl_disconnect && mcl_disconnect_timeout >= 0) {
+		sleep(mcl_disconnect_timeout);
+
+		mcap_close_mcl(mcl, TRUE);
+	}
 }
 
 static void mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
@@ -205,9 +226,11 @@ static void usage(void)
 	printf("Usage:\n"
 		"\tmcaptest <control_mode> <data_mode> [options]\n");
 	printf("Control Link Mode:\n"
-		"\t-c connect <dst_addr>\n");
+		"\t-c connect <dst_addr>\n"
+		"\t-e <timeout> disconnect MCL and quit after MDL is closed\n");
 	printf("Data Link Mode:\n"
-		"\t-d connect\n");
+		"\t-d connect\n"
+		"\t-f <timeout> disconnect MDL after it's connected\n");
 	printf("Options:\n"
 		"\t-i <hcidev>        HCI device\n"
 		"\t-C <control_ch>    Control channel PSM\n"
@@ -215,12 +238,14 @@ static void usage(void)
 }
 
 static struct option main_options[] = {
-	{ "help",	0, 0, 'h' },
-	{ "device",	1, 0, 'i' },
-	{ "connect_cl",	1, 0, 'c' },
-	{ "connect_dl",	0, 0, 'd' },
-	{ "control_ch",	1, 0, 'C' },
-	{ "data_ch",	1, 0, 'D' },
+	{ "help",		0, 0, 'h' },
+	{ "device",		1, 0, 'i' },
+	{ "connect_cl",		1, 0, 'c' },
+	{ "disconnect_cl",	1, 0, 'e' },
+	{ "connect_dl",		0, 0, 'd' },
+	{ "disconnect_dl",	1, 0, 'f' },
+	{ "control_ch",		1, 0, 'C' },
+	{ "data_ch",		1, 0, 'D' },
 	{ 0, 0, 0, 0 }
 };
 int main(int argc, char *argv[])
@@ -240,7 +265,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:hd",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:hd",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -262,6 +287,18 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'e':
+			mcl_disconnect = TRUE;
+			mcl_disconnect_timeout = atoi(optarg);
+
+			break;
+
+		case 'f':
+			mdl_disconnect = TRUE;
+			mdl_disconnect_timeout = atoi(optarg);
+
+			break;
+
 		case 'C':
 			ccpsm = atoi(optarg);
 
-- 
2.0.0

