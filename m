Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Add management events for controller addition & removal
Date: Mon, 13 Dec 2010 21:07:07 +0200
Message-Id: <1292267227-22028-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
References: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds Bluetooth Management interface events for controller
addition and removal. The events correspond to the existing HCI_DEV_REG
and HCI_DEV_UNREG stack internal events.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 include/net/bluetooth/mgmt.h     |   10 +++++++++
 net/bluetooth/hci_core.c         |    2 +
 net/bluetooth/mgmt.c             |   41 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1992fac..3786ee8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -662,6 +662,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 
 /* Management interface */
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
+int mgmt_index_added(u16 index);
+int mgmt_index_removed(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 70985aa..ca29c13 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -75,3 +75,13 @@ struct mgmt_ev_controller_error {
 	__le16 index;
 	__u8 error_code;
 } __packed;
+
+#define MGMT_EV_INDEX_ADDED		0x0004
+struct mgmt_ev_index_added {
+	__le16 index;
+} __packed;
+
+#define MGMT_EV_INDEX_REMOVED		0x0005
+struct mgmt_ev_index_removed {
+	__le16 index;
+} __packed;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 51c61f7..1a4ec97 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -960,6 +960,7 @@ int hci_register_dev(struct hci_dev *hdev)
 		}
 	}
 
+	mgmt_index_added(hdev->id);
 	hci_notify(hdev, HCI_DEV_REG);
 
 	return id;
@@ -989,6 +990,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	for (i = 0; i < NUM_REASSEMBLY; i++)
 		kfree_skb(hdev->reassembly[i]);
 
+	mgmt_index_removed(hdev->id);
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d6c5a32..f827fd9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -265,3 +265,44 @@ done:
 	kfree(buf);
 	return err;
 }
+
+static int mgmt_event(u16 event, void *data, u16 data_len)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+
+	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	bt_cb(skb)->channel = HCI_CHANNEL_CONTROL;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(event);
+	hdr->len = cpu_to_le16(data_len);
+
+	memcpy(skb_put(skb, data_len), data, data_len);
+
+	hci_send_to_sock(NULL, skb);
+	kfree_skb(skb);
+
+	return 0;
+}
+
+int mgmt_index_added(u16 index)
+{
+	struct mgmt_ev_index_added ev;
+
+	put_unaligned_le16(index, &ev.index);
+
+	return mgmt_event(MGMT_EV_INDEX_ADDED, &ev, sizeof(ev));
+}
+
+int mgmt_index_removed(u16 index)
+{
+	struct mgmt_ev_index_added ev;
+
+	put_unaligned_le16(index, &ev.index);
+
+	return mgmt_event(MGMT_EV_INDEX_REMOVED, &ev, sizeof(ev));
+}
-- 
1.7.2.3

