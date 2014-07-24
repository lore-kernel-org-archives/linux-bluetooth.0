Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 11/14] android/tester-ng: Set scan enable for dual mode devices
Date: Thu, 24 Jul 2014 10:38:04 +0200
Message-Id: <1406191087-5831-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for socket HAL connect test cases.
---
 android/tester-main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index bbb3375..40416d7 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1029,16 +1029,27 @@ static void emu_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
 {
-	struct step *step = g_new0(struct step, 1);
+	struct step *step;
+	struct test_data *data = user_data;
 
 	switch (opcode) {
 	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+		break;
 	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		/*
+		 * For BREDRLE emulator we want to verify step after scan
+		 * enable and not after le_set_adv_enable
+		 */
+		if (data->hciemu_type == HCIEMU_TYPE_BREDRLE)
+			return;
+
 		break;
 	default:
 		return;
 	}
 
+	step = g_new0(struct step, 1);
+
 	if (status) {
 		tester_warn("Emulated remote setup failed.");
 		step->action_status = BT_STATUS_FAIL;
@@ -1061,7 +1072,8 @@ void emu_setup_powered_remote_action(void)
 	if ((data->hciemu_type == HCIEMU_TYPE_LE) ||
 				(data->hciemu_type == HCIEMU_TYPE_BREDRLE))
 		bthost_set_adv_enable(bthost, 0x01, 0x02);
-	else
+
+	if (data->hciemu_type != HCIEMU_TYPE_LE)
 		bthost_write_scan_enable(bthost, 0x03);
 }
 
-- 
1.9.1

