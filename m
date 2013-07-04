Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	"Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: autosuspend issues with the Intel Bluetooth device [8087:07dc]
References: <Pine.LNX.4.44L0.1307031032540.1241-100000@iolanthe.rowland.org>
Date: Thu, 04 Jul 2013 09:15:18 +0200
In-Reply-To: <Pine.LNX.4.44L0.1307031032540.1241-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Wed, 3 Jul 2013 10:36:40 -0400 (EDT)")
Message-ID: <87mwq2lrsp.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> The relative order of those two completions doesn't mean anything,
> because they are on different endpoints and they happened during the
> same frame.  It just happens that uhci-hcd scans interrupt URBs before
> bulk URBs when looking for completions, but it could easily be the 
> other way around.

Thanks.  I should know that. Sorry for the confusion...

> It may be that the device simply takes longer to resume than it should.  
> Or longer than btusb expects it to, which may not be the same thing.

Yes, that is what it looks like.  But the URBs are submitted as part of
the resume callback.  Shouldn't the device be alive and kicking when
this is called?  At least from the USB point of view, which is all the
driver can possibly know anything about? Is the problem that the
firmware finishes the USB resume before actually being ready to respond
to the HCI command?


I'm including an usbmon dump of this sequence below:

Jul  4 09:03:54 nemi kernel: [13047.695364] btusb_send_frame:716: hci1
Jul  4 09:03:54 nemi kernel: [13047.697048] uhci_hcd 0000:00:1d.1: setting latency timer to 64
Jul  4 09:03:55 nemi kernel: [13047.771270] btusb_resume:1560: intf ffff880230fb5800
Jul  4 09:03:55 nemi kernel: [13047.771284] btusb_resume:1560: intf ffff880230dc2800
Jul  4 09:03:55 nemi kernel: [13047.771293] btusb_submit_intr_urb:322: hci1
Jul  4 09:03:55 nemi kernel: [13047.771331] btusb_submit_bulk_urb:410: hci1
Jul  4 09:03:55 nemi kernel: [13047.771392] btusb_submit_bulk_urb:410: hci1
Jul  4 09:03:55 nemi kernel: [13047.772229] btusb_tx_complete:574: hci1 urb ffff88021ace62c0 status 0 count 3
Jul  4 09:03:55 nemi kernel: [13047.773232] btusb_intr_complete:281: hci1 urb ffff88020c40f380 status 0 count 6
Jul  4 09:03:57 nemi kernel: [13049.808289] btusb_suspend:1516: intf ffff880230dc2800
Jul  4 09:03:57 nemi kernel: [13049.810384] btusb_intr_complete:281: hci1 urb ffff88020c40f380 status -2 count 0
Jul  4 09:03:57 nemi kernel: [13049.811353] btusb_bulk_complete:369: hci1 urb ffff88020c40f140 status -2 count 0
Jul  4 09:03:57 nemi kernel: [13049.812348] btusb_bulk_complete:369: hci1 urb ffff88020c40f680 status -2 count 0
Jul  4 09:03:57 nemi kernel: [13049.812599] btusb_suspend:1516: intf ffff880230fb5800


nemi:/tmp# cat /sys/kernel/debug/usb/usbmon/7t 
ffff88020c40f380 3674990429 S Ci:001:00 s a3 00 0000 0001 0004 4 <
ffff88020c40f380 3674990490 C Ci:001:00 0 4 = 07010000
ffff88020c40f380 3674990546 S Ci:001:00 s a3 00 0000 0002 0004 4 <
ffff88020c40f380 3674990567 C Ci:001:00 0 4 = 00010000
ffff8802300c1680 3674990585 S Ii:001:01 -115 2 <
ffff88020c40f380 3674990669 S Ci:001:00 s a3 00 0000 0001 0004 4 <
ffff88020c40f380 3674990690 C Ci:001:00 0 4 = 07010000
ffff88020c40f380 3674990731 S Co:001:00 s 23 01 0002 0001 0000 0
ffff88020c40f380 3674990753 C Co:001:00 0 0
ffff88020c40f380 3675022455 S Ci:001:00 s a3 00 0000 0001 0004 4 <
ffff88020c40f380 3675022508 C Ci:001:00 0 4 = 03010400
ffff88020c40f380 3675038376 S Co:001:00 s 23 01 0012 0001 0000 0
ffff88020c40f380 3675038408 C Co:001:00 0 0
ffff88020c40f380 3675038457 S Ci:002:00 s 80 00 0000 0000 0002 2 <
ffff88020c40f380 3675040416 C Ci:002:00 0 2 = 0300
ffff88020c40f380 3675040496 S Co:002:00 s 00 01 0001 0000 0000 0
ffff88020c40f380 3675041362 C Co:002:00 0 0
ffff88020c40f380 3675041465 S Ii:002:01 -115 64 <
ffff88020c40f680 3675041501 S Bi:002:02 -115 1028 <
ffff88020c40f140 3675041561 S Bi:002:02 -115 1028 <
ffff88021ace62c0 3675041611 S Co:002:00 s 20 00 0000 0000 0003 3 = 011000
ffff88022228d140 3675041721 S Co:002:00 s 01 0b 0000 0001 0000 0
ffff88021ace62c0 3675042361 C Co:002:00 0 3 >
ffff88022228d140 3675042409 C Co:002:00 0 0
ffff88020c40f380 3675043359 C Ii:002:01 0 6 = 0f040101 010b
ffff88020c40f380 3675043429 S Ii:002:01 -115 64 <
ffff88020c40f380 3677080502 C Ii:002:01 -2 0
ffff88020c40f380 3677080554 S Ii:002:01 -115 64 <
ffff88020c40f380 3677080574 E Ii:002:01 -1 0
ffff88020c40f140 3677081484 C Bi:002:02 -2 0
ffff88020c40f140 3677081522 S Bi:002:02 -115 1028 <
ffff88020c40f140 3677081541 E Bi:002:02 -1 0
ffff88020c40f680 3677082485 C Bi:002:02 -2 0
ffff88020c40f680 3677082515 S Bi:002:02 -115 1028 <
ffff88020c40f680 3677082534 E Bi:002:02 -1 0
ffff88020c40f680 3677082804 S Co:002:00 s 00 03 0001 0000 0000 0
ffff88020c40f680 3677083460 C Co:002:00 0 0
ffff88020c40f680 3677084334 S Co:001:00 s 23 03 0002 0001 0000 0
ffff88020c40f680 3677084357 C Co:001:00 0 0
ffff8802300c1680 3677098476 C Ii:001:01 -2 0



So the 6 bytes returned in this case are "0f040101 010b".  I assume
anyone familiar with HCI commands will immediately understand what that
means?


For reference, the 14 expected bytes are:

ffff88020c40f200 88163963 S Co:002:00 s 20 00 0000 0000 0003 3 = 011000
ffff88020c752980 88165215 C Ii:002:01 0 14 = 0e0c0101 10000600 05060200 0005
ffff88020c752980 88165281 S Ii:002:01 -115 64 <
ffff88020c40f200 88165327 C Co:002:00 0 3 >


Bjørn
