Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix crash with incoming uart packet
Date: Fri, 22 Mar 2013 22:44:13 +0900
Message-id: <1363959853-21666-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds check HCI_UART_REGISTERED before reading uart packet because
BT uart data could be read before hci_uart is registered.

Backtrace:
[<c05f27ec>] (hci_recv_stream_fragment+0x0/0x74) from [<c04126f4>] (h4_recv+0x18/0x40)
 r7:eb1d4d1c r6:eb7683b0 r5:eae8e800 r4:0000000c
[<c04126dc>] (h4_recv+0x0/0x40) from [<c0411870>] (hci_uart_tty_receive+0x6c/0x94)
 r5:eae8e800 r4:eb768380
[<c0411804>] (hci_uart_tty_receive+0x0/0x94) from [<c027be88>] (flush_to_ldisc+0x16c/0x17c)
 r6:eae8e8d8 r5:eae8e800 r4:eae8e8c8
[<c027bd1c>] (flush_to_ldisc+0x0/0x17c) from [<c0050ae8>] (process_one_work+0x144/0x4d4)
[<c00509a4>] (process_one_work+0x0/0x4d4) from [<c0051208>] (worker_thread+0x180/0x370)
[<c0051088>] (worker_thread+0x0/0x370) from [<c005617c>] (kthread+0x90/0x9c)
[<c00560ec>] (kthread+0x0/0x9c) from [<c003a3a0>] (do_exit+0x0/0x7ec)

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/hci_ldisc.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ed0fade..476a307 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -386,6 +386,9 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *f
 	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
 		return;
 
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return;
+
 	spin_lock(&hu->rx_lock);
 	hu->proto->recv(hu, (void *) data, count);
 	hu->hdev->stat.byte_rx += count;
-- 
1.7.10.4

