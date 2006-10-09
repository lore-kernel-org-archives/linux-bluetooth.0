Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 9 Oct 2006 11:04:50 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061009090450.GI28087@suse.de>
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
	<1159972670.1601.25.camel@localhost>
	<3f5a9ba20610072313w41cb4aa1qf0b5a21a7199f737@mail.gmail.com>
	<1160314144.4258.8.camel@aeonflux.holtmann.net>
	<3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
Subject: Re: [Bluez-devel] About the kernel 2.6.18
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Mon, Oct 09, 2006 at 10:57:53AM +0800, Mingfan.Lu wrote:
> Hi,
> I am just use the Bluetooth OBEX Object Push client (0.99 beta1).
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Host:
> Vmware 5.5
> OS: Suse 10.1
> bluetooth dongle: 1.2
> File pushed: testpkg whose size is 137956B
> =

> Target:
>  Nokia E61
> =

>  kernel version: 2.6.16.13-4 (built from Suse 10.1) about 11-12s   kernel
> version: 2.6.16.13-4 (rebuilt from above) about 11-12s
>  kernel version: 2.6.17 (built from kernel.org)  about 11-12s
>  kernel version: 2.6.18: about  145s
>  kernel version: 2.6.18 with mh4 (built with the patch from bluez):   143s
> 146s

This means that ~1000bytes/second are transferred. I am using 2.6.18 with =

ppp-via-rfcomm and it does get me at least 45kB/second (3G/UMTS speed), with
a sony-ericsson k600i as target, so there are configurations where it still
works fine.

> Too terrible!!!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> using other RFCOMM applications, 2.6.18 is slower too.

Well, apparentely not everywhere and not for everybody.
-- =

Stefan Seyfried                     | "Please, just tell people
QA / R&D Team Mobile Devices        |               to use KDE."
SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
