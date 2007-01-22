Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45B4093B.4000901@appstate.edu>
Date: Sun, 21 Jan 2007 19:45:47 -0500
From: Kinney Baughman <baughmankr@appstate.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Still trying to install bluetooth headset on Mandriva
	2007 for Skype
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

To continue from a previous post:

Have been following the instructions from here:

http://bluetooth-alsa.sourceforge.net/build.html

Have had success at every step until I run:

a2dpd

as a regular user.

I get this output to the terminal:

==
A2DPD[596.956]: make_daemon_process: a2dpd [Jan 20 2007 16:37:17] 
starting ...
A2DPD[596.957]: init_uinput: (errno=2:No such file or directory)Cannot 
open /dev/input/uinput
A2DPD[596.957]: main: a2dpd addr=00:0A:9B:22:CA:71 timer=4000 us [Jan 20 
2007 16:37:24]
A2DPD[596.957]: a2dpd_signal_init:
A2DPD[596.958]: a2dpd_signal_init: (errno=2:No such file or 
directory)Getting on DBUS
A2DPD[596.961]: a2dpd_signal_init: OK
Segmentation fault
==

I've searched the email archives for "Cannot open /dev/input/uinput" 
which appears to be the primary problem but I get no hits.

Suggestions?

Thanks.

-- 
Kinney

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
