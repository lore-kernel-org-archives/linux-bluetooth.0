Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 5/5] Bluetooth: Add support for max_tx_power in Get Conn Info
Date: Wed, 14 May 2014 12:49:43 +0200
Message-ID: <1400064583-12623-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for max_tx_power in Get Connection Information
request. Value is read only once for given connection and then always
returned in response as parameter.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 664dbc4..17ebaa3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4583,12 +4583,13 @@ static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
 	if (!match->mgmt_status) {
 		rp.rssi = conn->rssi;
 
-		if (match->valid_tx_power)
+		if (match->valid_tx_power) {
 			rp.tx_power = conn->tx_power;
-		else
+			rp.max_tx_power = conn->max_tx_power;
+		} else {
 			rp.tx_power = HCI_TX_POWER_INVALID;
-
-		rp.max_tx_power = HCI_TX_POWER_INVALID;
+			rp.max_tx_power = HCI_TX_POWER_INVALID;
+		}
 	}
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
@@ -4611,7 +4612,9 @@ static void conn_info_refresh_complete(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	/* TX power data is valid in case request completed successfully,
-	 * otherwise we assume it's not valid.
+	 * otherwise we assume it's not valid. At the moment we assume that
+	 * either both or none of current and max values are valid to keep code
+	 * simple.
 	 */
 	match.valid_tx_power = !status;
 
@@ -4728,6 +4731,14 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 				    sizeof(req_txp_cp), &req_txp_cp);
 		}
 
+		/* Max TX power needs to be read only once per connection */
+		if (conn->max_tx_power == HCI_TX_POWER_INVALID) {
+			req_txp_cp.handle = cpu_to_le16(conn->handle);
+			req_txp_cp.type = 0x01;
+			hci_req_add(&req, HCI_OP_READ_TX_POWER,
+				    sizeof(req_txp_cp), &req_txp_cp);
+		}
+
 		err = hci_req_run(&req, conn_info_refresh_complete);
 		if (err < 0)
 			goto unlock;
@@ -4747,7 +4758,7 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		/* Cache is valid, just reply with values cached in hci_conn */
 		rp.rssi = conn->rssi;
 		rp.tx_power = conn->tx_power;
-		rp.max_tx_power = HCI_TX_POWER_INVALID;
+		rp.max_tx_power = conn->max_tx_power;
 
 		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
 				   MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
1.9.3

