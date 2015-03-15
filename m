Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 14/14] Bluetooth: Use BIT(n) macro instead of manually encoding (1 << n)
Date: Sat, 14 Mar 2015 19:28:06 -0700
Message-Id: <1426386486-15962-14-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The flags for the management command table used manual encoding of
bits in the form of (1 << n). It is however preferred to use BIT(n)
macro instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3546789c1616..ce94bcb33600 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1289,10 +1289,10 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
-#define HCI_MGMT_VAR_LEN	(1 << 0)
-#define HCI_MGMT_NO_HDEV	(1 << 1)
-#define HCI_MGMT_UNTRUSTED	(1 << 2)
-#define HCI_MGMT_UNCONFIGURED	(1 << 3)
+#define HCI_MGMT_VAR_LEN	BIT(0)
+#define HCI_MGMT_NO_HDEV	BIT(1)
+#define HCI_MGMT_UNTRUSTED	BIT(2)
+#define HCI_MGMT_UNCONFIGURED	BIT(3)
 
 struct hci_mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
-- 
2.1.0

