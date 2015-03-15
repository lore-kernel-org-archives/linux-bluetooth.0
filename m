Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 03/14] Bluetooth: Use special function to send filter management index events
Date: Sat, 14 Mar 2015 19:27:55 -0700
Message-Id: <1426386486-15962-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For sending Index Added, Index Removed, Unconfigured Index Added and
Unconfigured Index Removed managment events the new helper functions
allows taking into account if these events are enabled for a certain
management socket or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  6 +++++
 net/bluetooth/hci_sock.c    | 10 +++++++
 net/bluetooth/mgmt.c        | 64 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d942fedbaedd..0995ec755959 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -179,6 +179,12 @@ enum {
 	HCI_RESET,
 };
 
+/* HCI socket flags */
+enum {
+	HCI_MGMT_INDEX_EVENTS,
+	HCI_MGMT_UNCONF_INDEX_EVENTS,
+};
+
 /*
  * BR/EDR and/or LE controller flags: the flags defined here should represent
  * states from the controller.
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 174a353a7dcf..00775c4fef83 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -817,6 +817,16 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		/* At the moment the index and unconfigured index events
+		 * are enabled unconditionally. Setting them on each
+		 * socket when binding keeps this functionality. They
+		 * however might be cleared later and then sending of these
+		 * events will be disabled, but that is then intentional.
+		 */
+		if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
+			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
+			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
+		}
 		break;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c58908652519..6b58c13b2b51 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -250,6 +250,33 @@ static int mgmt_send_event(u16 event, struct hci_dev *hdev,
 	return 0;
 }
 
+static int mgmt_index_event(u16 event, struct hci_dev *hdev,
+			    void *data, u16 data_len, int flag)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+
+	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(event);
+	hdr->index = cpu_to_le16(hdev->id);
+	hdr->len = cpu_to_le16(data_len);
+
+	if (data)
+		memcpy(skb_put(skb, data_len), data, data_len);
+
+	/* Time stamp */
+	__net_timestamp(skb);
+
+	hci_send_to_flagged_channel(HCI_CHANNEL_CONTROL, skb, flag);
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 		      struct sock *skip_sk)
 {
@@ -6343,34 +6370,43 @@ done:
 
 void mgmt_index_added(struct hci_dev *hdev)
 {
-	if (hdev->dev_type != HCI_BREDR)
-		return;
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
-		mgmt_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev, NULL, 0, NULL);
-	else
-		mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
+	switch (hdev->dev_type) {
+	case HCI_BREDR:
+		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+			mgmt_index_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev,
+					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
+		} else {
+			mgmt_index_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0,
+					 HCI_MGMT_INDEX_EVENTS);
+		}
+		break;
+	}
 }
 
 void mgmt_index_removed(struct hci_dev *hdev)
 {
 	u8 status = MGMT_STATUS_INVALID_INDEX;
 
-	if (hdev->dev_type != HCI_BREDR)
-		return;
-
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	switch (hdev->dev_type) {
+	case HCI_BREDR:
+		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
-	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
-		mgmt_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0, NULL);
-	else
-		mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
+		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+			mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev,
+					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
+		} else {
+			mgmt_index_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0,
+					 HCI_MGMT_INDEX_EVENTS);
+		}
+		break;
+	}
 }
 
 /* This function requires the caller holds hdev->lock */
-- 
2.1.0

