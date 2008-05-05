Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 5 May 2008 10:32:00 -0700
Message-ID: <F60A3CE9E807BE49B5F56BD80B894D2001688376@sc-exch03.marvell.com>
From: "Angus Ainslie" <aainslie@marvell.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluez 3.30 audio service problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I have a working blues libs and utils 3.24 . To try out some of the
sbcenc optimizations I've been trying to get bluez 3.30 running. When I
try to start the audio service I get this error 

[root@Linux /]#dbus-send --system --print-reply --dest=org.bluez
/org/bluez org.bluez.Manager.ActivateService string:audio
Error org.bluez.Error.Failed: Exec format error

Has anyone seen something ike this before ?

Thanks
Angus

Senior Firmware Developer
Automotive Systems Group
Marvell Semiconductor


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
