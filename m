Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 1/6] emulator: Store LE advertising data length in btdev
Date: Wed,  3 Jul 2013 16:54:51 -0400
Message-Id: <1372884896-11419-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LE advertising data length will be used for emulating reports in other
virtual devices.
---
 emulator/btdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a602c05..73174a5 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -90,6 +90,7 @@ struct btdev {
 	uint8_t  le_simultaneous;
 	uint8_t  le_event_mask[8];
 	uint8_t  le_adv_data[31];
+	uint8_t  le_adv_data_len;
 
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
@@ -1487,6 +1488,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
 		lsad = data;
+		btdev->le_adv_data_len = lsad->len;
 		memcpy(btdev->le_adv_data, lsad->data, 31);
 		status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
-- 
1.8.3.2

