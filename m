Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas =?ISO-8859-1?Q?B=F6hler?= <andy.boehler@gmx.at>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] emporia/mega-Headset and btsco problems
Message-Id: <20050703004746.45b60662.andy.boehler@gmx.at>
In-Reply-To: <42C70688.9050407@xmission.com>
References: <20050702172632.3d3b3dcd.andy.boehler@gmx.at>
	<42C70688.9050407@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sun, 3 Jul 2005 00:47:46 +0200

Hi, thanks for the quick reply;

> One thing we have needed to do for a long time that would help this is=20
> to rebuild the rfcomm connection when it goes bad (or even make it=20
> happen on demand). With other headsets, the rfcomm connection only goes=20
> bad if the headset goes out of range. Holding the rfcomm connection open=
=20
> isn't great anyway because I think it prevents a laptop from suspending.

yeah, the best way to handle my particular headset would be if btsco reconn=
ects the rfcomm-channel after it is lost!
May I ask someone if it is possible to supply such a patch? I would really =
do it myself, if I had the necessary C-skills....

thanks,=20

andy

--=20
Andreas B=F6hler
andy (dot) boehler (at) gmx (dot) at
www.klasseonline.tk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
