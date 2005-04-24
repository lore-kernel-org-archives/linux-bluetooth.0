Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050424171103.GB12143@externe.net>
References: <1114345112.10706.64.camel@pegasus>
	 <20050424134746.GA31151@externe.net> <1114355799.10706.91.camel@pegasus>
	 <20050424171103.GB12143@externe.net>
Content-Type: text/plain
Message-Id: <1114366176.10706.116.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 24 Apr 2005 20:09:36 +0200

Hi Guylhem,

> > > Then my rant- why everyone wants an alsa plugin? It's ugly!
> > 
> > ALSA is not prefect and it has it edges, but it is far away from ugly.
> > It is actually the only sane thing to do on the desktop.
> 
> Alsa is not ugly - I mean a plugin to do that is :-)

no it is not. I can't understand why do you think that.

> > So you are going to write IO plugins for Gnomemeeting, Totem, xine,
> > mplayer, sox, mpg123 and so on. Have fun with it ;)
> 
> (I won't :-)

So you understand why an ALSA plugin is the only way to support every
audio capable application.

> Brad who now has an xscale board now realise how much precious space
> is. Honnestly using alsa is only good if you consider existing
> applications. But then did you read Nicolas Pitre and Alan Cox
> replies? Apps should be fixed - nothing else.
> 
> Another API idea:
> /dev/a2dp_capabilities
> 
> listing the existing a2dp devices associated, their bt address, the
> audio formats they support
> /dev/a2dp1
> /dev/a2dp2
> etc.

Please stop designing weird interface. As I said the prefered thing is a
socket API if we move AVDTP into the kernel.

And as a sidenote, you need a connection before you can request the
capabilities of the headphone. It is not going to work your way.

> mplayer/etc. plugins would have to open the first file before sending
> audio to the second file. This would avoid wasting almost 1 Mb for alsa.
> 
> An alsa "plugin" could certainly also take advantage of that approach -
> it would simply do like an mplayer plugin, doing the same thing a
> mplayer plugin would do. It'd just have to be a daemon going the
> recoding etc. in user space. Much cleaner, and desktop compatible.

This is not cleaner. It is more ugly. You must put the application
aside. We have ALSA and OSS and sound interfaces and ALSA is used by
almost every distribution by now. So once we get A2DP to play nice with
ALSA every audio application works.

> > for any other application. If then someone comes up with an integer
> > version of the SBC codec, I may think about moving that into the kernel,
> > too. But to be honest, this is future talk and has nothing to do with
> > reality right now.
> 
> IMHO an encoder doesn't belong to the kernel.

I know, but it is still an option. Not my preferred one, but still an
option.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
