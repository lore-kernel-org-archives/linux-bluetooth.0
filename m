Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] trying to send data at HCI level
From: Marcel Holtmann <marcel@holtmann.org>
To: Mohan K <kmohangda@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <7aa80ced0502212319181c8835@mail.gmail.com>
References: <7aa80ced0502212224cce2126@mail.gmail.com>
	 <1109055931.8506.0.camel@pegasus>
	 <7aa80ced0502212319181c8835@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109059399.8506.3.camel@pegasus>
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
Date: Tue, 22 Feb 2005 09:03:19 +0100

Hi Mohan,

>               Thank you for your response. I need some clarifications. 
> How to set the device device in RAW mode? In my program I opened the
> socket in RAW mode. Is it sufficient?

no, that is not enough. You must use "ioctl(dd, HCISETRAW, 1)".

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
