Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove interval parameter from HCI connection
Date: Sat, 19 Oct 2013 05:26:57 -0700
Message-Id: <1382185617-43385-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The conn->interval parameter of HCI connections is not used at all
and so just remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/hci_event.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f621c5b..d50cc7a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -316,7 +316,6 @@ struct hci_conn {
 	__u8		attempt;
 	__u8		dev_class[3];
 	__u8		features[HCI_MAX_PAGES][8];
-	__u16		interval;
 	__u16		pkt_type;
 	__u16		link_policy;
 	__u32		link_mode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 83478da..5935f74 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2551,7 +2551,6 @@ static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
 		conn->mode = ev->mode;
-		conn->interval = __le16_to_cpu(ev->interval);
 
 		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND,
 					&conn->flags)) {
-- 
1.8.3.1

