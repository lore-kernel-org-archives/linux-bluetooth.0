Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Bluetooth: use recommended LE connection parameters
Date: Wed, 27 Jul 2011 18:40:09 -0300
Message-Id: <1311802809-10565-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new connection parameters now match the recommended values for
Proximity and Health Thermometer profiles. The previous values were
ramdomly chosen, and are either too low or too high for most cases.

New values:

Scan Interval: 60 ms
Scan Window: 30 ms
Minimum Connection Interval: 50 ms
Maximum Connection Interval: 70 ms
Supervision Timeout: 420 ms

See "Table 5.2: Recommended Scan Interval and Scan Window Values" and
"Table 5.3: Recommended Connection Interval Values" for both profiles
for details. Note that the "fast connection" parameters were chosen,
because we do not support yet dynamically changing these parameters from
initiator side.

Additionally, the Proximity profile recommends (section "4.4 Alert on
Link Loss"):

"It is recommended that the Link Supervision Timeout (LSTO) is set to 6x
the connection interval."

Minimum_CE_Length and Maximum_CE_Length were also changed from 0x0001 to
0x0000 because they are informational and optional, and old value was
not reflecting reality.
---
 net/bluetooth/hci_conn.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ea7f031..fa6820e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -56,15 +56,15 @@ static void hci_le_connect(struct hci_conn *conn)
 	conn->sec_level = BT_SECURITY_LOW;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = cpu_to_le16(0x0004);
-	cp.scan_window = cpu_to_le16(0x0004);
+	cp.scan_interval = cpu_to_le16(0x0060);
+	cp.scan_window = cpu_to_le16(0x0030);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
-	cp.conn_interval_min = cpu_to_le16(0x0008);
-	cp.conn_interval_max = cpu_to_le16(0x0100);
-	cp.supervision_timeout = cpu_to_le16(0x0064);
-	cp.min_ce_len = cpu_to_le16(0x0001);
-	cp.max_ce_len = cpu_to_le16(0x0001);
+	cp.conn_interval_min = cpu_to_le16(0x0028);
+	cp.conn_interval_max = cpu_to_le16(0x0038);
+	cp.supervision_timeout = cpu_to_le16(0x002a);
+	cp.min_ce_len = cpu_to_le16(0x0000);
+	cp.max_ce_len = cpu_to_le16(0x0000);
 
 	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 }
-- 
1.7.0.4

