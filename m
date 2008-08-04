Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 4 Aug 2008 20:32:47 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808041901.36706.oliver@neukum.org> <9925799E-5F50-4C03-9C0C-A28A9A657B1A@holtmann.org>
In-Reply-To: <9925799E-5F50-4C03-9C0C-A28A9A657B1A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808042032.48105.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 04 August 2008 19:25:17 schrieb Marcel Holtmann:
> Hi Oliver,
>=20
> >>> Then why do you implement this option for hci_usb?
> >>> And why can the other IGNORE options be overridden?
> >>
> >> if I wanna use the generic Bluetooth descriptor for matching, I =20
> >> need a
> >> way to mark broken devices as to be ignored. Otherwise I would have a
> >> really long list of matching vendor and product ids.
> >
> > True, but if btusb is to replace hci_usb, the module options should =20
> > match.
> > So will you remove that option in hci_usb?
>=20
> the override_ignore is your invention. So what do you mean?

Hm, I may be smoking strange kernels, but I copied this as far as I can tell
from 2.6.25 hci_usb and merely renamed it because "ignore" seemed too
generic to me. Could you check we are talking about the same parameter?

	Gru=DF
		Oliver
