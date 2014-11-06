Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCHv2 2/2] Bluetooth: Sort switch cases by opcode's numeric value
Date: Thu,  6 Nov 2014 19:36:53 +0100
Message-Id: <1415299013-24580-2-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1415299013-24580-1-git-send-email-kubax.t.pawlak@intel.com>
References: <1415299013-24580-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Opcodes in switch/case in hci_cmd_status_evt are not sorted
by value. This patch restores proper ordering.

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 net/bluetooth/hci_event.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 73d9bb4..5e7be80 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2873,6 +2873,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_create_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_DISCONNECT:
+		hci_cs_disconnect(hdev, ev->status);
+		break;
+
 	case HCI_OP_ADD_SCO:
 		hci_cs_add_sco(hdev, ev->status);
 		break;
@@ -2901,6 +2905,14 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_setup_sync_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_CREATE_PHY_LINK:
+		hci_cs_create_phylink(hdev, ev->status);
+		break;
+
+	case HCI_OP_ACCEPT_PHY_LINK:
+		hci_cs_accept_phylink(hdev, ev->status);
+		break;
+
 	case HCI_OP_SNIFF_MODE:
 		hci_cs_sniff_mode(hdev, ev->status);
 		break;
@@ -2913,18 +2925,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_switch_role(hdev, ev->status);
 		break;
 
-	case HCI_OP_DISCONNECT:
-		hci_cs_disconnect(hdev, ev->status);
-		break;
-
-	case HCI_OP_CREATE_PHY_LINK:
-		hci_cs_create_phylink(hdev, ev->status);
-		break;
-
-	case HCI_OP_ACCEPT_PHY_LINK:
-		hci_cs_accept_phylink(hdev, ev->status);
-		break;
-
 	case HCI_OP_LE_CREATE_CONN:
 		hci_cs_le_create_conn(hdev, ev->status);
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

