Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About rfcomm socket
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1ffb4b070412060647d45e65b@mail.gmail.com>
References: <41AD2B86.6010002@avantwave.com>
	 <1102043750.7350.41.camel@pegasus> <41B40C4B.90002@avantwave.com>
	 <1102318698.8510.69.camel@pegasus> <41B44296.40805@avantwave.com>
	 <1102332461.9644.13.camel@pegasus>
	 <1ffb4b0704120605174bda678@mail.gmail.com>
	 <1102339636.9644.18.camel@pegasus>
	 <1ffb4b0704120606046b7bbfae@mail.gmail.com>
	 <1102342812.9644.26.camel@pegasus>
	 <1ffb4b070412060647d45e65b@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102347674.9644.34.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 06 Dec 2004 16:41:14 +0100

Hi Mike,

>     I have one question about rfcomm, Is there any setting like MTU in TCP? 

no, because RFCOMM is a stream. All MTU stuff is hidden inside the
implementation.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
