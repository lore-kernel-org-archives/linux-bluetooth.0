Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB7919047093986@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Stephen Crane'" <steve.crane@rococosoft.com>
Cc: "'Bluez-devel@lists.sourceforge.net'"
	 <Bluez-devel@lists.sourceforge.net>
Subject: AW: AW: [Bluez-devel] pand + socket filtering on zaurus
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
Date: Wed, 2 Jun 2004 14:45:00 +0200

Hi Steve,

I failed to install the "bluez_2.4.18-mh8_arm.ipk" on OpenZaurus 3.3.5
System, which has an 2.4.18 kernel. messages occur like
	/etc/rc.d/init.d/pcmcia not found
	modprobe: Can't locate module l2cap
First is due to differing directory structure, it's /etc/init.d/pcmcia =
on OZ
3.3.5)

After manually restarting pcmcia, insmod l2cap.o gives lots
of unresolved symbols, e.g. "l2cap.o: unresolved symbol batostr"
(I cannot follow the installation instruction from the old 2.4.6-ipk,
for instance there is no file "modules.conf.add". )

Easiest would be, if you already ran the bluez-2.4.18 on a Zaurus =
SL-5500G,=20
to tell me, which initrd.bin (or Ospack) and which zImage did you use ?
Is there any installation instruction for the 2.4.18-ipk ?

Thanks, Matthias
>=20
>=20
> Hi Matthias,
> Unless Edd has built a package of modules for this kernel,=20
> the most recent .ipk I know of is at Xavier Garreau's site:
>=20
> http://fichiers.xgarreau.org/zaurus/bluez_2.4.18-mh8_arm.ipk
>=20
> Note that this is from last August and a lot of bugs have=20
> been fixed since then but this should get you started.
>=20
> Marcel, can we remove the bluez-zaurus_2.3b from the=20
> Sourceforge site? It causes too much confusion.
>=20
> Steve
>=20
> On Tue, 2004-06-01 at 15:23, Kutschenreuter Matthias wrote:
> > Hi Marcel,
> >=20
> > I found out, that the latest supported zaurus kernel for collie is=20
> > 2.4.18 . So I want to try this one. When I want to load=20
> l2cap.o after=20
> > installing "bluez-zaurus_2.3b_arm.ipk", it says:=20
> kernel-module version=20
> > mismatch l2cap.o was compiled for kernel 2.4.6...
> > while this kernel is 2.4.18...
> >=20
> >=20
> > So, is there any   "bluez-zaurus....ipk" compiled for 2.4.18=20
> > and where can I download it ?
> >=20
> >=20
> > Kind regards, Matthias
> >=20
> >=20
> >=20
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: Marcel Holtmann [mailto:marcel@holtmann.org]
> > > Gesendet: Mittwoch, 26. Mai 2004 12:00
> > > An: Kutschenreuter Matthias
> > > Cc: 'Bluez-devel@lists.sourceforge.net'
> > > Betreff: Re: [Bluez-devel] pand + socket filtering on zaurus
> > >=20
> > >=20
> > > Hi Matthias,
> > >=20
> > > > > you now that we are already at Linux kernel 2.6.6 ;)=20
> The 2.4.6=20
> > > > > is so old that I can't even tell you, if there are=20
> problems with=20
> > > > > your combination. I stopped testing BNEP with 2.4.18 and you=20
> > > > > should take an iPAQ with 2.4.19 to check if your=20
> combination is=20
> > > > > there working, too. Maybe it is an ARM related problem.
> > > >=20
> > > > yeah. I hate my zaurus 2.4.6 kernel, too. do you know what
> > > the latest
> > > > linux kernel for zaurus is (and where to get the=20
> sources) ? on the
> > > > other hand, the latest linux kernels have also their=20
> > > disadvantages, I
> > > > read about the problems with the linux bridge few weeks ago.
> > >=20
> > > you can take a look at www.openzaurus.org and I think they go
> > > with 2.4.21, but I don't know what version of -mh patch=20
> they include.
> > >=20
> > > The bridge problem you read about has been fixed.
> > >=20
> > > Regards
> > >=20
> > > Marcel
> > >=20
> > >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: Oracle 10g
> > Get certified on the hottest thing ever to hit the market... Oracle =

> > 10g.
> > Take an Oracle 10g class now, and we'll give you the exam FREE.
> > http://ads.osdn.com/?ad_id149&alloc_id=8166&op=3Dclick
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
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
