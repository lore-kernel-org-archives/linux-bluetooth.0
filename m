Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/3] Bluetooth: Fix hci-uart-h4 crash from incoming uart
 packet
Date: Tue, 02 Apr 2013 21:24:21 +0900
Message-id: <1364905463-1752-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds check HCI_UART_REGISTERED before reading uart data for
hci uart h4 driver. Uart data could be arrived when inside the
hci_uart_tty_ioctl function after calling test_and_set_bit for
HCI_UART_PROTO_SET but before the hci_uart_set_proto function has
returned.

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
 drivers/bluetooth/hci_h4.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index c60623f..8ae9f1e 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -153,6 +153,9 @@ static int h4_recv(struct hci_uart *hu, void *data, int count)
 {
 	int ret;
 
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
 	ret = hci_recv_stream_fragment(hu->hdev, data, count);
 	if (ret < 0) {
 		BT_ERR("Frame Reassembly Failed");
-- 
1.7.10.4

