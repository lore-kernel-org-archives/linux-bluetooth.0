Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <3d3168e50704050743u7b2b95d3q1120a628955b6bfe@mail.gmail.com>
Date: Thu, 5 Apr 2007 16:43:00 +0200
From: "=?ISO-8859-2?Q?Micha=B3_Majchrowicz?=" <mmajchrowicz@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <3d3168e50704050736p3b243dc3tc9bc084cc983bc8e@mail.gmail.com>
MIME-Version: 1.0
References: <3d3168e50704050420g3063bec4p67ccc742ab19e0bb@mail.gmail.com>
	<1175772422.5815.626.camel@violet>
	<3d3168e50704050736p3b243dc3tc9bc084cc983bc8e@mail.gmail.com>
Subject: Re: [Bluez-users] Random MAC/MAC Spoofing.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi.
I also wanted to add that the mac addresses "look similar" for one
dongle they always begin with 0x20 for other always with 0x7b :) Hope
you can help me with this :)
Regards Michal.

On 4/5/07, Micha=B3 Majchrowicz <mmajchrowicz@gmail.com> wrote:
> Hi.
> The guy in the store said it has this kind of feature.
> And I bought two dongles and both worked the same :)
> Regards Michal.
>
> lapek ~ # hciconfig -a
> hci0:   Type: USB
>         BD Address: 20:C1:20:6F:50:40 ACL MTU: 1017:8 SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:8348377 acl:42729 sco:0 events:4630 errors:0
>         TX bytes:1619750 acl:17283 sco:0 commands:28 errors:0
>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'Lapek new :D'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x3000 LMP Ver: 2.0 (0x3) LMP Subver:=
 0x420b
>         Manufacturer: Broadcom Corporation (15)
>
>
> On 4/5/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Michal,
> >
> > > I have a small problem. I bought Bluetooth USB dongle and it has
> > > annoying feature. Everytime I plug it in/out it has different mac
> > > address :( Is there any way to turn this feature off? Or maybe there
> > > is some way to change mac address? Like with eth inferfaces?
> >
> > that is not a feature. That is a broken dongle. You actually need to
> > return it to the store. However first show me "hciconfig -a".
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> > -----------------------------------------------------------------------=
--
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share=
 your
> > opinions on IT & business topics through brief surveys-and earn cash
> > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
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
