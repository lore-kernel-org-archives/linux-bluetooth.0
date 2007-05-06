Return-Path: <ohad@bencohen.org>
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 2.6.21] Bluetooth: fix unintentional fall-through in hci line discipline
MIME-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 6 May 2007 15:04:00 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705061504.00541.ohad@bencohen.org>
List-ID: <bluez-devel.lists.sourceforge.net>

From: Ohad Ben-Cohen <ohad@bencohen.org>

A trivial fix to (what looks like) an unintentional fall-through in hci line discipline.

Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>
---
Hi Marcel, patch should be applied third after previous two patches to hci_ldisc.c
(first patch is "add  HCIUARTGETDEVICE", second patch is "fix NULL pointer dereference").
Thanks, Ohad.

 drivers/bluetooth/hci_ldisc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 4a59a33..1e7ad6b 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -474,6 +474,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
 			tty->low_latency = 1;
 		} else
 			return -EBUSY;
+		break;
 
 	case HCIUARTGETPROTO:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-- 
1.5.0.6
