Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/8] android: Remove not needed bt_adapter_get_address function
Date: Tue, 12 Nov 2013 23:48:18 +0000
Message-Id: <1384300100-8941-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
References: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All services receive adapter address on init so there is no need for
this function. Removing it will also help keeping services not depend
on adapter service.
---
 android/adapter.c | 5 -----
 android/adapter.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index dcb823b..3f135be 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -2160,11 +2160,6 @@ error:
 	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
-const bdaddr_t *bt_adapter_get_address(void)
-{
-	return &adapter.bdaddr;
-}
-
 bool bt_adapter_register(int sk)
 {
 	DBG("");
diff --git a/android/adapter.h b/android/adapter.h
index 68f2046..99bd85f 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -31,8 +31,6 @@ void bt_adapter_cleanup(void);
 
 void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-const bdaddr_t *bt_adapter_get_address(void);
-
 bool bt_adapter_register(int sk);
 void bt_adapter_unregister(void);
 
-- 
1.8.4.3

