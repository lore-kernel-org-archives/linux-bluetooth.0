Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix error check
Date: Thu, 12 Jun 2014 17:52:38 +0300
Message-Id: <1402584758-8631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 59e6f25..abc8053 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5127,7 +5127,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 		}
 
 		data->filter_value = malloc0(search_vlen);
-		if (!data) {
+		if (!data->filter_value) {
 			destroy_pending_request(data);
 			queue_destroy(q, NULL);
 			return ATT_ECODE_INSUFF_RESOURCES;
-- 
1.8.3.2

