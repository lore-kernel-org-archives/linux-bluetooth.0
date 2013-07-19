Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jul 2013 19:20:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?J=F6rg?= Esser <jackfritt@boh.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20130719162051.GA7373@x220.p-661hnu-f1>
References: <51E7ED11.7010103@boh.de>
 <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org>
 <51E8DBFF.4060702@boh.de>
 <5BE2601B-7C94-4C24-AB9B-EF187CAD9098@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5BE2601B-7C94-4C24-AB9B-EF187CAD9098@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 19, 2013, Marcel Holtmann wrote:
> > > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.043811
> >      Read Local Version Information (0x04|0x0001) ncmd 1
> >        Status: Success (0x00)
> >        HCI version: 2 - 0x2006
> >        LMP version: 2 - 0x1806
> >        Manufacturer: AVM Berlin (31)
> 
> it declares itself here as Bluetooth 1.2 device. Which means it is the
> second generation of BlueFritz! USB device.
> 
> <snip>
> 
> > < HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 0.210014
> > > HCI Event: Command Status (0x0f) plen 4 [hci0] 0.217361
> >      Read Local Supported Commands (0x04|0x0002) ncmd 1
> >        Status: Unknown HCI Command (0x01)
> 
> And here is your failing command. Newer kernels have been strict with
> failing commands and will just abort the setup if anything goes wrong.
> 
> Johan, we need to figure out on how to work around this one. Might
> just match for the manufacturer before sending the command.

Either that or a quirk based on the USB id. Wouldn't matching just the
manufacturer be a bit problematic for any newer chips from this company,
or they stopped doing Bluetooth dongles after this one?

Johan
