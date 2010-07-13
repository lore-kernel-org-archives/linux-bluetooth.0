Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v6 1/4] add one more buffer for stream reassembly
Date: Tue, 13 Jul 2010 15:03:28 +0530
Message-ID: <1279013611-4775-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Additional reassembly buffer to keep track of stream reasembly

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 include/net/bluetooth/hci_core.h |    4 ++--
 net/bluetooth/hci_core.c         |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 600372d..10ad3ed 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -66,7 +66,7 @@ struct bdaddr_list {
 	struct list_head list;
 	bdaddr_t bdaddr;
 };
-
+#define NUM_REASSEMBLY_BUFFER 4
 struct hci_dev {
 	struct list_head list;
 	spinlock_t	lock;
@@ -123,7 +123,7 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
-	struct sk_buff		*reassembly[3];
+	struct sk_buff		*reassembly[NUM_REASSEMBLY_BUFFER];
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aeb2982..5df09fd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -914,7 +914,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
 
-	for (i = 0; i < 3; i++)
+	for (i = 0; i < NUM_REASSEMBLY_BUFFER; i++)
 		hdev->reassembly[i] = NULL;
 
 	init_waitqueue_head(&hdev->req_wait_q);
@@ -973,7 +973,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_dev_do_close(hdev);
 
-	for (i = 0; i < 3; i++)
+	for (i = 0; i < NUM_REASSEMBLY_BUFFER; i++)
 		kfree_skb(hdev->reassembly[i]);
 
 	hci_notify(hdev, HCI_DEV_UNREG);
-- 
1.7.0.4

