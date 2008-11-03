Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-15?q?Isa=EDas_Mart=EDnez_Yelmo?= <isaiasmy@gmail.com>
To: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Dell 365 Bluetooth
Date: Mon, 3 Nov 2008 23:06:40 +0100
Cc: linux-bluetooth@vger.kernel.org
References: <200811031947.40187.isaiasmy@gmail.com>
	<200811032158.21654.isaiasmy@gmail.com> <490F6861.5060704@dell.com>
In-Reply-To: <490F6861.5060704@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-15
Message-Id: <200811032306.41166.isaiasmy@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Monday 03 November 2008 22:08:49 Mario Limonciello escribió:
> Isaias:
>
> Isaías Martínez Yelmo wrote:
> > El Monday 03 November 2008 20:03:51 Mario Limonciello escribió:
> >
> >
> > Hello,
> >
> > I'm not very sure on how to enable the option that you mention, sorry.
> > I've include in /etc/modprobe.d/options the next line:
> >
> > options btusb=1
> >
> > but I don't know if this is right. The dmesg command shows these lines
> > related with hid2hci:
> >
> > [   12.458741] usb 1-1.2: usbfs: process 2746 (hid2hci) did not claim
> > interface 0 before use
> > [   24.365796] usb 1-1.2: usbfs: process 5909 (hid2hci) did not claim
> > interface 0 before use
> >
> > Perhaps, it could be relevant.
> >
> > Let me know, if I have to enable the option in other way.
> >
> > Regards,
> >
> > Isaias
>
> Sorry, I mistyped before.  The modprobe options should be:
>
> options btusb reset=1
>
> See if that does your device any good.
>
> Regards

Hi,


things are going better, the device is detected:

[   11.974093] Bluetooth: Core ver 2.13
[   11.986233] Bluetooth: HCI device and connection manager initialized
[   11.986235] Bluetooth: HCI socket layer initialized
[   11.989265] Bluetooth: Generic Bluetooth USB driver ver 0.3
[   22.193174] Bluetooth: L2CAP ver 2.11
[   22.193188] Bluetooth: L2CAP socket layer initialized
[   22.244021] Bluetooth: SCO (Voice Link) ver 0.6
[   22.244037] Bluetooth: SCO socket layer initialized
[   22.287679] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.287693] Bluetooth: BNEP filters: protocol multicast
[   22.393267] Bluetooth: RFCOMM socket layer initialized
[   22.393300] Bluetooth: RFCOMM TTY layer initialized
[   22.393305] Bluetooth: RFCOMM ver 1.10

I can pair with my mobilephone, but I cannot see the services between the 
laptop and the mobilephone or to transfer some file :( I have tried to  look 
for some thing but I have not found any relevant yet.  Some Idea? Fortunately, 
at least is recognised :)

Regards,

Isaias
-- 
Isaías Martínez Yelmo
