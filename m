Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Ulisses Furquim <ulisses@profusion.mobi>
Subject: [PATCH] Bluetooth: Remove global mutex hci_task_lock
Date: Tue, 20 Dec 2011 17:10:51 -0200
Message-Id: <1324408251-8116-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_task_lock mutex (previously a lock) was supposed to protect the
register/unregister of HCI protocols against RX/TX tasks. This will not
be needed anymore because SCO and L2CAP will always be compiled.

Moreover, with the recent move of RX/TX to workqueues per device the
global hci_task_lock was causing starvation between different HCI
devices.

Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 net/bluetooth/hci_core.c |   21 +--------------------
 1 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6382db..b45b745 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -61,8 +61,6 @@ static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
 
-static DEFINE_MUTEX(hci_task_lock);
-
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
 DEFINE_RWLOCK(hci_dev_list_lock);
@@ -1800,8 +1798,7 @@ EXPORT_SYMBOL(hci_recv_stream_fragment);
 
 /* ---- Interface to upper protocols ---- */
 
-/* Register/Unregister protocols.
- * hci_task_lock is used to ensure that no tasks are running. */
+/* Register/Unregister protocols. */
 int hci_register_proto(struct hci_proto *hp)
 {
 	int err = 0;
@@ -1811,15 +1808,11 @@ int hci_register_proto(struct hci_proto *hp)
 	if (hp->id >= HCI_MAX_PROTO)
 		return -EINVAL;
 
-	mutex_lock(&hci_task_lock);
-
 	if (!hci_proto[hp->id])
 		hci_proto[hp->id] = hp;
 	else
 		err = -EEXIST;
 
-	mutex_unlock(&hci_task_lock);
-
 	return err;
 }
 EXPORT_SYMBOL(hci_register_proto);
@@ -1833,15 +1826,11 @@ int hci_unregister_proto(struct hci_proto *hp)
 	if (hp->id >= HCI_MAX_PROTO)
 		return -EINVAL;
 
-	mutex_lock(&hci_task_lock);
-
 	if (hci_proto[hp->id])
 		hci_proto[hp->id] = NULL;
 	else
 		err = -ENOENT;
 
-	mutex_unlock(&hci_task_lock);
-
 	return err;
 }
 EXPORT_SYMBOL(hci_unregister_proto);
@@ -2407,8 +2396,6 @@ static void hci_tx_work(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, tx_work);
 	struct sk_buff *skb;
 
-	mutex_lock(&hci_task_lock);
-
 	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
 		hdev->sco_cnt, hdev->le_cnt);
 
@@ -2425,8 +2412,6 @@ static void hci_tx_work(struct work_struct *work)
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
-
-	mutex_unlock(&hci_task_lock);
 }
 
 /* ----- HCI RX task (incoming data processing) ----- */
@@ -2514,8 +2499,6 @@ static void hci_rx_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	mutex_lock(&hci_task_lock);
-
 	while ((skb = skb_dequeue(&hdev->rx_q))) {
 		if (atomic_read(&hdev->promisc)) {
 			/* Send copy to the sockets */
@@ -2559,8 +2542,6 @@ static void hci_rx_work(struct work_struct *work)
 			break;
 		}
 	}
-
-	mutex_unlock(&hci_task_lock);
 }
 
 static void hci_cmd_work(struct work_struct *work)
-- 
1.7.8.rc4

