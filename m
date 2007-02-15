Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 15 Feb 2007 10:21:56 +1000
MIME-Version: 1.0
Message-Id: <200702151021.56853.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] dbus-sdp & find_pending_connect
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

Marcel,

I'd like to understand why all SDP related functions in dbus-sdp.c call the 
find_pending_connect function?

Effectively this guards against simultaneous SDP connection attempts to the 
same remote device.  My understanding is that BlueZ does not have any 
limitations against multiple simultaneous connections to the same device, and 
neither does the BlueZ sdp daemon.  Commenting out find_pending_connect, I 
can run up to 6 simultaneous SDP queries to another BlueZ implementation 
(this is because sdpd has a queue of up to 5 connections.)  So this leads me 
to wonder why hcid is not allowing this particular case?

-Denis



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
