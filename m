Return-Path: <alexandre.ghisoli@ycom.ch>
Subject: Re: [Bluez-users] hid2usb error
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1077215608.2767.2.camel@pegasus>
References: <1077206432.17056.7.camel@pc-04.ycom.ch>
	 <1077215608.2767.2.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1077216551.17051.14.camel@pc-04.ycom.ch>
Mime-Version: 1.0
Date: Thu, 19 Feb 2004 19:49:11 +0100
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel, 

Can I find this patch somewhere ?

Thanks for your time

	..Alexandre

Le jeu 19/02/2004 à 19:33, Marcel Holtmann a écrit :
> Hi Alexandre,
> 
> > I've the Logitech diNovo Bluetooth kit, and try to use it as BT device.
> > So, i've bluez-libs2 & bluez-utils2 to use the hid2hci tool to pass my
> > Logitech USB HUB to an Bluetooth HUB.
> > 
> > Kernel 2.6.2-mh
> > hid module loaded.
> > 
> > Running the hid2usb give :
> > Invalid argument ...
> > 
> > After some investigations, it appear that the following line return the
> > error (around line 240) :
> > 
> > err = send_report(fd, rep1, sizeof(rep1))
> > 
> > at the 2nd byte send (0xff 0x80)
> 
> you need a patch for the USB HID driver to send multiple bytes. I think
> it is not included so far. Must be pending in Greg's list.
> 
> Regards
> 
> Marcel
> 
