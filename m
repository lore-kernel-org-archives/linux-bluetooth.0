Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
Message-ID: <20050424134746.GA31151@externe.net>
References: <1114345112.10706.64.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1114345112.10706.64.camel@pegasus>
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
Date: Sun, 24 Apr 2005 09:47:47 -0400

On Sunday, 24 April 2005 at 14:18:32 (+0200), Marcel Holtmann wrote:
> I also got first results with the HP headphone by adding an usleep(2500=
)
> for every SBC frame. It is also needed to pack as most SBC frames into
> an AVDTP frame as possible. In my case this was up to eight. So this is
> all about the timing. The perfect thing now would be if we can tell ALS=
A
> to time everything for us. Problem is that I am not an audio expert and
> also not an ALSA expert. Maybe the SBC encoder should return/store the
> time the SBC frame is encoded for.
>
> Comments? Ideas?

(A question first - did you add the usleep to Mayank code? I'll then
take it and try to optimise it for ARM. Last time I just made it
barely compile :-)

Then my rant- why everyone wants an alsa plugin? It's ugly!

IMHO a2dp will be mostly useful for embedded system or in specific
applications on desktop systems (xmms, etc). Having to use alsa is at
best useless and at worse a potential showstopper.

- on most embedded systems resources are scarce. Having to include
alsa for what can be currently done from the command line is a bad idea

- I think ideally a standalone application would be best suited for
this. The standalone application could be built over mpg321, some ogg
player, whatever, and do the mp3/ogg decoding, sbc encoding and a2dp
streaming until some dedicated tool manage a2dp streaming.
It would be much easier to optimise for embedded systems - most don't
have a FPU, so minimizing floating point operation is very important

- on desktop systems a2dp could also be managed by a standalone
application, which could be an audio out plugin for xmms/mplayer etc.
This plugin would also manage sbc encoding and a2dp streaming until
some dedicated tool manage a2dp streaming.

- for kernel integration, linus &co may not be interested in a
kernel-side sbc decoder- they will certainly ask for a /dev/ entry
taking the native format - in that case already encoded sbc. Remember
the mono/stereo and 48 kHz rants:
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2001-July/003997=
.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.3/0324.html

So my suggestion, at least until a good strategy has been defined, would
be to use a2play as a work base, and add mp3/ogg decoding - the "all
in one" approach. Quite easy to test, enhance, fix, finetune, etc -
better IMHO that separate tools for the moment.

Later on, like rfcomm manages rfcomm0 etc. entries, some a2dp tool
could bind a2dp peripherals to /dev/a2dpN where SBC audio would be
expected and streamed to the a2dp peripheral bound there.

Then, applications would simply write to that device in sbc encoded
format. A first candidate application would be a2play [if it follows
the "all in one" approach], which would simply have to be stripped of
its current main function [sbcencoding, a2dp streaming], to become a
mp3/ogg to sbc decoder writting to /dev/a2dpN [that's why I advocate a
all-in-one approach]

Please don't take that personally, I just want to offer my opinion on
the right way to do that. I fear an alsa plugin will cause immediate
problems (to me on ARM systems) then later or for kernel integration.

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
