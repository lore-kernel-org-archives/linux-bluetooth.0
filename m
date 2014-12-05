Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Add support for handling LE Direct Advertising Report events
Date: Fri,  5 Dec 2014 16:20:13 +0100
Message-Id: <1417792815-55907-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller sends a LE Direct Advertising Report event, the host
must confirm that the resolvable random address provided matches with
its own identity resolving key. If it does, then that advertising report
needs to be processed. If it does not match, the report needs to be
ignored.

This patch adds full support for handling these new reports and using
them for device discovery and connection handling. This means when a
Bluetooth controller supports the Extended Scanner Filter Policies, it
is possible to use directed advertising with LE privacy.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 57 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 527dfdc9d8c8..322abbbbcef9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4426,7 +4426,8 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 }
 
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
-			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
+			       u8 bdaddr_type, bdaddr_t *direct_addr,
+			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
@@ -4434,6 +4435,32 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	bool match;
 	u32 flags;
 
+	/* If the direct address is present, then this report is from
+	 * a LE Direct Advertising Report event. In that case it is
+	 * important to see if the address is matching the local
+	 * controller address.
+	 */
+	if (direct_addr) {
+		/* Only resolvable random addresses are valid for these
+		 * kind of reports and others can be ignored.
+		 */
+		if (!hci_bdaddr_is_rpa(direct_addr, direct_addr_type))
+			return;
+
+		/* If the controller is not using resolvable random
+		 * addresses, then this report can be ignored.
+		 */
+		if (!test_bit(HCI_PRIVACY, &hdev->dev_flags))
+			return;
+
+		/* If the local IRK of the controller does not match
+		 * with the resolvable random address provided, then
+		 * this report can be ignored.
+		 */
+		if (!smp_irk_matches(hdev, hdev->irk, direct_addr))
+			return;
+	}
+
 	/* Check if we need to convert to identity address */
 	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
 	if (irk) {
@@ -4570,7 +4597,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		rssi = ev->data[ev->length];
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-				   ev->bdaddr_type, rssi, ev->data, ev->length);
+				   ev->bdaddr_type, NULL, 0, rssi,
+				   ev->data, ev->length);
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
@@ -4711,6 +4739,27 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
 }
 
+static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	u8 num_reports = skb->data[0];
+	void *ptr = &skb->data[1];
+
+	hci_dev_lock(hdev);
+
+	while (num_reports--) {
+		struct hci_ev_le_direct_adv_info *ev = ptr;
+
+		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
+				   ev->bdaddr_type, &ev->direct_addr,
+				   ev->direct_addr_type, ev->rssi, NULL, 0);
+
+		ptr += sizeof(*ev);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -4738,6 +4787,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_remote_conn_param_req_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_DIRECT_ADV_REPORT:
+		hci_le_direct_adv_report_evt(hdev, skb);
+		break;
+
 	default:
 		break;
 	}
-- 
1.9.3

