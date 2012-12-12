Return-Path: <cyrus@holtmann.org>
From: Ting Chou <Ting.Chou@iaSolution.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 12 Dec 2012 17:47:35 +0800
Subject: RE: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
 <20121212075201.GA14256@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
 <20121212092537.GA5371@x220>
In-Reply-To: <20121212092537.GA5371@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Wednesday, December 12, 2012 5:26 PM
> To: Ting Chou
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [BLE] org.bluez.Device1.Connect() returns
> org.bluez.Error.NotAvailable
> 
> Hi Ting,
> 
> On Wed, Dec 12, 2012, Ting Chou wrote:
> > I tried Device.Pair, it does connect to the LE device like the first
> > call to Device.Connect, but:
> >
> > - I can't unpair the device (CancelPairing can't do this).
> 
> There's no "unpair" method. You'd need to call Adapter.RemoveDevice to
> do it.
> 
> > - If I Device.Disconnect after Device.Pair, then I can't connect to
> the device
> >   again by either Device.Connect or Device.Pair:
> >   - Device1.Connect
> >     Error org.bluez.Error.NotAvailable: Operation currently not
> available
> >   - Device1.Pair
> >     Error org.bluez.Error.AlreadyExists: Already Exists
> >
> > I still can't connect to the LE device once I disconnect it.
> 
> That means that the profiles that are supposed to be supported with
> this device are not calling either device_set_auto_connect() or
> btd_device_add_attio_callback(). Both of those functions should cause
> bluetoothd to start doing passive scanning and try to connect to the
> device. Btw, which kernel version are you using. IIRC you'll need
> something like 3.5 or newer for LE passive scanning to work.
> 

I tried to let btd_device_add_attio_callback() get called by

  Characterisitc.DiscoverCharacteristics()

But still the Device1.Connect() after Device1.Disconnect() does not establish
the connection. connect_profiles() returns btd_error_not_available() since
!dev->pending:

  ting@user-OptiPlex-755:~/w/bluez$ sudo dbus-send --system --dest=org.bluez --type=method_call --print-reply /org/bluez/hci0/dev_00_07_80_4C_5F_17 org.bluez.Device1.Connect
  Error org.bluez.Error.NotAvailable: Operation currently not available

  ting@user-OptiPlex-755:~/w/bluez$ sudo dbus-send --system --dest=org.bluez --type=method_call --print-reply /org/bluez/hci0/dev_00_07_80_4C_5F_17/service000d  org.bluez.Characteristic.DiscoverCharacteristics
  method return sender=:1.1992 -> dest=:1.1997 reply_serial=2
     array [
        object path "/org/bluez/hci0/dev_00_07_80_4C_5F_17/service000d/characteristic000f"
     ]

  ting@user-OptiPlex-755:~/w/bluez$ sudo dbus-send --system --dest=org.bluez --type=method_call --print-reply /org/bluez/hci0/dev_00_07_80_4C_5F_17 org.bluez.Device1.Disconnect
  method return sender=:1.1992 -> dest=:1.1998 reply_serial=2

  ting@user-OptiPlex-755:~/w/bluez$ sudo dbus-send --system --dest=org.bluez --type=method_call --print-reply /org/bluez/hci0/dev_00_07_80_4C_5F_17 org.bluez.Device1.Connect
  Error org.bluez.Error.NotAvailable: Operation currently not available

The kernel I'm using:

  ting@user-OptiPlex-755:~/w/bluez$ uname -a
  Linux user-OptiPlex-755 3.6.6-030606-generic #201211050512 SMP Mon Nov 5 10:20:03 UTC 2012 i686 i686 i686 GNU/Linux

Thank you,
Ting
