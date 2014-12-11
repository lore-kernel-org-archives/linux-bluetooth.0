Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Firmware load fails in 3.18.0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54884879.8010903@googlemail.com>
Date: Thu, 11 Dec 2014 13:55:03 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <707EFA17-C59D-404C-9334-3B3D6A9D383D@holtmann.org>
References: <54884879.8010903@googlemail.com>
To: Chris Clayton <chris2553@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chris,

> In trying to diagnose a problem with bluetooth-audio on my laptop, I've spotted that the firmware is failing to load.
> The bluetooth related output from dmesg is:
> 
> [    0.426890] Bluetooth: Core ver 2.19
> [    0.426986] Bluetooth: HCI device and connection manager initialized
> [    0.427038] Bluetooth: HCI socket layer initialized
> [    0.427087] Bluetooth: L2CAP socket layer initialized
> [    0.427137] Bluetooth: SCO socket layer initialized
> [    1.017575] Bluetooth: hci0: read Intel version: 3707100180012d0d00
> [    1.017602] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq failed with error -2

this is pretty much clear. The filesystem where the firmware is located is not yet mounted. Build the btusb.ko driver has a module.

Regards

Marcel

