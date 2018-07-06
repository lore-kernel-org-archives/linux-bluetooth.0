Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v3 11/18] Bluetooth: Use selected PHYs in extended connect
Date: Fri,  6 Jul 2018 17:05:37 +0530
Message-Id: <1530876944-17453-12-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the selected PHYs by Set PHY Configuration management command
in extended create connection.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_conn.c | 63 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cc967ca..5d421a2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -777,8 +777,9 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	if (use_ext_conn(hdev)) {
 		struct hci_cp_le_ext_create_conn *cp;
 		struct hci_cp_le_ext_conn_param *p;
-		/* As of now only LE 1M is supported */
-		u8 data[sizeof(*cp) + sizeof(*p) * 1];
+		u8 data[sizeof(*cp) + sizeof(*p) * 3];
+		u8 init_phys;
+		u32 plen;
 
 		cp = (void *) data;
 		p = (void *) cp->data;
@@ -788,24 +789,54 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 		bacpy(&cp->peer_addr, &conn->dst);
 		cp->peer_addr_type = conn->dst_type;
 		cp->own_addr_type = own_addr_type;
-		cp->phys = LE_SCAN_PHY_1M;
 
-		memset(p, 0, sizeof(*p));
+		if (scan_1m(hdev))
+			cp->phys |= LE_SCAN_PHY_1M;
 
-		/* Set window to be the same value as the interval to enable
-		 * continuous scanning.
-		 */
+		if (scan_2m(hdev))
+			cp->phys |= LE_SCAN_PHY_2M;
+
+		if (scan_coded(hdev))
+			cp->phys |= LE_SCAN_PHY_CODED;
+
+		init_phys = cp->phys;
+
+		plen = sizeof(*cp);
+
+		/* Use same param for all PHYs */
+		while (init_phys) {
+			u16 min_interval, max_interval, supv_timeout;
 
-		p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
-		p->scan_window = p->scan_interval;
-		p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
-		p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-		p->conn_latency = cpu_to_le16(conn->le_conn_latency);
-		p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
-		p->min_ce_len = cpu_to_le16(0x0000);
-		p->max_ce_len = cpu_to_le16(0x0000);
+			if (!(init_phys & 0x01)) {
+				init_phys >>= 0x01;
+				continue;
+			}
+
+			memset(p, 0, sizeof(*p));
+
+			/* Set window to be the same value as the interval to
+			 * enable continuous scanning.
+			 */
+
+			min_interval = conn->le_conn_min_interval;
+			max_interval = conn->le_conn_max_interval;
+			supv_timeout = conn->le_supv_timeout;
+
+			p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
+			p->scan_window = p->scan_interval;
+			p->conn_interval_min = cpu_to_le16(min_interval);
+			p->conn_interval_max = cpu_to_le16(max_interval);
+			p->conn_latency = cpu_to_le16(conn->le_conn_latency);
+			p->supervision_timeout = cpu_to_le16(supv_timeout);
+			p->min_ce_len = cpu_to_le16(0x0000);
+			p->max_ce_len = cpu_to_le16(0x0000);
+
+			p++;
+			plen += sizeof(*p);
+			init_phys >>= 1;
+		}
 
-		hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, sizeof(data), data);
+		hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, plen, data);
 
 	} else {
 		struct hci_cp_le_create_conn cp;
-- 
2.7.4
