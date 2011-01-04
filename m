Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/11] Bluetooth: Add support for management powered event
Date: Tue,  4 Jan 2011 12:08:43 +0200
Message-Id: <1294135732-26765-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds support for the powered event that's used to indicate to
userspace when the powered state of a local adapter changes.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    6 ++++++
 net/bluetooth/hci_core.c         |    4 ++++
 net/bluetooth/mgmt.c             |   10 ++++++++++
 4 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dfbb325..6449ff8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -671,6 +671,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(u16 index);
 int mgmt_index_removed(u16 index);
+int mgmt_powered(u16 index, u8 powered);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ca29c13..0ac1520 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -85,3 +85,9 @@ struct mgmt_ev_index_added {
 struct mgmt_ev_index_removed {
 	__le16 index;
 } __packed;
+
+#define MGMT_EV_POWERED			0x0006
+struct mgmt_ev_powered {
+	__le16 index;
+	__u8 powered;
+} __packed;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d5a315c..36b08a4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -535,6 +535,8 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
+		if (!test_bit(HCI_SETUP, &hdev->flags))
+			mgmt_powered(hdev->id, 1);
 	} else {
 		/* Init failed, cleanup */
 		tasklet_kill(&hdev->rx_task);
@@ -616,6 +618,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
 
+	mgmt_powered(hdev->id, 0);
+
 	/* Clear flags */
 	hdev->flags = 0;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2a88b35..b7aeb7c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -314,3 +314,13 @@ int mgmt_index_removed(u16 index)
 
 	return mgmt_event(MGMT_EV_INDEX_REMOVED, &ev, sizeof(ev));
 }
+
+int mgmt_powered(u16 index, u8 powered)
+{
+	struct mgmt_ev_powered ev;
+
+	put_unaligned_le16(index, &ev.index);
+	ev.powered = powered;
+
+	return mgmt_event(MGMT_EV_POWERED, &ev, sizeof(ev));
+}
-- 
1.7.2.3

