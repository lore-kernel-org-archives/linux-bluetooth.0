Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D47DA0.1090909@xmission.com>
Date: Thu, 15 Feb 2007 08:34:56 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5b9417770702132316t2594eedfie00e3d930ef82efe@mail.gmail.com>	<45D33129.7040906@xmission.com>
	<5b9417770702150030x4e84f59flfbac26257b600ef1@mail.gmail.com>
In-Reply-To: <5b9417770702150030x4e84f59flfbac26257b600ef1@mail.gmail.com>
Subject: Re: [Bluez-devel] can you use bluetooth alsa to let bt device use
 computer speakers as output?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

John

> I am confused, I Can't use plugz and have to use btsco???

I didn't carry forward all the junk in btsco when I created plugz, but
the a2dp sink maybe should be brought forward. It is relatively clean
and there is not an equivalent plugin for what it does.

> I don't even see these binaries after installing btsco, like a2play

make install doesn't install a2recv or a2play. the idea was that they
are developer test apps.

if you do play with a2recv, note that at least one a2dp source insists
we do a role switch before it will work and at least one other fails to
work right if we do. :(

clearly the hci_switch_role call should be a conditioned on a
command-line argument. for now you can run it as root and then as a
regular user since the user isn't allowed to do the switch.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
