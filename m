Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050424134746.GA31151@externe.net>
References: <1114345112.10706.64.camel@pegasus>
	 <20050424134746.GA31151@externe.net>
Content-Type: text/plain
Message-Id: <1114355799.10706.91.camel@pegasus>
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
Date: Sun, 24 Apr 2005 17:16:39 +0200

Hi Guylhem,

> > I also got first results with the HP headphone by adding an usleep(2500)
> > for every SBC frame. It is also needed to pack as most SBC frames into
> > an AVDTP frame as possible. In my case this was up to eight. So this is
> > all about the timing. The perfect thing now would be if we can tell ALSA
> > to time everything for us. Problem is that I am not an audio expert and
> > also not an ALSA expert. Maybe the SBC encoder should return/store the
> > time the SBC frame is encoded for.
> >
> > Comments? Ideas?
> 
> (A question first - did you add the usleep to Mayank code? I'll then
> take it and try to optimise it for ARM. Last time I just made it
> barely compile :-)

no and it is totally a hack that only works on my P4-HT desktop systems.
The time to wait will also depend on the time the SBC encoder needs to
actually create the SBC frame. And this of course depends on the CPU
etc.

> Then my rant- why everyone wants an alsa plugin? It's ugly!

ALSA is not prefect and it has it edges, but it is far away from ugly.
It is actually the only sane thing to do on the desktop.

> IMHO a2dp will be mostly useful for embedded system or in specific
> applications on desktop systems (xmms, etc). Having to use alsa is at
> best useless and at worse a potential showstopper.

So you are going to write IO plugins for Gnomemeeting, Totem, xine,
mplayer, sox, mpg123 and so on. Have fun with it ;)

> - on most embedded systems resources are scarce. Having to include
> alsa for what can be currently done from the command line is a bad idea

We are not talking here about ALSA and its pcm_a2dp plugin for embedded
systems. The point for the plugin is the desktop and in the case of the
embedded system you can come up with something by yourself. The only
hard part of A2DP is the SBC encoder/decoder. And this will stay generic
as a library.

> - I think ideally a standalone application would be best suited for
> this. The standalone application could be built over mpg321, some ogg
> player, whatever, and do the mp3/ogg decoding, sbc encoding and a2dp
> streaming until some dedicated tool manage a2dp streaming.
> It would be much easier to optimise for embedded systems - most don't
> have a FPU, so minimizing floating point operation is very important

You are mixing things up here. The AVDTP only describes the transport
protocol and it don't uses floating point. The A2DP profile only talks
about how to deal with AVDTP and how to put the SBC frames into the
AVDTP payload. Here are also no floating point operations involved. Now
we come down to the SBC encoding and decoding and yes, this can be
problematic for embedded systems (especially if they don't have a FPU),
but you can come up with an all integer based implementation of SBC and
I am happy to adapt it (as long as it is under LGPL).

> - on desktop systems a2dp could also be managed by a standalone
> application, which could be an audio out plugin for xmms/mplayer etc.
> This plugin would also manage sbc encoding and a2dp streaming until
> some dedicated tool manage a2dp streaming.

Again. Too many plugin to be written. This is why you are going to
choose ALSA as a middle layer between applications and the actual sound
hardware. A Bluetooth A2DP headphone is a virtual soundcard. Nothing
more and nothing less. View it from this point and realize that they
only replaces the PCI bus with a Bluetooth connection. It is not that
easy in reality, but you must look at it this way.

> - for kernel integration, linus &co may not be interested in a
> kernel-side sbc decoder- they will certainly ask for a /dev/ entry
> taking the native format - in that case already encoded sbc. Remember
> the mono/stereo and 48 kHz rants:
> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2001-July/003997.html
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.3/0324.html
> 
> So my suggestion, at least until a good strategy has been defined, would
> be to use a2play as a work base, and add mp3/ogg decoding - the "all
> in one" approach. Quite easy to test, enhance, fix, finetune, etc -
> better IMHO that separate tools for the moment.

Actually we used a2play as working and test base and we learned a lot.
Now it is time to get this knowledge into the right shape and make it
easy for the end user who wants to use its new A2DP headphone with
Linux.

> Later on, like rfcomm manages rfcomm0 etc. entries, some a2dp tool
> could bind a2dp peripherals to /dev/a2dpN where SBC audio would be
> expected and streamed to the a2dp peripheral bound there.
> 
> Then, applications would simply write to that device in sbc encoded
> format. A first candidate application would be a2play [if it follows
> the "all in one" approach], which would simply have to be stripped of
> its current main function [sbcencoding, a2dp streaming], to become a
> mp3/ogg to sbc decoder writting to /dev/a2dpN [that's why I advocate a
> all-in-one approach]

We are going do this approach, but we will use sockets for it, because
simple character devices makes no sense. The main interface for RFCOMM
is also a socket and the RFCOMM TTYs are only for legacy apps.

The point in not doing it at the moment is, because it is too much work.
Writing a kernel layer (it is not a driver) for AVDTP is quite complex
and I don't wanna deal with it at the moment. There are other things to
do that have a higher priority on my todo list. For example the L2CAP
flow control and retransmission support.

But if this AVDTP kernel layer will be there, the pcm_a2dp ALSA plugin
will use it and there is no visible change to for the end user. The
advantage will be that you can also use AVDTP (also for video streaming)
for any other application. If then someone comes up with an integer
version of the SBC codec, I may think about moving that into the kernel,
too. But to be honest, this is future talk and has nothing to do with
reality right now.

> Please don't take that personally, I just want to offer my opinion on
> the right way to do that. I fear an alsa plugin will cause immediate
> problems (to me on ARM systems) then later or for kernel integration.

No offense taken. And actually I asked for comments :)

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
