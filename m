Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4225DEAC.7050203@gmx.de>
From: Zbigniew Diaczyszyn <z.dia@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] Typhoon BluetoothModem working with Suse Linux 9.0
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
Date: Wed, 02 Mar 2005 16:41:32 +0100


I got the error message "Permission denied", although hcid was working
correctly, /bin/bluepin got the "echo PIN:xxxx"  command and
/dev/rfcomm0 was installed.

The solution: A Windows-connection with the Modem deranged the pairing
with the Linux-connection. After I had deleted the content of the file
/etc/bluetooth/link_key, or when I had renamed it to link_key.org, then 
everything
was working fine.

-----
Zbigniew Diaczyszyn	z.dia@gmx.de




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
