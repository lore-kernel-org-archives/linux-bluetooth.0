Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 3/5] Bluetooth: Avoid polling TX power for LE links
Date: Wed, 14 May 2014 12:49:41 +0200
Message-ID: <1400064583-12623-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TX power for LE links is immutable thus we do not need to query for it
if already have value.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0e5a316..664dbc4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4717,10 +4717,16 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
 			    &req_rssi_cp);
 
-		req_txp_cp.handle = cpu_to_le16(conn->handle);
-		req_txp_cp.type = 0x00;
-		hci_req_add(&req, HCI_OP_READ_TX_POWER,
-			    sizeof(req_txp_cp), &req_txp_cp);
+		/* For LE links TX power does not change thus we don't need to
+		 * query for it once value is known.
+		 */
+		if (!bdaddr_type_is_le(cp->addr.type) ||
+		    conn->tx_power == HCI_TX_POWER_INVALID) {
+			req_txp_cp.handle = cpu_to_le16(conn->handle);
+			req_txp_cp.type = 0x00;
+			hci_req_add(&req, HCI_OP_READ_TX_POWER,
+				    sizeof(req_txp_cp), &req_txp_cp);
+		}
 
 		err = hci_req_run(&req, conn_info_refresh_complete);
 		if (err < 0)
-- 
1.9.3

