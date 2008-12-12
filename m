Return-Path: <cyrus@holtmann.org>
Subject: Re: Adapter API - Devices property not updated if connection
 initiated by remote device
From: Marcel Holtmann <marcel@holtmann.org>
To: Bea Lam <blam@trolltech.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200812111357.59004.blam@trolltech.com>
References: <200812111357.59004.blam@trolltech.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:43:17 +0100
Message-Id: <1229046197.22285.21.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bea,

> When using the org.bluez.Adapter interface, if I initiate a connection to a 
> remote device, then the adapter's Devices property is updated to include the 
> remote device, as expected. However, if the remote device initiates the 
> connection to my device instead, it isn't added to the Devices list. This 
> would appear to be a bug.
> 
> This can be problematic if I am trying to identify whether any remote devices 
> are currently connected to the local adapter; it is not possible to identify 
> the connected devices if they have initiated the connection.
> 
> It would be much appreciated if someone could look into this. Perhaps the 
> adapter->devices list could be updated when adapter_add_active_conn() is 
> called, but I'm not sure if this is correct.

I know that Johan fixed a bug where FindDevice would not give any result
for temporary devices. So you can use FindDevice to get the device
object. Adding it to the device list? I am not sure about that.

Regards

Marcel


