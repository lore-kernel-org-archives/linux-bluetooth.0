Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/2] Bluetooth: Make hci_unregister_dev return void
Date: Wed, 26 Oct 2011 10:43:19 +0200
Message-Id: <1319618599-10938-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1319618599-10938-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319618599-10938-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

hci_unregister_dev cannot fail and always returns 0. The drivers already ignore
the return value so we can safely make it return void.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 119b795..967e18f7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -554,7 +554,7 @@ struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
 struct hci_dev *hci_alloc_dev(void);
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
-int hci_unregister_dev(struct hci_dev *hdev);
+void hci_unregister_dev(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_dev_open(__u16 dev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdcbf8f..557ff90 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1541,7 +1541,7 @@ err:
 EXPORT_SYMBOL(hci_register_dev);
 
 /* Unregister HCI device */
-int hci_unregister_dev(struct hci_dev *hdev)
+void hci_unregister_dev(struct hci_dev *hdev)
 {
 	int i;
 
@@ -1583,8 +1583,6 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
-
-	return 0;
 }
 EXPORT_SYMBOL(hci_unregister_dev);
 
-- 
1.7.7.1
