Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Sep 2009 14:26:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org
Subject: Bluetooth is very ill in -next
Message-ID: <20090930142636.5366dafe@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Doing "sdptool search DUN" reliably crashes the kernel when using a USB
bluetooth dongle

Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100


is as far as it gets

It then explodes

_spin_lock_irqsave
?skb_dequeue
skb_dequeue
skb_queue_purge
l2cap_recv_frame
?__lock_acquire
?__usb_hcd_submit_urb
?__lock_acquire
l2cap_recv_acldata
hci_rx_task
?l2cap_recv_acldata
tasklet_action

reliably.

Alan
