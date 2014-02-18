Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v10 08/10] Bluetooth: Introduce LE auto connect options
Date: Tue, 18 Feb 2014 17:15:32 -0300
Message-Id: <1392754534-12747-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
References: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the LE auto connection options: HCI_AUTO_CONN_
ALWAYS and HCI_AUTO_CONN_LINK_LOSS. Their working mechanism are
described as follows:

The HCI_AUTO_CONN_ALWAYS option configures the kernel to always re-
establish the connection, no matter the reason the connection was
terminated. This feature is required by some LE profiles such as
HID over GATT, Health Thermometer and Blood Pressure. These profiles
require the host autonomously connect to the device as soon as it
enters in connectable mode (start advertising) so the device is able
to delivery notifications or indications.

The BT_AUTO_CONN_LINK_LOSS option configures the kernel to re-
establish the connection in case the connection was terminated due
to a link loss. This feature is required by the majority of LE
profiles such as Proximity, Find Me, Cycling Speed and Cadence and
Time.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  9 ++++++++-
 net/bluetooth/hci_core.c         | 11 +++++++----
 net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 297b954..de6357b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -393,6 +393,12 @@ struct hci_conn_params {
 
 	u16 conn_min_interval;
 	u16 conn_max_interval;
+
+	enum {
+		HCI_AUTO_CONN_DISABLED,
+		HCI_AUTO_CONN_ALWAYS,
+		HCI_AUTO_CONN_LINK_LOSS,
+	} auto_connect;
 };
 
 extern struct list_head hci_dev_list;
@@ -778,7 +784,8 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			 u16 conn_min_interval, u16 conn_max_interval);
+			 u8 auto_connect, u16 conn_min_interval,
+			 u16 conn_max_interval);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9434d1c..4f9db12 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3037,7 +3037,8 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 
 /* This function requires the caller holds hdev->lock */
 void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			 u16 conn_min_interval, u16 conn_max_interval)
+			 u8 auto_connect, u16 conn_min_interval,
+			 u16 conn_max_interval)
 {
 	struct hci_conn_params *params;
 
@@ -3045,6 +3046,7 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	if (params) {
 		params->conn_min_interval = conn_min_interval;
 		params->conn_max_interval = conn_max_interval;
+		params->auto_connect = auto_connect;
 		return;
 	}
 
@@ -3058,12 +3060,13 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	params->addr_type = addr_type;
 	params->conn_min_interval = conn_min_interval;
 	params->conn_max_interval = conn_max_interval;
+	params->auto_connect = auto_connect;
 
 	list_add(&params->list, &hdev->le_conn_params);
 
-	BT_DBG("addr %pMR (type %u) conn_min_interval 0x%.4x "
-	       "conn_max_interval 0x%.4x", addr, addr_type, conn_min_interval,
-	       conn_max_interval);
+	BT_DBG("addr %pMR (type %u) auto_connect %u conn_min_interval 0x%.4x "
+	       "conn_max_interval 0x%.4x", addr, addr_type, auto_connect,
+	       conn_min_interval, conn_max_interval);
 }
 
 /* This function requires the caller holds hdev->lock */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b25cefd..86c02dd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1825,6 +1825,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	u8 reason = hci_to_mgmt_reason(ev->reason);
+	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	u8 type;
 
@@ -1851,6 +1852,23 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn->type == ACL_LINK && conn->flush_key)
 		hci_remove_link_key(hdev, &conn->dst);
 
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		switch (params->auto_connect) {
+		case HCI_AUTO_CONN_LINK_LOSS:
+			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+				break;
+			/* Fall through */
+
+		case HCI_AUTO_CONN_ALWAYS:
+			hci_pend_le_conn_add(hdev, &conn->dst, conn->dst_type);
+			break;
+
+		default:
+			break;
+		}
+	}
+
 	type = conn->type;
 
 	hci_proto_disconn_cfm(conn, ev->reason);
-- 
1.8.5.4

