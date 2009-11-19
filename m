Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Nov 2009 15:13:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Alexander H Deriziotis <deriziotis@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Connecting to Bluetooth Speakers via command line
Message-ID: <20091119131350.GA5256@jh-x301>
References: <5eee8c670911190321gd44f7f4x522dc8af67e19c2f@mail.gmail.com>
 <20091119123535.GA4305@jh-x301>
 <1258635027.2150.9168.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1258635027.2150.9168.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Nov 19, 2009, Bastien Nocera wrote:
> > I think the Bluetooth applet is using the org.bluez.Audio.Connect D-Bus
> > method to create the connection. You can call it from the command line
> > using e.g. the attached python script (I also realized this was missing
> > from the bluez source tree so it's now added there too). I also think
> > that it could be a nice feature if in the Bluetooth applet you could
> > mark devices to be auto-connected when the applet starts.
> 
> We could probably have it try to connect to all the known audio devices
> on startup, but that'd probably break some things when multiple devices
> can be used.

Yes, and it'd also be quite bad if a user has lots of paired devices.
Each connect attempt to a device that's not connectable or within range
would block the Bluetooth adapter for the page timeout duration which is
typically between 5 and 20 seconds.

> How about trying to connect to the last used audio device? That would
> probably solve most use cases, and avoid surprises.

Yeah, that sounds like a better option to me. Maybe it would also make
sense to make this configurable since I have a feeling that not all
people will want to have their PC exhibiting this kind of behavior upon
bootup.

> Do you want to file a bug against gnome-bluetooth to ask for that? I'll
> try to implement it then.

Since I personally don't have a strong need for this feature I think
it'd be good if Alexander who originally brought up the issue would do
it so he can also do the fix verification later on.

Johan
