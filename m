Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44D1CEA0.4080205@flcd.net>
Date: Thu, 03 Aug 2006 13:23:28 +0300
From: Denis <denis@flcd.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] can't change HCI and LMP version on Cellink BTA-6030
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello!
Few days ago I've got Cellink BTA-6030 Bluetooth dongle but have a 
problem installing it on my Debian box for which it was bought.
It works slower than my previous LinkSys BT100 V1.1 Bluetooth, on other 
end I've got Canyon V1.2

After some reading I've checked how device is identify itself and spot 
that from remote WinXP notebook it's reported that LMP feature - unknown 
and LMP Version is simply blank. I've recompiled BlueZ 3.2 with bccmd 
enabled and tried perform these steps:
----------------------------------------------------------------------------------------------
# bccmd psget version
The HCI and LMP version reported locally: 0x0101 (257)
# bccmd psset version 0x0303
# bccmd psget remver
Can't execute command: No such device or address (6)
# bccmd psset remver 0x0003
# bccmd warmreset
# bccmd psget version
The HCI and LMP version reported locally: 0x0101 (257)
# bccmd psget remver
Can't execute command: No such device or address (6)
----------------------------------------------------------------------------------------------

But as you can see it doesn't let me to reset LMP version. From other 
side if plug this device in WinXP notebook it's reported as v2.0 device.

Any ideas how this could be fixed and maybe I'm doing something wrong?

Thank you!
Best Regards,
Denis Stenderchuck
http://forum.weblamp.net/linux
http://www.pharos-search.com


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
