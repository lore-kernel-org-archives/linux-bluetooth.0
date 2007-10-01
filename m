Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats@blue2net.com>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002c01c80435$14e15a70$0200a8c0@jester>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
	<8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
	<1187964393.5121.10.camel@matthias.BEYONDSOFT.local>
	<Pine.LNX.4.63.0708241410030.12067@redbean.intranet.gw-instruments.de>
	<20071001154023.53e57c49@localhost.localdomain>
	<002c01c80435$14e15a70$0200a8c0@jester>
Date: Mon, 01 Oct 2007 18:55:52 +0200
Message-Id: <1191257752.4229.13.camel@Blue2net-mats.bellman.mea>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch mh3
Reply-To: mats.andersson@blue2net.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

m=E5n 2007-10-01 klockan 16:12 +0200 skrev Olivier Le Pogam:
> Hello,
> =

> I have a 2.6.22.12 kernel (ubuntu gutsy gibbon) and when I want to apply =
the =

> mh3 kernel patch (dry run for now) it seems there are some modifications =

> which have already been applied (partially ?) in hci_core.h, rfcomm.h, sc=
o.h
> =

Do a manual auditing of those patch bits that fail: read the
corresponding source in your kernel-source-2.6.22.12 and cross check
aginst the suggested amending from the patch file. Remove from the
patch file those parts that the Ubuntu maintainer already applied,
and keep the new additions. Then perform a final (or intermediary)
dry-runs with the patch command to check that things apply cleanly.
Of course, you have to use your own wit to go with the Bluez maintainers
suggestion against the decision of the Ubuntu crew, but the time will
be well invested. I used this technique to patch my own kernel
sources for Debian Etch 2.6.18 and I did eliminate some suboptimal
behaviour of Bluez in doing so.

In your case, disect the following contributions:

> patching file linux-source-2.6.22/include/net/bluetooth/rfcomm.h
> patching file linux-source-2.6.22/Makefile
> patching file linux-source-2.6.22/net/bluetooth/hci_conn.c
> patching file linux-source-2.6.22/net/bluetooth/hci_core.c
> patching file linux-source-2.6.22/net/bluetooth/hci_event.c

since they only produced rejects.


Good luck on your venture

Mats Erik Andersson


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
