Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: AW: AW: AW: [Bluez-devel] pand + socket filtering on zaurus
From: Stephen Crane <steve.crane@rococosoft.com>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB7919047093987@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB7919047093987@mchp997a.mch.sbs.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1086188792.7888.683.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: Wed, 02 Jun 2004 16:06:32 +0100

Hi Matthias,
This is a kernel-module-only package. If you want the user-space
binaries, have a look here:

ftp://www.rococosoft.com/pub/zaurus/

Unfortunately these are also about a year old, before I discovered the
joys of packaging for Zaurus. Have a look at the README.txt file, it
might help you.

Cheers,
Steve

On Wed, 2004-06-02 at 15:57, Kutschenreuter Matthias wrote:
> Hi,
> 
> no problem. I would simply install the 3.10 ROM!
> But, during my attempt to install the 
> http://fichiers.xgarreau.org/zaurus/bluez_2.4.18-mh8_arm.ipk
> on OZ manually, I realized, that this is not exactly what I need. 
> 
> I would need the bluez utility "hciattach" and the PAN daemon "pand"
> to attach my Bluetooth chipsets and work with them,
> whereas the above ipk doesnt contain this.
> It provides lots of drivers for commercial Bluetooth CF-Cards instead, 
> as far as I understand. 
> 
> Do you know a "bluez_2.4.18....ipk", that contains the stuff I need,
> i.e. that contains similar programs than the old
> "bluez-zaurus_2.3b_arm.ipk".
> 
> Regards, Matthias
> 
> 
>  
> 
> 
> 
> 
> > 
> > Hi Matthias,
> > Sorry but I didn't realise you were using OZ. These modules 
> > were built against the 2.4.18-rmk7-pxa3-embedix kernel which 
> > is part of the 3.10 ROM image from Sharp. This is the stock 
> > Sharp upgrade to the original
> > (2.39?) ROM image which contains the 2.4.6-mumble kernel.
> > 
> > Sorry about that,
> > Steve
> > 
> > P.S. If I ever switch to using OZ (which I might if I get 
> > time), I will put together some packages for it.
> > 
> > On Wed, 2004-06-02 at 13:45, Kutschenreuter Matthias wrote:
> > > Hi Steve,
> > > 
> > > I failed to install the "bluez_2.4.18-mh8_arm.ipk" on 
> > OpenZaurus 3.3.5 
> > > System, which has an 2.4.18 kernel. messages occur like
> > > 	/etc/rc.d/init.d/pcmcia not found
> > > 	modprobe: Can't locate module l2cap
> > > First is due to differing directory structure, it's 
> > /etc/init.d/pcmcia 
> > > on OZ
> > > 3.3.5)
> > > 
> > > After manually restarting pcmcia, insmod l2cap.o gives lots of 
> > > unresolved symbols, e.g. "l2cap.o: unresolved symbol batostr" (I 
> > > cannot follow the installation instruction from the old 
> > 2.4.6-ipk, for 
> > > instance there is no file "modules.conf.add". )
> > > 
> > > Easiest would be, if you already ran the bluez-2.4.18 on a Zaurus 
> > > SL-5500G,
> > > to tell me, which initrd.bin (or Ospack) and which zImage 
> > did you use ?
> > > Is there any installation instruction for the 2.4.18-ipk ?
> > > 
> > > Thanks, Matthias
> > > > 
> > > > 
> > > > Hi Matthias,
> > > > Unless Edd has built a package of modules for this kernel,
> > > > the most recent .ipk I know of is at Xavier Garreau's site:
> > > > 
> > > > http://fichiers.xgarreau.org/zaurus/bluez_2.4.18-mh8_arm.ipk
> > > > 
> > > > Note that this is from last August and a lot of bugs have
> > > > been fixed since then but this should get you started.
> > > > 
> > > > Marcel, can we remove the bluez-zaurus_2.3b from the
> > > > Sourceforge site? It causes too much confusion.
> > > > 
> > > > Steve
> > > > 
> > > > On Tue, 2004-06-01 at 15:23, Kutschenreuter Matthias wrote:
> > > > > Hi Marcel,
> > > > > 
> > > > > I found out, that the latest supported zaurus kernel 
> > for collie is
> > > > > 2.4.18 . So I want to try this one. When I want to load 
> > > > l2cap.o after
> > > > > installing "bluez-zaurus_2.3b_arm.ipk", it says:
> > > > kernel-module version
> > > > > mismatch l2cap.o was compiled for kernel 2.4.6...
> > > > > while this kernel is 2.4.18...
> > > > > 
> > > > > 
> > > > > So, is there any   "bluez-zaurus....ipk" compiled for 2.4.18 
> > > > > and where can I download it ?
> > > > > 
> > > > > 
> > > > > Kind regards, Matthias
> > > > > 
> > > > > 
> > > > > 
> > > > > > -----Ursprüngliche Nachricht-----
> > > > > > Von: Marcel Holtmann [mailto:marcel@holtmann.org]
> > > > > > Gesendet: Mittwoch, 26. Mai 2004 12:00
> > > > > > An: Kutschenreuter Matthias
> > > > > > Cc: 'Bluez-devel@lists.sourceforge.net'
> > > > > > Betreff: Re: [Bluez-devel] pand + socket filtering on zaurus
> > > > > > 
> > > > > > 
> > > > > > Hi Matthias,
> > > > > > 
> > > > > > > > you now that we are already at Linux kernel 2.6.6 ;)
> > > > The 2.4.6
> > > > > > > > is so old that I can't even tell you, if there are
> > > > problems with
> > > > > > > > your combination. I stopped testing BNEP with 
> > 2.4.18 and you
> > > > > > > > should take an iPAQ with 2.4.19 to check if your 
> > > > combination is
> > > > > > > > there working, too. Maybe it is an ARM related problem.
> > > > > > > 
> > > > > > > yeah. I hate my zaurus 2.4.6 kernel, too. do you know what
> > > > > > the latest
> > > > > > > linux kernel for zaurus is (and where to get the
> > > > sources) ? on the
> > > > > > > other hand, the latest linux kernels have also their
> > > > > > disadvantages, I
> > > > > > > read about the problems with the linux bridge few weeks ago.
> > > > > > 
> > > > > > you can take a look at www.openzaurus.org and I think they go 
> > > > > > with 2.4.21, but I don't know what version of -mh patch
> > > > they include.
> > > > > > 
> > > > > > The bridge problem you read about has been fixed.
> > > > > > 
> > > > > > Regards
> > > > > > 
> > > > > > Marcel
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > > -------------------------------------------------------
> > > > > This SF.Net email is sponsored by: Oracle 10g
> > > > > Get certified on the hottest thing ever to hit the market... 
> > > > > Oracle
> > > > > 10g.
> > > > > Take an Oracle 10g class now, and we'll give you the exam FREE.
> > > > > http://ads.osdn.com/?ad_id149&alloc_id66&op=click
> > > > > _______________________________________________
> > > > > Bluez-devel mailing list
> > > > > Bluez-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > > --
> > > > Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
> > > > steve.crane@rococosoft.com +353-1-6601315 (ext 209)
> > > > 
> > > 
> > > 
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by the new InstallShield X.
> > > >From Windows to Linux, servers to mobile, InstallShield X 
> > is the one
> > > installation-authoring solution that does it all. Learn more and 
> > > evaluate today! http://www.installshield.com/Dev2Dev/0504
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net 
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > -- 
> > Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
> > steve.crane@rococosoft.com +353-1-6601315 (ext 209)
> > 
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
