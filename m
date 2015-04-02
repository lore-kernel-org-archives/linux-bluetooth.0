Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/5] Move HCI UART vendor specific setup to kernel
Date: Thu,  2 Apr 2015 16:37:31 +0200
Message-Id: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a proposal to move the vendor specific setup (firmware loading and
final speed setup) to the kernel.
This will allow vendor specific setup function to use the HCI protocols already
implemented in kernel.

This adds 2 new IOCTLs (HCIUARTSETDEVTYPE and HCIUARTSETBAUDRATE) to be able to
select vendor specific setup function and final baudrate to use.

User space application in charge of attaching Bluetooth UART device will have to
call them before changing the proto to use (HCIUARTSETPROTO).

UART baud rate setup needs to set tty_set_termios() publicly available
(partially reverting patch "tty: Remove external interface for tty_set_termios()"
from Peter Hurley 2015-01-25 SHA1 632f32e2107).

A first work is provided based on Broadcom chip integrated in Asus T100.

Future: A third IOCTL (HCIUARTLISTDEVTYPE) can be added to allow user space
application to list supported Bluetooth device types by kernel.

Frederic Danis (5):
  Bluetooth: hci_uart: Add HCIUARTSETDEVTYPE ioctl
  Bluetooth: hci_uart: Add BCM specific setup function
  Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
  tty: Re-add external interface for tty_set_termios()
  Bluetooth: hci_uart: Add BCM specific UART speed management

 drivers/bluetooth/Kconfig     |  10 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_bcm.c   | 351 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |  59 +++++++
 drivers/bluetooth/hci_uart.h  |  10 ++
 drivers/tty/tty_ioctl.c       |   3 +-
 include/linux/tty.h           |   1 +
 7 files changed, 434 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_bcm.c

-- 
1.9.1

