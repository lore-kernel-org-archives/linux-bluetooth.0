Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to create a shortcut for connecting to
	internet
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050409173218.1597.qmail@webmail28.rediffmail.com>
References: <20050409173218.1597.qmail@webmail28.rediffmail.com>
Content-Type: text/plain
Message-Id: <1113068391.9655.6.camel@pegasus>
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
Date: Sat, 09 Apr 2005 19:39:51 +0200

Hi Adil,

> i have been using internet successfully over the last couple of months
> by typing the following commands.
> 
> 1) hcitool scan
> 
>   ==>which gives me the <b-addr>
> 
> 2) rfcoomm bind 0 <b-addr> 7
> 
> 3) wvdial GPRS
> 
>   ==> GPRS being some file i wrote as directed by a pdf which i used
> as 
>       guidance.
> 
> Que)Can any1 tell me how to automate these 3 steps so that i donot
> have to do this every time i want to connect. My friends tell me i
> have to write a executable file. I have very limited knowledge of
> linux-programming (scripting if thats what u call it!!!), so please if
> any1 understands what that means..???

if you know the BD_ADDR then you can use the rfcomm autobind feature to
create the /dev/rfcomm0 device. Check /etc/bluetooth/rfcomm.conf and
make sure that the init script executes "rfcomm bind all" at some point.
After that you only have to call "wvdial GPRS" to be happy.

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
