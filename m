Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About rfcomm socket
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41AD867D.2060609@avantwave.com>
References: <41AD2B86.6010002@avantwave.com>
	 <1101882506.18840.18.camel@pegasus>  <41AD867D.2060609@avantwave.com>
Content-Type: text/plain
Message-Id: <1101894514.18840.50.camel@pegasus>
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
Date: Wed, 01 Dec 2004 10:48:34 +0100

Hi Mike,

you posted your request to both mailing lists. Don't do any cross
posting.

>     Here is code fragment. I use usual fork practise to run these two 
> func do_connect and do_listen.  I hard code the bluetooth device to be 
> connected just because code is under testing.
>     And these two func are using different channel, it can be connected 
> when do_connect retry more than 3 times.
>     So i do not why it can not be connected when it is trying to connect 
> another device.

I don't get your point. Make it clear who is connecting to whom.

And if you don't set your socket to non-blocking the use of select makes
no sense. Show us the full code.

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
