Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] Bluez on Axis DevBoard 82
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB2364EC@exmail1.se.axis.com>
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: =?iso-8859-1?Q?=22Daniel_W=FCrfel=22?= <dice-box@web.de>
Cc: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 5 Aug 2004 14:45:13 +0200

The errors below do not look like they have anything to do with
BlueZ, but rather with your DevBoard installation. Try asking
the question again on the correct list (i.e., dev-etrax@axis.com)
and provide more information as to what you have changed.=20

Here are some points you can investigate yourself first though:

Make sure the libbluetooth.so library is compiled for CRIS=20
(you can check with 'readelf -h libbluetooth.so.1.0.3').

The error about ld-linux.so.2 indicates that you have built
something (probably the libbluetooth.so library) for glibc
rather than uClibc...

//Peter

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> "Daniel W=FCrfel"
> Sent: 05 August 2004 12:51
> To: bluez-devel@lists.sourceforge.net
> Subject: [Bluez-devel] Bluez on Axis DevBoard 82
>=20
> Hi,
>=20
> I use the kernel 2.4.22 and bluez-utils-2.5 and=20
> bluez-libs-2.4, bacause I have a Makefile for the=20
> bluetooth-directory that should work. But I am not sure. make=20
> install works fine, but when I want to make images, I always=20
> get an error.=20
> I have searched in the archive for hints, but those I found=20
> (including a Makefile) have not solved this problem.
> Can anybody help me?
> Has anybody a better working Makefile for those versions or=20
> even for the latest versions of bluez?
> Thanks,
> Daniel W=FCrfel
>=20
> [root@localhost devboard_82]# make images
> ##### Including needed shared library files #####
> perl: warning: Setting locale failed.
> perl: warning: Please check that your locale settings:
>         LANGUAGE =3D (unset),
>         LC_ALL =3D "CC",
>         LC_LANG =3D "CC",
>         LANG =3D "CC"
>     are supported and installed on your system.
> perl: warning: Falling back to the standard locale ("C").
> strip-cris: Warning: Output file cannot represent=20
> architecture UNKNOWN!
> libbluetooth.so.1 -> libbluetooth.so.1.0.3
> #### No ld-linux.so.2 in=20
> /var/test/axis/devboard_82/target/cris-axis-linux-gnu/usr/lib=20
> /var/test/axis/devboard_82/target/cris-axis-linux-gnu/lib
> make: *** [cramfs.img] Error 1
> [root@localhost devboard_82]#


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
