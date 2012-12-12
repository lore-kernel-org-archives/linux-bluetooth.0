Return-Path: <cyrus@holtmann.org>
From: Ting Chou <Ting.Chou@iaSolution.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 12 Dec 2012 17:10:45 +0800
Subject: RE: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
 <20121212075201.GA14256@x220>
In-Reply-To: <20121212075201.GA14256@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Wednesday, December 12, 2012 3:52 PM
> To: Ting Chou
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [BLE] org.bluez.Device1.Connect() returns
> org.bluez.Error.NotAvailable
> 
> Hi Ting,
> 
> On Wed, Dec 12, 2012, Ting Chou wrote:
> > I Found
> > -------
> >
> > - I checked /var/log/syslog and src/device.c, and found
> connect_profiles() is
> >   called twice at the first time calling org.bluez.Device.Connect():
> >
> >   - 1st time
> >     dev->svc_resolved==FALSE, device_resolve_svc() is invoked.
> >
> >   - 2nd time
> >     dev->svc_resolved==TRUE
> >     In the for loop of iterating device profiles, there're two
> profiles:
> >
> >       a) p->auto_connect==FALSE, p->name==deviceinfo, p-
> >local_uuid==NULL
> >       b) p->auto_connect==FALSE, p->name==Health Thermometer GATT
> > driver, p->local_uuid==NULL
> >
> >     Since none of them have auto_connect TRUE, dev->pending==NULL,
> and
> >     btd_error_not_available() is called.
> >
> > - I tried org.bluez.Device1.ConnectProfile() as well, but since all
> the profiles
> >   have local_uuid NULL, find_connectable_profile() return NULL and
> >   btd_error_invalid_args() is called.
> 
> It's not actually local_uuid that is so important but that p->connect
> is set. Also, it'd make much more sense to pass the remote UUID to
> ConnectProfile than the local one and we'll still do this change before
> releasing 5.0. The main thing that needs to be done before that is to
> convert profile->remote_uuids list to a single profile->remote_uuid
> which is a bit of work since some profiles still declare multiple UUIDs.
> 
> So far no LE profile is hooked up to Device.Connect and I'm not sure
> exactly how that should be done since LE device are connected through
> the general connection establishment procedure which requires scanning
> first. Since we already have Device.Pair doing the same as
> CreatePairedDevice in BlueZ 4 (and this should work btw, did you try
> it?) maybe Device.Connect should be roughly the same for LE devices as
> Adapter.CreateDevice is in BlueZ 4? For BR/EDR devices it already
> serves this purpose. The main question is what should be done if
> Device.Connect is called subsequent times as bluetoothd should anyway
> already be doing passive scanning and trying to connect to devices that
> have supported profiles.
> 
> Johan

I tried Device.Pair, it does connect to the LE device like the first call to
Device.Connect, but:

- I can't unpair the device (CancelPairing can't do this).

- If I Device.Disconnect after Device.Pair, then I can't connect to the device
  again by either Device.Connect or Device.Pair:
  - Device1.Connect
    Error org.bluez.Error.NotAvailable: Operation currently not available
  - Device1.Pair
    Error org.bluez.Error.AlreadyExists: Already Exists

I still can't connect to the LE device once I disconnect it.

Thanks,
Ting
