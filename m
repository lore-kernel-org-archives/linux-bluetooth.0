Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 4/8] Bluetooth: AMP: Process Disc Logical Link
Date: Tue, 16 Oct 2012 18:01:06 +0300
Message-Id: <1350399670-12418-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add processing for HCI Disconnection Logical Link Complete
Event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    1 +
 net/bluetooth/amp.c         |    7 +++++++
 net/bluetooth/hci_event.c   |   28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 70d5c15..405fb9c 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -47,5 +47,6 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 void amp_create_logical_link(struct l2cap_chan *chan);
+void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 6f10e8b..40c5d95 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -420,3 +420,10 @@ void amp_create_logical_link(struct l2cap_chan *chan)
 done:
 	hci_dev_put(hdev);
 }
+
+void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason)
+{
+	BT_DBG("hchan %p", hchan);
+
+	hci_chan_del(hchan);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3f99214..dc24489 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3639,6 +3639,30 @@ static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
+{
+	struct hci_ev_disconn_logical_link_complete *ev = (void *) skb->data;
+	struct hci_chan *hchan;
+
+	BT_DBG("%s log handle 0x%4.4x status 0x%2.2x", hdev->name,
+	       le16_to_cpu(ev->handle), ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hchan = hci_chan_lookup_handle(hdev, le16_to_cpu(ev->handle));
+	if (!hchan)
+		goto unlock;
+
+	amp_destroy_logical_link(hchan, ev->reason);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -3974,6 +3998,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_loglink_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE:
+		hci_disconn_loglink_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
-- 
1.7.9.5

