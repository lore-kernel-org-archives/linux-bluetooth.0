Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 11:25:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ting Chou <Ting.Chou@iaSolution.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <20121212092537.GA5371@x220>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
 <20121212075201.GA14256@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ting,

On Wed, Dec 12, 2012, Ting Chou wrote:
> I tried Device.Pair, it does connect to the LE device like the first call to
> Device.Connect, but:
> 
> - I can't unpair the device (CancelPairing can't do this).

There's no "unpair" method. You'd need to call Adapter.RemoveDevice to
do it.

> - If I Device.Disconnect after Device.Pair, then I can't connect to the device
>   again by either Device.Connect or Device.Pair:
>   - Device1.Connect
>     Error org.bluez.Error.NotAvailable: Operation currently not available
>   - Device1.Pair
>     Error org.bluez.Error.AlreadyExists: Already Exists
> 
> I still can't connect to the LE device once I disconnect it.

That means that the profiles that are supposed to be supported with this
device are not calling either device_set_auto_connect() or
btd_device_add_attio_callback(). Both of those functions should cause
bluetoothd to start doing passive scanning and try to connect to the
device. Btw, which kernel version are you using. IIRC you'll need
something like 3.5 or newer for LE passive scanning to work.

Johan
