Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Tue, 5 Aug 2008 13:15:21 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808042032.48105.oliver@neukum.org> <1217881449.7819.12.camel@californication>
In-Reply-To: <1217881449.7819.12.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808051315.21771.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 04 August 2008 22:24:08 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > >>> Then why do you implement this option for hci_usb?
> > > >>> And why can the other IGNORE options be overridden?
> > > >>
> > > >> if I wanna use the generic Bluetooth descriptor for matching, I  
> > > >> need a
> > > >> way to mark broken devices as to be ignored. Otherwise I would have a
> > > >> really long list of matching vendor and product ids.
> > > >
> > > > True, but if btusb is to replace hci_usb, the module options should  
> > > > match.
> > > > So will you remove that option in hci_usb?
> > > 
> > > the override_ignore is your invention. So what do you mean?
> > 
> > Hm, I may be smoking strange kernels, but I copied this as far as I can tell
> > from 2.6.25 hci_usb and merely renamed it because "ignore" seemed too
> > generic to me. Could you check we are talking about the same parameter?
> 
> the generic ignore parameter can be removed. There is no other way to
> deal with Bluetooth in Linux and we can use other ways to unattach a
> driver from a device.

Exactly. Therefore I wonder whether this in vanilla hci_usb is not a mistake:

	if (ignore || id->driver_info & HCI_IGNORE)
		return -ENODEV;

	if (ignore_dga && id->driver_info & HCI_DIGIANSWER)
		return -ENODEV;

	if (ignore_csr && id->driver_info & HCI_CSR)
		return -ENODEV;

And should be (ignore && id->driver_info & HCI_IGNORE) or
negatively formulated (!ignore && id->driver_info & HCI_IGNORE)
so that the blacklist is used by default.

	Regards
		Oliver
