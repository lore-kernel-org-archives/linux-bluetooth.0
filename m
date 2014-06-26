Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/7] android/mcaptest: Support incomming connections
Date: Thu, 26 Jun 2014 15:09:08 +0200
Message-Id: <1403788151-21025-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for handling incomming Control Link (MCL) and Data
Link (MDL) connections.
---
 android/mcaptest.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 100 insertions(+), 15 deletions(-)

diff --git a/android/mcaptest.c b/android/mcaptest.c
index 0ad51a6..8d30e4d 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -54,11 +54,47 @@ static struct mcap_mdl *mdl = NULL;
 static uint16_t mdlid;
 
 static int control_mode = MODE_LISTEN;
+static int data_mode = MODE_LISTEN;
 
-static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
+static struct mcap_mcl *mcl = NULL;
+
+static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
+static void mdl_closed_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
+static void mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
+static void mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 {
 	/* TODO */
-	printf("MCL connected unsupported\n");
+	printf("%s\n", __func__);
+}
+
+static uint8_t mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
+				uint16_t mdlid, uint8_t *conf, void *data)
+{
+	printf("%s\n", __func__);
+
+	return MCAP_SUCCESS;
+}
+
+static uint8_t mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
+{
+	printf("%s\n", __func__);
+
+	return MCAP_SUCCESS;
 }
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
@@ -109,30 +145,69 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 	}
 }
 
-static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
+static void trigger_mdl_action(int mode)
 {
 	GError *gerr = NULL;
+	gboolean ret;
+
+	ret = mcap_mcl_set_cb(mcl, NULL, &gerr,
+		MCAP_MDL_CB_CONNECTED, mdl_connected_cb,
+		MCAP_MDL_CB_CLOSED, mdl_closed_cb,
+		MCAP_MDL_CB_DELETED, mdl_deleted_cb,
+		MCAP_MDL_CB_ABORTED, mdl_aborted_cb,
+		MCAP_MDL_CB_REMOTE_CONN_REQ, mdl_conn_req_cb,
+		MCAP_MDL_CB_REMOTE_RECONN_REQ, mdl_reconn_req_cb,
+		MCAP_MDL_CB_INVALID);
+
+	if (!ret && gerr) {
+		printf("MCL cannot handle connection %s\n",
+							gerr->message);
+		g_error_free(gerr);
+	}
+
+	if (mode == MODE_CONNECT) {
+		mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
+		if (gerr) {
+			printf("Could not connect MDL: %s\n", gerr->message);
+			g_error_free(gerr);
+		}
+	}
+}
 
+static void mcl_connected(struct mcap_mcl *mcap_mcl, gpointer data)
+{
+	printf("%s\n", __func__);
+
+	if (mcl)
+		mcap_mcl_unref(mcl);
+
+	mcl = mcap_mcl_ref(mcap_mcl);
+	trigger_mdl_action(data_mode);
+}
+
+static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
+{
 	if (err) {
 		printf("Could not connect MCL: %s\n", err->message);
 
 		return;
 	}
 
-	mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
-	if (gerr) {
-		printf("Could not connect MDL: %s\n", gerr->message);
-		g_error_free(gerr);
-	}
-}
+	if (mcl)
+		mcap_mcl_unref(mcl);
 
+	mcl = mcap_mcl_ref(mcap_mcl);
+	trigger_mdl_action(data_mode);
+}
 static void usage(void)
 {
 	printf("mcaptest - MCAP testing ver %s\n", VERSION);
 	printf("Usage:\n"
-		"\tmcaptest <mode> [options]\n");
-	printf("Modes:\n"
-		"\t-c connect <dst_addr> (than wait for disconnect)\n");
+		"\tmcaptest <control_mode> <data_mode> [options]\n");
+	printf("Control Link Mode:\n"
+		"\t-c connect <dst_addr>\n");
+	printf("Data Link Mode:\n"
+		"\t-d connect\n");
 	printf("Options:\n"
 		"\t-i <hcidev>        HCI device\n"
 		"\t-C <control_ch>    Control channel PSM\n"
@@ -142,7 +217,8 @@ static void usage(void)
 static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "device",	1, 0, 'i' },
-	{ "connect",	1, 0, 'c' },
+	{ "connect_cl",	1, 0, 'c' },
+	{ "connect_dl",	0, 0, 'd' },
 	{ "control_ch",	1, 0, 'C' },
 	{ "data_ch",	1, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -164,7 +240,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:h",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:hd",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -181,6 +257,11 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'd':
+			data_mode = MODE_CONNECT;
+
+			break;
+
 		case 'C':
 			ccpsm = atoi(optarg);
 
@@ -198,7 +279,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	mcap = mcap_create_instance(&src, BT_IO_SEC_MEDIUM, 0, 0,
+	mcap = mcap_create_instance(&src, BT_IO_SEC_MEDIUM, ccpsm, dcpsm,
 					mcl_connected, mcl_reconnected,
 					mcl_disconnected, mcl_uncached,
 					NULL, /* CSP is not used right now */
@@ -228,6 +309,10 @@ int main(int argc, char *argv[])
 		}
 
 		break;
+	case MODE_LISTEN:
+		printf("Listening for control channel connection\n");
+
+		break;
 	case MODE_NONE:
 	default:
 		goto done;
-- 
2.0.0

