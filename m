Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <55638D99.5000704@lwfinger.net>
Date: Mon, 25 May 2015 16:01:13 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
CC: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Subject: Memory leak in btusb
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

While using kmemleak to check for memory leaks in a wireless driver, I noticed 
the following stack traceback for a leak in btusb:

<ffffffff8160257e>] __alloc_skb+0x7e/0x2b0
[<ffffffffa06029d6>] btusb_recv_intr+0x136/0x180 [btusb]
[<ffffffffa0602ad8>] btusb_intr_complete+0xb8/0x150 [btusb]
[<ffffffff8156ccb2>] __usb_hcd_giveback_urb+0x72/0x120

To eliminate a false positive, I unloaded the driver and got the following for 
the virtual address:

[<ffffffff8160257e>] __alloc_skb+0x7e/0x2b0
[<ffffffffa06029d6>] 0xffffffffa06029d6
[<ffffffffa0602ad8>] 0xffffffffa0602ad8
[<ffffffff8156ccb2>] __usb_hcd_giveback_urb+0x72/0x120

The source is from wireless-drivers-next.git with pulls from bluetooth-next.git 
and Torvalds mainline git repo that were done on May 25. The source includes 
commit 04b8c8143d46453a443ac32bfcd76ec952605765 with the subject "Bluetooth: 
btusb: fix Realtek suspend/resume".

The Bluetooth device in use is made by Intel with USB ID 8087:07dc.

Thanks,

Larry
