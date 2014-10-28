Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/mcaptest: Add missing mainloop quit
Date: Tue, 28 Oct 2014 15:42:36 +0100
Message-Id: <1414507356-7620-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MCAP test should quit from main loop if mcl disconnects or if can't
create mdl, mcl. Tested with PTS 5.3 test cases.
---
 tools/mcaptest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index 5ef030c..dd638c9 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -151,6 +151,8 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 {
 	/* TODO */
 	printf("MCL disconnected\n");
+
+	g_main_loop_quit(mloop);
 }
 
 static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
@@ -174,6 +176,7 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 	if (gerr) {
 		printf("MDL error: %s\n", gerr->message);
 
+		g_main_loop_quit(mloop);
 		return;
 	}
 
@@ -186,6 +189,8 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
 								NULL, &err)) {
 		printf("Error connecting to mdl: %s\n", err->message);
 		g_error_free(err);
+
+		g_main_loop_quit(mloop);
 	}
 }
 
@@ -255,6 +260,7 @@ static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
 	if (err) {
 		printf("Could not connect MCL: %s\n", err->message);
 
+		g_main_loop_quit(mloop);
 		return;
 	}
 
-- 
1.9.3

