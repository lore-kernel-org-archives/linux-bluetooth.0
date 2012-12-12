Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 12:07:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ting Chou <Ting.Chou@iaSolution.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <20121212100737.GA6620@x220>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
 <20121212075201.GA14256@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
 <20121212092537.GA5371@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ting,

On Wed, Dec 12, 2012, Ting Chou wrote:
> > That means that the profiles that are supposed to be supported with
> > this device are not calling either device_set_auto_connect() or
> > btd_device_add_attio_callback(). Both of those functions should cause
> > bluetoothd to start doing passive scanning and try to connect to the
> > device. Btw, which kernel version are you using. IIRC you'll need
> > something like 3.5 or newer for LE passive scanning to work.
> > 
> 
> I tried to let btd_device_add_attio_callback() get called by
> 
>   Characterisitc.DiscoverCharacteristics()

I thought you said some internally supported profiles get detected? Why
then do you need to use the ATT D-Bus interface? FWIW, since
attrib/client.c implementation doesn't match what's documented and since
there hasn't been anyone stepping up to update the code to use D-Bus
properties we'll probably not have the entire Characteristic D-Bus
interface in the 5.0 release. Instead, there's a plan to have a more
comprehensive and generic GATT D-Bus API for both peripheral and central
roles, which will probably land in 5.1 or one of the subsequent
releases.

> But still the Device1.Connect() after Device1.Disconnect() does not establish
> the connection. connect_profiles() returns btd_error_not_available() since
> !dev->pending:

It seems you've misunderstood this part. If the functions I mentioned
are used correctly you will not need to use Device.Connect at all.
Instead bluetoothd will start doing passive scanning and automatically
establish a connection to any device doing connectable advertising.

Johan
