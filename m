Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/4] emulator/btdev: Add support for Read TX Power command
Date: Mon, 19 May 2014 23:14:03 +0200
Message-Id: <1400534045-16818-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d97476b..28709ca 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1764,6 +1764,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
+	const struct bt_hci_cmd_read_tx_power *rtxp;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1815,6 +1816,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_user_confirm_request_reply ucrr_rsp;
 	struct bt_hci_rsp_user_confirm_request_neg_reply ucrnr_rsp;
 	struct bt_hci_rsp_read_rssi rrssi_rsp;
+	struct bt_hci_rsp_read_tx_power rtxp_rsp;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -2476,6 +2478,30 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &rrssi_rsp, sizeof(rrssi_rsp));
 		break;
 
+	case BT_HCI_CMD_READ_TX_POWER:
+		rtxp = data;
+
+		switch (rtxp->type) {
+		case 0x00:
+			rtxp_rsp.status = BT_HCI_ERR_SUCCESS;
+			rtxp_rsp.level =  -1; /* non-zero */
+			break;
+
+		case 0x01:
+			rtxp_rsp.status = BT_HCI_ERR_SUCCESS;
+			rtxp_rsp.level = 4; /* max for class 2 radio */
+			break;
+
+		default:
+			rtxp_rsp.level = 0;
+			rtxp_rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			break;
+		}
+
+		rtxp_rsp.handle = rtxp->handle;
+		cmd_complete(btdev, opcode, &rtxp_rsp, sizeof(rtxp_rsp));
+		break;
+
 	case BT_HCI_CMD_READ_LOCAL_AMP_INFO:
 		if (btdev->type != BTDEV_TYPE_AMP)
 			goto unsupported;
-- 
1.9.3

