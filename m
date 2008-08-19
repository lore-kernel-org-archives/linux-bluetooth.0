Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch]race condition in btusb disconnect() handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808191509.00705.oliver@neukum.org>
References: <200808191423.52657.oliver@neukum.org>
	 <1219149781.7591.137.camel@violet.holtmann.net>
	 <200808191509.00705.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 15:28:26 +0200
Message-Id: <1219152506.7591.142.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > btusb has some races in disconnect()
> > > 
> > > - it doesn't deal with only the iso interface disconnected
> > 
> > It see the point here, but then we have to release the main interface
> > cleanly or just disable SCO. I would prefer to just disable SCO.
> 
> The patch disables the main interface. Just disabling SCO means that
> btusb_data.isoc could no longer be treated as constant and locking for it
> would be necessary. This seems extravagant for a minor use case.

I am fine with both ways. Will decide which code looks cleaner :)

> > > - it releases the data interface before unregistering the iso interface
> > 
> > How does this happen? It doesn't do it that way.
> 
> From your version:
> 	if (data->isoc)
> 		usb_driver_release_interface(&btusb_driver, data->isoc);
> 
> 	usb_set_intfdata(intf, NULL);
> 
> 	hci_unregister_dev(hdev);
> 
> First you release the interface, then you unregister the hci.

Putting it after hci_unregister_dev is an issue. The unregister will
call __hci_dev_put and then in return will call the destruct callback
which will free the data pointer.

So either we use hci_dev_hold or make sure that disconnect can only
disable the SCO interface. That comes directly with the first comment
from you.

Regards

Marcel


