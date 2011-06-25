Return-Path: <cyrus@holtmann.org>
Message-ID: <1309028614.41250.YahooMailClassic@web26505.mail.ukl.yahoo.com>
Date: Sat, 25 Jun 2011 20:03:34 +0100 (BST)
From: Mark Hobley <markhobley@yahoo.co.uk>
Reply-To: markhobley@yahoo.co.uk
Subject: Re: How do I make the computer visible to the mobile phone?
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1309019239.14190.31.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



--- On Sat, 25/6/11, Peter Hurley <peter@hurleysoftware.com> wrote:

> From: Peter Hurley <peter@hurleysoftware.com>
> Subject: Re: How do I make the computer visible to the mobile phone?
> To: "markhobley@yahoo.co.uk" <markhobley@yahoo.co.uk>
> Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
> Date: Saturday, 25 June, 2011, 17:27
> On Sat, 2011-06-25 at 08:44 -0400,
> Mark Hobley wrote:
> > I am using Debian (Mixed/Unstable) and I have a Nano
> Tiny Bluetooth adapter
> > that uses an Accel Semiconductor microchip. The mobile
> phone is visible to
> > the computer, but I cannot see the computer from the
> mobile phone. How do I
> > make the computer visible to my mobile phone?
> 
>     sudo hciconfig hci0 piscan
> 
> Should work.
> 
> Did you resolve your earlier problem with timeouts?
> http://marc.info/?l=linux-bluetooth&m=130877416213307&w=2

> 
> In a terminal:
>     hcitool scan
> should print out the BD_ADDR of the phone
>     bluez-simple-agent hci0 BD_ADDR
> should pair.
> What happens?
> 
> The typical way to debug bluetooth issues is:
> 1. add debug flag "-d" to bluetoothd command line and then
> review system
> log
> 2. run hcidump while performing operation that's not
> working
>     sudo hcidump -tVX > filename
>    -or-
>     sudo hcidump -t --save-dump=filename
>     hcidump -tVXr filename
> Post the dump and let someone look at it.
> 
> >         Class: 0x4a0100
> >         Service Classes:
> Networking, Capturing, Telephony
> >         Device Class:
> Computer, Uncategorized
> 
> These look ok to me.
> 
> > Does anyone know what the class codes are? 
> 
> Class_of_device is defined here:
> https://www.bluetooth.org/Technical/AssignedNumbers/baseband.htm

> 
> > Should I change the class code 
> > in the /etc/bluetooth/main.conf configuration file?
> 
> No.
> 
