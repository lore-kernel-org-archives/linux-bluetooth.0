Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dimitry Andric <dimitry@andric.com>
Message-ID: <35666156.20050506103036@andric.com>
To: Guylhem Aznar <bluez-devel@externe.net>
Cc: bluez-devel@lists.sourceforge.net, steve.crane@rococosoft.com
Subject: Re: [Bluez-devel] cross compiling bluez 2.16 for arm (Zaurus)
In-Reply-To: <20050505182213.GA22967@externe.net>
References: <20050505182213.GA22967@externe.net>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg="pgp-sha1";
  boundary="----------8418AD16D9B1D1"
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
Date: Fri, 6 May 2005 10:30:36 +0200

------------8418AD16D9B1D1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 2005-05-05 at 20:22:13 Guylhem Aznar wrote:

> arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..
> -I/home/guylhem/bluez-libs-2.16//include  -I/usr/include -Wall -O2
> -c `test -f 'sdptool.c' || echo './'`sdptool.c
> /tmp/ccsosFZV.s: Assembler messages:
> /tmp/ccsosFZV.s:1094: Error: bad instruction `rorw $8,r4'
> /tmp/ccsosFZV.s:1094: Error: bad instruction `rorl $16,r4'
> /tmp/ccsosFZV.s:1094: Error: bad instruction `rorw $8,r4'
> /tmp/ccsosFZV.s:1096: Error: bad instruction `rorw $8,r3'
> /tmp/ccsosFZV.s:1099: Error: bad instruction `rorw $8,r2'
> /tmp/ccsosFZV.s:1102: Error: bad instruction `rorw $8,r3'
> /tmp/ccsosFZV.s:1105: Error: bad instruction `rorw $8,r2'
> /tmp/ccsosFZV.s:1105: Error: bad instruction `rorl $16,r2'
> /tmp/ccsosFZV.s:1105: Error: bad instruction `rorw $8,r2'
> /tmp/ccsosFZV.s:1108: Error: bad instruction `rorw $8,r3'

This usually means there's something wrong with your toolchain.
Please run exactly the same command line, but then with the "-v"
option to arm-linux-gcc, and mail us the output.

------------8418AD16D9B1D1
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCeysssF6jCi4glqMRAp15AJ94eTkunYr20xP/08nQokMSpduZRgCfduLz
qyZS4fUXS2rDRv/9LbqzIlA=
=6UPX
-----END PGP MESSAGE-----

------------8418AD16D9B1D1--



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
