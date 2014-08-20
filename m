Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/bluetooth: Fix bdaddr_type in pairing scenario
Date: Wed, 20 Aug 2014 10:10:23 +0200
Message-Id: <1408522224-27670-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch correct bdaddr type is used in ssp pairing scenario
---
 android/bluetooth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 64a7696..59dd047 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4500,11 +4500,13 @@ static void handle_ssp_reply_cmd(const void *buf, uint16_t len)
 	switch (cmd->ssp_variant) {
 	case HAL_SSP_VARIANT_CONFIRM:
 	case HAL_SSP_VARIANT_CONSENT:
-		status = user_confirm_reply(&dev->bdaddr, dev->bdaddr_type,
-								cmd->accept);
+		status = user_confirm_reply(&dev->bdaddr,
+						select_device_bearer(dev),
+						cmd->accept);
 		break;
 	case HAL_SSP_VARIANT_ENTRY:
-		status = user_passkey_reply(&dev->bdaddr, dev->bdaddr_type,
+		status = user_passkey_reply(&dev->bdaddr,
+						select_device_bearer(dev),
 						cmd->accept, cmd->passkey);
 		break;
 	case HAL_SSP_VARIANT_NOTIF:
-- 
1.8.4

