Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Robert L Waldrop <bob.waldrop@motorola.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050801190110.GC11317@urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] BlueZ stack failure
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
Date: Mon, 1 Aug 2005 14:01:10 -0500

Hi,

I'm having a problem with the rfcomm utility and linux select().
The symptoms are that if I CTRL-C after incomming connection is heard,
when using "rfcomm listen ... /dev/rfcomm10", /dev/rfcomm10 is deleted.  
More importantly, a select call on the device blocks except for the 
first try.  Also, when my machine boots, you have to run 
"/etc/init.d/bluetooth restart" for some reason, otherwise; bluetooth
doesn't work, it's like there is something stuck at boot up.

I created the /dev/rfcomm10 using .../bluz-utils-2.18/scripts/create_dev 
and am using a clean copy of "rfcomm."  I've also tried rebooting bluetooth
between each calls rfcomm and that doesn't work.

I reinstalled libs and utils.  I had been using the patch on 2.6.11 from
bluez.org.  I'm initially had an install of Fedora Core three based on 
2.6.9.

Thanks!

--bob w.

-- 
Robert Waldrop                  Motorola Personal Communications Sector
rwaldrop@urbana.css.mot.com     Urbana-Champaign Design Center
voice  217-384-8719             1800 South Oak Street
                                Champaign IL 61820

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
