Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689C8EC874C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 18:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjIGSVe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjIGSVd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3BE92
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 11:21:28 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RhJGT1hCVzVkXr;
        Thu,  7 Sep 2023 20:20:01 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 20:22:39 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC:     <jiangzp@google.com>
Subject: [PATCH] Bluetooth: Fix sleeping function called from invalid context in hci_cmd_sync_submit()
Date:   Thu, 7 Sep 2023 20:22:34 +0800
Message-ID: <20230907122234.146449-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Syzbot reports a sleeping function called from invalid context problem.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4440, name: kworker/u5:1
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
...
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10187
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0xee/0x1340 kernel/locking/mutex.c:747
 hci_cmd_sync_submit+0x3f/0x340 net/bluetooth/hci_sync.c:699
 hci_cmd_sync_queue+0x79/0xa0 net/bluetooth/hci_sync.c:739
 hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2928
 hci_disconnect+0xc4/0x220 net/bluetooth/hci_conn.c:258
 hci_link_tx_to net/bluetooth/hci_core.c:3421 [inline]
 __check_timeout net/bluetooth/hci_core.c:3567 [inline]
 __check_timeout+0x331/0x4e0 net/bluetooth/hci_core.c:3547
 hci_sched_le net/bluetooth/hci_core.c:3750 [inline]
 hci_tx_work+0x818/0x1d30 net/bluetooth/hci_core.c:3828
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Use rcu_read_lock() to protect hci_conn_hash->list in hci_link_tx_to().
rcu_read_lock() will disable preempt when CONFIG_PREEMPT_RCU is enabled.
When it needs to abort connection, it will submit a command by
hci_cmd_sync_submit() which has some sleeping functions like mutex_lock()
and kmalloc(, GFP_KERNEL). That triggers the bug.

Convert cmd_sync_work_lock and unregister_lock to spin_lock type and
replace GFP_KERNEL with GFP_ATOMIC to fix the bug.

Fixes: 1857c19941c8 ("Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER")
Fixes: 6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")
Reported-by: syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/hci_core.c         |  4 ++--
 net/bluetooth/hci_sync.c         | 28 +++++++++++++++-------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e6359f7346f1..7a046a80a1ac 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -514,8 +514,8 @@ struct hci_dev {
 	struct work_struct	error_reset;
 	struct work_struct	cmd_sync_work;
 	struct list_head	cmd_sync_work_list;
-	struct mutex		cmd_sync_work_lock;
-	struct mutex		unregister_lock;
+	spinlock_t		cmd_sync_work_lock;
+	spinlock_t		unregister_lock;
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a5992f1b3c9b..c94bfde68228 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2716,9 +2716,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	mutex_lock(&hdev->unregister_lock);
+	spin_lock(&hdev->unregister_lock);
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
-	mutex_unlock(&hdev->unregister_lock);
+	spin_unlock(&hdev->unregister_lock);
 
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9b93653c6197..4356ee29cd5f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -286,13 +286,13 @@ static void hci_cmd_sync_work(struct work_struct *work)
 	while (1) {
 		struct hci_cmd_sync_work_entry *entry;
 
-		mutex_lock(&hdev->cmd_sync_work_lock);
+		spin_lock(&hdev->cmd_sync_work_lock);
 		entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
 						 struct hci_cmd_sync_work_entry,
 						 list);
 		if (entry)
 			list_del(&entry->list);
-		mutex_unlock(&hdev->cmd_sync_work_lock);
+		spin_unlock(&hdev->cmd_sync_work_lock);
 
 		if (!entry)
 			break;
@@ -629,8 +629,8 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
 	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
-	mutex_init(&hdev->cmd_sync_work_lock);
-	mutex_init(&hdev->unregister_lock);
+	spin_lock_init(&hdev->cmd_sync_work_lock);
+	spin_lock_init(&hdev->unregister_lock);
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
@@ -646,15 +646,17 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->cmd_sync_work);
 	cancel_work_sync(&hdev->reenable_adv_work);
 
-	mutex_lock(&hdev->cmd_sync_work_lock);
+	spin_lock(&hdev->cmd_sync_work_lock);
 	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
+		list_del(&entry->list);
+		spin_unlock(&hdev->cmd_sync_work_lock);
+
 		if (entry->destroy)
 			entry->destroy(hdev, entry->data, -ECANCELED);
-
-		list_del(&entry->list);
 		kfree(entry);
+		spin_lock(&hdev->cmd_sync_work_lock);
 	}
-	mutex_unlock(&hdev->cmd_sync_work_lock);
+	spin_unlock(&hdev->cmd_sync_work_lock);
 }
 
 void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
@@ -696,13 +698,13 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 	struct hci_cmd_sync_work_entry *entry;
 	int err = 0;
 
-	mutex_lock(&hdev->unregister_lock);
+	spin_lock(&hdev->unregister_lock);
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		err = -ENODEV;
 		goto unlock;
 	}
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry) {
 		err = -ENOMEM;
 		goto unlock;
@@ -711,14 +713,14 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 	entry->data = data;
 	entry->destroy = destroy;
 
-	mutex_lock(&hdev->cmd_sync_work_lock);
+	spin_lock(&hdev->cmd_sync_work_lock);
 	list_add_tail(&entry->list, &hdev->cmd_sync_work_list);
-	mutex_unlock(&hdev->cmd_sync_work_lock);
+	spin_unlock(&hdev->cmd_sync_work_lock);
 
 	queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
 
 unlock:
-	mutex_unlock(&hdev->unregister_lock);
+	spin_unlock(&hdev->unregister_lock);
 	return err;
 }
 EXPORT_SYMBOL(hci_cmd_sync_submit);
-- 
2.25.1

