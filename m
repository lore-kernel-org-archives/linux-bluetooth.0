Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <003c01c555b5$31b193d0$8300a8c0@priveiqvfluhp9>
From: "Pieter De Mil" <mil@pandora.be>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Subject: [Bluez-users] rfcomm - multiple connections to 1 pocketPC from 2 seperate bluetooth-dongles
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 May 2005 01:08:36 +0200

Hello,

I'm using rfcomm 2.15 to make a connection from Linux to a 
PocketPc(00:04:3E:68:3C:6B). I can do this for one connection. But when I 
plug in a second bluetooth-dongle in my linuxPC, I can't establish a second 
rfcomm connection with the same PocketPc.

Scenario 1:
BT1 ------- PocketPC  : ok
channel0

Scenario 2:
BT2 ------- PocketPC   : ok
channel1

Scenario 3: not ok

channel0
BT1 ----------|
                       |
                    PocketPC
                       |
BT2 ----------|
channel1

Someone tried this?

Regards,
Pieter




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
