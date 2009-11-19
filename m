Return-Path: <cyrus@holtmann.org>
Subject: Re: Connecting to Bluetooth Speakers via command line
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Alexander H Deriziotis <deriziotis@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20091119123535.GA4305@jh-x301>
References: <5eee8c670911190321gd44f7f4x522dc8af67e19c2f@mail.gmail.com>
	 <20091119123535.GA4305@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Nov 2009 12:50:27 +0000
Message-ID: <1258635027.2150.9168.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-11-19 at 14:35 +0200, Johan Hedberg wrote:
> Hi Alex,
> 
> On Thu, Nov 19, 2009, Alexander H Deriziotis wrote:
> > In Ubuntu 9.10 the Bluetooth applet has improved functionality for
> > managing connected devices. Once I pair my Bluetooth speakers with my
> > computer, I can click on the Bluetooth applet, select my speakers and
> > click ‘Connect’ in order to establish a connection.
> > 
> > This seems to automatically connect to the speakers and create a
> > pulseaudio sink for me which I can use, however, every time I reboot,
> > I need to manually click on Connect again to get my sink back.
> > 
> > Is there any way to connect to my Bluetooth speakers from the
> > command-line, so that I can set-up my system to automatically use the
> > relevant sink whenever I boot-up?
> 
> I think the Bluetooth applet is using the org.bluez.Audio.Connect D-Bus
> method to create the connection. You can call it from the command line
> using e.g. the attached python script (I also realized this was missing
> from the bluez source tree so it's now added there too). I also think
> that it could be a nice feature if in the Bluetooth applet you could
> mark devices to be auto-connected when the applet starts.

We could probably have it try to connect to all the known audio devices
on startup, but that'd probably break some things when multiple devices
can be used.

How about trying to connect to the last used audio device? That would
probably solve most use cases, and avoid surprises.

Do you want to file a bug against gnome-bluetooth to ask for that? I'll
try to implement it then.

Cheers

