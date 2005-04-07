Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <d1f423d30504070519333f3148@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Build BlueZ Libs and BluzZ Utils for ARM
In-Reply-To: <BAY20-F20A55F402EB690A199F6BD853E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <BAY20-F20A55F402EB690A199F6BD853E0@phx.gbl>
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
Date: Thu, 7 Apr 2005 08:19:16 -0400

Martin,


There is a tool called scracthbox that you can use to compile your
code. It gaves you and artificial environment which lets you compile
for especific platforms. I have not any experience with your platform
at all, but i have some with Innovator 1510 and 5912 and It worked
fine for both.

I posted a little tutorial about how to compiling and testing bluez on
those platforms. Maybe you can use it as a start.

Regards

On Apr 7, 2005 6:06 AM, Martin Rolsted Jensen <mrj_ing@hotmail.com> wrote:
> Hello everybody!
>=20
> First of all thanks to Peter Wippich for his help - it gave me a clue,
> but=A1K!
>=20
> I am currently working on a triton1 board with a pxa255 module. I want to
> connect a UART Bluetooth module to the board (WML-C20AH).
> The first thing I did was to configure the kernel (2.6.10) to support
> Bluetooth. As far as I can see in the boot sequence of Linux, the ttyBT
> interface is controlled by the standard ttyS1.
>=20
> Peter told me to build BlueZ Libs and then BluzZ Utils for my platform =
=A1V I
> got that, marvellous.
> My new question is how to build those on a host-PC for my arm-board (no g=
cc
> on that board).
> Am I going to get them precompiled - if so were to get them, and how to
> install (step by step).
> I am newbie to Linux =83=BA
>=20
> Best Regards
>=20
> Martin Rolsted Jensen
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
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
