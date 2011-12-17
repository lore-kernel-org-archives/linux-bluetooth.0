Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 09/22] Bluetooth: move hci_task_lock to mutex
Date: Sat, 17 Dec 2011 19:29:29 -0200
Message-Id: <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Now we can sleep in any path inside Bluetooth core, so mutex can make
sense here.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_core.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1605fe7..1f0198b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -60,7 +60,7 @@ static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
 
-static DEFINE_RWLOCK(hci_task_lock);
+static DEFINE_MUTEX(hci_task_lock);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -1809,14 +1809,14 @@ int hci_register_proto(struct hci_proto *hp)
 	if (hp->id >= HCI_MAX_PROTO)
 		return -EINVAL;
 
-	write_lock_bh(&hci_task_lock);
+	mutex_lock(&hci_task_lock);
 
 	if (!hci_proto[hp->id])
 		hci_proto[hp->id] = hp;
 	else
 		err = -EEXIST;
 
-	write_unlock_bh(&hci_task_lock);
+	mutex_unlock(&hci_task_lock);
 
 	return err;
 }
@@ -1831,14 +1831,14 @@ int hci_unregister_proto(struct hci_proto *hp)
 	if (hp->id >= HCI_MAX_PROTO)
 		return -EINVAL;
 
-	write_lock_bh(&hci_task_lock);
+	mutex_lock(&hci_task_lock);
 
 	if (hci_proto[hp->id])
 		hci_proto[hp->id] = NULL;
 	else
 		err = -ENOENT;
 
-	write_unlock_bh(&hci_task_lock);
+	mutex_unlock(&hci_task_lock);
 
 	return err;
 }
@@ -2387,7 +2387,7 @@ static void hci_tx_task(unsigned long arg)
 	struct hci_dev *hdev = (struct hci_dev *) arg;
 	struct sk_buff *skb;
 
-	read_lock(&hci_task_lock);
+	mutex_lock(&hci_task_lock);
 
 	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
 		hdev->sco_cnt, hdev->le_cnt);
@@ -2406,7 +2406,7 @@ static void hci_tx_task(unsigned long arg)
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
 
-	read_unlock(&hci_task_lock);
+	mutex_unlock(&hci_task_lock);
 }
 
 /* ----- HCI RX task (incoming data processing) ----- */
@@ -2494,7 +2494,7 @@ static void hci_rx_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	read_lock(&hci_task_lock);
+	mutex_lock(&hci_task_lock);
 
 	while ((skb = skb_dequeue(&hdev->rx_q))) {
 		if (atomic_read(&hdev->promisc)) {
@@ -2540,7 +2540,7 @@ static void hci_rx_work(struct work_struct *work)
 		}
 	}
 
-	read_unlock(&hci_task_lock);
+	mutex_unlock(&hci_task_lock);
 }
 
 static void hci_cmd_task(unsigned long arg)
-- 
1.7.6.4

