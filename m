Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Tue, 18 Jul 2006 16:44:04 +1000
MIME-Version: 1.0
Message-Id: <200607181644.05026.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] DBUS API - Service Classes as ints?
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

Is it a good idea/Are there any plans to extend the current DBUS API to enable 
Major/Minor/Service classes of the local Adapter to be available/settable in 
integer form? The string representations are nice and user-friendly, however 
we need to maintain internationalized versions of these, so doing conversion 
ourselves is much easier.  

This would also solve the problem of combination minor device numbers (e.g. in 
case of peripherals).  How would you set "Pointing device" + "Joystick" via 
the current API?  It would also bring the API closer in line with the 
RemoteDevice API which uses uint32 to represent the class.

Perhaps SetClass(uint32) and 
uint32 GetClass()?

If this is wanted, I can work on a patch.

-Denis


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
