Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 03/11] Bluetooth: AMP: Process Physical Link Complete evt
Date: Thu, 25 Oct 2012 15:20:44 +0300
Message-Id: <1351167652-12346-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add processing for HCI Physical Link Complete event. Upon
successful status received start L2CAP create channel process.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |   55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aae8053..183d8bd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3637,6 +3637,57 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_phy_link_complete_evt(struct hci_dev *hdev,
+				      struct sk_buff *skb)
+{
+	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon, *bredr_hcon;
+
+	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
+	       ev->status);
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	if (ev->status) {
+		hci_conn_del(hcon);
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
+
+	hcon->state = BT_CONNECTED;
+	bacpy(&hcon->dst, &bredr_hcon->dst);
+
+	hci_conn_hold(hcon);
+	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
+	hci_conn_put(hcon);
+
+	hci_conn_hold_device(hcon);
+	hci_conn_add_sysfs(hcon);
+
+	hci_dev_unlock(hdev);
+
+	if (hcon->out) {
+		struct hci_dev *bredr_hdev = hci_dev_hold(bredr_hcon->hdev);
+
+		if (!bredr_hdev)
+			return;
+
+		/* Placeholder - create chan req
+		l2cap_chan_create_cfm(bredr_hcon, hcon->remote_id);
+		*/
+
+		hci_dev_put(bredr_hdev);
+	}
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -3964,6 +4015,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_PHY_LINK_COMPLETE:
+		hci_phy_link_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
-- 
1.7.9.5

