Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 4/5] tools/mcaptest: Support incomming connections
Date: Wed, 25 Jun 2014 17:50:00 +0200
Message-Id: <1403711401-11247-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for handling incomming Control Link (MCL) and Data
Link (MDL) connections. This also adds support for aborting MDL and
reconnecting.
---
 tools/mcaptest.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 150 insertions(+), 18 deletions(-)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index 2793b9f..72b2246 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -54,11 +54,50 @@ static struct mcap_mdl *mdl = NULL;
 static uint16_t mdlid;
 
 static int control_mode = MODE_LISTEN;
+static int data_mode = MODE_LISTEN;
+static int reconnect_mdl_mode = MODE_LISTEN;
 
-static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
+static gboolean abort_mdl = FALSE;
+
+static struct mcap_mcl *mcl = NULL;
+
+static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data) {
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
+static void hdp_mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
+static void hdp_mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 {
 	/* TODO */
-	printf("MCL connected unsupported\n");
+	printf("%s\n", __func__);
+}
+
+static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
+static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
+				uint16_t mdlid, uint8_t *conf, void *data)
+{
+	printf("%s\n", __func__);
+
+	return MCAP_SUCCESS;
+}
+
+static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+
+	return MCAP_SUCCESS;
 }
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
@@ -87,6 +126,31 @@ static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
 	printf("MDL %d connected\n", mdlid);
 }
 
+static void mdl_reconnect_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
+{
+	printf("%s\n", __func__);
+}
+
+static void trigger_mdl_action(int mode);
+
+static void mdl_abort_cb(GError *err, gpointer data)
+{
+	GError *gerr = NULL;
+
+	printf("%s\n", __func__);
+
+	if (reconnect_mdl_mode == MODE_CONNECT) {
+		mcap_reconnect_mdl(mdl, mdl_reconnect_cb, NULL, NULL, &gerr);
+
+		if (gerr) {
+			printf("Could not connect MDL: %s\n", gerr->message);
+			g_error_free(gerr);
+		}
+	} else if (reconnect_mdl_mode == MODE_LISTEN) {
+		trigger_mdl_action(MODE_LISTEN);
+	}
+}
+
 static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 								gpointer data)
 {
@@ -95,42 +159,88 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 	if (gerr) {
 		printf("MDL error: %s\n", gerr->message);
 
-		exit(1);
+		return;
 	}
 
 	mdl = mcap_mdl_ref(mcap_mdl);
 
-	if (!mcap_connect_mdl(mdl, L2CAP_MODE_ERTM, dcpsm, connect_mdl_cb, NULL,
-								NULL, &err)) {
+	if (abort_mdl) {
+		mcap_mdl_abort(mcap_mdl, mdl_abort_cb, NULL, NULL, &err);
+		if (err) {
+			printf("MDL abort error: %s\n", err->message);
+
+			g_error_free(err);
+		}
+
+		return;
+	}
+
+	if (!mcap_connect_mdl(mdl, L2CAP_MODE_ERTM, dcpsm,
+				connect_mdl_cb, NULL, NULL, &err)) {
 		printf("Error connecting to mdl: %s\n", err->message);
 		g_error_free(err);
 	}
 }
 
-static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
+static void trigger_mdl_action(int mode)
 {
 	GError *gerr = NULL;
+	gboolean ret;
+
+	if (mode == MODE_LISTEN) {
+		ret = mcap_mcl_set_cb(mcl, NULL, &gerr,
+			MCAP_MDL_CB_CONNECTED, hdp_mcap_mdl_connected_cb,
+			MCAP_MDL_CB_CLOSED, hdp_mcap_mdl_closed_cb,
+			MCAP_MDL_CB_DELETED, hdp_mcap_mdl_deleted_cb,
+			MCAP_MDL_CB_ABORTED, hdp_mcap_mdl_aborted_cb,
+			MCAP_MDL_CB_REMOTE_CONN_REQ, hdp_mcap_mdl_conn_req_cb,
+			MCAP_MDL_CB_REMOTE_RECONN_REQ,
+			hdp_mcap_mdl_reconn_req_cb, MCAP_MDL_CB_INVALID);
+
+		if (!ret && gerr) {
+			printf("MCL cannot handle connection %s\n",
+								gerr->message);
+			g_error_free(gerr);
+		}
+	} else if (mode == MODE_CONNECT) {
+		mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
+		if (gerr) {
+			printf("Could not connect MDL: %s\n", gerr->message);
+			g_error_free(gerr);
+		}
+	}
+}
+
+static void mcl_connected(struct mcap_mcl *mcap_mcl, gpointer data)
+{
+	printf("%s\n", __func__);
 
+	mcl = mcap_mcl_ref(mcap_mcl);
+	trigger_mdl_action(data_mode);
+}
+
+static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
+{
 	if (err) {
 		printf("Could not connect MCL: %s\n", err->message);
 
 		exit(1);
 	}
 
-	mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
-	if (gerr) {
-		printf("Could not connect MDL: %s\n", gerr->message);
-		g_error_free(gerr);
-	}
+	mcl = mcap_mcl_ref(mcap_mcl);
+	trigger_mdl_action(data_mode);
 }
-
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
+		"\t-d connect\n"
+		"\t-a abort MDL connection\n"
+		"\t-r reconnect MDL after abort\n");
 	printf("Options:\n"
 		"\t-i <hcidev>        HCI device\n"
 		"\t-C <control_ch>    Control channel PSM\n"
@@ -140,7 +250,10 @@ static void usage(void)
 static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "device",	1, 0, 'i' },
-	{ "connect",	1, 0, 'c' },
+	{ "connect_cl",	1, 0, 'c' },
+	{ "connect_cl",	0, 0, 'a' },
+	{ "connect_cl",	0, 0, 'r' },
+	{ "connect_dl",	0, 0, 'd' },
 	{ "control_ch",	1, 0, 'C' },
 	{ "data_ch",	1, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -162,7 +275,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:h",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:hdar",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -173,12 +286,27 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'a':
+			abort_mdl = TRUE;
+
+			break;
+
+		case 'r':
+			reconnect_mdl_mode = MODE_CONNECT;
+
+			break;
+
 		case 'c':
 			control_mode = MODE_CONNECT;
 			str2ba(optarg, &dst);
 
 			break;
 
+		case 'd':
+			data_mode = MODE_CONNECT;
+
+			break;
+
 		case 'C':
 			ccpsm = atoi(optarg);
 
@@ -196,7 +324,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	mcap = mcap_create_instance(&src, BT_IO_SEC_MEDIUM, 0, 0,
+	mcap = mcap_create_instance(&src, BT_IO_SEC_MEDIUM, ccpsm, dcpsm,
 					mcl_connected, mcl_reconnected,
 					mcl_disconnected, mcl_uncached,
 					NULL, /* CSP is not used right now */
@@ -226,6 +354,10 @@ int main(int argc, char *argv[])
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

