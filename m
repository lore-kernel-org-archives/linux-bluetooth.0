Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.de>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	"Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: autosuspend issues with the Intel Bluetooth device [8087:07dc]
References: <87obajn8wv.fsf@nemi.mork.no> <2178464.gnEadSyMSQ@linux-5eaq.site>
	<877gh7n6nn.fsf@nemi.mork.no>
Date: Wed, 03 Jul 2013 15:53:42 +0200
In-Reply-To: <877gh7n6nn.fsf@nemi.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Wed, 03
	Jul 2013 14:56:44 +0200")
Message-ID: <8738rvn40p.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bjørn Mork <bjorn@mork.no> writes:

> Ah, this is probably a timing issue. 

It definitely is, and I believe it is a generic problem with the btusb
driver and not with this particular device.  That's just where I was
"lucky" enough to see it.

Enabling a bit of debugging in btusb, I see this for a hci version
command with wakeup actually working:


Jul  3 15:47:44 nemi kernel: [ 8864.982520] btusb_send_frame:716: hci1
Jul  3 15:47:44 nemi kernel: [ 8864.984197] uhci_hcd 0000:00:1d.1: setting latency timer to 64
Jul  3 15:47:44 nemi kernel: [ 8865.059400] btusb_resume:1560: intf ffff880230fb5800
Jul  3 15:47:44 nemi kernel: [ 8865.059414] btusb_resume:1560: intf ffff880230dc2800
Jul  3 15:47:44 nemi kernel: [ 8865.059423] btusb_submit_intr_urb:322: hci1
Jul  3 15:47:44 nemi kernel: [ 8865.059462] btusb_submit_bulk_urb:410: hci1
Jul  3 15:47:44 nemi kernel: [ 8865.059510] btusb_submit_bulk_urb:410: hci1
Jul  3 15:47:44 nemi kernel: [ 8865.060262] btusb_tx_complete:574: hci1 urb ffff88021f778540 status 0 count 3
Jul  3 15:47:44 nemi kernel: [ 8865.061266] btusb_intr_complete:281: hci1 urb ffff88021f778900 status 0 count 14
Jul  3 15:47:46 nemi kernel: [ 8867.060121] btusb_suspend:1516: intf ffff880230dc2800
Jul  3 15:47:46 nemi kernel: [ 8867.061333] btusb_intr_complete:281: hci1 urb ffff88021f778900 status -2 count 0
Jul  3 15:47:46 nemi kernel: [ 8867.062307] btusb_bulk_complete:369: hci1 urb ffff88021f7780c0 status -2 count 0
Jul  3 15:47:46 nemi kernel: [ 8867.068305] btusb_bulk_complete:369: hci1 urb ffff88021f7783c0 status -2 count 0
Jul  3 15:47:46 nemi kernel: [ 8867.068373] btusb_suspend:1516: intf ffff880230fb5800


and then repeating the exact same and seeing a failing one:

Jul  3 15:47:58 nemi kernel: [ 8878.765249] btusb_send_frame:716: hci1
Jul  3 15:47:58 nemi kernel: [ 8878.766855] uhci_hcd 0000:00:1d.1: setting latency timer to 64
Jul  3 15:47:58 nemi kernel: [ 8878.839639] btusb_resume:1560: intf ffff880230fb5800
Jul  3 15:47:58 nemi kernel: [ 8878.839654] btusb_resume:1560: intf ffff880230dc2800
Jul  3 15:47:58 nemi kernel: [ 8878.839663] btusb_submit_intr_urb:322: hci1
Jul  3 15:47:58 nemi kernel: [ 8878.839707] btusb_submit_bulk_urb:410: hci1
Jul  3 15:47:58 nemi kernel: [ 8878.839756] btusb_submit_bulk_urb:410: hci1
Jul  3 15:47:58 nemi kernel: [ 8878.840318] btusb_intr_complete:281: hci1 urb ffff88021f778300 status 0 count 6
Jul  3 15:47:58 nemi kernel: [ 8878.840397] btusb_tx_complete:574: hci1 urb ffff88021f7783c0 status 0 count 3
Jul  3 15:48:00 nemi kernel: [ 8880.840253] btusb_suspend:1516: intf ffff880230dc2800
Jul  3 15:48:00 nemi kernel: [ 8880.842343] btusb_intr_complete:281: hci1 urb ffff88021f778300 status -2 count 0
Jul  3 15:48:00 nemi kernel: [ 8880.843562] btusb_bulk_complete:369: hci1 urb ffff88021f778cc0 status -2 count 0
Jul  3 15:48:00 nemi kernel: [ 8880.844326] btusb_bulk_complete:369: hci1 urb ffff88021f778c00 status -2 count 0
Jul  3 15:48:00 nemi kernel: [ 8880.844705] btusb_suspend:1516: intf ffff880230fb5800


Notice how the interrupt completion runs before the tx completion in the
failing case?  I believe you have the problem right there...



Bjørn
