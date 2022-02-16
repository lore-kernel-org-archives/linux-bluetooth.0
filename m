Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F251C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 04:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbiBPEhj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:37:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbiBPEhf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 23:37:35 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9780AF4063
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 20:37:22 -0800 (PST)
Received: from localhost.localdomain (unknown [222.205.15.208])
        by mail-app2 (Coremail) with SMTP id by_KCgCXnop+fwxibTzsAQ--.39156S4;
        Wed, 16 Feb 2022 12:37:19 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, linux-bluetooth@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] Bluetooth: fix data races in smp_unregister(), smp_del_chan()
Date:   Wed, 16 Feb 2022 12:37:14 +0800
Message-Id: <20220216043714.22011-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgCXnop+fwxibTzsAQ--.39156S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4fGF17KFWUCw4fCr17Jrb_yoWrZFykpF
        Z0kFyxCr4kXrWUXw47A3WxAFykWFZrZ3W8GFW8Jw1UGw45Kr1UJrWIyryjq3W7CrWUAa4j
        v3Wqyrs2qryDAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Previous commit e04480920d1e ("Bluetooth: defer cleanup of resources
in hci_unregister_dev()") defers all destructive actions to
hci_release_dev() to prevent cocurrent problems like NPD, UAF.

However, there are still some exceptions that are ignored.

The smp_unregister() in hci_dev_close_sync() (previously in
hci_dev_do_close) will release resources like the sensitive channel
and the smp_dev objects. Consider the situations the device is detaching
or power down while the kernel is still operating on it, the following
data race could take place.

thread-A  hci_dev_close_sync  | thread-B  read_local_oob_ext_data
                              |
hci_dev_unlock()              |
...                           | hci_dev_lock()
if (hdev->smp_data)           |
  chan = hdev->smp_data       |
                              | chan = hdev->smp_data (3)
                              |
  hdev->smp_data = NULL (1)   | if (!chan || !chan->data) (4)
  ...                         |
  smp = chan->data            | smp = chan->data
  if (smp)                    |
    chan->data = NULL (2)     |
    ...                       |
    kfree_sensitive(smp)      |
                              | // dereference smp trigger UFA

That is, the objects hdev->smp_data and chan->data both suffer from the
data races. In a preempt-enable kernel, the above schedule (when (3) is
before (1) and (4) is before (2)) leads to UAF bugs. It can be
reproduced in the latest kernel and below is part of the report:

[   49.097146] ================================================================
[   49.097611] BUG: KASAN: use-after-free in smp_generate_oob+0x2dd/0x570
[   49.097611] Read of size 8 at addr ffff888006528360 by task generate_oob/155
[   49.097611]
[   49.097611] Call Trace:
[   49.097611]  <TASK>
[   49.097611]  dump_stack_lvl+0x34/0x44
[   49.097611]  print_address_description.constprop.0+0x1f/0x150
[   49.097611]  ? smp_generate_oob+0x2dd/0x570
[   49.097611]  ? smp_generate_oob+0x2dd/0x570
[   49.097611]  kasan_report.cold+0x7f/0x11b
[   49.097611]  ? smp_generate_oob+0x2dd/0x570
[   49.097611]  smp_generate_oob+0x2dd/0x570
[   49.097611]  read_local_oob_ext_data+0x689/0xc30
[   49.097611]  ? hci_event_packet+0xc80/0xc80
[   49.097611]  ? sysvec_apic_timer_interrupt+0x9b/0xc0
[   49.097611]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   49.097611]  ? mgmt_init_hdev+0x1c/0x240
[   49.097611]  ? mgmt_init_hdev+0x28/0x240
[   49.097611]  hci_sock_sendmsg+0x1880/0x1e70
[   49.097611]  ? create_monitor_event+0x890/0x890
[   49.097611]  ? create_monitor_event+0x890/0x890
[   49.097611]  sock_sendmsg+0xdf/0x110
[   49.097611]  __sys_sendto+0x19e/0x270
[   49.097611]  ? __ia32_sys_getpeername+0xa0/0xa0
[   49.097611]  ? kernel_fpu_begin_mask+0x1c0/0x1c0
[   49.097611]  __x64_sys_sendto+0xd8/0x1b0
[   49.097611]  ? syscall_exit_to_user_mode+0x1d/0x40
[   49.097611]  do_syscall_64+0x3b/0x90
[   49.097611]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   49.097611] RIP: 0033:0x7f5a59f51f64
...
[   49.097611] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5a59f51f64
[   49.097611] RDX: 0000000000000007 RSI: 00007f5a59d6ac70 RDI: 0000000000000006
[   49.097611] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   49.097611] R10: 0000000000000040 R11: 0000000000000246 R12: 00007ffec26916ee
[   49.097611] R13: 00007ffec26916ef R14: 00007f5a59d6afc0 R15: 00007f5a59d6b700

To solve these data races, this patch places the smp_unregister()
function in the protected area by the hci_dev_lock(). That is, the
smp_unregister() function can not be concurrently executed when
operating functions (most of them are mgmt operations in mgmt.c) hold
the device lock.

This patch is tested with kernel LOCK DEBUGGING enabled. The price from
the extended holding time of the device lock is supposed to be low as the
smp_unregister() function is fairly short and efficient.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0feb68f12545..e34fc15b7d2c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4106,9 +4106,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	hci_inquiry_cache_flush(hdev);
 	hci_pend_le_actions_clear(hdev);
 	hci_conn_hash_flush(hdev);
-	hci_dev_unlock(hdev);
-
+	/* Prevent data races on hdev->smp_data or hdev->smp_bredr_data */
 	smp_unregister(hdev);
+	hci_dev_unlock(hdev);
 
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
-- 
2.33.1

