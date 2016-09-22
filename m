Return-Path: <labbott@redhat.com>
From: Laura Abbott <labbott@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>
Subject: [PATCH] Bluetooth: btwilink: Save the packet type before sending
Date: Thu, 22 Sep 2016 11:20:42 -0700
Message-Id: <1474568442-4810-1-git-send-email-labbott@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Running with KASAN produces some messages:

BUG: KASAN: use-after-free in ti_st_send_frame+0x9c/0x16c at addr
ffffffc064868fe8
Read of size 1 by task kworker/u17:1/1266

<KASAN output trimmed>

Hardware name: HiKey Development Board (DT)
Workqueue: hci0 hci_cmd_work
Call trace:
[<ffffffc00008c00c>] dump_backtrace+0x0/0x178
[<ffffffc00008c1a4>] show_stack+0x20/0x28
[<ffffffc00067da38>] dump_stack+0xa8/0xe0
[<ffffffc000288430>] print_trailer+0x110/0x174
[<ffffffc00028aedc>] object_err+0x4c/0x5c
[<ffffffc00028f714>] kasan_report_error+0x254/0x54c
[<ffffffc00028fa70>] kasan_report+0x64/0x70
[<ffffffc00028eb8c>] __asan_load1+0x4c/0x54
[<ffffffc000b59b24>] ti_st_send_frame+0x9c/0x16c
[<ffffffc000ee8dcc>] hci_send_frame+0xb4/0x118
[<ffffffc000ee8efc>] hci_cmd_work+0xcc/0x154
[<ffffffc0000f6c48>] process_one_work+0x26c/0x7a4
[<ffffffc0000f721c>] worker_thread+0x9c/0x73c
[<ffffffc000100250>] kthread+0x138/0x154
[<ffffffc000085c50>] ret_from_fork+0x10/0x40

The packet is being accessed for statistics after it has been freed.
Save the packet type before sending for statistics afterwards.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Originally found and tested on 4.4 based branch.
---
 drivers/bluetooth/btwilink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 485281b..ef51c9c 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -245,6 +245,7 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct ti_st *hst;
 	long len;
+	int pkt_type;
 
 	hst = hci_get_drvdata(hdev);
 
@@ -258,6 +259,7 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	 * Freeing skb memory is taken care in shared transport layer,
 	 * so don't free skb memory here.
 	 */
+	pkt_type = hci_skb_pkt_type(skb);
 	len = hst->st_write(skb);
 	if (len < 0) {
 		kfree_skb(skb);
@@ -268,7 +270,7 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	/* ST accepted our skb. So, Go ahead and do rest */
 	hdev->stat.byte_tx += len;
-	ti_st_tx_complete(hst, hci_skb_pkt_type(skb));
+	ti_st_tx_complete(hst, pkt_type);
 
 	return 0;
 }
-- 
2.7.4
