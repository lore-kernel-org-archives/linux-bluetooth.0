Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43078EF3.4050702@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco - a few comments and a small .py script
References: <20050819193855.GA25514@uni-duesseldorf.de>
In-Reply-To: <20050819193855.GA25514@uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 20 Aug 2005 14:13:39 -0600

Andreas,

> I've played around with btsco the last few days - now it sort of works
> like intended.

great

> I got the following comments about the procedure:
> 
> 1. I'd like to suggest to put the comment about compatible dongles on
>    the btsco website a little clearer.
> 
>    "If it doesn't say anything at all about SCO mapping, " wasn't clear 
>    to me (being a bluetooth newbie), as it was "displaying something
>    with SCO" (i.e. the MTU, but I didn't grasp the difference at first,
>    as my first adapter didn't show more than the first 2 lines).
> 
>    I'd suggest to put a simple exaple there, how the results from
>    "hciconfig hci0 revision" should look like. I.e. that the line 
>    "SCO mapping:  HCI" should exist.

I cleaned this up a bit.

> A: Remove the line in /var/lib/bluetooth/[my-bdaddr]/linkkeys that is
> corresponding to the device that doesn't want to pair. BlueZ thinks it
> is already paired, but the Link-Key does not match.
> 
>    Another - possibly very interesting - solution would be to allow to
>    change the bdaddr in software. This would allow me to fake the same
>    dongle to have two different bdaddrs depending on where I use it,
>    thus allowing the headset to correctly pair with _both_ devices,
>    so that I only need to move the dongle and everything works.
> 
>    Is there such a command? Please excuse, if it is obvious. I'm very
>    new to this stuff.

I don't know of such a command. /etc/bluetooth/link_key is how the keys 
are stored in the older daemon so I've mentioned both in the docs.

> 3. I have written a small Python-Script and a .btscorc

Perfect. I gave a talk about btsco at our usergroup meeting and this 
very question came up! (slides at http://flamebot.com/blog)

I will link to you or put these in a contrib dir (what do you think?)

> 4. I also have the "microphone transmits noise" problem sometimes
>    (rarely). Could it be, that there is a missed byte that swaps high
>    and lowbyte? It sounded a bit like this to me.

I think you are right. There is some kind of fundamental transport glitch.

> 5. My cheap (EUR 22.- incl. VAT) LevelOne BLH-1000 Headset works fine,
>    except for the glitch just described. It ignores microphone level
>    setup, though. Loopback control works. Using the buttons, you can
>    only reach Speaker Level 12 (80%) - using the mixer you can go to
>    100%.

I added it to the list.

thanks for all the contribs!

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
