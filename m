Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/5] android/health: Implement mcl_uncached callback
Date: Mon, 30 Jun 2014 19:58:25 +0300
Message-Id: <1404147508-22756-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 1905862..7518dad 100644
--- a/android/health.c
+++ b/android/health.c
@@ -2026,7 +2026,12 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 
 static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 {
-	DBG("Not implemented");
+	struct health_device *dev;
+
+	DBG("");
+
+	dev = search_dev_by_mcl(mcl);
+	free_health_device(dev);
 }
 
 bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
-- 
1.9.1

