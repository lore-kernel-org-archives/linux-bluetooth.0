Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100810291527w6d5c4615udcb450d49e68702@mail.gmail.com>
Date: Wed, 29 Oct 2008 19:27:44 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004e01c939db$5c241760$146c4620$@de>
MIME-Version: 1.0
References: <001501c9381a$022b7f40$06827dc0$@de>
	<d89ddf300810271213w53d8d179gc3af2f89c37bea47@mail.gmail.com>
	<1225136516.7157.22.camel@californication>
	<004e01c939db$5c241760$146c4620$@de>
Cc: Frans de Bont <frans.de.bont@philips.com>
Subject: Re: [Bluez-devel] REALLY Bad encoding performance of Linux SBC
	audio codec
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

Thanks for doing those tests, we never really have a method for
testing the sbc codec, so PEAQ could be a good start. By looking the
results it seems that our decoder is not really in good shape, which
is not a surprise since we normally only use the encoder part. As for
comparison with the reference implementation, bluez sbc codec does not
use floating point as the reference codec seems to be using, so this
may well be impacting on quality, although we probably gain some
speed.

Other points we might need to consider:
  - Test with different audio source/parameter. (48000hz/mono/28
bitpool is not that common to be used as reference)
  - Mono seems to surfer from quality problems which may cause the problem.
  - Consider working on a gstreamer element for doing live tests based
on ITU BS.1387 (PEAQ)
  - Also consider using liboil as alternative for using floating point.

BTW, don't assume something is bad just because it produces different
results than the reference, as far I can tell you one cannot really
notice _any_ difference between bluez sbc codec and logitech freepulse
e(enhanced)sbc, so on real world we are not that _bad_.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
