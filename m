Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Make hci_blacklist_clear function static
Date: Thu, 27 Feb 2014 19:35:54 -0800
Message-Id: <1393558554-42295-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_blacklist_clear function is not used outside of hci_core.c and
can be made static.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/hci_core.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f1652430dee8..55ee2a5ca503 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -796,7 +796,6 @@ int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 					 bdaddr_t *bdaddr, u8 type);
-void hci_blacklist_clear(struct hci_dev *hdev);
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ba888e2ef39e..b0aa4eaa4660 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3237,7 +3237,7 @@ struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
-void hci_blacklist_clear(struct hci_dev *hdev)
+static void hci_blacklist_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
 
-- 
1.8.5.3

