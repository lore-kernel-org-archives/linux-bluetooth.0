Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB7919047093988@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Stephen Crane'" <steve.crane@rococosoft.com>
Cc: "'Bluez-devel@lists.sourceforge.net'"
	 <Bluez-devel@lists.sourceforge.net>
Subject: AW: AW: AW: AW: [Bluez-devel] pand + socket filtering on zaurus
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Wed, 2 Jun 2004 17:51:42 +0200



> This is a kernel-module-only package. If you want the=20
> user-space binaries, have a look here:
>=20
> ftp://www.rococosoft.com/pub/zaurus/
=20
There I found the "pand", but still no "hciattach"=20
Nevertheless, thanks a lot.
Matthias=20

P.S.: Perhaps it's more sporty if I cross compile the hciattach=20
myself, although I tried to avoid this...=20



 Unfortunately these are also about a year old, before I=20
> discovered the joys of packaging for Zaurus. Have a look at=20
> the README.txt file, it might help you.
>=20
> Cheers,
> Steve
>=20
> On Wed, 2004-06-02 at 15:57, Kutschenreuter Matthias wrote:
> > Hi,
> >=20
> > no problem. I would simply install the 3.10 ROM!
> > But, during my attempt to install the
> > http://fichiers.xgarreau.org/zaurus/bluez_2.4.18-mh8_arm.ipk
> > on OZ manually, I realized, that this is not exactly what I need.=20
> >=20
> > I would need the bluez utility "hciattach" and the PAN=20
> daemon "pand"=20
> > to attach my Bluetooth chipsets and work with them, whereas=20
> the above=20
> > ipk doesnt contain this. It provides lots of drivers for commercial=20
> > Bluetooth CF-Cards instead, as far as I understand.
> >=20
> > Do you know a "bluez_2.4.18....ipk", that contains the=20
> stuff I need,=20
> > i.e. that contains similar programs than the old=20
> > "bluez-zaurus_2.3b_arm.ipk".
> >=20
> > Regards, Matthias
> >=20
> >=20
> > =20
> >=20
> >=20
> >=20
> >=20
> > >=20
> > > Hi Matthias,
> > > Sorry but I didn't realise you were using OZ. These modules
> > > were built against the 2.4.18-rmk7-pxa3-embedix kernel which=20
> > > is part of the 3.10 ROM image from Sharp. This is the stock=20
> > > Sharp upgrade to the original
> > > (2.39?) ROM image which contains the 2.4.6-mumble kernel.
> > >=20
> > > Sorry about that,
> > > Steve
> > >=20
> > > P.S. If I ever switch to using OZ (which I might if I get
> > > time), I will put together some packages for it.
> > >=20
> > > On Wed, 2004-06-02 at 13:45, Kutschenreuter Matthias wrote:
> > > > Hi Steve,
> > > >=20
> > > > I failed to install the "bluez_2.4.18-mh8_arm.ipk" on
> > > OpenZaurus 3.3.5
> > > > System, which has an 2.4.18 kernel. messages occur like
> > > > 	/etc/rc.d/init.d/pcmcia not found
> > > > 	modprobe: Can't locate module l2cap
> > > > First is due to differing directory structure, it's
> > > /etc/init.d/pcmcia
> > > > on OZ
> > > > 3.3.5)
> > > >=20
> > > > After manually restarting pcmcia, insmod l2cap.o gives lots of
> > > > unresolved symbols, e.g. "l2cap.o: unresolved symbol=20
> batostr" (I=20
> > > > cannot follow the installation instruction from the old=20
> > > 2.4.6-ipk, for
> > > > instance there is no file "modules.conf.add". )
> > > >=20
> > > > Easiest would be, if you already ran the bluez-2.4.18=20
> on a Zaurus
> > > > SL-5500G,
> > > > to tell me, which initrd.bin (or Ospack) and which zImage=20
> > > did you use ?
> > > > Is there any installation instruction for the 2.4.18-ipk ?
> > > >=20
> > > > Thanks, Matthias
> > > > >=20
> > > > >=20
> > > > > Hi Matthias,
> > > > > Unless Edd has built a package of modules for this=20
> kernel, the=20
> > > > > most recent .ipk I know of is at Xavier Garreau's site:
> > > > >=20
> > > > > http://fichiers.xgarreau.org/zaurus/bluez_2.4.18-mh8_arm.ipk
> > > > >=20
> > > > > Note that this is from last August and a lot of bugs=20
> have been=20
> > > > > fixed since then but this should get you started.
> > > > >=20
> > > > > Marcel, can we remove the bluez-zaurus_2.3b from the=20
> Sourceforge=20
> > > > > site? It causes too much confusion.
> > > > >=20
> > > > > Steve
> > > > >=20
> > > > > On Tue, 2004-06-01 at 15:23, Kutschenreuter Matthias wrote:
> > > > > > Hi Marcel,
> > > > > >=20
> > > > > > I found out, that the latest supported zaurus kernel
> > > for collie is
> > > > > > 2.4.18 . So I want to try this one. When I want to load
> > > > > l2cap.o after
> > > > > > installing "bluez-zaurus_2.3b_arm.ipk", it says:
> > > > > kernel-module version
> > > > > > mismatch l2cap.o was compiled for kernel 2.4.6...=20
> while this=20
> > > > > > kernel is 2.4.18...
> > > > > >=20
> > > > > >=20
> > > > > > So, is there any   "bluez-zaurus....ipk" compiled=20
> for 2.4.18=20
> > > > > > and where can I download it ?
> > > > > >=20
> > > > > >=20
> > > > > > Kind regards, Matthias
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > -----Urspr=FCngliche Nachricht-----
> > > > > > > Von: Marcel Holtmann [mailto:marcel@holtmann.org]
> > > > > > > Gesendet: Mittwoch, 26. Mai 2004 12:00
> > > > > > > An: Kutschenreuter Matthias
> > > > > > > Cc: 'Bluez-devel@lists.sourceforge.net'
> > > > > > > Betreff: Re: [Bluez-devel] pand + socket=20
> filtering on zaurus
> > > > > > >=20
> > > > > > >=20
> > > > > > > Hi Matthias,
> > > > > > >=20
> > > > > > > > > you now that we are already at Linux kernel 2.6.6 ;)
> > > > > The 2.4.6
> > > > > > > > > is so old that I can't even tell you, if there are
> > > > > problems with
> > > > > > > > > your combination. I stopped testing BNEP with
> > > 2.4.18 and you
> > > > > > > > > should take an iPAQ with 2.4.19 to check if your
> > > > > combination is
> > > > > > > > > there working, too. Maybe it is an ARM=20
> related problem.
> > > > > > > >=20
> > > > > > > > yeah. I hate my zaurus 2.4.6 kernel, too. do=20
> you know what
> > > > > > > the latest
> > > > > > > > linux kernel for zaurus is (and where to get the
> > > > > sources) ? on the
> > > > > > > > other hand, the latest linux kernels have also their
> > > > > > > disadvantages, I
> > > > > > > > read about the problems with the linux bridge few weeks=20
> > > > > > > > ago.
> > > > > > >=20
> > > > > > > you can take a look at www.openzaurus.org and I=20
> think they=20
> > > > > > > go
> > > > > > > with 2.4.21, but I don't know what version of -mh patch
> > > > > they include.
> > > > > > >=20
> > > > > > > The bridge problem you read about has been fixed.
> > > > > > >=20
> > > > > > > Regards
> > > > > > >=20
> > > > > > > Marcel
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > -------------------------------------------------------
> > > > > > This SF.Net email is sponsored by: Oracle 10g
> > > > > > Get certified on the hottest thing ever to hit the market...
> > > > > > Oracle
> > > > > > 10g.
> > > > > > Take an Oracle 10g class now, and we'll give you=20
> the exam FREE.
> > > > > > http://ads.osdn.com/?ad_id149&alloc_id=8166&op=3Dclick
> > > > > > _______________________________________________
> > > > > > Bluez-devel mailing list
> > > > > > Bluez-devel@lists.sourceforge.net
> > > > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > > > --
> > > > > Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com=20
> > > > > steve.crane@rococosoft.com +353-1-6601315 (ext 209)
> > > > >=20
> > > >=20
> > > >=20
> > > > -------------------------------------------------------
> > > > This SF.Net email is sponsored by the new InstallShield X.
> > > > >From Windows to Linux, servers to mobile, InstallShield X
> > > is the one
> > > > installation-authoring solution that does it all. Learn more and
> > > > evaluate today! http://www.installshield.com/Dev2Dev/0504
> > > > _______________________________________________
> > > > Bluez-devel mailing list
> > > > Bluez-devel@lists.sourceforge.net=20
> > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > --
> > > Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
> > > steve.crane@rococosoft.com +353-1-6601315 (ext 209)
> > >=20
> --=20
> Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com=20
> steve.crane@rococosoft.com +353-1-6601315 (ext 209)
>=20


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
