Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth clock and security manager
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <312616200.24329@bjut.edu.cn>
References: <312616200.24329@bjut.edu.cn>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1112618303.8263.92.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 04 Apr 2005 14:38:23 +0200

Hi,

>   I want to read local bluetooth clock with hcitool. But when I use the=
 command "hcitool clock XX:XX:XX:XX:XX:XX=EF=BC=88local bd_addr)",the ret=
urn message is "not connected",and I am sure that I have created one ACL =
link.
>   So, I use "hcitool clock  XX:XX:XX:XX:XX:XX=EF=BC=88remote bd_addr)",=
the reture message is "read failed,Input/output error",but the command "h=
citool clkoff" works good.

the clock reading is a Bluetooth 1.2 feature. So make sure that you use
Bluetooth 1.2 device that supports this HCI command.

>   There is another question about security mananger within BlueZ.
>   I have paired my pda with BlueZ successfully,but I want to make it cl=
early that how to add authenticated device into the security manager in p=
rogramming ,and where do these authenticated device go?

The current security manager is inside hcid. The link keys are stored
at /etc/bluetooth/link_key.

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
