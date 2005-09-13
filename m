Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <8eddf07b050913071147ada120@mail.gmail.com>
From: Wu Jason <superht001@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: I can't compile with -lbluetooth
In-Reply-To: <20050913133105.61DEA1EC7A1@mrelay1.st2.lyceu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8eddf07b0509130429406261a5@mail.gmail.com>
	 <20050913133105.61DEA1EC7A1@mrelay1.st2.lyceu.net>
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
Date: Tue, 13 Sep 2005 22:11:07 +0800

Hi,

Thanks for your help,=20
After I installed the libarary, I can compile the code.

On 9/13/05, Esther Lopez <esther.lopez@erzia.com> wrote:
> Hi
> I had quite the same problem in Fedora 4, and I solved it by installing t=
he
> "bluez-libs-devel-xx". I had to install the same version  I had for
> BlueZ-libs, and I solved it. I found the package using http://rpm.pbone.n=
et/
>=20
> Regards
>=20
> Esther
>=20
> -----Mensaje original-----
> De: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net] En nombre de Wu Jason
> Enviado el: martes, 13 de septiembre de 2005 13:30
> Para: bluez-users@lists.sourceforge.net
> Asunto: [Bluez-users] Re: I can't compile with -lbluetooth
>=20
> Hi,
>=20
> Thanks for your reply,
> but all package I can find on official web site are:
>=20
> bluez-libs-2.21.tar.gz
> bluez-utils-2.21.tar.gz
> bluez-pin-0.26.tar.gz
> bluez-firmware-1.0.tar.gz
> bluez-hcidump-1.25.tar.gz
> bluez-hciemu-1.2.tar.gz
>=20
> There was no package you said.
>=20
> By the way, I attach the error message generated when I compile
>=20
> [root@localhost c]# gcc -o rfcomm-server rfcomm-server.c -lbluetooth
> /usr/bin/ld: cannot find -lbluetooth
> collect2: ld returned 1 exit status
>=20
> [root@localhost c]# gcc -o rfcomm-server rfcomm-server.c -llibbluetooth
> /usr/bin/ld: cannot find -llibbluetooth
> collect2: ld returned 1 exit status
>=20
>=20
> On 9/13/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi,
> >
> > > Sorry I don't know what do you mean bluez devel package,
> > > the following are packages default installed:
> > >
> > > [root@localhost ~]# rpm -qa | grep ^bluez
> > > bluez-libs-2.10-2
> > > bluez-hcidump-1.11-1
> > > bluez-bluefw-1.0-6
> > > bluez-utils-2.10-2
> > >
> > > Did I miss something?
> >
> > I think the package is called bluez-libs-devel.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > SF.Net email is Sponsored by the Better Software Conference & EXPO
> > September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices
> > Agile & Plan-Driven Development * Managing Projects & Teams * Testing &=
 QA
> > Security * Process Improvement & Measurement * http://www.sqe.com/bsce5=
sf
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
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
