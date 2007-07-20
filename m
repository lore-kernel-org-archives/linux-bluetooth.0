Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c02b565a0707200259u12be6d64qacaaddc86a7bd319@mail.gmail.com>
Date: Fri, 20 Jul 2007 11:59:38 +0200
From: "Crni Gorac" <cgorac@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] Plantronics Explorer 350 and bluetooth-alsa
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

To reply to my own questions from previous posting:

1. It is absolutely necessary to apply sco-flowcontrol kernel patch in
order to have Bluetooth headsets supported properly.  The patch
updated for current (2.6.22.1) kernel could be found here:
http://gentoo-wiki.com/HOWTO_use_a_bluetooth_headset, link is under
"Step 2" (bu the way, the whole thing with this patch really sucks, it
should be pushed upstream into the kernel ASAP).

2. Also, option "CONFIG_BT_SCO" must be enabled in kernel in order to
have Bluetooth headsets working properly.

So, now I have my headset working fine (am able to make a recording
using "arecord -D plug:headset test.wav", and play it back using
"aplay -D plug:headset test.wav"); on the other side, Skype seems to
have its own issues in actually using ALSA, but that's another
story...

HTH.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
