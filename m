Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/5] android/health: Fix do not set mdl callbacks on mcl_reconneced call back
Date: Mon, 30 Jun 2014 18:31:52 +0300
Message-Id: <1404142314-20795-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1404142314-20795-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404142314-20795-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MDL related callbacks should be already set when creating mcl. Only
update connection status.
---
 android/health.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/health.c b/android/health.c
index 7518dad..0327542 100644
--- a/android/health.c
+++ b/android/health.c
@@ -2001,16 +2001,17 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 {
-	GError *gerr = NULL;
-	bool ret;
+	struct health_device *dev;
 
 	DBG("");
 
-	ret = set_mcl_cb(mcl, NULL, &gerr);
-	if (!ret) {
-		error("health: error setting mcl callbacks: %s", gerr->message);
-		g_error_free(gerr);
+	dev = search_dev_by_mcl(mcl);
+	if (!dev) {
+		error("device data does not exists");
+		return;
 	}
+
+	dev->mcl_conn = true;
 }
 
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
-- 
1.9.1

