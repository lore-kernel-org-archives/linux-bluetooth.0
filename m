Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Karneges <justin-qt@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309231444.09863.justin-qt@affinix.com>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309231409.47300.justin-qt@affinix.com>
	<1064353054.1620.40.camel@pegasus>
	<200309231444.09863.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1064355476.1619.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 24 Sep 2003 00:17:51 +0200

Hi Justin,

> Ok, so it appears that the resetting of the card itself is the issue at hand.

I am not 100% sure, but this is what I got.

> How did you write the rest of the driver without the specs?  It would seem if 
> you were able to get this far, that deriving the reset function would be 
> possible.

The Affix stack came with support of the DTL-1 card and I have started
to read their code, which was very ugly by the way. After analysing the
complete HCI abstraction and the driver itself, the driver divides into
two parts. One is the HCI transport protocol which is not H:4, the other
part is the correct way of driving the internal UART on the card. The
Affix driver was not portable in any way, so I have started to write a
driver for these cards from scratch.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
