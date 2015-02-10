Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] tools/mcaptest: Refractor debug logs for functions
Date: Tue, 10 Feb 2015 18:17:27 +0100
Message-Id: <1423588650-12191-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing logs for callback functions and unify existing.
---
 tools/mcaptest.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index 980d21a..c44750f 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -152,7 +152,7 @@ static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 {
 	/* TODO */
-	printf("MCL disconnected\n");
+	printf("%s\n", __func__);
 
 	if (no_close)
 		return;
@@ -163,14 +163,19 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 {
 	/* TODO */
-	printf("MCL uncached unsupported\n");
+	printf("%s\n", __func__);
 }
 
 static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
 {
 	mdlid = mcap_mdl_get_mdlid(mdl);
 
-	printf("MDL %d connected\n", mdlid);
+	printf("%s\n", __func__);
+
+	if (mdlid == MCAP_MDLID_RESERVED)
+		printf("MCAP mdlid is reserved");
+	else
+		printf("MDL %d connected\n", mdlid);
 }
 
 static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
@@ -178,6 +183,8 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 {
 	GError *err = NULL;
 
+	printf("%s\n", __func__);
+
 	if (gerr) {
 		printf("MDL error: %s\n", gerr->message);
 
@@ -234,6 +241,7 @@ static void trigger_mdl_action(int mode)
 	}
 
 	if (mode == MODE_CONNECT) {
+		printf("Creating MCAP Data End Point\n");
 		mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
 		if (gerr) {
 			printf("Could not connect MDL: %s\n", gerr->message);
-- 
1.9.3

