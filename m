Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C7BECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 11:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiIBL0Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiIBLZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 07:25:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8713D5703
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 04:23:54 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 282BNq0c089899;
        Fri, 2 Sep 2022 20:23:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 02 Sep 2022 20:23:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 282BNqBw089896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Sep 2022 20:23:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
Date:   Fri, 2 Sep 2022 20:23:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Schspa Shi <schspa@gmail.com>
References: <00000000000016512d05e76bd837@google.com>
Cc:     syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, jiangshanlai@gmail.com,
        tj@kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000016512d05e76bd837@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot is reporting attempt to schedule hdev->cmd_work work from system_wq
WQ into hdev->workqueue WQ which is under draining operation [1], for
commit c8efcc2589464ac7 ("workqueue: allow chained queueing during
destruction") does not allow such operation.

The check introduced by commit 877afadad2dce8aa ("Bluetooth: When HCI work
queue is drained, only queue chained work") was incomplete.

Use hdev->workqueue WQ when queuing hdev->{cmd,ncmd}_timer works because
hci_{cmd,ncmd}_timeout() calls queue_work(hdev->workqueue). Also, protect
the queuing operation with RCU read lock in order to avoid calling
queue_delayed_work() after cancel_delayed_work() completed.

Link: https://syzkaller.appspot.com/bug?extid=243b7d89777f90f7613b [1]
Reported-by: syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 877afadad2dce8aa ("Bluetooth: When HCI work queue is drained, only queue chained work")
---
This is a difficult to trigger race condition, and therefore reproducer is
not available. Please do logical check in addition to automated testing.

 net/bluetooth/hci_core.c  | 15 +++++++++++++--
 net/bluetooth/hci_event.c |  6 ++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3a5a3cc9372..9873d2e67988 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -597,6 +597,15 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 
 	/* Cancel these to avoid queueing non-chained pending work */
 	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	/* Wait for
+	 *
+	 *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+	 *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
+	 *
+	 * inside RCU section to see the flag or complete scheduling.
+	 */
+	synchronize_rcu();
+	/* Explicitly cancel works in case scheduled after setting the flag. */
 	cancel_delayed_work(&hdev->cmd_timer);
 	cancel_delayed_work(&hdev->ncmd_timer);
 
@@ -4056,12 +4065,14 @@ static void hci_cmd_work(struct work_struct *work)
 			if (res < 0)
 				__hci_cmd_sync_cancel(hdev, -res);
 
+			rcu_read_lock();
 			if (test_bit(HCI_RESET, &hdev->flags) ||
 			    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
 				cancel_delayed_work(&hdev->cmd_timer);
 			else
-				schedule_delayed_work(&hdev->cmd_timer,
-						      HCI_CMD_TIMEOUT);
+				queue_delayed_work(hdev->workqueue, &hdev->cmd_timer,
+						   HCI_CMD_TIMEOUT);
+			rcu_read_unlock();
 		} else {
 			skb_queue_head(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6643c9c20fa4..d6f0e6ca0e7e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3766,16 +3766,18 @@ static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
 {
 	cancel_delayed_work(&hdev->cmd_timer);
 
+	rcu_read_lock();
 	if (!test_bit(HCI_RESET, &hdev->flags)) {
 		if (ncmd) {
 			cancel_delayed_work(&hdev->ncmd_timer);
 			atomic_set(&hdev->cmd_cnt, 1);
 		} else {
 			if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
-				schedule_delayed_work(&hdev->ncmd_timer,
-						      HCI_NCMD_TIMEOUT);
+				queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer,
+						   HCI_NCMD_TIMEOUT);
 		}
 	}
+	rcu_read_unlock();
 }
 
 static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
-- 
2.18.4

