Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Use HCI request for LE connection
Date: Tue,  1 Oct 2013 20:03:51 -0300
Message-Id: <1380668636-30654-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new helper for initiating LE conneciton which uses
the HCI request framework. This patch also changes the hci_connect_le()
so it uses the new helper instead of the old hci_le_create_connection().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  7 +++++-
 net/bluetooth/hci_core.c         | 46 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 26cc9f7..6aa172c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1216,6 +1216,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
+int hci_initiate_le_connection(struct hci_dev *hdev, bdaddr_t *addr, u8 type);
+
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f473605..24d1a0a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -545,6 +545,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				    u8 dst_type, u8 sec_level, u8 auth_type)
 {
 	struct hci_conn *le;
+	int err;
 
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
@@ -565,7 +566,11 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		le->link_mode |= HCI_LM_MASTER;
 		le->sec_level = BT_SECURITY_LOW;
 
-		hci_le_create_connection(le);
+		err = hci_initiate_le_connection(hdev, &le->dst, le->dst_type);
+		if (err) {
+			hci_conn_del(le);
+			return ERR_PTR(err);
+		}
 	}
 
 	le->pending_sec_level = sec_level;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4549b5c..51c1796 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3631,3 +3631,49 @@ u8 bdaddr_to_le(u8 bdaddr_type)
 		return ADDR_LE_DEV_RANDOM;
 	}
 }
+
+static void initiate_le_connection_complete(struct hci_dev *hdev, u8 status)
+{
+	struct hci_conn *conn;
+
+	if (status == 0)
+		return;
+
+	BT_ERR("HCI request failed to initiate LE connection: status 0x%2.2x",
+	       status);
+
+	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	if (!conn)
+		return;
+
+	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
+			    status);
+
+	hci_proto_connect_cfm(conn, status);
+
+	hci_dev_lock(hdev);
+	hci_conn_del(conn);
+	hci_dev_unlock(hdev);
+}
+
+int hci_initiate_le_connection(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_cp_le_create_conn cp;
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.scan_interval = __constant_cpu_to_le16(0x0060);
+	cp.scan_window = __constant_cpu_to_le16(0x0030);
+	bacpy(&cp.peer_addr, addr);
+	cp.peer_addr_type = type;
+	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
+	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
+	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
+	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
+	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
+	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
+
+	return hci_req_run(&req, initiate_le_connection_complete);
+}
-- 
1.8.4

