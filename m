Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
Cc: David Vitrant <prussia@gmail.com>
References: <b5c638dc05032815321b2739c5@mail.gmail.com> <1112075117.9016.60.camel@pegasus> <b5c638dc05032907582bf771dc@mail.gmail.com>
In-Reply-To: <b5c638dc05032907582bf771dc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503292303.38682.pavouk@pavouk.org>
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
Date: Tue, 29 Mar 2005 23:03:38 +0200

Hello,

before few days 17.3.2005 writes Jonathan McDowell message about
success with Billionton card with identical ID:
  product info: "Compact Flash", "Bluetooth Card", "", ""
  manfid: 0x0279, 0x950b

He suggests these commands:
setserial /dev/ttyS0 baud_base 912600
hciattach -s 912600 /dev/ttyS0 bcsp

(His baudrate is probably wrong. 921600 instead 912600 can be).
But his mail have many additional informations.
Please look at archive of mailing-list and search for message with subject:
"Billionton(?) CF card - success".
 
>   manfid 0x0279, 0x950b
>   funcid serial_port [post]
>   serial_interface
>     uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
>   vers_1 7.1, "PCMCIA", "Bluetooth Card", "", ""

Best regards,

Pavel Ruzicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
