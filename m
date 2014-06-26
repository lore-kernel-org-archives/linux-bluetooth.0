Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/7] android/mcaptest: Support MDL reconnection if MCL reconnected
Date: Thu, 26 Jun 2014 15:09:10 +0200
Message-Id: <1403788151-21025-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed in some PTS test cases.
---
 android/mcaptest.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/android/mcaptest.c b/android/mcaptest.c
index f1f28d9..6277b40 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -118,10 +118,22 @@ static uint8_t mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 	return MCAP_SUCCESS;
 }
 
+static void create_mdl_cb(struct mcap_mdl *mcap_mdl, uint8_t type, GError *gerr,
+								gpointer data);
+
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 {
-	/* TODO */
-	printf("MCL reconnected unsupported\n");
+	GError *gerr = NULL;
+
+	printf("%s\n", __func__);
+
+	if (data_mode == MODE_CONNECT) {
+		mcap_create_mdl(mcl, 1, 0, create_mdl_cb, NULL, NULL, &gerr);
+		if (gerr) {
+			printf("Could not connect MDL: %s\n", gerr->message);
+			g_error_free(gerr);
+		}
+	}
 }
 
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
-- 
2.0.0

