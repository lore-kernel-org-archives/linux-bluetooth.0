Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: btusb: add support for 0bb4:0306
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0dd3dccb-e0b2-fcd1-5271-5388ab847bd3@frickel.club>
Date: Fri, 10 Feb 2017 13:27:08 +0100
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <AF9A409D-9EAD-4037-984E-81BBDA7CB5E5@holtmann.org>
References: <20170210003142.3871-1-haagch@frickel.club>
 <04A5C1B8-16D8-4146-8A3E-7DCBA0FDB7CB@holtmann.org>
 <0dd3dccb-e0b2-fcd1-5271-5388ab847bd3@frickel.club>
To: Christoph Haag <haagch@frickel.club>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christoph,

> I've sent a new version but it seems my message was not included, so here it is.
> 
> Thanks for the comment.
> It did not work right with the first patch anyway, was probably missing some stuff.
> 
> With this new patch I can actually pair and use gatttool.
> lsusb says BCM920703 now.
> 
> dmesg says
> 
> Bluetooth: hci0: BCM: chip id 102
> Bluetooth: hci0: c-l
> Bluetooth: hci0: BCM (001.001.005) build 0000
> Bluetooth: hci0: BCM (001.001.005) build 0481
> Bluetooth: hci0: BCM20703A1 Generic USB 20Mhz fcbga_BU
> 
> Would this be useful for the commit message?

yes, please include it in the commit message.

Just for my personal curiosity, can you run btmon and capture the HCI Version Information, HCI Supported Features, HCI Supported Commands and HCI LE Supported Features commands. It sounds like this is a Bluetooth 4.1 capable chip.

Regards

Marcel

