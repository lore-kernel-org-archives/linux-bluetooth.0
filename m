Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6D4DC8B4AD16D6118E8200D0B76FE2621033CFE6@ont06exm01.comm.mot.com>
From: Belokour Victor-Y18342C <Y18342C@motorola.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-users] Re: PIN for Microsoft Mouse (Marcel Holtmann)
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
Date: Fri, 8 Apr 2005 12:32:22 -0400

Hi Marcel

How do I enable security mode 1/2 ??
In hcid.conf, there are only options 'none', 'auto' and 'user'.

Thanks


-----Original Message-----

so you are using security mode 3 and in this case this is how it will be, because the mouse can't store a link key. And actually if you follow the HID profile then it don't have to.

Use security mode 1/2 and if needed add --encrypt when you start the hidd server daemon.

Regards

Marcel





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
