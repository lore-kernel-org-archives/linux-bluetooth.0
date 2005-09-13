Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <8eddf07b0509130429406261a5@mail.gmail.com>
From: Wu Jason <superht001@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1126592735.28181.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8eddf07b050912011254a84668@mail.gmail.com>
	 <1126563492.5518.0.camel@localhost.localdomain>
	 <8eddf07b05091223105952b949@mail.gmail.com>
	 <1126592735.28181.2.camel@localhost.localdomain>
Subject: [Bluez-users] Re: I can't compile with -lbluetooth
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 13 Sep 2005 19:29:54 +0800

Hi,

Thanks for your reply,=20
but all package I can find on official web site are:

bluez-libs-2.21.tar.gz=20
bluez-utils-2.21.tar.gz=20
bluez-pin-0.26.tar.gz=20
bluez-firmware-1.0.tar.gz=20
bluez-hcidump-1.25.tar.gz=20
bluez-hciemu-1.2.tar.gz=20

There was no package you said.

By the way, I attach the error message generated when I compile

[root@localhost c]# gcc -o rfcomm-server rfcomm-server.c -lbluetooth
/usr/bin/ld: cannot find -lbluetooth
collect2: ld returned 1 exit status

[root@localhost c]# gcc -o rfcomm-server rfcomm-server.c -llibbluetooth
/usr/bin/ld: cannot find -llibbluetooth
collect2: ld returned 1 exit status


On 9/13/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>=20
> > Sorry I don't know what do you mean bluez devel package,=20
> > the following are packages default installed:
> >=20
> > [root@localhost ~]# rpm -qa | grep ^bluez
> > bluez-libs-2.10-2
> > bluez-hcidump-1.11-1
> > bluez-bluefw-1.0-6
> > bluez-utils-2.10-2
> >=20
> > Did I miss something?=20
>=20
> I think the package is called bluez-libs-devel.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
