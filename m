Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/7] android/bluetooth: Fix passing address type to SSP replies
Date: Sun, 22 Jun 2014 22:47:03 +0200
Message-Id: <1403470027-24720-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
References: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4031b17..be50a1a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4056,7 +4056,8 @@ failed:
 									status);
 }
 
-static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
+static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, uint8_t type,
+								bool accept)
 {
 	struct mgmt_addr_info cp;
 	uint16_t opcode;
@@ -4067,7 +4068,7 @@ static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
 		opcode = MGMT_OP_USER_CONFIRM_NEG_REPLY;
 
 	bacpy(&cp.bdaddr, bdaddr);
-	cp.type = BDADDR_BREDR;
+	cp.type = type;
 
 	if (mgmt_reply(mgmt_if, opcode, adapter.index, sizeof(cp), &cp,
 							NULL, NULL, NULL) > 0)
@@ -4076,8 +4077,8 @@ static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
-							uint32_t passkey)
+static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, uint8_t type,
+						bool accept, uint32_t passkey)
 {
 	unsigned int id;
 
@@ -4086,7 +4087,7 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.addr.bdaddr, bdaddr);
-		cp.addr.type = BDADDR_BREDR;
+		cp.addr.type = type;
 		cp.passkey = htobl(passkey);
 
 		id = mgmt_reply(mgmt_if, MGMT_OP_USER_PASSKEY_REPLY,
@@ -4097,7 +4098,7 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.addr.bdaddr, bdaddr);
-		cp.addr.type = BDADDR_BREDR;
+		cp.addr.type = type;
 
 		id = mgmt_reply(mgmt_if, MGMT_OP_USER_PASSKEY_NEG_REPLY,
 						adapter.index, sizeof(cp), &cp,
@@ -4130,11 +4131,12 @@ static void handle_ssp_reply_cmd(const void *buf, uint16_t len)
 	switch (cmd->ssp_variant) {
 	case HAL_SSP_VARIANT_CONFIRM:
 	case HAL_SSP_VARIANT_CONSENT:
-		status = user_confirm_reply(&dev->bdaddr, cmd->accept);
+		status = user_confirm_reply(&dev->bdaddr, dev->bdaddr_type,
+								cmd->accept);
 		break;
 	case HAL_SSP_VARIANT_ENTRY:
-		status = user_passkey_reply(&dev->bdaddr, cmd->accept,
-								cmd->passkey);
+		status = user_passkey_reply(&dev->bdaddr, dev->bdaddr_type,
+						cmd->accept, cmd->passkey);
 		break;
 	case HAL_SSP_VARIANT_NOTIF:
 		status = HAL_STATUS_SUCCESS;
-- 
1.9.3

