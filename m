Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch]race condition in btusb disconnect() handling
Date: Tue, 19 Aug 2008 15:09:00 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808191423.52657.oliver@neukum.org> <1219149781.7591.137.camel@violet.holtmann.net>
In-Reply-To: <1219149781.7591.137.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808191509.00705.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 19 August 2008 14:43:01 schrieb Marcel Holtmann:
> Hi Oliver,
>=20
> > btusb has some races in disconnect()
> >=20
> > - it doesn't deal with only the iso interface disconnected
>=20
> It see the point here, but then we have to release the main interface
> cleanly or just disable SCO. I would prefer to just disable SCO.

The patch disables the main interface. Just disabling SCO means that
btusb_data.isoc could no longer be treated as constant and locking for it
would be necessary. This seems extravagant for a minor use case.

> > - it releases the data interface before unregistering the iso interface
>=20
> How does this happen? It doesn't do it that way.

=46rom your version:
	if (data->isoc)
		usb_driver_release_interface(&btusb_driver, data->isoc);

	usb_set_intfdata(intf, NULL);

	hci_unregister_dev(hdev);

=46irst you release the interface, then you unregister the hci.

>=20
> > - it isn't carefull to kill all URBs in case of soft disconnect
>=20
> The hci_unregister_dev will be calling the close() callback. Check
> hci_core.c and hci_dev_do_close().

OK, I'll modify the patch.

	Regards
		Oliver
