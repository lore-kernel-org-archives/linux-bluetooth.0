Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/7] android/mcaptest: Support connect
Date: Thu, 26 Jun 2014 15:09:07 +0200
Message-Id: <1403788151-21025-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This initiates the connection
---
 android/mcaptest.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/android/mcaptest.c b/android/mcaptest.c
index cc2d9cd..0ad51a6 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -50,8 +50,10 @@ static GMainLoop *mloop;
 static int ccpsm = 0x1003, dcpsm = 0x1005;
 
 static struct mcap_instance *mcap = NULL;
+static struct mcap_mdl *mdl = NULL;
+static uint16_t mdlid;
 
-int control_mode = MODE_LISTEN;
+static int control_mode = MODE_LISTEN;
 
 static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 {
@@ -77,6 +79,53 @@ static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 	printf("MCL uncached unsupported\n");
 }
 
+static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
+{
+	mdlid = mcap_mdl_get_mdlid(mdl);
+
+	printf("MDL %d connected\n", mdlid);
+}
+
+static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
+								gpointer data)
+{
+	GError *err = NULL;
+
+	if (gerr) {
+		printf("MDL error: %s\n", gerr->message);
+
+		return;
+	}
+
+	if (mdl)
+		mcap_mdl_unref(mdl);
+
+	mdl = mcap_mdl_ref(mcap_mdl);
+
+	if (!mcap_connect_mdl(mdl, L2CAP_MODE_ERTM, dcpsm, connect_mdl_cb, NULL,
+								NULL, &err)) {
+		printf("Error connecting to mdl: %s\n", err->message);
+		g_error_free(err);
+	}
+}
+
+static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
+{
+	GError *gerr = NULL;
+
+	if (err) {
+		printf("Could not connect MCL: %s\n", err->message);
+
+		return;
+	}
+
+	mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
+	if (gerr) {
+		printf("Could not connect MDL: %s\n", gerr->message);
+		g_error_free(gerr);
+	}
+}
+
 static void usage(void)
 {
 	printf("mcaptest - MCAP testing ver %s\n", VERSION);
@@ -98,12 +147,12 @@ static struct option main_options[] = {
 	{ "data_ch",	1, 0, 'D' },
 	{ 0, 0, 0, 0 }
 };
-
 int main(int argc, char *argv[])
 {
 	GError *err = NULL;
 	bdaddr_t src, dst;
 	int opt;
+	char bdastr[18];
 
 	hci_devba(0, &src);
 	bacpy(&dst, BDADDR_ANY);
@@ -165,6 +214,20 @@ int main(int argc, char *argv[])
 
 	switch (control_mode) {
 	case MODE_CONNECT:
+		ba2str(&dst, bdastr);
+		printf("Connecting to %s\n", bdastr);
+
+		mcap_create_mcl(mcap, &dst, ccpsm, create_mcl_cb, NULL, NULL,
+									&err);
+
+		if (err) {
+			printf("MCAP create error %s\n", err->message);
+			g_error_free(err);
+
+			exit(1);
+		}
+
+		break;
 	case MODE_NONE:
 	default:
 		goto done;
-- 
2.0.0

