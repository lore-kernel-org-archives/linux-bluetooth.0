Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Move hci_recv_frame and hci_recv_diag prototypes
Date: Sun, 17 Jul 2016 19:55:15 +0200
Message-Id: <1468778117-62931-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The protoypes for hci_recv_frame and hci_recv_diag are in the wrong
location in the header file. Move them close to all the other hci_dev
related exported functions.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 77d7fe115a0d..84d0273d826a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1022,6 +1022,8 @@ void hci_unregister_dev(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
+int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
+int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_do_close(struct hci_dev *hdev);
@@ -1098,9 +1100,6 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
-int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
-int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
-
 void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
-- 
2.7.4

