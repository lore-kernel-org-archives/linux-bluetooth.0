Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas =?ISO-8859-1?Q?B=F6hler?= <andy.boehler@gmx.at>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20050702172632.3d3b3dcd.andy.boehler@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] emporia/mega-Headset and btsco problems
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
Date: Sat, 2 Jul 2005 17:26:32 +0200

Hi!

I recently purchased a Mega BT-Headset and fetched, compiled and installed =
btsco from bluetooth-alsa.sf.net.=20
Pairing works fine and sending and receiving audio from and to the headset =
also works - for a while.=20
My problem is, that the headset disconnects after a very short time if no a=
udio is transmitted!
I think that this is the same problem as with the Jabra BT-110: "Jabra BT11=
0 (will turn off very soon after the last audio packets have been transmitt=
ed and btsco will quit with "RFCOMM channel lost")" -> quote from bluetooth=
-alsa.sf.net main page.
I'm wondering if someone has solved this problem? Isn't it possible that bt=
sco simply reconnects to the headset? Or that it transmits empty or quiet a=
udio-frames just to keep the connection alive?
I tried what is done using Windows: When you connect the headset, it rings =
as if the phone was ringing and you have to pick it up (headset-button), th=
en the connection is established. I wonder if this would also work under Li=
nux? Or is this the implementation of the Hands-Free profile and not the He=
adset-Profile?

Any help is appreciated,=20

thanks,

Andreas B=F6hler

PS: I'm using Linux 2.6.12, custom compilation, D-Link DBT-120 (or Digitus =
DN-3008), SoL-Linux 18.00, BlueZ-stack and Mega BTHS-6023-F (manufacturer i=
s Emporia, www.emporia.at)

--=20
Andreas B=F6hler
andy.boehler@gmx.at
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
