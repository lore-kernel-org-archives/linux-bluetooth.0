Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btohs,btohl, ...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050209143858.1e0350c3@CleverSophie>
References: <20050209140701.2cf50710@CleverSophie>
	 <1107955171.13863.26.camel@pegasus>  <20050209143858.1e0350c3@CleverSophie>
Content-Type: text/plain
Message-Id: <1107957430.13863.34.camel@pegasus>
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
Date: Wed, 09 Feb 2005 14:57:10 +0100

Hi Bjoern,

> sorry for my signing. I read that sometimes a different order is used within a byte as well and not only between bytes. 

I don't know of any architecture that stores the bits of its bytes in a
different order and where this is visible to for the user. However such
a platform might exists.

> Okay that makes it easier.

You mean big endian communicates with little endian or vice versa?

> But if this is not the case:
> When I send a 32bit integer for example, do I have to worry about the order of the bytes when I send or receive them? 

If you have a byte stream (a character array) then you don't need to
worry, because they are stored in a endianless format (bytewise). If you
use datatypes like uint16_t and uint32_t and send them to the stream or
copy them into an array then you should convert them to the same endian
encoding.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
