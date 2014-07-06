Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use lower timeout for LE auto-connections
Date: Sun,  6 Jul 2014 13:41:15 +0300
Message-Id: <1404643275-22676-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we establish connections as a consequence of receiving an
advertising report it makes no sense to wait the normal 20 second LE
connection timeout. This patch modifies the hci_connect_le function to
take an extra timeout value and uses a lower 2 second timeout for the
auto-connection case. This timeout is intentionally chosen to be just a
bit higher than the 1.28 second timeout that High Duty Cycle Advertising
uses.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      | 1 +
 include/net/bluetooth/hci_core.h | 4 +++-
 net/bluetooth/hci_conn.c         | 4 +++-
 net/bluetooth/hci_event.c        | 4 ++--
 net/bluetooth/l2cap_core.c       | 2 +-
 net/bluetooth/mgmt.c             | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 80c5fc947fbc..18bfdf8d125a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -237,6 +237,7 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
+#define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9d838a072db4..06039aae3010 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -385,6 +385,7 @@ struct hci_conn {
 	__u32		passkey_notify;
 	__u8		passkey_entered;
 	__u16		disc_timeout;
+	__u16		conn_timeout;
 	__u16		setting;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
@@ -703,7 +704,8 @@ void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u8 auth_type);
+				u8 dst_type, u8 sec_level, u8 auth_type,
+				u16 conn_timeout);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0d579d036833..faa032fcdaee 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -700,7 +700,8 @@ static void hci_req_directed_advertising(struct hci_request *req,
 }
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u8 auth_type)
+				u8 dst_type, u8 sec_level, u8 auth_type,
+				u16 conn_timeout)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -758,6 +759,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
+	conn->conn_timeout = conn_timeout;
 
 	hci_req_init(&req, hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c2ba79c8fe51..80f48c15f12b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1073,7 +1073,7 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		if (conn)
 			queue_delayed_work(hdev->workqueue,
 					   &conn->le_conn_timeout,
-					   HCI_LE_CONN_TIMEOUT);
+					   conn->conn_timeout);
 	}
 
 	mgmt_advertising(hdev, *sent);
@@ -4238,7 +4238,7 @@ static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		return false;
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_AT_NO_BONDING);
+			      HCI_AT_NO_BONDING, HCI_LE_AUTOCONN_TIMEOUT);
 	if (!IS_ERR(conn))
 		return true;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f1f544a12c3c..a219276d9f92 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7135,7 +7135,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 			dst_type = ADDR_LE_DEV_RANDOM;
 
 		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      auth_type);
+				      auth_type, HCI_LE_CONN_TIMEOUT);
 	} else {
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 04a66429ad4d..9eaa3dc03ded 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3113,7 +3113,8 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
 		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
-				      sec_level, auth_type);
+				      sec_level, auth_type,
+				      HCI_LE_CONN_TIMEOUT);
 	}
 
 	if (IS_ERR(conn)) {
-- 
1.9.3

