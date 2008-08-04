Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808042032.48105.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808041901.36706.oliver@neukum.org>
	 <9925799E-5F50-4C03-9C0C-A28A9A657B1A@holtmann.org>
	 <200808042032.48105.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 04 Aug 2008 22:24:08 +0200
Message-Id: <1217881449.7819.12.camel@californication>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > >>> Then why do you implement this option for hci_usb?
> > >>> And why can the other IGNORE options be overridden?
> > >>
> > >> if I wanna use the generic Bluetooth descriptor for matching, I  
> > >> need a
> > >> way to mark broken devices as to be ignored. Otherwise I would have a
> > >> really long list of matching vendor and product ids.
> > >
> > > True, but if btusb is to replace hci_usb, the module options should  
> > > match.
> > > So will you remove that option in hci_usb?
> > 
> > the override_ignore is your invention. So what do you mean?
> 
> Hm, I may be smoking strange kernels, but I copied this as far as I can tell
> from 2.6.25 hci_usb and merely renamed it because "ignore" seemed too
> generic to me. Could you check we are talking about the same parameter?

the generic ignore parameter can be removed. There is no other way to
deal with Bluetooth in Linux and we can use other ways to unattach a
driver from a device.

Regards

Marcel


