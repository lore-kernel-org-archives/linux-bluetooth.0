Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Subject: [[RFC] PATCH V1 0/3] Minor code improvements for HCI UART LDISC
Date: Sun, 29 Jan 2017 21:59:32 +0100
Message-ID: <1485723575-12340-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Please note that these 3 patches have not been formally tested. This is
partly due to not having Bluetooth hardware that will excercise the call to
hci_uart_init_work().

I have released the patches as [RFC] as the changes may need discussion.
I think the changes are trivial and safe.

The motivation for making these minor changes now is that
hci_uart_tty_close() can be reworked in future to simplify it. This means:

1) hu->hdev needs to be correctly set to NULL when the HCI device fails to
   be registered.

2) HCI_UART_REGISTERED needs to be clear when the HCI UART fails to be
   registered.

3) HCI_UART_PROTO_READY needs to be clear just before the Data Link
   Protocol layer is closed.

As these changes are untested there is a risk of potential side-effects but
the changes only make a difference when the HCI device fails to be
registered which should be rare.

The patches were ported to the master branch of bluetooth-next.git

Dean Jenkins (3):
  Bluetooth: Add missing return in hci_uart_init_work()
  Bluetooth: Ensure hu->hdev set to NULL before freeing hdev
  Bluetooth: Add missing clear HCI_UART_PROTO_READY

 drivers/bluetooth/hci_ldisc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.7.4
