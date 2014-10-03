Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] android/tester: Fix debug callback logs
Date: Fri,  3 Oct 2014 10:44:48 +0200
Message-Id: <1412325892-25013-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412325892-25013-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412325892-25013-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Debug logs for callback should also print logs if callback is not
expected. Additional value in callback enum is added (BT_CB_NONE).
---
 android/tester-main.c | 1 +
 android/tester-main.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index fe452f8..08324a4 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -33,6 +33,7 @@ static struct {
 	uint16_t cb_num;
 	const char *str;
 } cb_table[] = {
+	DBG_CB(CB_BT_NONE),
 	DBG_CB(CB_BT_ADAPTER_STATE_CHANGED),
 	DBG_CB(CB_BT_ADAPTER_PROPERTIES),
 	DBG_CB(CB_BT_REMOTE_DEVICE_PROPERTIES),
diff --git a/android/tester-main.h b/android/tester-main.h
index 57b7508..c02b372 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -320,7 +320,8 @@ struct pdu_set {
  * updated while adding new HAL to tester.
  */
 typedef enum {
-	CB_BT_ADAPTER_STATE_CHANGED = 1,
+	CB_BT_NONE,
+	CB_BT_ADAPTER_STATE_CHANGED,
 	CB_BT_ADAPTER_PROPERTIES,
 	CB_BT_REMOTE_DEVICE_PROPERTIES,
 	CB_BT_DEVICE_FOUND,
-- 
1.9.3

