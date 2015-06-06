Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Memory leak in btusb
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55638D99.5000704@lwfinger.net>
Date: Sat, 6 Jun 2015 08:23:17 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>
Message-Id: <FEA49882-9F1E-463F-9253-AD9E6AF8A762@holtmann.org>
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
> 
> The source is from wireless-drivers-next.git with pulls from bluetooth-next.git and Torvalds mainline git repo that were done on May 25. The source includes commit 04b8c8143d46453a443ac32bfcd76ec952605765 with the subject "Bluetooth: btusb: fix Realtek suspend/resume".
> 
> The Bluetooth device in use is made by Intel with USB ID 8087:07dc.

actually if this is only this device causing it, this might fix it:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 94c6c048130f..e6815c678898 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1614,6 +1614,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
        }
        fw_ptr = fw->data;
 
+       kfree_skb(skb);
+
        /* This Intel specific command enables the manufacturer mode of the
         * controller.
         *

Totally untested, but it seems we forget to free that SKB and it would explain if you only see this on Intel Wilkens Peak and Stone Peak controllers.

Regards

Marcel

