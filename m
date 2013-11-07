Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android: Remove redundant command complete callback
Date: Thu,  7 Nov 2013 10:31:49 +0100
Message-Id: <1383816710-31059-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes command complete callback used only for verbose error
reporting.

---
 android/adapter.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 1d462c8..da5984a 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -625,14 +625,6 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 						sizeof(cp), &cp, -1);
 }
 
-static void confirm_name_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS)
-		error("Failed to confirm name: %s (0x%02x)",
-						mgmt_errstr(status), status);
-}
-
 static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
 {
 	struct mgmt_cp_confirm_name cp;
@@ -642,8 +634,7 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
 	cp.addr.type = addr_type;
 
 	if (mgmt_reply(adapter->mgmt, MGMT_OP_CONFIRM_NAME, adapter->index,
-					sizeof(cp), &cp, confirm_name_complete,
-					NULL, NULL) == 0)
+					sizeof(cp), &cp, NULL, NULL, NULL) == 0)
 		error("Failed to send confirm name request");
 }
 
-- 
1.8.4.1

