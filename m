Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use same LE min/max connection event length during update
Date: Tue, 18 Feb 2014 22:27:14 -0800
Message-Id: <1392791234-43343-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During LE connection establishment the value 0x0000 is used for min/max
connection event length. So use the same value when the peripheral is
requesting an update of the the connection paramters.

For some reason the value 0x0001 got used in the connection update and
0x0000 in the connection creation. Using the same value for both just
makes sense.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a027951d0da5..bd66c52eff95 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -225,8 +225,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 	cp.conn_interval_max	= cpu_to_le16(max);
 	cp.conn_latency		= cpu_to_le16(latency);
 	cp.supervision_timeout	= cpu_to_le16(to_multiplier);
-	cp.min_ce_len		= __constant_cpu_to_le16(0x0001);
-	cp.max_ce_len		= __constant_cpu_to_le16(0x0001);
+	cp.min_ce_len		= __constant_cpu_to_le16(0x0000);
+	cp.max_ce_len		= __constant_cpu_to_le16(0x0000);
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
 }
-- 
1.8.5.3

