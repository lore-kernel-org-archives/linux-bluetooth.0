Return-Path: <cyrus@holtmann.org>
Message-ID: <48463F6F.6010500@magtech.com.au>
Date: Wed, 04 Jun 2008 17:08:31 +1000
From: Aras Vaichas <arasv@magtech.com.au>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
	<d89ddf300805290539q2401bcx915d0b0756824409@mail.gmail.com>
In-Reply-To: <d89ddf300805290539q2401bcx915d0b0756824409@mail.gmail.com>
Subject: Re: [Bluez-users] DUND pre-pppd script
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Brad Midgley wrote:
> Aras
>
>   
>> I need to determine my ppp IP address pair before I run pppd.
>>     
>
> I ran into this when setting up a bluetooth AP for use with a couple
> of nokia devices. They are using dun not pan, and I wanted to assign
> different addresses to each device. I had to hardcode the ip addresses
> in the nokias' dialup config which wasn't very satisfying.
>
>   

Thanks for the replies and ideas. What I've done is this:

#!/bin/sh
IP_PAIR=`safeip -p`
pppd $1 $2 ${IP_PAIR} $3 $4 $5 $6 $7 $8 $9


safeip is a Python script I wrote which finds a private subnet of size 2
that is not in use anywhere on the system. Option -p returns the data
like so: IP1:IP2

I just pass this IP pair on to pppd as well as all the other information
that dund passes on from itself and the /etc/default/bluetooth file.

Works quite well regardless of the state of (almost) any other possible
network configuration. I can also connect from multiple devices and it
just dishes out a new IP pair every time.

my /etc/default/bluetooth file has:
DUND_OPTIONS="--listen --persist --channel 3 --msdun --pppd pppd_pre.sh
crtscts 115200 ms-dns 10.0.0.1

I haven't fixed the ms-dns entry yet, but that is easily done

Aras

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
