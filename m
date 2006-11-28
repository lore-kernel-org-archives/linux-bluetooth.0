Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY108-F14D0E2C437D8EE10A1C0CF84E50@phx.gbl>
From: "mark bernard" <mark_qp@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 28 Nov 2006 14:35:24 +0000
Mime-Version: 1.0
Subject: [Bluez-devel] connections
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

hi,
im trying to connect 7 devices on bluetooth, but i get stuck at 3 devices.
the 4th device refuses to connect.
http://by108fd.bay108.hotmail.msn.com/cgi-bin/compose?&curmbox=00000000%2d0000%2d0000%2d0000%2d000000000001&a=d56e940c65c89244b0be101733a1c79516289b6786b97bffd0ecea592e886438#
Verzenden
the message i got from hcidump is:

>ACL data: handle 42 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 4097 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0
         Connection refused - no resources available

then it starts disconnecting this device.
connection 3 devices works good, and i can send messages to every of them. 
but connecting 4 or more will refuse the connection. "no resources 
available", what does that mean? how can i fix that?


Gr,
mark

_________________________________________________________________
Typ je SMS sneller binnen Messenger 
http://join.msn.com/mobile-Messaging/overview


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
