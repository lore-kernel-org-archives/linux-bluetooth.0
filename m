Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <008601c4200c$4c75ee30$0000fea9@RICHARDP>
From: "Richard Pruen" <r.pruen@btinternet.com>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] Using BlueZ for network access via ppp does not work, nothing at all in log files
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 11 Apr 2004 22:31:02 +0100

Hello everyone,

Hope you can help, because this has got me stumped.

I am trying to use dund to allow my pocket pc 2003 device to connect to my
home network. And it won't work, having checked all the log files there is
nothing in them at all relating to this. If I remove rfcomm tty support from
the kernel, then I do get entries saying that rfcomm can't connect. But with
it enabled there isn't a peep out of anything at all, dund, rfcomm and pppd
are all silent.

rfcomm can be connected to serial ports on my other pc, so everything seems
to work ok.

I have a Belken USB dongle, and slackware 9.1 with the 2.6.4 kernel, I have
the latest BlueZ packages.

Hope someone has some ideas of what to try to find the problem.

Thanks

Richard



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
