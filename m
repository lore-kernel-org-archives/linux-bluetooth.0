Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Fwd: [Bluez-users] trying to send data at HCI level
From: Marcel Holtmann <marcel@holtmann.org>
To: Mohan K <kmohangda@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <7aa80ced050222024634dce552@mail.gmail.com>
References: <7aa80ced0502212224cce2126@mail.gmail.com>
	 <1109055931.8506.0.camel@pegasus>
	 <7aa80ced0502212319181c8835@mail.gmail.com>
	 <1109059399.8506.3.camel@pegasus>
	 <7aa80ced050222002338e57eaf@mail.gmail.com>
	 <7aa80ced0502220057379ef414@mail.gmail.com>
	 <1109066181.8506.6.camel@pegasus>
	 <7aa80ced0502220231161c0a3@mail.gmail.com>
	 <1109068760.8506.13.camel@pegasus>
	 <7aa80ced050222024634dce552@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109069504.8506.16.camel@pegasus>
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
Date: Tue, 22 Feb 2005 11:51:44 +0100

Hi Mohan,

>               Whether I want to establish the connection between two
> PC's, like L2CAP?. Can I directly read or write using the raw socket?
>               I saw a function "hci_create_connection" in hci.c! 

HCI is the host controller interface and you should not use it for
direct communication between two devices. It is the hardware abstraction
of Bluetooth. Use L2CAP instead.

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
