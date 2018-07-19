Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 08/16] Bluetooth: Use selected PHYs in extended connect
Date: Thu, 19 Jul 2018 17:09:39 +0530
Message-Id: <1532000387-3649-9-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the selected PHYs by Set PHY Configuration management command
in extended create connection.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_conn.c | 61 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cc967ca..64e828a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -748,6 +748,26 @@ static bool conn_use_rpa(struct hci_conn *conn)
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
 }
 
+static void set_ext_conn_params(struct hci_conn *conn,
+				struct hci_cp_le_ext_conn_param *p)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	memset(p, 0, sizeof(*p));
+
+	/* Set window to be the same value as the interval to
+	 * enable continuous scanning.
+	 */
+	p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
+	p->scan_window = p->scan_interval;
+	p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
+	p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
+	p->conn_latency = cpu_to_le16(conn->le_conn_latency);
+	p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
+	p->min_ce_len = cpu_to_le16(0x0000);
+	p->max_ce_len = cpu_to_le16(0x0000);
+}
+
 static void hci_req_add_le_create_conn(struct hci_request *req,
 				       struct hci_conn *conn,
 				       bdaddr_t *direct_rpa)
@@ -777,8 +797,8 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	if (use_ext_conn(hdev)) {
 		struct hci_cp_le_ext_create_conn *cp;
 		struct hci_cp_le_ext_conn_param *p;
-		/* As of now only LE 1M is supported */
-		u8 data[sizeof(*cp) + sizeof(*p) * 1];
+		u8 data[sizeof(*cp) + sizeof(*p) * 3];
+		u32 plen;
 
 		cp = (void *) data;
 		p = (void *) cp->data;
@@ -788,24 +808,33 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 		bacpy(&cp->peer_addr, &conn->dst);
 		cp->peer_addr_type = conn->dst_type;
 		cp->own_addr_type = own_addr_type;
-		cp->phys = LE_SCAN_PHY_1M;
 
-		memset(p, 0, sizeof(*p));
+		plen = sizeof(*cp);
 
-		/* Set window to be the same value as the interval to enable
-		 * continuous scanning.
-		 */
+		if (scan_1m(hdev)) {
+			cp->phys |= LE_SCAN_PHY_1M;
+			set_ext_conn_params(conn, p);
+
+			p++;
+			plen += sizeof(*p);
+		}
+
+		if (scan_2m(hdev)) {
+			cp->phys |= LE_SCAN_PHY_2M;
+			set_ext_conn_params(conn, p);
 
-		p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
-		p->scan_window = p->scan_interval;
-		p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
-		p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-		p->conn_latency = cpu_to_le16(conn->le_conn_latency);
-		p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
-		p->min_ce_len = cpu_to_le16(0x0000);
-		p->max_ce_len = cpu_to_le16(0x0000);
+			p++;
+			plen += sizeof(*p);
+		}
+
+		if (scan_coded(hdev)) {
+			cp->phys |= LE_SCAN_PHY_CODED;
+			set_ext_conn_params(conn, p);
+
+			plen += sizeof(*p);
+		}
 
-		hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, sizeof(data), data);
+		hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, plen, data);
 
 	} else {
 		struct hci_cp_le_create_conn cp;
-- 
2.7.4
