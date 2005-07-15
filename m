Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluez without libbluez?
Cc: "Michael 'Mickey' Lauer" <mickey@tm.informatik.uni-frankfurt.de>,
   bluez-devel@lists.sf.net
References: <1121456287.7374.16.camel@gandalf.tm.informatik.uni-frankfurt.de>
In-Reply-To: <1121456287.7374.16.camel@gandalf.tm.informatik.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200507160026.47848.bluez-devel@schaettgen.de>
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
Date: Sat, 16 Jul 2005 00:26:47 +0200

On Friday, 15. July 2005 21:38, Michael 'Mickey' Lauer wrote:
=2E..
> As a side note, I'm wondering how libkdebluetooth and Gnome's libbtctl
> can claim that they're LGPL while linking to libbluez.

libkbluetooth is GPLed or did I miss something?
libqobex on the other hand is in fact LGPLed. But libqobex alone as source=
=20
does not derive from or use the BlueZ libs. It does once you compile it,=20
which means that the resulting programs must be GPLed. Which they are. And=
=20
besides that I won=C2=B4t care about such details unless as german court co=
mmented=20
on these linking issues. The outcome will be like throwing a dice anyway.

=46red

=2D-=20
=46red Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
