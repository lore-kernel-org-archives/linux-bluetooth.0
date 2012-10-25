Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 04/11] Bluetooth: AMP: Process Logical Link complete evt
Date: Thu, 25 Oct 2012 15:20:45 +0300
Message-Id: <1351167652-12346-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After receiving HCI Logical Link Complete event finish EFS
configuration by sending L2CAP Conf Response with success code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/hci_event.c     |   42 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |    4 ++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 49783e9..24c61ef 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -810,5 +810,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
+void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
+		       u8 status);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 183d8bd..00021cb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3688,6 +3688,44 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 	}
 }
 
+static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon;
+	struct hci_chan *hchan;
+	struct amp_mgr *mgr;
+
+	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
+	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
+	       ev->status);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	/* Create AMP hchan */
+	hchan = hci_chan_create(hcon);
+	if (!hchan)
+		return;
+
+	hchan->handle = le16_to_cpu(ev->handle);
+
+	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->amp_mgr, hchan);
+
+	mgr = hcon->amp_mgr;
+	if (mgr && mgr->bredr_chan) {
+		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
+
+		l2cap_chan_lock(bredr_chan);
+
+		bredr_chan->conn->mtu = hdev->block_mtu;
+		l2cap_logical_cfm(bredr_chan, hchan, 0);
+		hci_conn_hold(hcon);
+
+		l2cap_chan_unlock(bredr_chan);
+	}
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -4019,6 +4057,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_phy_link_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LOGICAL_LINK_COMPLETE:
+		hci_loglink_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 600d808..d1728af 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4428,8 +4428,8 @@ static void l2cap_logical_finish_move(struct l2cap_chan *chan,
 }
 
 /* Call with chan locked */
-static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
-			      u8 status)
+void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
+		       u8 status)
 {
 	BT_DBG("chan %p, hchan %p, status %d", chan, hchan, status);
 
-- 
1.7.9.5

