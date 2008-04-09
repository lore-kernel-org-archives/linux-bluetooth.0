Return-Path: <cyrus@holtmann.org>
Message-ID: <012d01c899d5$e7236740$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <00bd01c89901$26af9f80$6701a8c0@freqonedev> <2B4A186F-49DD-4131-ABB7-46E79D1A9DE8@holtmann.org> <00f801c899a1$946db020$6701a8c0@freqonedev> <7698E157-DB74-482D-9442-2B9C035B5A62@holtmann.org> <012801c899cd$447eb880$6701a8c0@freqonedev> <1D6A3083-03A3-4698-A040-DD010CC4EBAD@holtmann.org>
Subject: Re: [Bluez-devel] UPDATE: org.bluez.Adapter Methods/Signals
Date: Tue, 8 Apr 2008 19:08:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks.  After digging into ~/bluez-utils-3.30/doc/... the situation became significantly more clear.  I see the names of the 
xxx-api.txt are also changed, which is why I did not find them before...sigh.

All the best,

DS
----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "David Stockwell" <dstockwell@frequency-one.com>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Tuesday, April 08, 2008 6:36 PM
Subject: Re: [Bluez-devel] UPDATE: org.bluez.Adapter Methods/Signals


Hi David,

> That "flame" was uncalled for.  I have attached file bluez-
> utils-3.30/hcid/dbus-api.txt

actually I mentioned before that you only will see DeviceFound on /
hci0 and if you look into the doc/ directory you see the documentation
for the new API. I mailed an update to the mailing list that mentioned
that from now on forward I am going to put new documentation there.

> The section describing the org.bluez.Adapter interface contains the
> following (emphasis added):
>
>  void DiscoverDevices()
>
>   This method starts the device discovery procedure. This
>   includes an inquiry procedure and remote device name
>   resolving.
>
>   On start up this process will generate a DiscoveryStarted
>   signal and then return ***RemoteDeviceFound*** and also
>   ***RemoteNameUpdated*** signals. If the procedure has been
>   finished an DiscoveryCompleted signal will be sent.
>
>   Possible errors: org.bluez.Error.NotReady
>      org.bluez.Error.Failed
>      org.bluez.Error.InProgress
>      org.bluez.Error.NoSuchAdapter
>
>  void DiscoverDevicesWithoutNameResolving()
>
>   This method starts the device discovery procedure. This
>   includes an inquiry and an optional remote device name
>   resolving. The remote names can be retrieved with
>   GetRemoteName and in the case a name doesn't exist it
>   will be queued for later resolving and GetRemoteName
>   will return an error.
>
>   While this procedure is running every found device
>   will be returned with ***RemoteDeviceFound***. While
>   DiscoverDevices() automatically resolves unknown
>   devices names and sends ***RemoteNameUpdated*** in this
>   case it will only happen if GetRemoteName has been
>   called and no previously stored name is available.
>
>   Possible errors: org.bluez.Error.NotReady
>      org.bluez.Error.Failed
>      org.bluez.Error.InProgress
>      org.bluez.Error.NoSuchAdapter
>
> Note well: not "DeviceFound", but "RemoteDeviceFound".

Check doc/adapter-api.txt and you will see. I might mix up stuff from
time to time, but most times I mean exactly what I say. Also using
introspection utility like d-feet would have shown you this.

> The file I attached is the only dbus-api-txt found in the entire
> bluez-utils-3.30 tree.   So, it appears the documentation is out of
> date; after digging into the code at adapter.c, I found signals
> DeviceCreated, DeviceRemoved, and DeviceFound in the adapter_signals
> table.  I will implement "catches" for them, now, and expect that
> this problem will go away.

No. The documentation is all there. Depending on your entry point is
either / or /org/bluez you have to follow a different API.

Regards

Marcel
