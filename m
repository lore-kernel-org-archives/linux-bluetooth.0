Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] trying to send data at HCI level
From: Marcel Holtmann <marcel@holtmann.org>
To: Mohan K <kmohangda@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <7aa80ced0502220057379ef414@mail.gmail.com>
References: <7aa80ced0502212224cce2126@mail.gmail.com>
	 <1109055931.8506.0.camel@pegasus>
	 <7aa80ced0502212319181c8835@mail.gmail.com>
	 <1109059399.8506.3.camel@pegasus>
	 <7aa80ced050222002338e57eaf@mail.gmail.com>
	 <7aa80ced0502220057379ef414@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109066181.8506.6.camel@pegasus>
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
Date: Tue, 22 Feb 2005 10:56:21 +0100

Hi Mohan,

>               Thank you for your valuable information. I am new to
> Bluetooth. Anyhow I have written L2CAP level send & recv program
> successfully. In the L2CAP level, on the sending end, I created a
> socket and transmitted the data using "send" function. Whereas on recv
> side  I created a small server program, which listens for connection
> and receives the data using "read" function. I am trying to use the
> same functions in the HCI level also.
>                Can I use the same send and recv functions in the HCI
> level after creating the HCI RAW sockets? If it is not possible, could
> you please tell me which function I have to use to send and recv the
> data in the HCI level?

this won't work, because HCI is a raw socket and L2CAP is sequential
packet socket. If you wanna use HCI then you have to conform to the H:4
specification and send everything in this format.

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
