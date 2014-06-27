Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/3] android/mcaptest: Send clock sync capabilities request
Date: Fri, 27 Jun 2014 12:08:01 +0200
Message-Id: <1403863683-9844-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds option to send synchronization capabilities and requirements
request on MCL connection.
---
 android/mcaptest.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/android/mcaptest.c b/android/mcaptest.c
index 9869abb..642dbf4 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -57,6 +57,7 @@ static uint16_t mdlid;
 static int control_mode = MODE_LISTEN;
 static int data_mode = MODE_LISTEN;
 
+static gboolean send_synccap_req = FALSE;
 static gboolean mcl_disconnect = FALSE;
 static gboolean mdl_disconnect = FALSE;
 static int mcl_disconnect_timeout = -1;
@@ -64,6 +65,8 @@ static int mdl_disconnect_timeout = -1;
 
 static struct mcap_mcl *mcl = NULL;
 
+#define REQ_CLOCK_ACC 0x1400
+
 static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 {
 	int fd = -1;
@@ -178,6 +181,15 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 	}
 }
 
+static void sync_cap_cb(struct mcap_mcl *mcl, uint8_t mcap_err,
+			uint8_t btclockres, uint16_t synclead,
+			uint16_t tmstampres, uint16_t tmstampacc, GError *err,
+			gpointer data)
+{
+	/* TODO */
+	printf("%s\n", __func__);
+}
+
 static void trigger_mdl_action(int mode)
 {
 	GError *gerr = NULL;
@@ -205,14 +217,26 @@ static void trigger_mdl_action(int mode)
 			g_error_free(gerr);
 		}
 	}
+
+	if (send_synccap_req && mcap->csp_enabled) {
+		mcap_sync_init(mcl);
+
+		mcap_sync_cap_req(mcl, REQ_CLOCK_ACC, sync_cap_cb, NULL, &gerr);
+		if (gerr) {
+			printf("MCAP Sync req error: %s\n", gerr->message);
+			g_error_free(gerr);
+		}
+	}
 }
 
 static void mcl_connected(struct mcap_mcl *mcap_mcl, gpointer data)
 {
 	printf("%s\n", __func__);
 
-	if (mcl)
+	if (mcl) {
+		mcap_sync_stop(mcl);
 		mcap_mcl_unref(mcl);
+	}
 
 	mcl = mcap_mcl_ref(mcap_mcl);
 	trigger_mdl_action(data_mode);
@@ -226,8 +250,10 @@ static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
 		return;
 	}
 
-	if (mcl)
+	if (mcl) {
+		mcap_sync_stop(mcl);
 		mcap_mcl_unref(mcl);
+	}
 
 	mcl = mcap_mcl_ref(mcap_mcl);
 	trigger_mdl_action(data_mode);
@@ -239,7 +265,8 @@ static void usage(void)
 		"\tmcaptest <control_mode> <data_mode> [options]\n");
 	printf("Control Link Mode:\n"
 		"\t-c connect <dst_addr>\n"
-		"\t-e <timeout> disconnect MCL and quit after MDL is closed\n");
+		"\t-e <timeout> disconnect MCL and quit after MDL is closed\n"
+		"\t-g send clock sync capability request if MCL connected\n");
 	printf("Data Link Mode:\n"
 		"\t-d connect\n"
 		"\t-f <timeout> disconnect MDL after it's connected\n");
@@ -254,6 +281,7 @@ static struct option main_options[] = {
 	{ "device",		1, 0, 'i' },
 	{ "connect_cl",		1, 0, 'c' },
 	{ "disconnect_cl",	1, 0, 'e' },
+	{ "synccap_req",	0, 0, 'g' },
 	{ "connect_dl",		0, 0, 'd' },
 	{ "disconnect_dl",	1, 0, 'f' },
 	{ "control_ch",		1, 0, 'C' },
@@ -277,7 +305,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:hd",
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dgh",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -311,6 +339,11 @@ int main(int argc, char *argv[])
 
 			break;
 
+		case 'g':
+			send_synccap_req = TRUE;
+
+			break;
+
 		case 'C':
 			ccpsm = atoi(optarg);
 
@@ -341,6 +374,8 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	mcap_enable_csp(mcap);
+
 	switch (control_mode) {
 	case MODE_CONNECT:
 		ba2str(&dst, bdastr);
-- 
2.0.0

