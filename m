Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c638dc05032912313f814461@mail.gmail.com>
References: <b5c638dc05032815321b2739c5@mail.gmail.com>
	 <1112075117.9016.60.camel@pegasus>
	 <b5c638dc05032907582bf771dc@mail.gmail.com>
	 <1112114217.9016.92.camel@pegasus>
	 <b5c638dc050329084145c6fecd@mail.gmail.com>
	 <1112114986.9016.94.camel@pegasus>
	 <b5c638dc05032908584e207be8@mail.gmail.com>
	 <b5c638dc05032909155d940a3c@mail.gmail.com>
	 <b5c638dc0503290934170df12@mail.gmail.com>
	 <1112117903.9016.103.camel@pegasus>
	 <b5c638dc05032912313f814461@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112128804.9016.111.camel@pegasus>
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
Date: Tue, 29 Mar 2005 22:40:04 +0200

Hi David,

> ok well i tried from 9600 to 921600
> 
> using the:
> 
> hciattach ttyS14 any "number here"
> 
> then i did what you said and ran "hcid" and "hciconfig" in every
> outpud it's the same (except the RX bytes and errors increase)
> 
> am i missing something  or does that mean that my card just doesn't
> work with bluez :(
> 
> hci0:   Type: UART
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN INIT RUNNING
>         RX bytes:18 acl:0 sco:0 events:0 errors:18
>         TX bytes:4 acl:0 sco:0 commands:1 errors:0

there are actually more options to hciattach than only changing the baud
rate. May you look at the Windows driver *.inf to get a clue what they
are. However if this card uses a CSR chip then

	hciattach ttyS14 bcsp 115200

might work. It can also be possible that this card has a problem,
because some weird things in the new serial subsystem of the kernel.

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
