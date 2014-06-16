Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/6] android/health: Notify application deregistration status
Date: Mon, 16 Jun 2014 18:01:39 +0300
Message-Id: <1402930900-24209-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/health.c b/android/health.c
index 4862b76..36ed6e7 100644
--- a/android/health.c
+++ b/android/health.c
@@ -731,6 +731,8 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
 		return;
 	}
 
+	send_app_reg_notify(app, HAL_HEALTH_APP_DEREG_SUCCESS);
+
 	if (record_id > 0) {
 		bt_adapter_remove_record(record_id);
 		record_id = 0;
-- 
1.9.1

