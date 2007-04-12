Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2bf8a3380704121124t70285f8oe2b1678d69648319@mail.gmail.com>
Date: Thu, 12 Apr 2007 15:24:42 -0300
From: "Bruno Cavaler Ghisi" <brunogh@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <b621074b0704102122t9a942c6v7ee44d03ea342d33@mail.gmail.com>
MIME-Version: 1.0
References: <2bf8a3380704091001j59941c4fia4aaf4c6d8a0d5be@mail.gmail.com>
	<2bf8a3380704101510q7bdbe0ep7fd39473a5dae73@mail.gmail.com>
	<b621074b0704102122t9a942c6v7ee44d03ea342d33@mail.gmail.com>
Subject: Re: [Bluez-users] Doubts related to BlueZ and JSR-82
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have installed BlueZ but I do not know which java library I could
use to communicate with it. I have heard about JBlueZ, is it good? Any
other suggestions?

Thanks,
Bruno

2007/4/11, Tushar Paturde <tusharpaturde@gmail.com>:
> Hi Bruno,
> Bluez library give you access to your bluetooth hardware . So if your blu=
ez
> library calls are working and ur jsr82 implementation is using Bluez libr=
ary
> functions it should work for u.
> As I understand Impronto, Avetana gives complete solution for JSR82
> including native library.
> Impronto internally uses Bluez library only.
>
>
> regards,
> Tushar
>
>
> On 4/11/07, Bruno Cavaler Ghisi <brunogh@gmail.com > wrote:
> >
> > Just explaining better... will I need any other lib in the application
> > classpath to work?
> >
> > Thanks,
> >
> > 2007/4/9, Bruno Cavaler Ghisi <brunogh@gmail.com>:
> > > Hi,
> > >
> > > I am developing some stuff using jsr-82 and I would like to try it in
> > > a jse application under Linux.
> > >
> > > I read about the BlueZ protocol stack and I have installed its
> > > packages, however I do not know if I just need to have it in order to
> > > the app work, because I read about other things like Impronto, Avetana
> > > and I got confused... All of these are bluetooth protocol stacks? Will
> > > I need anything else to run my application? Does anybody has any good
> > > link about it?
> > >
> > > Thanks in advance.
> > > Bruno
> > >
> >
> >
> > --
> > Bruno Cavaler Ghisi
> > Graduando de Sistemas de Informa=E7=E3o
> > Universidade Federal de Santa Catarina
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>
> --
> Tushar Paturde
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>


-- =

Bruno Cavaler Ghisi
Graduando de Sistemas de Informa=E7=E3o
Universidade Federal de Santa Catarina

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
