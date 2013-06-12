Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 02/35] emulator: Store LE advertising data length in btdev
Date: Wed, 12 Jun 2013 08:56:48 -0400
Message-Id: <1371041841-21793-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

LE advertising data length will be used for emulating reports in other
virtual devices.
---
 emulator/btdev.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4baf019..1555e2f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -88,6 +88,7 @@ struct btdev {
 	uint8_t  le_simultaneous;
 	uint8_t  le_event_mask[8];
 	uint8_t  le_adv_data[31];
+	uint8_t  le_adv_data_len;
 
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
@@ -1550,6 +1551,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
 		lsad = data;
+		btdev->le_adv_data_len = lsad->len;
 		memcpy(btdev->le_adv_data, lsad->data, 31);
 		status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
-- 
1.7.9.5

