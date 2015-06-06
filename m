Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Memory leak in btusb
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55638D99.5000704@lwfinger.net>
Date: Sat, 6 Jun 2015 18:37:41 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>
Message-Id: <CF543FED-6CEE-4821-A0E1-9EC751026C24@holtmann.org>
References: <55638D99.5000704@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

> While using kmemleak to check for memory leaks in a wireless driver, I noticed the following stack traceback for a leak in btusb:
> 
> <ffffffff8160257e>] __alloc_skb+0x7e/0x2b0
> [<ffffffffa06029d6>] btusb_recv_intr+0x136/0x180 [btusb]
> [<ffffffffa0602ad8>] btusb_intr_complete+0xb8/0x150 [btusb]
> [<ffffffff8156ccb2>] __usb_hcd_giveback_urb+0x72/0x120
> 
> To eliminate a false positive, I unloaded the driver and got the following for the virtual address:
> 
> [<ffffffff8160257e>] __alloc_skb+0x7e/0x2b0
> [<ffffffffa06029d6>] 0xffffffffa06029d6
> [<ffffffffa0602ad8>] 0xffffffffa0602ad8
> [<ffffffff8156ccb2>] __usb_hcd_giveback_urb+0x72/0x120

if this is really an alloc_skb from btusb_recv_intr, then it is the HCI event reassembly handling. Meaning this is data->evt_skb since that is the only one that is ever allocated there.

All the SKBs allocated in that function are consumed by the core or later on freed by btusb_free_frags. Is this some rare case on suspend/resume where we forget to free the frags when we get disconnected and re-enumerate via probe?

When the core consumes this SKB via hci_recv_frame it really consumes it. If for some reason this function returns an error, it still frees the SKB. So for all intense in purposes it could be even void.

So I need some more info on what is causing this memory leak. The one in the Intel setup routine was obvious. If that does not fix it, then this is not obvious. You might need to check which alloc_skb this really is. As I said, if it is the one in btusb_recv_intr, then it is the data->evt_skb that is leaking in some corner case.

Regards

Marcel

