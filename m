Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/8] btdev: Add DHKey generation command to emulator
Date: Fri, 15 May 2015 16:46:25 +0300
Message-Id: <1431697586-20611-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add LE Generate DHKey Command available in Bluetooth Spec 4.2.
Controller sends Command Status and LE Meta event LE Generate DHKey
Complete.
...
> HCI Event: Command Status (0x0f) plen 4
      LE Generate DHKey (0x08|0x0026) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 34
      LE Generate DHKey Complete (0x09)
        Status: Success (0x00)
        Diffie-Hellman key:<key>
...
---
 emulator/btdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 354cf04..d9e38b5 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1950,6 +1950,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_start_encrypt *lse;
 	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
 	const struct bt_hci_cmd_le_encrypt *lenc_cmd;
+	const struct bt_hci_cmd_le_generate_dhkey *dh;
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
 	const struct bt_hci_cmd_read_tx_power *rtxp;
@@ -2009,6 +2010,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_read_rssi rrssi_rsp;
 	struct bt_hci_rsp_read_tx_power rtxp_rsp;
 	struct bt_hci_evt_le_read_local_pk256_complete pk_evt;
+	struct bt_hci_evt_le_generate_dhkey_complete dh_evt;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -2944,6 +2946,22 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 						&pk_evt, sizeof(pk_evt));
 		break;
 
+	case BT_HCI_CMD_LE_GENERATE_DHKEY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		dh = data;
+		if (!ecdh_shared_secret(dh->remote_pk256, btdev->le_local_sk256,
+								dh_evt.dhkey)) {
+			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
+									opcode);
+			break;
+		}
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS,
+						BT_HCI_CMD_LE_GENERATE_DHKEY);
+		le_meta_event(btdev, BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE,
+						&dh_evt, sizeof(dh_evt));
+		break;
+
 	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-- 
2.1.4

