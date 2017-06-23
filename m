Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: QCA ROME (btqca) driver issues? bt stack issues? kernel HID
 output points to bt device latency issues...
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <69492e80-3da0-db04-b41c-2f601ba2f48e@varnernet.com>
Date: Fri, 23 Jun 2017 10:48:57 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A512C492-7675-493B-942D-B9C3C69DAB82@holtmann.org>
References: <69492e80-3da0-db04-b41c-2f601ba2f48e@varnernet.com>
To: Bryan Varner <bryan@varnernet.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bryan,

> Over the last few days with a new laptop, I've been having many issues with the on-board bt.
> 
> * My bt keyboard begins to repeat keys randomly.
> * Mouse behavior is completely erratic, and connections don't last more than a couple minutes.
> 
> I've had an HID driver dev look at kernel output logs of HID data. It appears packets relating to key-ups from the keyboard and other mouse data has huge latency issues. The kernel is receiving key-down events and sometimes there is a pause of several hundred or thousand ms before the keyup event comes in to the HID drivers. This happens even if I'm just typing normally (believe me, I'm not holding the keys down when this happens). Regarding the mouse, it looks like the mouse is also dropping events, and then the mouse forces an L2CAP disconnect and renegotiation (according to btmon dumps).
> 
> Wireless network (802.11 -- also on this Dell branded ROME based card) seems to be rock-steady.
> 
> 
> I'm running a locally built kernel 4.11.6 SMP  with bluez 5.43-2 (debian 9 package).
> 
> # dmesg | grep 'qca'
> [    3.546077] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [    3.561669] ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1028:0310
> [    3.575096] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> 
> 
> 
> 
> In order to isolate the issue a bit, I've plugged in an old bt host adapter I had laying around that I knew worked well on other machines.
> The same keyboard and mouse are working perfectly with it (and have in the past). The btmon output from this older host adapter looks quite different from the output I get from the qca device. The mouse sends a steady stream of mode change events when not sending actual data, they keyboard behaves properly, and I've yet to loose a mouse connection.
> 
> I'd love to get the onboard BT working better, because I hate carrying around dongles.
> What can I do to help?

send around btmon -w trace.log so that we can see what is going on there.

Regards

Marcel

