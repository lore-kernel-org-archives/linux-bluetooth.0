Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F19DD2587C30922B460977FBFBA0@phx.gbl>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 02 Jan 2007 15:31:42 +0800
Mime-Version: 1.0
Subject: [Bluez-devel] Error Compiling Bluez-Util
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

Dear all,

When i was trying to compile Bluez-Util 3.7 in a scratchbox environment, i 
ran into the following errors:
In function 'uart_speed'
hciattach.c:106: error:'B230400' undeclared (first use in this function)
hciattach.c:108: error:'B460800' undeclared (first use in this function)
..
..
..
etc

May i know whether i have missed out on any header files or any linking 
problems
I am trying to a arm target board.

Regards,
Kelvin

_________________________________________________________________
Get an advanced look at the new version of Windows Live Messenger. 
http://get.live.com/messenger/overview


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
