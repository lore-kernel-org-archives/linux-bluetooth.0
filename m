Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 4 Aug 2008 19:01:36 +0200
References: <200807311452.24166.oliver@neukum.org> <200808041823.28309.oliver@neukum.org> <7D2DA686-9741-4369-9E47-E4AD140D067E@holtmann.org>
In-Reply-To: <7D2DA686-9741-4369-9E47-E4AD140D067E@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808041901.36706.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 04 August 2008 18:33:36 schrieben Sie:
> > Then why do you implement this option for hci_usb?
> > And why can the other IGNORE options be overridden?
>=20
> if I wanna use the generic Bluetooth descriptor for matching, I need a =A0
> way to mark broken devices as to be ignored. Otherwise I would have a =A0
> really long list of matching vendor and product ids.

True, but if btusb is to replace hci_usb, the module options should match.
So will you remove that option in hci_usb?

	Regards
		Oliver
