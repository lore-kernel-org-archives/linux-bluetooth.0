Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Which software is responsible for bringing the devices (hci0 .. hcix) up ?
Date: Wed, 29 Aug 2012 09:49:14 +0200
Message-ID: <1531E53627F1F749B4FE809BF2A4EB67036F2FD3@WETMEX10.loepfe.com>
In-Reply-To: <20120829073733.GC3937@aemeltch-MOBL1>
References: <1531E53627F1F749B4FE809BF2A4EB67036F2F97@WETMEX10.loepfe.com> <20120829070853.GA3937@aemeltch-MOBL1> <1531E53627F1F749B4FE809BF2A4EB67036F2FAC@WETMEX10.loepfe.com> <20120829071455.GB3937@aemeltch-MOBL1> <1531E53627F1F749B4FE809BF2A4EB67036F2FB2@WETMEX10.loepfe.com> <20120829073733.GC3937@aemeltch-MOBL1>
From: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>
To: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> Do you have bluetoothd running?

OK : You've got it.. I think.

When looking into the process-list with ps , I don't see bluetoothd.

When starting Bluetoothd on the command line .. . before plugging in the
device .. 
the the device is 'UP' like it should be... (you are guiding/pointing me
in the GOOD direction, thankx) 


Next question (Sorry) ? Isn't bluetoothd supposed to be launched by udev
?

Or I'm I missing some startup-script  (/etc/init.d/... ) ?

I just wonder is there somewhere a description on how bleuz (bluetooth)
is started at boot ?


Regards Noel



-----Original Message-----
From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
Sent: 29Aug12 09:38
To: Vellemans, Noel
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Which software is responsible for bringing the devices
(hci0 .. hcix) up ?

Hi,

On Wed, Aug 29, 2012 at 09:20:34AM +0200, Vellemans, Noel wrote:
> Hi,
> 
> It is an EXTERNAL USB-device plugged in manually, and if it is plugged

> in, the device is recognized.

Do you have bluetoothd running?

Best regards
Andrei Emeltchenko 

>  
> 
> Regards Noel
> 
> << log>>
> 
> Plug in device ...  Results in....
> 
> 
> # usb wakeup is here
> usb 2-1: new full speed USB device using fsl-ehci and address 4 usb 
> 2-1: New USB device found, idVendor=0a12, idProduct=0001 usb 2-1: New 
> USB device strings: Mfr=0, Product=0, SerialNumber=0
> 
> #
> 
> # lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub Bus 002

> Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub Bus 001 Device 
> 002: ID 0eef:7304 D-WAV Scientific Co., Ltd Bus 003 Device 001: ID 
> 1d6b:0002 Linux Foundation 2.0 root hub Bus 002 Device 004: ID 
> 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> 
> 
> # hciconfig
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
> 
> 
> -----Original Message-----
> From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com]
> Sent: 29Aug12 09:15
> To: Vellemans, Noel
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: Which software is responsible for bringing the devices 
> (hci0 .. hcix) up ?
> 
> Hi Noel,
> 
> On Wed, Aug 29, 2012 at 09:12:18AM +0200, Vellemans, Noel wrote:
> > Hi Andrei,
> > 
> > Any clue what the reason can be, that the device is not comming 'UP'
> > automatically ?
> 
> It is powered off automatically.
> 
> Best regards
> Andrei Emeltchenko
> 
> > 
> > 
> > Regards Noel
> >  
> > 
> > -----Original Message-----
> > From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com]
> > Sent: 29Aug12 09:09
> > To: Vellemans, Noel
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: Which software is responsible for bringing the devices 
> > (hci0 .. hcix) up ?
> > 
> > Hi Noel,
> > 
> > On Wed, Aug 29, 2012 at 08:58:12AM +0200, Vellemans, Noel wrote:
> > > Hi,
> > >  
> > >  
> > > I have a simple question, I think, But I do not manage to find the

> > > answer into the old mailing-list-posts.
> > >  
> > > I'm using bluez-4.99 and Linux kernel 2.6.35.3. 
> > >  
> > > When plugging in a device (CSR-device) the device is recognized 
> > > but it
> > 
> > > is not 'UP'.
> > >  
> > > Can someone tell me what piece of software is NORMALLY setting the

> > > device into the 'UP' state?
> > > (so that I do not have to type hciconfig hci0 up)
> > 
> > bluetoothd
> > 
> > Best regards
> > Andrei Emeltchenko
> > 
