Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <420CC94E.70003@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <Pine.GSO.4.58.0502101727190.7559@qew.cs>
In-Reply-To: <Pine.GSO.4.58.0502101727190.7559@qew.cs>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] Re: Lower granularity for INQUIRY interval
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
Date: Fri, 11 Feb 2005 15:03:42 +0000

Catalin Drula wrote:
> Stever Singer wrote:
>> Catalin Drula wrote:
>>> Is there a way to perform INQUIRY for intervals with
>>> a lower granularity than 1.28 seconds? I know the Bluetooth
>>> specification says no.
> 
>> To inquire for less than 10.24 seconds is a bad idea. Unless you
>> inquire for a single contiguous block lasting 10.24 seconds you do not
>> have a good probability of picking up all devices.
>>
>> Note that, for example, 8 consecutive 1.28 second inquiries is not
>> guaranteed to work.
> 
> Not necessarily a bad idea. In my case, I need to do symmetric Bluetooth
> discovery. There are no predefined roles (master-slave, server-client) for
> the devices which must continually scan their surroundings in order to
> discover other devices. Hence, each device must continously switch between
> the INQUIRY and INQUIRY SCAN states. Since in my setup, the devices will
> be in range for 20-30 seconds (i.e. humans walking past each other), to
> remain for 10.24 seconds in INQUIRY mode might just me too much. Imagine
> that the "phases" of the devices are almost synchronized, then they will
> both be in INQUIRY mode at the same time, then in INQUIRY SCAN mode at the
> same time, and so on, and none of them will discover the other one.
> 
> The problem has been studied both theoretically and experimentally (for
> example, see:
> http://web.informatik.uni-bonn.de/IV/Mitarbeiter/scholz/10_Bohman.pdf

This analysis is predicated on the assumption that the device can be in
one of two phases - inquiry or inquiry scan - and that in each phase it
should spend all of its time performing either the inquiry or the
inquiry scan.

Although it is true that in each individual slot, the radio can be in
only one of these two modes, it's not necessarily true that the device
can be in just one of these two modes.

Over HCI it's possible to command a device both to be in inquiry scan
and in inquiry. How a device resolves this conflict is implementation
dependent.

For example, older CSR firmware (15 and earlier) simply gave priority to
inquiry. So, for the duration of the inquiry, all inquiry scans were
suppressed. The reasoning behind this was that inquiry was an
intermittent event but it would benefit from having all the bandwidth.

However, for 16 firmware we changed that behaviour. We got reports from
customers that devices going undiscoverable whilst performing their own
inquiries was undesirable. The customers would much prefer a slightly
reduced probability of the inquiry finding other devices if they could
get a much improved probability that other devices would find this one.

So, from 16 onwards we time slice between inquiry and inquiry scan. In
the event that the inquiry scans are short (like the default 18 slots),
this means that the scans will beat the inquiry. The scans will knock
small holes in the inquiry but the inquiry will continue around it and,
more importantly, will change trains.

This change allows the device to remain continuously in inquiry scan
even during inquiry and so violates some of the assumptions in the paper
by Bohman et al.

> For your information, I did some experiments with the above algorithm and
> four Bluetooth devices. Without having precise figures, I can tell you,
> that two of the devices were discovered about 50% of the time during the
> first time in INQUIRY state (3-4 seconds) and about 80% time the first or
> second time (8-9 seconds). The third device which is the builtin Bluetooth
> card in an iPaq h5550, was discovered far less often (30 seconds). I don't
> know why but I am guessing this has to do with the hardware
> implementation. An USB dongle (I forget the manufacturer) was the most
> "discoverable" device.

Were you explicitly exiting inquiry scan before doing the inquiries or
were you just assuming the inquiries would stop the scans? If the
latter, what inquiry scan parameters were you using? I suspect you're
seeing variations between implementations.

I suggest you grab some CSR devices with 16.4 firmware or later (other
manufacturer's devices may work too, but I can't comment) and try some
experiments where you put each device in a normal inquiry scan (with
an interval of 1.28 or 2.56 seconds and an window of 18 slots) and get
the devices to perform back-to-back inquiries (or some variation
thereof such as 10.24 second inquiry, 5-10 second backoff). See what
results you get.

Knowing that device will continue to inquiry scan whilst inquiring
means that using the HCI periodic inquiry command is now a possibility.

For better results, get some 1.2 devices (firmware version 18 or later
for CSR devices) and select interlaced inquiry scan with a 1.28 or 2.56
second interval and an 18 slot window. Then just command 10.24 second
inquiries and see what you get. The results should be noticeably better.
(In fact, if you know the scanner is in interlaced inquiry scan then
you might be able to get away with 5.12 second inquiries).

If you really have only 20 or 30 seconds for devices to find each other
then you really want interlaced inquiry scan and the 1.2 changes to the
FHS timing. Together these really reduce the time it takes for devices
to find each other.

To avoid two devices having the same inquiry scan timing, it might be
worth randomising the interval slightly (say, somwhere between 1.00
and 1.28 seconds, or between 2.00 and 2.56) and changing the interval
every 10 seconds or so.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
