Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Dun Server
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1108718316.4215b2ec84280@imp5-q.free.fr>
References: <1108718316.4215b2ec84280@imp5-q.free.fr>
Content-Type: text/plain
Message-Id: <1109027308.7626.25.camel@pegasus>
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
Date: Tue, 22 Feb 2005 00:08:28 +0100

Hi,

>  I'd like to implement a Dun Server in my Linux Box. My problem is the AT
> command, I want to implement a real DUN server not LAN server.
> 
> My problem is around the AT command, and I want to know if this solution is
> already implemented.
> 
> My device is connect to my Linux box by a RFCOMM connection in the DUN channel.
> The device send for example AT+GMI ...the response is : Linux..OK..
> After                       AT+GMM...the response is : Linux x86..OK..
> 
> The goal is to replace my Bluetooth phone by my dsl linuxbox !

you can add support for it in dund directly or try using programs like
chat in conjunction with the pppd caller options of dund.

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
