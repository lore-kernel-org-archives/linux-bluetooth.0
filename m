Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <002c01c80435$14e15a70$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com><8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com><1187964393.5121.10.camel@matthias.BEYONDSOFT.local><Pine.LNX.4.63.0708241410030.12067@redbean.intranet.gw-instruments.de>
	<20071001154023.53e57c49@localhost.localdomain>
Date: Mon, 1 Oct 2007 16:12:20 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] Patch mh3
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I have a 2.6.22.12 kernel (ubuntu gutsy gibbon) and when I want to apply the 
mh3 kernel patch (dry run for now) it seems there are some modifications 
which have already been applied (partially ?) in hci_core.h, rfcomm.h, sco.h

Could you please tell me what I have to do :( ?
Or where I can get an up-to-date drivers/bluetooth/* , /net/bluetooth/* , 
/include/net/bluetooth/*  sources ?

Thanks a lot,
Oli

------------------------------------------------------------------

patching file linux-source-2.6.22/include/net/bluetooth/rfcomm.h
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file 
linux-source-2.6.22/include/net/bluetooth/rfcomm.h.rej
patching file linux-source-2.6.22/Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file 
linux-source-2.6.22/Makefile.rej
patching file linux-source-2.6.22/net/bluetooth/hci_conn.c
Hunk #6 FAILED at 243.
Hunk #7 succeeded at 348 (offset 28 lines).
Hunk #8 succeeded at 365 (offset 28 lines).
Hunk #9 succeeded at 403 (offset 28 lines).
Hunk #10 succeeded at 424 (offset 28 lines).
Hunk #11 succeeded at 438 (offset 28 lines).
Hunk #12 succeeded at 456 (offset 28 lines).
Hunk #13 succeeded at 478 (offset 28 lines).
Hunk #14 succeeded at 509 (offset 28 lines).
Hunk #15 succeeded at 519 (offset 28 lines).
Hunk #16 succeeded at 545 (offset 28 lines).
1 out of 16 hunks FAILED -- saving rejects to file 
linux-source-2.6.22/net/bluetooth/hci_conn.c.rej
patching file linux-source-2.6.22/net/bluetooth/hci_core.c
Hunk #8 succeeded at 831 (offset 1 line).
Hunk #9 succeeded at 856 (offset 1 line).
Hunk #10 succeeded at 871 (offset 1 line).
Hunk #11 succeeded at 898 (offset 1 line).
Hunk #12 succeeded at 910 (offset 1 line).
Hunk #13 succeeded at 937 (offset 1 line).
Hunk #14 succeeded at 1118 (offset 1 line).
Hunk #15 succeeded at 1150 (offset 1 line).
Hunk #16 succeeded at 1159 (offset 1 line).
Hunk #17 FAILED at 1260.
Hunk #18 succeeded at 1405 (offset 44 lines).
Hunk #19 succeeded at 1440 with fuzz 2 (offset 44 lines).
1 out of 19 hunks FAILED -- saving rejects to file 
linux-source-2.6.22/net/bluetooth/hci_core.c.rej
patching file linux-source-2.6.22/net/bluetooth/hci_event.c
Hunk #2 FAILED at 326.
Hunk #7 FAILED at 933.
Hunk #8 succeeded at 1125 (offset -3 lines).
Hunk #9 succeeded at 1196 (offset -3 lines).
Hunk #10 succeeded at 1221 (offset -3 lines).
Hunk #11 succeeded at 1342 (offset -3 lines).
Hunk #12 succeeded at 1378 (offset -3 lines).
Hunk #13 succeeded at 1392 (offset -3 lines).
Hunk #14 succeeded at 1464 (offset -3 lines).
Hunk #15 succeeded at 1472 (offset -3 lines).
2 out of 15 hunks FAILED -- saving rejects to file 
linux-source-2.6.22/net/bluetooth/hci_event.c.rej


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
