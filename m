Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Maintain Bluetooth Connections
In-Reply-To: <6EF58BF68042DF4AA46A54994117D64F0253E787@mercury.mtctech.com>
Message-ID: <Pine.LNX.4.33.0502101902060.20345-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 10 Feb 2005 19:15:44 +0100 (CET)


Hi Richard,

just some crude thoughts about this:

What happens if one of the remote devices wants to send some data to the
PDA ?? Or can you make sure that this will not happen ?? If it can happen
you need some sort of wakeup on your host. If the host can wake up on
serial line activity this is fine, but as far as I remember this is not
possible with an X-scale.

If you are sure that the above will not cause you problems you could put
all active connections into park mode, which will allow the BT chip to
save a lot of power. However, you have to remember the state of each
active connection to unpark it once your host wakes up. Because you have
to remeber te connections states a bluetooth stop / start is not an
option. You have to add (I don't know if there already is something, but
from Marcels answer I think it is not) power management at least to the
HCI layer which parks the slaves if you enter low power state and unparks them
when you come back.

Good luck !!!

Peter

On Thu, 10 Feb 2005, Williams, Richard wrote:

> Greetings Marcel,
>
> I have a small, wearable computer, battery powered, of course. The
> X-scale processor is connected to the BT radio through a serial port and
> is the master in a small network of BT devices. All this works very
> well. This is running Linux 2.6 with the latest patches.
>
> During idle periods, to save power, I want to suspend the main
> microprocessor. The BT radio is powered from a separate circuit. For
> now, before I suspend the micro, I close all the connections, and
> perform a "bluetooth stop". When the micro wakes up, the micro does a
> "bluetooth start" and then reestablishes the connections to the
> peripheral devices. This does work, but it takes some time. I would like
> to have the BT network recover as quickly as possible.
>
> Is it possible to instruct the BT radio to autonomously maintain the
> established connections, even though the microprocessor has been
> suspended ?  So that when the main processor wakes up, the BT network is
> still there. I don't know how much of the connection "keep alive"
> function is performed by the Bluez stack.
>
> Thank you, as usual for all your help.
>
> Best Regards,
>
> Rich
>
> ----------------------------
> Richard B. Williams
> Vitronics, Inc.
> An MTC Technologies Company
> 3 Corbett Way
> Eatontown, NJ 07724-2262
> 732-389-0244 x29
> Richard.Williams@mtctechnologies.com
>
>
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
