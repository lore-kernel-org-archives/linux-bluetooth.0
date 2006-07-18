Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 18 Jul 2006 15:53:25 +0200
From: "Marcus C. Gottwald" <gottwald@inf.fu-berlin.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060718135325.GA19893@inf.fu-berlin.de>
References: <20060714161657.GA25533@inf.fu-berlin.de>
	<1152894175.25660.35.camel@localhost>
	<20060714164706.GB25533@inf.fu-berlin.de>
	<1153220491.4639.23.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1153220491.4639.23.camel@localhost>
Subject: Re: [Bluez-users] SCO mapping, bccmd mapsco
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


Hello Marcel,

Marcel Holtmann wrote (Tue 2006-Jul-18 13:01:31 +0200):

> > > use "bccmd psset --stores psf mapsco 0".
> > =

> > Wow, that was quick. But using "--stores psf" doesn't seem to
> > help; and even the hciconfig output remains unchanged:
..
> try "bccmd psset --stores psi mapsco 0". If this still doesn't work then
> replace "psi" with "0".

Good news is: It works!

Bad news is: I don't really know why. A simple "psget mapsco"
currently doesn't work anymore, though after issuing a "psset
mapsco" the output of "hciconfig hci0 revision" keeps changing
as exepcted and as it always did.

While testing with "--stores" I realized that having "btsco"
running and/or having "snd-bt-sco" loaded might make a
difference, so I currently can't tell what exactly made it work
while I was playing around. If I ever find out for sure, I'll
post it. :-)

I now have my notebook computer with builtin Bluetooth adapter
(internally connected via USB, switched on and off by software)
online via a Bluetooth connection to my UMTS mobile and talking
to a Bluetooth headset at the same time.


Thanks again!

Marcus

-- =

   Marcus C. Gottwald  =B7  http://www.inf.fu-berlin.de/~gottwald/


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
