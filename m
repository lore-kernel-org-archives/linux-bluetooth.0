Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ipaq 1945
From: Marcel Holtmann <marcel@holtmann.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
Cc: Wolfgang <wood.stock@gmx.net>, bluez-users@lists.sourceforge.net
In-Reply-To: <320075ff04092805251ce925e6@mail.gmail.com>
References: <320075ff040925153753850d92@mail.gmail.com>
	 <1096153758.7719.12.camel@pegasus>
	 <320075ff040926011212538dac@mail.gmail.com>
	 <003001c4a3ba$d064fba0$8696a8c0@marcy>
	 <320075ff0409270050bbaf228@mail.gmail.com>
	 <1096371841.4950.5.camel@notepaq>
	 <320075ff04092805251ce925e6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1096374487.4649.5.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 28 Sep 2004 14:28:07 +0200

Hi Nigel,

> I got a lot further, I can connect to my server now; I am just left
> with trying to understand why I can't get bridging to work.
> 
> I have:
>  - router (Internet, DHCP serving 192.168.1.{100-200}) (255.255.255.0)
>  - linux box, eth0 = 192.168.1.55 (fixed), bnep0 for bluetooth
>  - iPaq connecting to bluetooth
> 
> I can talk to the server by making bnep0 192.168.*2*.254 and fixing
> the IP address in the ipaq (or running a dchp server on linux as
> well), but it would be nice to not have to have another dchp server.
> 
> I had thought I could bridge the interfaces, but I have tried lots of
> things like
> brctl addbr br0
>  brctl addif br0 eth0
>  brctl addif br0 bnep0
> 
> but that just leads to aggravating things like the linux box dropping
> off the network altogether ..

look at the PAN howto. It has the correct commands to setup a bridge
when you are using Bluetooth BNEP.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
