Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch]race condition in btusb disconnect() handling
Date: Tue, 19 Aug 2008 15:40:22 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808191423.52657.oliver@neukum.org> <200808191509.00705.oliver@neukum.org> <1219152506.7591.142.camel@violet.holtmann.net>
In-Reply-To: <1219152506.7591.142.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808191540.23072.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 19 August 2008 15:28:26 schrieb Marcel Holtmann:
Hello,

> Hi Oliver,
> 
> > > > btusb has some races in disconnect()
> > > > 
> > > > - it doesn't deal with only the iso interface disconnected
> > > 
> > > It see the point here, but then we have to release the main interface
> > > cleanly or just disable SCO. I would prefer to just disable SCO.
> > 
> > The patch disables the main interface. Just disabling SCO means that
> > btusb_data.isoc could no longer be treated as constant and locking for it
> > would be necessary. This seems extravagant for a minor use case.
> 
> I am fine with both ways. Will decide which code looks cleaner :)
> 
> > > > - it releases the data interface before unregistering the iso interface
> > > 
> > > How does this happen? It doesn't do it that way.
> > 
> > From your version:
> > 	if (data->isoc)
> > 		usb_driver_release_interface(&btusb_driver, data->isoc);
> > 
> > 	usb_set_intfdata(intf, NULL);
> > 
> > 	hci_unregister_dev(hdev);
> > 
> > First you release the interface, then you unregister the hci.
> 
> Putting it after hci_unregister_dev is an issue. The unregister will
> call __hci_dev_put and then in return will call the destruct callback
> which will free the data pointer.
> 
> So either we use hci_dev_hold or make sure that disconnect can only
> disable the SCO interface. That comes directly with the first comment
> from you.

I'll make a patch with hci_dev_hold. It seems the cleaner solution.

	Regards
		Oliver
