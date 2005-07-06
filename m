Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedin <sua@home.se>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCI reset problem
References: <200507021912.29173.sua@home.se> <200507031653.47442.sua@home.se> <20050706001104.BBC6A43A@arbetsmyra.dyndns.org>
In-Reply-To: <20050706001104.BBC6A43A@arbetsmyra.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507062228.01252.sua@home.se>
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
Date: Wed, 6 Jul 2005 22:28:01 +0200

Hi Ronny and others,

> Hi
> Ok, here are the descriptions:
>  Panic 0x22:
> An irrecoverable USB (hardware) error has been detected.

Ok, since I get a USB disconnect, panic 0x22 doesn't seem too unrelated.

>  Fault 0x1f:
> Either the chip received an unrecognised SDD/SDP (upper interface)
> command message from the host or the chip ran out of pool memory when
> processing the message. In either case, the message has been discarded.
> Presuming the fault was issued because of an invalid SDD/SDP message,
> the firmware has survived the problem.

Since the fault is there when I start my tests and everything works in the 
beginning, I guess that the firmware survived the fault (thus indicating an 
unrecognised SDD/SDP message).

> Unfortunately panic code 0x01 ain't the normal value, that's 0. And
> when everything is working all right hciconfig won't even show any
> "panic" value at all. It only display non-zero values.
>
>  Panic 0x01:
> The useless catchall. Used to indicate an error where no other
> appropriate panic code exists.

Well, just have to accept that...

> I'm only guessing but chances are the internal USB transfer might cause
> the errors too. You might want to try with a Knoppix or other live CD
> first but then I think you should make your machine to dual boot
> between Linux/Windows.

Yes, especially with panic code 0x22 I suspect USB as well...
So the next step for me is most likely a re-install to narrow down the 
problem. I  will try dual/triple boot with an older Fedora version, XP and 
perhaps some other distro.

Fedora Core 4 is compiled with GCC 4.0 and recent mails from Marcel indicated 
that there were some issues with BlueZ and GCC 4.0. Perhaps this is related 
to my problems?

> To my knowledge you must get the unique firmware from each respective
> dongle manufacturer, but I'm a bit uncertain of this.

Then I'll wait with any firmware experiments.

/ Johan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
