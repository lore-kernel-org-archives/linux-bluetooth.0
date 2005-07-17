Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez without libbluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: bluez-devel@lists.sf.net
In-Reply-To: <1121456287.7374.16.camel@gandalf.tm.informatik.uni-frankfurt.de>
References: 
	 <1121456287.7374.16.camel@gandalf.tm.informatik.uni-frankfurt.de>
Content-Type: text/plain
Message-Id: <1121607577.22662.16.camel@pegasus>
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
Date: Sun, 17 Jul 2005 15:39:37 +0200

Hi Mickey,

> Is there anyone who wrote a library or application using the Bluez
> kernel layer without linking to libbluez out there? I have been starting
> to write a C++ wrapper as part of a library that's supposed to be
> licensed under LGPL which means I can't look nor link nor even take part
> of the code of libbluez (which is GPL).
> 
> However, I didn't find any documentation that does teaches how to do
> that.

and how do you think it is possible to write a library that uses a
kernel interface that is under GPL. We have the bdaddr_t and some other
socket structs that you need to copy. However ask a lawyer about these
legal things.

And btw the Bluetooth library will be re-released under LGPL if I get an
approval from Qualcomm.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
