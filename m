Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Kernel module for PCMCIA/CF Bluetooth cards with CSR chipset
Message-ID: <20050801214137.GA30572@adamis.de>
References: <20050728030527.B34DB12FEB@sc8-sf-spam2.sourceforge.net> <Pine.LNX.4.60.0507281157380.15380@purdy.demon.co.uk> <200507281340.00164.wolfgang@iksw-muees.de> <Pine.LNX.4.60.0507281250290.15380@purdy.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0507281250290.15380@purdy.demon.co.uk>
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
Date: Mon, 1 Aug 2005 23:41:37 +0200

On 28.07.05 13:08:13, andy thomas wrote:
> Ah, I thought I'd try a low baud rate to begin with. But it still times 
> out if I use the 'bcsp' parameter although if I use 'any' then the hci0 
> device is registered:
> 
>   # hciattach ttyS1 any
>   # hciconfig -a
>   hci0:   Type: UART
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN
>         RX bytes:2086 acl:0 sco:0 events:6 errors:168
>         TX bytes:4 acl:0 sco:0 commands:1 errors:0
> 
> but it still won't come up.
> 
>   # hciconfig hci0 up
>   Can't init device hci0: Connection timed out (110)

if you're using a 2.6 kernel: did you apply the patch for the serial
driver I posted here some time ago? had the same problems before.

Regards,
Mathias

-- 
Perfection is achieved not when you have nothing more to add,
but when you have nothing left to take away.
 - Antoine de Saint-Exupery


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
