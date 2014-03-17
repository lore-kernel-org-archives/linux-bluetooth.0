Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 17 Mar 2014 11:26:14 -0400
Message-ID: <CAN44aq3oaNextuhg-reSzXWdFq+CuKUc+EeqQN1TaNebhz9WAQ@mail.gmail.com>
Subject: kernel 3.10.32 and rfcomm kernel oops bug status
From: Alex Gal <a.gal@motsai.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I have encountered a kernel panic triggered by a client(phone) rfcomm
deconnection on my embedded board.

Kernel version: 3.10.32

The kernel oops log:
http://pastebin.com/7kENvaVS

The revelant message:
[<c0008f58>] (__dabt_svc+0x38/0x60) from [<c00977b0>]
(__kmalloc_track_caller+0x6c/0x13c)
[<c00977b0>] (__kmalloc_track_caller+0x6c/0x13c) from [<c03b6e18>]
(__kmalloc_reserve.isra.21+0x24/0x70)
[<c03b6e18>] (__kmalloc_reserve.isra.21+0x24/0x70) from [<c03b6ec4>]
(__alloc_skb+0x60/0x144)
[<c03b6ec4>] (__alloc_skb+0x60/0x144) from [<c04bd7a8>] (mgmt_event+0x2c/0xcc)
[<c04bd7a8>] (mgmt_event+0x2c/0xcc) from [<c04c42e8>]
(mgmt_discovering+0x5c/0xec)
[<c04c42e8>] (mgmt_discovering+0x5c/0xec) from [<c04b13f8>]
(hci_discovery_set_state+0x4c/0x50)
[<c04b13f8>] (hci_discovery_set_state+0x4c/0x50) from [<c04bac28>]
(hci_cmd_complete_evt+0x1748/0x17f0)
[<c04bac28>] (hci_cmd_complete_evt+0x1748/0x17f0) from [<c04bbe74>]
(hci_event_packet+0x10ac/0x2864)
[<c04bbe74>] (hci_event_packet+0x10ac/0x2864) from [<c04b0b58>]
(hci_rx_work+0x200/0x25c)
[<c04b0b58>] (hci_rx_work+0x200/0x25c) from [<c002c804>]
(process_one_work+0x124/0x384)

I looked at posts on this mailing list and it seems there were some
patches from Gianluca to fix this issue:

[PATCH v5 0/6] rfcomm: Implement rfcomm as a proper tty_port
to
[PATCH v5 6/6] rfcomm: Purge the dlc->tx_queue to avoid circular dependency

and

[PATCH v3 1/4] rfcomm: release the port when the last user closes the tty
to
[PATCH v3 4/4] rfcomm: remove rfcomm_carrier_raised()

Would these patches be sufficient for my 3.10 kernel branch ?

Thank you,

Alex
