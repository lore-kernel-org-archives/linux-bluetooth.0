Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Michael 'Mickey' Lauer" <mickey@tm.informatik.uni-frankfurt.de>
To: bluez-devel@lists.sf.net
Content-Type: text/plain
Message-Id: <1121456287.7374.16.camel@gandalf.tm.informatik.uni-frankfurt.de>
Mime-Version: 1.0
Subject: [Bluez-devel] Bluez without libbluez?
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
Date: Fri, 15 Jul 2005 21:38:07 +0200

Hi,

Is there anyone who wrote a library or application using the Bluez
kernel layer without linking to libbluez out there? I have been starting
to write a C++ wrapper as part of a library that's supposed to be
licensed under LGPL which means I can't look nor link nor even take part
of the code of libbluez (which is GPL).

However, I didn't find any documentation that does teaches how to do
that.

As a side note, I'm wondering how libkdebluetooth and Gnome's libbtctl
can claim that they're LGPL while linking to libbluez.

Maybe I'm confused :)

Thanks for reading,

Mickey.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
