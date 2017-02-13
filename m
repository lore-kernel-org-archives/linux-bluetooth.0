Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: hci_core: Buggy handling of HCI_SETUP flag in mgmt API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170213070152.xub4xijmvnztpf43@earth>
Date: Mon, 13 Feb 2017 10:34:26 +0100
Cc: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <0ED8F56A-0542-4462-AE99-AFEB56AFB205@holtmann.org>
References: <20170213070152.xub4xijmvnztpf43@earth>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> While working on the nokia BT driver, I found a strange bug in
> bluetooth core support. If the driver's setup routine fails,
> a hci0 interface is created with status DOWN, which looks ok.
> The management interface is not happy, though:
> 
> n950# btmgmt info ; btmgmt config
> Index list with 0 items
> Unconfigured index list with 0 items
> 
> It becomes even more interesting, if I do "hciconfig hci0 up"
> (the setup routine only failed due to FW not yet being available
> during early boot). At that point btmgmt still fails:
> 
> n950# btmgmt info; btmgmt config
> Index list with 0 items
> Unconfigured index list with 0 items
> 
> But the device is up and running from hciconfig's perspective
> and hcitool can be used to scan for devices.
> 
> I added a few debug prints to the management interface and the
> problem is, that HCI_SETUP flag is never cleared, when initial
> setup fails. This should be easily reproducible by adding this
> to any BT driver's setup routine:
> 
> static bool fail = true;
> if (fail) {
>    fail = false;
>    return -ENOENT;
> }
> 
> I'm not sure about the correct solution to fix this. Initially I
> thought the flag just needs to be cleared in the path used by
> "hciconfig up". But this would mean, that such a device cannot be
> enabled using the management API (since HCI_SETUP would be set
> until its cleared by hciconfig).

so the legacy (aka old and don’t use it anymore) ioctl that hciconfig triggers for bringing an interface up should in theory do the same as Set Power from mgmt. At least from a BR/EDR perspective since for LE it is a lot more complicated. However this also includes Secure Connections and OOB pairing where you need mgmt to function properly.

That all said, there might be some race condition here in case hdev->setup returns a negative error. Actually if hdev->setup fails the controller should be marked as non-functional. That would mean mark it as RAW only device. I think that is how we have treated this. Which means you can bring it up with hciconfig’s ioctl or use it as HCI User Channel, but the Bluetooth core stack will never touch it again.

Regards

Marcel

