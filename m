Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 3/6] emulator: Add support for LE Remote Connection Parameter Request Reply
Date: Wed, 23 Sep 2015 13:36:56 +0200
Message-Id: <1443008219-15890-3-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1443008219-15890-1-git-send-email-mariusz.skamra@tieto.com>
References: <1443008219-15890-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Connection Update (0x08|0x0013) plen 14
		                          [hci0] 92750.079447
        Handle: 42
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
	                                  [hci0] 92750.079459
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 11
                                          [hci1] 92750.079462
      LE Remote Connection Parameter Request (0x06)
        Handle: 42
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
< HCI Command: LE Remote Connection Parameter Request Reply
(0x08|0x0020) plen 14			  [hci1] 92750.079476
        Handle: 42
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Complete (0x0e) plen 6
					  [hci1] 92750.079507
      LE Remote Connection Parameter Request Reply (0x08|0x0020)
							ncmd 1
        Status: Success (0x00)
        Handle: 42
> HCI Event: LE Meta Event (0x3e) plen 10
                                          [hci0] 92750.079510
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 42
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
> HCI Event: LE Meta Event (0x3e) plen 10
                                          [hci1] 92750.079509
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 42
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
@ New Conn Param: 00:AA:01:00:00:23 (1) hint 0 min 0x0028 max 0x0038
					latency 0x0000 timeout 0x002a
---
 emulator/btdev.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 77a83ef..1395ec8 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -443,6 +443,9 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[28] |= 0x20;	/* LE Transmitter Test */
 	btdev->commands[28] |= 0x40;	/* LE Test End */
 
+	/* Extra LE commands for >= 4.1 adapters */
+	btdev->commands[33] |= 0x10;	/* LE Remote Conn Param Req Reply */
+
 	/* Extra LE commands for >= 4.2 adapters */
 	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
 	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
@@ -562,6 +565,7 @@ static void set_le_features(struct btdev *btdev)
 	btdev->max_page = 1;
 
 	btdev->le_features[0] |= 0x01;	/* LE Encryption */
+	btdev->le_features[0] |= 0x02;	/* Connection Parameters Request */
 }
 
 static void set_amp_features(struct btdev *btdev)
@@ -1235,6 +1239,30 @@ static void le_conn_update(struct btdev *btdev, uint16_t handle,
 		send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
 }
 
+static void le_conn_param_req(struct btdev *btdev, uint16_t handle,
+				uint16_t min_interval, uint16_t max_interval,
+				uint16_t latency, uint16_t supv_timeout,
+				uint16_t min_length, uint16_t max_length)
+{
+	struct btdev *remote = btdev->conn;
+	struct __packed {
+		uint8_t subevent;
+		struct bt_hci_evt_le_conn_param_request ev;
+	} ev;
+
+	if (!remote)
+		return;
+
+	ev.subevent = BT_HCI_EVT_LE_CONN_PARAM_REQUEST;
+	ev.ev.handle = cpu_to_le16(handle);
+	ev.ev.min_interval = cpu_to_le16(min_interval);
+	ev.ev.max_interval = cpu_to_le16(max_interval);
+	ev.ev.latency = cpu_to_le16(latency);
+	ev.ev.supv_timeout = cpu_to_le16(supv_timeout);
+
+	send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+}
+
 static void disconnect_complete(struct btdev *btdev, uint16_t handle,
 							uint8_t reason)
 {
@@ -2004,6 +2032,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
 	const struct bt_hci_cmd_le_encrypt *lenc_cmd;
 	const struct bt_hci_cmd_le_generate_dhkey *dh;
+	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr_cmd;
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
 	const struct bt_hci_cmd_read_tx_power *rtxp;
@@ -2045,6 +2074,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_read_local_amp_info rlai;
 	struct bt_hci_rsp_read_local_amp_assoc rlaa_rsp;
 	struct bt_hci_rsp_get_mws_transport_config *gmtc;
+	struct bt_hci_rsp_le_conn_param_req_reply lcprr_rsp;
 	struct bt_hci_rsp_le_read_buffer_size lrbs;
 	struct bt_hci_rsp_le_read_local_features lrlf;
 	struct bt_hci_rsp_le_read_adv_tx_power lratp;
@@ -3149,6 +3179,14 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lte, sizeof(lte));
 		break;
 
+	case BT_HCI_CMD_LE_CONN_PARAM_REQ_REPLY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		lcprr_cmd = data;
+		lcprr_rsp.handle = lcprr_cmd->handle;
+		lcprr_rsp.status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &lcprr_rsp, sizeof(lcprr_rsp));
+		break;
 	default:
 		goto unsupported;
 	}
@@ -3183,6 +3221,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_read_clock_offset *rco;
 	const struct bt_hci_cmd_le_create_conn *lecc;
 	const struct bt_hci_cmd_le_conn_update *lecu;
+	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3334,13 +3373,34 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			return;
 		lecu = data;
-		le_conn_update(btdev, le16_to_cpu(lecu->handle),
-				le16_to_cpu(lecu->min_interval),
-				le16_to_cpu(lecu->max_interval),
-				le16_to_cpu(lecu->latency),
-				le16_to_cpu(lecu->supv_timeout),
-				le16_to_cpu(lecu->min_length),
-				le16_to_cpu(lecu->max_length));
+		if (btdev->le_features[0] & 0x02)
+			le_conn_param_req(btdev, le16_to_cpu(lecu->handle),
+					le16_to_cpu(lecu->min_interval),
+					le16_to_cpu(lecu->max_interval),
+					le16_to_cpu(lecu->latency),
+					le16_to_cpu(lecu->supv_timeout),
+					le16_to_cpu(lecu->min_length),
+					le16_to_cpu(lecu->max_length));
+		else
+			le_conn_update(btdev, le16_to_cpu(lecu->handle),
+					le16_to_cpu(lecu->min_interval),
+					le16_to_cpu(lecu->max_interval),
+					le16_to_cpu(lecu->latency),
+					le16_to_cpu(lecu->supv_timeout),
+					le16_to_cpu(lecu->min_length),
+					le16_to_cpu(lecu->max_length));
+		break;
+	case BT_HCI_CMD_LE_CONN_PARAM_REQ_REPLY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			return;
+		lcprr = data;
+		le_conn_update(btdev, le16_to_cpu(lcprr->handle),
+				le16_to_cpu(lcprr->min_interval),
+				le16_to_cpu(lcprr->max_interval),
+				le16_to_cpu(lcprr->latency),
+				le16_to_cpu(lcprr->supv_timeout),
+				le16_to_cpu(lcprr->min_length),
+				le16_to_cpu(lcprr->max_length));
 		break;
 	}
 }
-- 
2.4.3

