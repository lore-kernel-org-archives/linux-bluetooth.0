Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/3] android/mcaptest: Support unavailable response to first MDL connect
Date: Fri, 27 Jun 2014 12:08:02 +0200
Message-Id: <1403863683-9844-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403863683-9844-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403863683-9844-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to pass TC_MCAP_ERR_BI_16_C
---
 android/mcaptest.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/android/mcaptest.c b/android/mcaptest.c
index 642dbf4..f727a79 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -57,6 +57,8 @@ static uint16_t mdlid;
 static int control_mode = MODE_LISTEN;
 static int data_mode = MODE_LISTEN;
 
+static int mdl_conn_req_result = MCAP_SUCCESS;
+
 static gboolean send_synccap_req = FALSE;
 static gboolean mcl_disconnect = FALSE;
 static gboolean mdl_disconnect = FALSE;
@@ -109,9 +111,15 @@ static void mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 static uint8_t mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
+	int ret;
+
 	printf("%s\n", __func__);
 
-	return MCAP_SUCCESS;
+	ret = mdl_conn_req_result;
+
+	mdl_conn_req_result = MCAP_SUCCESS;
+
+	return ret;
 }
 
 static uint8_t mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
@@ -269,7 +277,8 @@ static void usage(void)
 		"\t-g send clock sync capability request if MCL connected\n");
 	printf("Data Link Mode:\n"
 		"\t-d connect\n"
-		"\t-f <timeout> disconnect MDL after it's connected\n");
+		"\t-f <timeout> disconnect MDL after it's connected\n"
+		"\t-u send \'Unavailable\' on first MDL connection request\n");
 	printf("Options:\n"
 		"\t-i <hcidev>        HCI device\n"
 		"\t-C <control_ch>    Control channel PSM\n"
@@ -284,6 +293,7 @@ static struct option main_options[] = {
 	{ "synccap_req",	0, 0, 'g' },
 	{ "connect_dl",		0, 0, 'd' },
 	{ "disconnect_dl",	1, 0, 'f' },
+	{ "unavailable_dl",	0, 0, 'u' },
 	{ "control_ch",		1, 0, 'C' },
 	{ "data_ch",		1, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -305,7 +315,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dgh",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghu",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -344,6 +354,11 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'u':
+			mdl_conn_req_result = MCAP_RESOURCE_UNAVAILABLE;
+
+			break;
+
 		case 'C':
 			ccpsm = atoi(optarg);
 
-- 
2.0.0

