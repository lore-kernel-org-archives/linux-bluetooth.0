Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Daniel Abraham <daniel.shrugged@gmail.com>
Subject: Re: HDP proposed API (ver 0.3)
Date: Fri, 14 May 2010 10:01:06 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>,
	Santiago Carot <sancane@gmail.com>,
	Raul Herbster <raul.herbster@signove.com>
References: <201005121126.12859.jcaden@libresoft.es> <AANLkTik5a4HBJZ_FYZ00xdnTiOtGmsdatn0EnV_joHjx@mail.gmail.com> <201005121325.26454.jcaden@libresoft.es>
In-Reply-To: <201005121325.26454.jcaden@libresoft.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005141001.06617.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

El Wednesday 12 May 2010 13:25:26 José Antonio Santos Cadenas escribió:
> > > HDPAgent hierarchy
> > > ==================
> > >
> > > 
> > >
> > > (this object is implemented by the HDP client an receives
> > > notifications)
> > >
> > > 
> > >
> > > Service         unique name
> > > Interface       org.bluez.HdpAgent
> > > Object path     freely definable
> > >
> > > 
> > >                void DeviceConnected(object path)
> > > 
> > >                        This method is called whenever a new device
> > >
> > > connection has been established over the control channel of the current
> > > HDP session. The object path contains the object path of the remote
> > > device.
> > >
> > > 
> > >                void DeviceDisconnected(object path)
> > > 
> > >                        This method is called when a remote device is
> > >                        disconnected definitively. Any future
> > >
> > > reconnections will fail. Also all data channels associated to this
> > > device will be closed.
> > >
> > > 
> > >                void CreatedDataChannel(object path, uint16 mdlid)
> > > 
> > >                        This method is called when a new data channel is
> > >
> > > created The path contains the object path of the device whith the new
> > > connection is created and the mdlid the data channel identificator.
> > >
> > > 
> > >                void DeletedDataChannel(object path, uint16 mdlid)
> > > 
> > >                        This method is called when a data channel is
> > >
> > > closed. After this call the data channel will not be valid and can be
> > > reused for future created data channels.
> >
> > 
> >
> > Question from a user's perspective: why define an agent? Why not
> > define the above as signal callbacks in the relevant object? (same as
> > most APIs in "bluez/docs").
> 
> Because the this notifications are only relevant for the process that
> created  the session and this process should be the unique that receives
> this events. If you define signals, everybody in the bus can be subscribed
> to them, this is a problem in two ways:
>         - Noise in the bus
>         - "Privacy" issue because just the owner of the session should be
> notified  of the session events.
> 
> > 
> >
> > The only places I saw where agents are used are: BlueZ pairing (remote
> > device object doesn't necessarily exist yet, so no way to register for
> > its events, so an agent is required), and obexd (callback methods for
> > authroization of transactions return a significant value, i.e. not a
> > simple signal, so an agent is also required).
> >
> > 
> >
> > But none of these conditions apply in the HDP agent above. So is there
> > another reason?
> 
> I explained above.
> 
> If we are wrong and signals can be cached only by one process it is OK for
> us  to change this.
> 
> > 
> >
> > Also, why not add properties for
> > connected/disconnected/opened/closed/etc. states? (And then
> > "GetProperties()" method, and "PropertyChanged(name, value)" signal).
> > For example, see "bluez/docs/network-api.txt"...
> 
> Because this notifications concern to objects that are being created and 
> destroyed (in the case of devices) and created or closed data channels, so
> new  data channels ids are created or destroyed when this method are
> called. I can't see how properties can help here. The channel may exist or
> not I think that properties are not a good option in this case.
> 
> Regards.

Any comments about this issue. It will be great to receive a little bit more 
of feedback in order to decide one of this two options.

