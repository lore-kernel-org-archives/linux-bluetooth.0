Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cvhkqf$2b0$2@sea.gmane.org>
References: <7aa80ced0502222239dd01830@mail.gmail.com>	 <cvh9lh$2b0$1@sea.gmane.org> <7aa80ced05022223273b5bba4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <7aa80ced05022223273b5bba4c@mail.gmail.com>
Subject: [Bluez-users] Re: Can't able to send data in both direction
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
Date: Wed, 23 Feb 2005 11:14:06 +0100

Hi,

>     When the sending program runs on the SiW dongle PC , HCI dump is
> not displaying any thing and it is giving the following error.
 >
> Error message on the sending side:
> 
> [root@localhost ]# ./senddata
> 
> L2CAP socket opened successfully.
> 
> Can't connect: No route to host (113)
I have no clue why this happens. Please post the sourcecode of your
application.

> Can't send data.
> : Bad file descriptor
This happens because it can't connect.
No connection, not able to send data!

Maybe there is a problem in the program. Or the needed kernel modules
are not loaded (just a guess).
# lsmod | grep -e l2cap -e rfcomm

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
