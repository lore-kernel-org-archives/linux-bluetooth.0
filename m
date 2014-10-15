Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Oct 2014 12:11:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkvKo0FQh+8_qTUMbttq_ggBnfr8dgeJAopxyozNK6u4=Fw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1410151207020.1210-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 15 Oct 2014, Naveen Kumar Parna wrote:

> Hi Oliver,
> 
> I tried this test in two different set of hardware configurations.
> 
> 
> 
> i)                    I tried in multiple test systems which has
> EHCI-USB host controller on PCI card and internal USB 2.0
> hub("rate-matching" hub). All the test systems with this configuration
> gives spurious stall packets.
> 
> [lowerlayers@banunxcas29 ~]$ lspci | grep -i usb
> 
> 00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
> USB2 Enhanced Host Controller (rev 05)
> 
> 00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
> USB2 Enhanced Host Controller (rev 05)
> 
> 
> lsusb:
> 
> Bus 001 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching Hub
> 
> Bus 002 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching Hub
> 
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> 
> 
> 
> 
> ii)                   I found different test systems which has
> OHCI-USB host controller on PCI card and internal USB 1.1 hub. All the
> test systems with this configuration are not producing stall packets.
> 
>  [lowerlayers@camunxcas11 ~]$ lspci | grep -i usb
> 
> 00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
> 
> 00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
> 
> 
> lsusb:
> 
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> 
> Bus 002 Device 002: ID 0451:2077 Texas Instruments, Inc. TUSB2077 Hub
> 
> 
> 
> 
> My device is a full-speed device. So , stall packets are due to buggy
> USB 2.0 hub?

It's entirely possible that the stall packets are created by the hub.  
When a full-speed device is connected to a USB-2 hub, and the device 
fails to respond to a packet sent by the host, the hub reports this 
failure as a stall.

When the device is connected to an OHCI controller, such failures would
be reported in a different way, such as a -EPROTO or -EILSEQ status.

> Is there a chance of getting stall packets “If the device runs at low
> speed or full speed and is connected through a USB-2.0 hub”? If so it
> looks like hub driver issue right?

If the problem is that the device fails to respond to a packet then it 
is an issue with the device.

> If the hub is the problem… what will be the better solution? Is it
> possible to change internal hub?

No, it is not possible.

Alan Stern

