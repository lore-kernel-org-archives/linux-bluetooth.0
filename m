Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/4] emulator/btdev: Add support for Read RSSI command
Date: Mon, 19 May 2014 23:14:02 +0200
Message-Id: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e590efa..d97476b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1763,6 +1763,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_start_encrypt *lse;
 	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
+	const struct bt_hci_cmd_read_rssi *rrssi;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1813,6 +1814,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_pin_code_request_neg_reply pcrnr_rsp;
 	struct bt_hci_rsp_user_confirm_request_reply ucrr_rsp;
 	struct bt_hci_rsp_user_confirm_request_neg_reply ucrnr_rsp;
+	struct bt_hci_rsp_read_rssi rrssi_rsp;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -2465,6 +2467,15 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &rdbs, sizeof(rdbs));
 		break;
 
+	case BT_HCI_CMD_READ_RSSI:
+		rrssi = data;
+
+		rrssi_rsp.status = BT_HCI_ERR_SUCCESS;
+		rrssi_rsp.handle = rrssi->handle;
+		rrssi_rsp.rssi = -1; /* non-zero so we can see it in tester */
+		cmd_complete(btdev, opcode, &rrssi_rsp, sizeof(rrssi_rsp));
+		break;
+
 	case BT_HCI_CMD_READ_LOCAL_AMP_INFO:
 		if (btdev->type != BTDEV_TYPE_AMP)
 			goto unsupported;
-- 
1.9.3

