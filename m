Return-Path: <cyrus@holtmann.org>
From: Bea Lam <blam@trolltech.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Adapter API - Devices property not updated if connection initiated by remote device
Date: Fri, 12 Dec 2008 14:52:37 +1000
Cc: linux-bluetooth@vger.kernel.org
References: <200812111357.59004.blam@trolltech.com> <1229046197.22285.21.camel@violet.holtmann.net>
In-Reply-To: <1229046197.22285.21.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812121452.37564.blam@trolltech.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Yes, FindDevice() is useful when I need to check whether a particular device 
is connected at the moment. But what if I don't know the address of the 
connecting device? That is, should BlueZ also be able to tell me when some 
random, unknown device connects to me?

thanks

Bea


On Friday 12 December 2008 11:43:17 am Marcel Holtmann wrote:
> Hi Bea,
>
> > When using the org.bluez.Adapter interface, if I initiate a connection to
> > a remote device, then the adapter's Devices property is updated to
> > include the remote device, as expected. However, if the remote device
> > initiates the connection to my device instead, it isn't added to the
> > Devices list. This would appear to be a bug.
> >
> > This can be problematic if I am trying to identify whether any remote
> > devices are currently connected to the local adapter; it is not possible
> > to identify the connected devices if they have initiated the connection.
> >
> > It would be much appreciated if someone could look into this. Perhaps the
> > adapter->devices list could be updated when adapter_add_active_conn() is
> > called, but I'm not sure if this is correct.
>
> I know that Johan fixed a bug where FindDevice would not give any result
> for temporary devices. So you can use FindDevice to get the device
> object. Adding it to the device list? I am not sure about that.
>
> Regards
>
> Marcel
