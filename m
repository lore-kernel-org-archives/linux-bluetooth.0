Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] tx submit failed urb c4c6b014 type 3 err -19
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0502241626280.12963-100000@blomma.comm2000.it>
References: <Pine.LNX.4.21.0502241626280.12963-100000@blomma.comm2000.it>
Content-Type: text/plain
Message-Id: <1109578717.17256.15.camel@pegasus>
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
Date: Mon, 28 Feb 2005 09:18:37 +0100

Hi Maxim,

> I'm prototyping an application that should eventually become a
> Voip/Bluethooth gateway.
> 
> Among the various problems I'm facing (i.e. occasional bizzare errors on
> SCO connections, or inability to open more than one SCO link through the
> same BT dongle), the currently most serious one is the following.
> 
> After a while my program is running (repeatedly dialing a phone number,
> opening and closing the audio link), the following error shows up
> 
>  kernel: __tx_submit: hci0 tx submit failed urb c4c6b014 type 3 err -19
> 
> followed, a few seconds later, by an "Unable to handle kernel NULL
> pointer..." message, which does not get logged.
> 
> Of course, I'm not asking what the cause is. I just need some suggestions
> as to how to further investigate the problem and provide a more useful
> report.
> 
> My system is Debian with kernel package 2.6.10-1-686.

build your own 2.6.11-rc5 kernel and use netconsole to get the full
oops.

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
