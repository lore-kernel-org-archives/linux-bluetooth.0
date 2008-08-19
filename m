Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch]race condition in btusb disconnect() handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808191423.52657.oliver@neukum.org>
References: <200808191423.52657.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 14:43:01 +0200
Message-Id: <1219149781.7591.137.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> btusb has some races in disconnect()
> 
> - it doesn't deal with only the iso interface disconnected

It see the point here, but then we have to release the main interface
cleanly or just disable SCO. I would prefer to just disable SCO.

> - it releases the data interface before unregistering the iso interface

How does this happen? It doesn't do it that way.

> - it isn't carefull to kill all URBs in case of soft disconnect

The hci_unregister_dev will be calling the close() callback. Check
hci_core.c and hci_dev_do_close().

Regards

Marcel


