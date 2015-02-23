Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Feb 2015 15:09:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery
 method.
Message-ID: <20150223130923.GA28722@t440s.lan>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
 <CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Feb 16, 2015, Luiz Augusto von Dentz wrote:
> > +               void StartFilteredDiscovery(dict filter)
> > +
> > +                       This method starts the device discovery session with
> > +                       filtering by uuids, and rssi or pathloss value. Use
> > +                       StopDiscovery to release the sessions acquired.
> > +
> > +                       Parameters that can be set in filter dictionary include
> > +                       the following:
> > +
> > +                       array{string} UUIDs : filtered service UUIDs (required)
> > +                       int16 RSSI      : RSSI threshold value (optional)
> > +                       uint16 pathloss : Pathloss threshold value (optional)
> > +                       string transport: type of scan to run
> > +
> > +                       When a device is found that advertise any UUID from
> > +                       UUIDs, it will be reported if:
> > +                       - pathloss and RSSI are both empty,
> > +                       - only pathloss param is set, device advertise TX pwer,
> > +                         and computed pathloss is less than pathloss param,
> > +                       - only RSSI param is set, and received RSSI is higher
> > +                         than RSSI param,
> > +
> > +                       transport parameter determines the type of scan:
> > +                               "auto"  - interleaved scan
> > +                               "bredr" - br/edr inquiry
> > +                               "le"    - le only scan, default value
> > +
> > +                       This process will start creating Device objects as new
> > +                       devices matching criteria are discovered. It will also
> > +                       emit PropertiesChanged signal for already existing
> > +                       Device objects, with updated RSSI value.
> > +
> > +                       StartDiscovery (SD) takes precedence over
> > +                       StartFilteredDiscovery (SFD). That means that you should
> > +                       check Discovering property before calling SFD, otherwise
> > +                       it would fail when any SD session is in progress.
> > +                       Calling SD when SFD is in progress pause all SFD
> > +                       sessions, and start them back when all SD sessions are
> > +                       finished. When filtered discovery state is changed,
> > +                       FilteredDiscovery variable is updated accordingly.
> > +
> > +                       Possible errors: org.bluez.Error.NotReady
> > +                                        org.bluez.Error.Failed
> > +
> >                 void StopDiscovery()
> >
> >                         This method will cancel any previous StartDiscovery
> > @@ -144,6 +188,11 @@ Properties string Address [readonly]
> >
> >                         Indicates that a device discovery procedure is active.
> >
> > +               boolean FilteredDiscovery [readonly]
> > +
> > +                       Indicates that a filtered device discovery procedure is
> > +                       active.
> > +
> >                 array{string} UUIDs [readonly]
> >
> >                         List of 128-bit UUIDs that represents the available
> > --
> > 2.2.0.rc0.207.ga3a616c
> 
> @Marcel, Johan: Is this API okay for you? We should probably make them
> experimental to begin with.

For the most part I'm fine with this, especially if it's marked as
experimental. As for the relationship to StartDiscovery, I'd take a
similar approach as we have done with the mgmt API, i.e. StartDiscovery
would be just a special kind of filtered discovery without any filters
(i.e. reporting all devices).

For the case of multiple applications requesting different discoveries
at the same time we'd go with the common denominator approach, i.e.
applications must be prepared to see devices outside of the range of
filters that it has specified (the only way to avoid something like that
support is to do unicast D-Bus signals which in turn would break
"passive observer" applications). Calling StartDiscovery when there are
one or more service discoveries in progress would simply clear out the
filters and start reporting all devices.

Considering the above style approach, the new property seems a bit
pointless.

Since we can't any more track multiple different discoveries within the
same application (D-Bus connection) the StopDiscovery behavior is now
quite broken. The simplest way around that would be to add a discovery
instance return parameter to StartServiceDiscovery and to have a new
StopServiceDiscovery D-Bus method that'd take this as an input
parameter.

Johan
