Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btohs,btohl, ...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050209140701.2cf50710@CleverSophie>
References: <20050209140701.2cf50710@CleverSophie>
Content-Type: text/plain
Message-Id: <1107955171.13863.26.camel@pegasus>
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
Date: Wed, 09 Feb 2005 14:19:31 +0100

Hi Bjoern,

if you sign emails that go to a mailing list. Make sure that your key is
available on a public keyserver. Yours is not.

> I implemented a client server over bluetooth and I was wondering if I need the Little Endian, Big Endien conversion functions btohs,btohl,htobs,htobl?

if both sides are of the same endianess then not, but it is a good
programming style to always use them.

> Do I need to convert every single byte? which is received or sent over my sock_stream socket?
> If yes, should it look like this for the receiving case: btohs(buf[0]).... an so on for every byte?

For what do you wanna swap a byte and with what? There is nothing to
swap. Think about it ;)

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
