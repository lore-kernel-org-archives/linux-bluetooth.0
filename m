Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCHv2 1/2] Bluetooth: Clear role switch pending flag
Date: Thu,  6 Nov 2014 19:36:52 +0100
Message-Id: <1415299013-24580-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If role switch was rejected by the controller and HCI Event: Command Status
returned with status "Command Disallowed" (0x0C) the flag
HCI_CONN_RSWITCH_PEND remains set. No further role switches are
possible as this flag prevents us from sending any new HCI Switch Role
requests and the only way to clear it is to receive a valid
HCI Event Switch Role.

This patch clears the flag if command was rejected.

2013-01-01 00:03:44.209913 < HCI Command: Switch Role (0x02|0x000b) plen 7
    bdaddr BC:C6:DB:C4:6F:79 role 0x00
    Role: Master
2013-01-01 00:03:44.210867 > HCI Event: Command Status (0x0f) plen 4
    Switch Role (0x02|0x000b) status 0x0c ncmd 1
    Error: Command Disallowed

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 net/bluetooth/hci_event.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f02ff0..73d9bb4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1947,6 +1947,29 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_switch_role *cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_SWITCH_ROLE);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (conn)
+		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2886,6 +2909,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_exit_sniff_mode(hdev, ev->status);
 		break;
 
+	case HCI_OP_SWITCH_ROLE:
+		hci_cs_switch_role(hdev, ev->status);
+		break;
+
 	case HCI_OP_DISCONNECT:
 		hci_cs_disconnect(hdev, ev->status);
 		break;
-- 
1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052

