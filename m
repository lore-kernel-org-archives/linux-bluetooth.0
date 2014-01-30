Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 13/14] Bleutooth: Add support for auto connect options
Date: Thu, 30 Jan 2014 18:22:16 -0300
Message-Id: <1391116937-28217-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the HCI_AUTO_CONN_ALWAYS and HCI_AUTO_
CONN_LINK_LOSS options from struct hci_conn_params.

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
 net/bluetooth/hci_event.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8f4686a..020fd9f 100644
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
1.8.5.3

