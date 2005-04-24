Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <mutt-ibiblio@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
Message-ID: <20050424171103.GB12143@externe.net>
References: <1114345112.10706.64.camel@pegasus> <20050424134746.GA31151@externe.net> <1114355799.10706.91.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1114355799.10706.91.camel@pegasus>
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
Date: Sun, 24 Apr 2005 13:11:03 -0400

Hello,

On Sunday, 24 April 2005 at 17:16:39 (+0200), Marcel Holtmann wrote:
> > Then my rant- why everyone wants an alsa plugin? It's ugly!
>=20
> ALSA is not prefect and it has it edges, but it is far away from ugly.
> It is actually the only sane thing to do on the desktop.

Alsa is not ugly - I mean a plugin to do that is :-)

> So you are going to write IO plugins for Gnomemeeting, Totem, xine,
> mplayer, sox, mpg123 and so on. Have fun with it ;)

(I won't :-)

Brad who now has an xscale board now realise how much precious space
is. Honnestly using alsa is only good if you consider existing
applications. But then did you read Nicolas Pitre and Alan Cox
replies? Apps should be fixed - nothing else.

Another API idea:
/dev/a2dp_capabilities

listing the existing a2dp devices associated, their bt address, the
audio formats they support
/dev/a2dp1
/dev/a2dp2
etc.

mplayer/etc. plugins would have to open the first file before sending
audio to the second file. This would avoid wasting almost 1 Mb for alsa.

An alsa "plugin" could certainly also take advantage of that approach -
it would simply do like an mplayer plugin, doing the same thing a
mplayer plugin would do. It'd just have to be a daemon going the
recoding etc. in user space. Much cleaner, and desktop compatible.

> We are going do this approach, but we will use sockets for it, because
> simple character devices makes no sense. The main interface for RFCOMM
> is also a socket and the RFCOMM TTYs are only for legacy apps.

(Ok never mind)

> for any other application. If then someone comes up with an integer
> version of the SBC codec, I may think about moving that into the kernel=
,
> too. But to be honest, this is future talk and has nothing to do with
> reality right now.

IMHO an encoder doesn't belong to the kernel.

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
