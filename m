Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 00/16] hci_ldisc hci_uart_tty_close() fixes
Date: Tue, 28 Mar 2017 18:50:13 +0100
Message-ID: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This is RFC patchset V1 which reorganises hci_uart_tty_close() to overcome a
design flaw. I would like some comments on the changes.

Design Flaw
===========

An example callstack is as follows

Have Bluetooth running using a BCSP based UART Bluetooth Radio Module.

Now kill the userland hciattach program by doing
killall hciattach

When hciattach terminates, it calls ioctl TIOCSETD to run:

tty_set_ldisc() takes a tty ref lock via tty_ldisc_lock
tty_ldisc_close()
hci_uart_tty_close()
hci_unregister_dev()
hci_dev_do_close()
__hci_req_sync() which tries to send a HCI RESET command which depends on
HCI_QUIRK_RESET_ON_CLOSE being enabled and that is the default condition.

The design flaw is that in order to send a HCI RESET command the BCSP Data Link
protocol layer must be able to send and receive BCSP frames from the UART port
that is physically connected to the BCSP based UART Bluetooth Radio Module. If
this data "pipe" is broken then BCSP will attempt to retransmit every 250ms
until the BCSP layer is closed. In addition, the HCI RESET command has a 2
second timeout which will block __hci_req_sync() for 2 seconds. Enabling
BT_DBG() shows BCSP attempting to retransmit during hci_uart_tty_close().

Meanwhile, tty_set_ldisc() has a tty ref lock which prevents flush_to_ldisc()
from passing the UART port data to the BCSP layer causing a loss of RX BCSP
frames. Similarly, the hci_uart_tty_wakeup() no longer runs. These commits do
not fix this tty ref lock issue.

This patchset removes hci_ldisc.c hci_uart_tty_close() breakages that prevent
__hci_req_sync() from being successful. There are also race conditions due to
the BCSP timeout handling being asynchronous to the thread running
hci_uart_tty_close() which can cause kernel crashes in particular when BCSP is
already retransmitting due to broken communications. Therefore, disabling
the sending of the HCI RESET command does not prevent some of the races.

Solution
========

Reorganise hci_uart_tty_close() so that hci_unregister_dev() can run with no
interference to the data pipe between the Data Link protocol layer such as BCSP
and the UART driver.

The patchset cleans up the HCI_UART_REGISTERED and HCI_UART_PROTO_READY flag
handling so that:
a) hdev is only valid when HCI_UART_REGISTERED is in the set state.
b) the proto Data Link functions pointers can only be used when
   HCI_UART_PROTO_READY is in the set state.

Note that flushing can corrupt any data being sent from BCSP to the UART driver
which is undesirable.

The most important patch is
"Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races"
which adds rwlocking around the clearing of the flag HCI_UART_PROTO_READY.
This is because the atomic flag HCI_UART_PROTO_READY cannot always prevent a
thread using a Data Link protocol layer function pointer during or after closure
of the Data Link protocol layer. This can result in a kernel crash. Remember
that the BCSP retransmission handling runs in a separate thread and tries to
send a new frame. Therefore there is a small window of a race condition for the
flag HCI_UART_PROTO_READY to be seen in the set state and then calls the
proto function pointer after the Data Link protocol layer has been closed,
resulting in a kernel crash.

Next steps
==========

I am still testing these changes but I would like some feedback on the proposed
changes.

I will reply to any feedback next week.

Thanks.


Dean Jenkins (16):
  Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
  Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
  Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
  Bluetooth: hci_ldisc: Add HCI RESET comment to hci_unregister_dev()
    call
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
  Bluetooth: hci_ldisc: Separate flag handling in hci_uart_tty_close()
  Bluetooth: hci_ldisc: Tidy-up HCI_UART_REGISTERED in
    hci_uart_tty_close()
  Bluetooth: hci_ldisc: hci_uart_tty_close() detach tty after last msg
  Bluetooth: hci_ldisc: hci_uart_tty_close() move hci_uart_close()
  Bluetooth: hci_ldisc: hci_uart_tty_close() move cancel_work_sync()
  Bluetooth: hci_ldisc: hci_uart_tty_close() free hu->tx_skb
  Bluetooth: hci_ldisc: Simplify flushing
  Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races
  Bluetooth: hci_ldisc: Add ioctl_mutex avoiding concurrency

 drivers/bluetooth/hci_ldisc.c | 105 ++++++++++++++++++++++++++++++++----------
 drivers/bluetooth/hci_uart.h  |   3 ++
 2 files changed, 84 insertions(+), 24 deletions(-)

-- 
2.7.4
