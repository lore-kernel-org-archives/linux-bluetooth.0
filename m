Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedin <sua@home.se>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCI reset problem
References: <200507021912.29173.sua@home.se> <20050702211535.3F4B356F@arbetsmyra.dyndns.org>
In-Reply-To: <20050702211535.3F4B356F@arbetsmyra.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507031653.47442.sua@home.se>
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
Date: Sun, 3 Jul 2005 16:53:46 +0200

Hi Ronny and thanks for the quick reply

> This is probably of limited use but one can see from your hciconfig
> output your dongle hit a trouble. Here's some cut'n-paste from one of
> the CSR developer manuals of the meanings:
>
> >         Panic code:   0x16
> An irrecoverable error has occurred within the Bluetooth Link
> Controller.
>
> >         Fault code:   0x1e
> Either the chip received an unrecognised RFCOMM (upper interface)
> command message from the host or the chip ran out of pool memory when
> processing the message. In either case the message has been discarded.
> Presuming the fault was issued because of an invalid RFCOMM message,
> the firmware has survived the problem.

Now that I know that the codes mean something I looked a bit more into it. The 
Panic code is 0x01 before the reset and 0x16 after (I guess that 0x01 is the 
normal value). Also, when I did a few more tries this morning, I got Panic 
code 0x22 and Fault code 0x1f. Since it looks that you have some usefull 
documents, could you look up the meaning of 0x22 and 0x1f?

So, I get panic code 0x16 when the reset happend out of it self and 0x22 when
provoked by a rfcomm connection. The strange thing is that Fault code 0x1f is 
there all the time. It shows up when I run the first hciconfig directly after 
bringing up everyting which makes me believe that someting else is wrong 
earlier in the startup process (or is 0x1f the "normal" value for the fault 
code?).

> Since your dongle seem to do a reset it "looks" like the mem pool ran
> out. But this is only a gues of mine. Is the error reproducable when
> using MS-Windows? In that case the donge firmware might need an update.

Hmm, I nuked the pre-installed XP since I didn't plan to use it.... perhaps a 
mistake. But it is possible to reinstall to check, but then I have to remove 
my current linux installation so I like to try other options first.

Do any of you have firmware files available? Perhaps any of the HCI 18.2 
versions listed here:

 http://www.holtmann.org/linux/bluetooth/csr.html

Can I restore my dongle in case of bad firmware if I do dfutool archive first 
to save my current firmware?

Regards Johan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
