Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <008901c50f7e$eccd4a60$7aac623e@pc>
From: "Jers" <salanga@tiscali.it>
To: <bluez-users@lists.sourceforge.net>
References: <20050208134358.17173.qmail@web53202.mail.yahoo.com> <1107880993.7327.190.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] IP address
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
Date: Thu, 10 Feb 2005 15:41:17 +0100

Hi all,
I intend to create a wireless network of laptops using bt-dongles.
I know that, first "pand -c <btaddr>" creates a connection and a bnep
interface, then an ip-address can be set to the bnep (ifconfig  bnepX
<ipaddr>)
Is it possible to assign the ip-address to each laptop/dongle before
creating connections?
Suppose that the ip-addressess of devices in a coverage area are set and
known. I'd like that involved laptops can require connection among
themselves using the ipaddress instead of btaddr.
Does BlueZ meet my requirements?
Thanks a lot.
Jers



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
