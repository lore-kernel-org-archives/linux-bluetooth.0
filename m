Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gene Imes <ebi7@ozob.net>
To: list-bluez <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1080515964.11299.4.camel@go2>
Mime-Version: 1.0
Subject: [Bluez-users] rfcomm problems
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
Date: Sun, 28 Mar 2004 17:19:24 -0600

I have a D-Link dbt-120 dongle. This has been working fine with a
bluetooth GPS. However today I tried to use it and I could not connect
to the GPS.

When I plug the dbt-120 in the /dev/rfcomm0-255 are created. If I try a
'cat /dev/rfcomm0' I get cat: rfcomm0 No such device. Previously a 'cat
/dev/rfcomm0' would return everything the GPS was sending.

Anyone know what is going on here?

Thanks,

Gene 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
