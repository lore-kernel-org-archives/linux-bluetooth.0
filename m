Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 05/15] Bluetooth: Use connection parameters if any
Date: Wed, 16 Oct 2013 20:17:55 -0300
Message-Id: <1381965485-9159-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes hci_create_le_conn() so it uses the connection
parameters specified by the user. If no parameters were configured,
we use the default values.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4e72650..d64000e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -548,6 +548,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_conn cp;
 	struct hci_request req;
+	struct hci_conn_param *param;
 	int err;
 
 	hci_req_init(&req, hdev);
@@ -558,11 +559,18 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
 	cp.own_address_type = conn->src_type;
-	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
-	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
 	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
+	param = hci_find_conn_param(hdev, &conn->dst, conn->dst_type);
+	if (param) {
+		cp.conn_interval_min = cpu_to_le16(param->min_conn_interval);
+		cp.conn_interval_max = cpu_to_le16(param->max_conn_interval);
+		hci_conn_param_put(param);
+	} else {
+		cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
+		cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
+	}
 	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 
 	err = hci_req_run(&req, create_le_conn_complete);
-- 
1.8.4

