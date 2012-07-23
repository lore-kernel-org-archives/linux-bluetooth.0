Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: Bartosz Szatkowski <bulislaw@linux.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Re: [PATCH BlueZ v2 1/3] Add SetRemoteProperties method for OOB COD setting
Date: Mon, 23 Jul 2012 13:15:21 +0200
Message-ID: <41983003.gzgoGV19lR@uw000953>
In-Reply-To: <20120628113321.GA18209@x220>
References: <1314014944-21554-1-git-send-email-bulislaw@linux.com> <20120628113321.GA18209@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 28 of June 2012 14:33:21 Johan Hedberg wrote:
> Hi Bartosz (and whoever is interested in OOB pairing),

Hi,
 
> On Mon, Aug 22, 2011, Bartosz Szatkowski wrote:
> > Add method for suppling class of device through OOB mechanism, to be
> > available at pairing phase. At this point it may be presented to the
> > user, by agent, in confirmation request (or whatever).
> > ---
> >  doc/oob-api.txt   |   13 ++++
> >  plugins/dbusoob.c |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 177 insertions(+), 0 deletions(-)
> 
> These patches never went upstream but I'd like to revive the discussion
> around them.
> 
> > diff --git a/doc/oob-api.txt b/doc/oob-api.txt
> > index d838712..0324758 100644
> > --- a/doc/oob-api.txt
> > +++ b/doc/oob-api.txt
> > @@ -36,3 +36,16 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
> >  
> >  			Possible errors: org.bluez.Error.Failed
> >  					 org.bluez.Error.InvalidArguments
> > +
> > +		void SetRemoteProperties(string address, dict data)
> > +
> > +			This method set new properties for device with specified
> > +			address, to be used when device is created.
> > +			On success DeviceFound signal will be emitted.
> > +
> > +			Currently supported keys:
> > +
> > +				Class		uint32
> > +
> > +			Possible errors: org.bluez.Error.Failed
> > +					 org.bluez.Error.InvalidArguments
> 
> Now that we're starting to prepare BlueZ 5 we can make more radical
> changes to the D-Bus APIs. E.g. I don't think we need a separate
> SetRemoteProperties method but the existing AddRemoteData one could
> simply be changed to take a dictionary which would usually just include
> the keys "Randomizer" and "Hash" but could also include other info like
> "Class".

In general dbusoob was intended to be only simple dbus wrapper for oob.h
functionality (mostly for testing purposes) and proper oob channel 'backend'
should be used with real usecases. But dbusoob is still usefull if one wants
to have oob handling developed outside of bluez (e.g. as some Android application).

I think changing to dictionary is good move as this will make API more
flexible and easier to extend.

Yet, I'm not sure how we should handle other (than hash and randomizer) info
coming from oob channel. Just write it down so we can show them in device
properties after pairing? Or simulate inquiry result with device found signal
(as with commented patch)? Second would probably require some additional comments
in adapter api.

> 
> Thoughts? Is anyone actually actively using the current OutOfBand D-Bus
> interface?

Some time ago I've created patch(es) [1] for Android ICS that make use of dbusoob
api instead of google's bluez oob implementation.

Also neard is currently using dbusoob but this should be dropped in favor of neard
specific plugin in bluez.


[1] https://android-review.googlesource.com/#/c/36650/

-- 
BR
Szymon Janc
