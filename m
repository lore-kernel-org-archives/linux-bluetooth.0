Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] RFCOMM connection problem Casira (Bluelab) and Bluez
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1120135682.42c3ea026eacb@www.webmail.ucl.ac.uk>
Message-Id: <20050630133545.0C2F31EAADA@mrelay1.st2.lyceu.net>
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
Date: Thu, 30 Jun 2005 15:36:34 +0200

Hello
Have you created the device rfcomm0? I'm also new with BlueZ, and have been
this days trying to get it into work.  In my case, but doing the following,
I managed to establish the rfcomm connection:

mknod /dev/rfcomm0 c 216 0 -> to create the device

Edit /etc/Bluetooth/rfcomm.conf
	rfcomm0{ 	bind yes;
			device 00:00:00:00;
			channel 1;
			comment "name";
		}
Replace the 00:00:00:00 with the address of the device you want to connect
to, and the channel number to the one defined for the service you want to
use.

I hope this helps!! (It works for me)

Regards 

Esther Lopez

-----Mensaje original-----
De: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] En nombre de
uceemoa@ucl.ac.uk
Enviado el: jueves, 30 de junio de 2005 14:48
Para: bluez-users@lists.sourceforge.net
Asunto: [Bluez-users] RFCOMM connection problem Casira (Bluelab) and Bluez


Hi all,

I'm a newbie for this bluez. I have a dongle (Bluez) and trying to connect
with
Casira (Bluelab). I can not establish the RFCOMM connection between both of
them. I set the Casira as slave and the dongle (bluez) as a master. I try to
connect the dongle, rfcomm connect 0 <addr>. But it display "can't open
RFCOMM
device : No such file or directory".  I hd try to connect with Nokia 660,
and
it's working. Do any of you know what I should do? one more thing, how I
want
to disable the modem status command?



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
