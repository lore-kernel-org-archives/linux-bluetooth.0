Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 4/6] emulator: Add support for LE Remote Connection Parameter Request Negative Reply
Date: Mon, 31 Aug 2015 12:18:06 +0200
Message-Id: <1441016288-23010-4-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
References: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <20150829032025.GA8367@t440s>
References: <20150829032025.GA8367@t440s>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Connection Update (0x08|0x0013) plen 14
                                                 [hci1] 915.472416
        Handle: 42
        Min connection interval: 0.00 msec (0x0000)
        Max connection interval: 18.75 msec (0x000f)
        Connection latency: 0x0000
        Supervision timeout: 32000 msec (0x0c80)
        Min connection length: 0.625 msec (0x0001)
        Max connection length: 0.625 msec (0x0001)
> HCI Event: Command Status (0x0f) plen 4         [hci1] 915.472432
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 11         [hci0] 915.472443
      LE Remote Connection Parameter Request (0x06)
        Handle: 42
        Min connection interval: 0.00 msec (0x0000)
        Max connection interval: 18.75 msec (0x000f)
        Connection latency: 0x0000
        Supervision timeout: 32000 msec (0x0c80)
< HCI Command: LE Remote Connection Parameter Request Negative Reply
			(0x08|0x0021) plen 3       [hci0] 915.474095
        Handle: 42
        Reason: Invalid LMP Parameters / Invalid LL Parameters (0x1e)
> HCI Event: Command Complete (0x0e) plen 6        [hci0] 915.474119
      LE Remote Connection Parameter Request Negative Reply
				(0x08|0x0021) ncmd 1
        Status: Success (0x00)
        Handle: 42
> HCI Event: LE Meta Event (0x3e) plen 10          [hci1] 915.474124
      LE Connection Update Complete (0x03)
        Status: Invalid LMP Parameters / Invalid LL Parameters (0x1e)
        Handle: 42
        Connection interval: 4800.00 msec (0x0f00)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 327680 msec (0x8000)

LE Connection Update rejected due to invalid parameter:
	Min connection interval: 0.00 msec (0x0000)
---
 emulator/btdev.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1395ec8..a3c73d9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -445,6 +445,7 @@ static void set_le_commands(struct btdev *btdev)
 
 	/* Extra LE commands for >= 4.1 adapters */
 	btdev->commands[33] |= 0x10;	/* LE Remote Conn Param Req Reply */
+	btdev->commands[33] |= 0x20;	/* LE Remote Conn Param Req Neg Reply */
 
 	/* Extra LE commands for >= 4.2 adapters */
 	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
@@ -1211,6 +1212,25 @@ static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 	}
 }
 
+static void rej_le_conn_update(struct btdev *btdev, uint16_t handle,
+								uint8_t reason)
+{
+	struct btdev *remote = btdev->conn;
+	struct __packed {
+		uint8_t subevent;
+		struct bt_hci_evt_le_conn_update_complete ev;
+	} ev;
+
+	if (!remote)
+		return;
+
+	ev.subevent = BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE;
+	ev.ev.handle = cpu_to_le16(handle);
+	ev.ev.status = cpu_to_le16(reason);
+
+	send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+}
+
 static void le_conn_update(struct btdev *btdev, uint16_t handle,
 				uint16_t min_interval, uint16_t max_interval,
 				uint16_t latency, uint16_t supv_timeout,
@@ -2033,6 +2053,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_encrypt *lenc_cmd;
 	const struct bt_hci_cmd_le_generate_dhkey *dh;
 	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr_cmd;
+	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr_cmd;
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
 	const struct bt_hci_cmd_read_tx_power *rtxp;
@@ -2075,6 +2096,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_read_local_amp_assoc rlaa_rsp;
 	struct bt_hci_rsp_get_mws_transport_config *gmtc;
 	struct bt_hci_rsp_le_conn_param_req_reply lcprr_rsp;
+	struct bt_hci_rsp_le_conn_param_req_neg_reply lcprnr_rsp;
 	struct bt_hci_rsp_le_read_buffer_size lrbs;
 	struct bt_hci_rsp_le_read_local_features lrlf;
 	struct bt_hci_rsp_le_read_adv_tx_power lratp;
@@ -3187,6 +3209,14 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		lcprr_rsp.status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &lcprr_rsp, sizeof(lcprr_rsp));
 		break;
+	case BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		lcprnr_cmd = data;
+		lcprnr_rsp.handle = lcprnr_cmd->handle;
+		lcprnr_rsp.status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &lcprnr_rsp, sizeof(lcprnr_rsp));
+		break;
 	default:
 		goto unsupported;
 	}
@@ -3222,6 +3252,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_create_conn *lecc;
 	const struct bt_hci_cmd_le_conn_update *lecu;
 	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr;
+	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3402,6 +3433,13 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 				le16_to_cpu(lcprr->min_length),
 				le16_to_cpu(lcprr->max_length));
 		break;
+	case BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			return;
+		lcprnr = data;
+		rej_le_conn_update(btdev, le16_to_cpu(lcprnr->handle),
+					le16_to_cpu(lcprnr->reason));
+		break;
 	}
 }
 
-- 
2.4.3

