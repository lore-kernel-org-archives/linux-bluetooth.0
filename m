Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <d1f423d305030804193af34558@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Troubles cross-compiling utils... Resolved?
In-Reply-To: <4208B84C00014D22@resmta04.ono.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <4208B84C00014D22@resmta04.ono.com>
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
Date: Tue, 8 Mar 2005 07:19:29 -0500

Hi,


I had some problems too and in my case changing the makefile manually
worked well. I sent a manual describing my expirience on
crosscompiling Bluez for ARM using Scratchbox.

Cheers,


On Tue, 8 Mar 2005 02:08:38 +0100, kwyjibo@ono.com <kwyjibo@ono.com> wrote:
> Hi, I found some troubles cross-compiling for Compulab ARM unit. First of
> all, I tried to do  it with gcc 3.3.2, but there were many problems, so I
> come back to 2.95.3, which it seems to be more kind...
>=20
> First, I use this command, in addition with enviroment variables to tell
> where the crosscompiling chain is located (v.g CC=3D/usr/local/arm/2.95.3=
/bin/arm-linux-gcc,
> LD=3D/...)
>=20
> ./configure --prefix=3D/mnt/image --host=3Darm --with-bluez=3D/mnt/img/li=
b
>=20
> The first problem I found is that it doesn't find the headers, but the co=
nfigure's
> help doesn't say nothing about that... I tried,  like in other releases:
>=20
> ./configure --prefix=3D/mnt/image --host=3Darm --with-bluez=3D/mnt/img/li=
b --with-bluez-includes=3D/mnt/image/include
>=20
> But throws the same error. I tried this, as I did before.
>=20
> ./configure --prefix=3D/mnt/image --host=3Darm --with-bluez-libs=3D/mnt/i=
mage/libs
> --with-bluez-includes=3D/mnt/image/include
>=20
> And now I passed the configure with no errors...
>=20
> Next I tried to make, and compiling one of the tools it stopped:
>=20
> /usr/local/arm/2.95.3/bin/arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..    -=
I/mnt/image/include
>  -I/mnt/image/include -Wall -O2 -c `test -f 'hcisecfilter.c' || echo './'=
`hcisecfilter.c
> /usr/local/arm/2.95.3/bin/arm-linux-gcc -I/mnt/image/include  -I/mnt/imag=
e/include
> -Wall -O2   -o hcisecfilter  hcisecfilter.o  -lbluetooth
> /usr/local/arm/2.95.3/arm-linux/bin/ld: cannot find -lbluetooth
>=20
> I notice that the tool app compiled before that was
>=20
> /usr/local/arm/2.95.3/bin/arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..    -=
I/mnt/image/include
>  -I/mnt/image/include -Wall -O2 -c `test -f 'ppporc.c' || echo './'`pppor=
c.c
> /usr/local/arm/2.95.3/bin/arm-linux-gcc -I/mnt/image/include  -I/mnt/imag=
e/include
> -Wall -O2   -o ppporc  ppporc.o -L/mnt/image/lib -lbluetooth -lbluetooth
>=20
> So I noticed that this one includes -L/mnt/image//lib, I edited the makef=
ile
> of the tool directory, adding that directory to the tools who needed, and
> I managed to compile them...
>=20
> I haven't tested yet, so I don't know if this is right, but may be it be
> useful to someone.
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


--=20
Anderson Clayton B. Rodrigues
Eng. de Software
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
