Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 4 Aug 2008 10:33:04 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808011357.16868.oliver@neukum.org> <1217612718.7819.7.camel@californication>
In-Reply-To: <1217612718.7819.7.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808041033.05446.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag 01 August 2008 19:45:18 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > Both table updates should be a separate patch and we can even submit  
> > > that for 2.6.27 inclusion. I was just to lazy to do that, but I have  
> > > it on my todo list, but the Simple Pairing support had higher priority.
> > 
> > This patch implements the quirks from hci_usb in btusb, too.
> > 
> > --- linux-2.6.22/drivers/bluetooth/btusb.c	2008-08-01 10:53:38.000000000 +0200
> > +++ linux-2.6.26/drivers/bluetooth/btusb.c	2008-08-01 13:47:54.000000000 +0200
> > @@ -41,21 +41,108 @@
> >  #define BT_DBG(D...)
> >  #endif
> >  
> > -#define VERSION "0.1"
> > +#define VERSION "0.3"
> 
> the version number increase to 0.3 is bogus, it should be 0.2.

Roger.

> > +module_param(override_ignore, bool, 0644);
> > +MODULE_PARM_DESC(override_ignore, "Drive blacklisted devices");
> 
> Why do we need this one? What is it good for?

To override HCI_IGNORE. IF we provide overrides for blacklist entries,
it should be done systematically.

	Regards
		Oliver
