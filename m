Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Janice M. Ballesteros" <janice@asti.dost.gov.ph>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502211623.57809.janice@asti.dost.gov.ph>
Subject: [Bluez-users] multiple instances of OPUSH server
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
Date: Mon, 21 Feb 2005 16:23:57 +0800

Halu!

How do I enable support for multiple instances of an Obex server. Im using 
OPD. What Im trying to do is setup two OPD servers on my computer. Two 
bluetooth dongles will be used. One of the dongles listen to rfcomm channel 
10 and the other to channel 3. I want one instance of OPD to listen to rfcomm 
channel 10 on /dev/rfcomm0 and the other one to channel 3 on /dev/rfcomm1.

If I run one instance of opd on channel 10, it works fine but when I try to 
run the 2nd opd on channel 3 i get the error message:
opd[4561]: Failed to register BtOBEX server on RFCOMM channel 10. (-1 / 98)
It seems that everytime I run opd, its default rfcomm device is /dev/rfcomm0. 
Note: error 98 stands for " Address already in use "

How do I make OPD run on a specified rfcomm device (say on /dev/rfcomm1)?
I tried looking at the code of OPD but I cant seem to find how to change the 
default rfcomm device. I also tried binding my bluetooth dongles to specified 
rfcomm devices and channels but it still doesnt work.

Any help/insight is greatly appreciated. 
Many thanks. :)

-jan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
