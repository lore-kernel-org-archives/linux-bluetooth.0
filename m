Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1258286232.3299.27.camel@violet>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
	 <1258286232.3299.27.camel@violet>
Date: Tue, 17 Nov 2009 17:53:53 +0100
Message-ID: <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Natale Vinto <ebballon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
I have a 2.1+EDR bluetooth usb dongle from Cubic 3c Corp.

Here there is a picture of it:
http://www.ec21.com/global/common/imageView.jsp?title=Sell%20bluetooth%20mini%20dongle,%20100m&img=http://image.ec21.com/image/skye112/OF0007943009_1/Sell_bluetooth_mini_dongle_100m.jpg

The command  hciconfig hci0 gives this result on 2.6.31 Kubuntu Karmic:
hci0:   Type: USB
        BD Address: 00:15:83:0C:1F:55 ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:999 acl:0 sco:0 events:30 errors:0
        TX bytes:367 acl:0 sco:0 commands:28 errors:0

Here you are some useful information about it:

lsusb:
Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)

lsmod | grep bt:
btusb                  11568  2
bluetooth              53828  9 rfcomm,sco,bnep,l2cap,btusb
usbcore               146288  4 btusb,ehci_hcd,uhci_hcd

so I get always:
hciconfig hci0 inqtpl
Can't read inquiry transmit power level on hci0: Input/output error (5)

either on Ubuntu/Debian Bluez 4.x/3.x

so isn't it a CSR based chip? I thought they would work fine with TPL, isn't it?

Best Regards


This doesn't work also on Bluez 3.x, what's wrong?


2009/11/15 Marcel Holtmann <marcel@holtmann.org>
>
> Hi Natale,
>
> > I've this issue: while trying to get/set inquiry transmit power level
> > from a bluetooth usb dongle on 2.6 kernels I got always this error:
> >
> > Can't read inquiry transmit power level on hci0: Input/output error (5)
> >
> > I've tried with any bluetooth usb dongle class (1.1, 2 and 2.1) from
> > many vendors (ex. Sitecom, Trust, D-Link, Belkin, etc), in many 2.6.x
> > kernels ( 2.6.{27,31} ) on Debian and Ubuntu machines using BlueZ 3.x
> > and 4.x stack and I got always that error while trying to get the TPL
> > with:
> >
> > hciconfig <device> inqtpl
> >
> > I searched a lot in mailing list archives and I haven't seen any
> > solution for this issue, I've found maybe useful only this old email
> >
> > http://osdir.com/ml/bluez.devel/2003-06/msg00140.html
> >
> > where is suggested a CSR chipset based hardware.
> > Also looking in sources I found that the problem comes from this pieces of code:
> >
> > int8_t level;
> >
> >         if (hci_read_inquiry_transmit_power_level(dd, &level, 1000) < 0) {
> >             fprintf(stderr, "Can't read inquiry transmit power level
> > on hci%d: %s (%d)\n",
> >                         hdev, strerror(errno), errno);
> >             exit(1);
> >         }
> >
> > My question is : how can I have the inqtpl option working? Should I
> > buy only CSR hardware dongle? I'm considering usb dongle because they
> > are the most common in the market, although it could be a linux-usb
> > issue I wonder how to try to fix it!
>
> what does hciconfig hci0 commands tell you? Does it show that this
> command is supported by the firmware. And this is a pure 2.1 feature so
> all older dongles will not have it.
>
> Regards
>
> Marcel
>
>



--
Natale Vinto
http://www.hictech.com
http://bluesman.gotext.org
