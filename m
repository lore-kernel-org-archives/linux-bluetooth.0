Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Catalin Drula <catalin@cs.toronto.edu>
To: steven.singer@csr.com
Cc: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0502101727190.7559@qew.cs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 10 Feb 2005 17:42:25 -0500 (EST)

Stever Singer wrote:
> Catalin Drula wrote:
> > Is there a way to perform INQUIRY for intervals with
> > a lower granularity than 1.28 seconds? I know the Bluetooth
> > specification says no.

> To inquire for less than 10.24 seconds is a bad idea. Unless you
> inquire for a single contiguous block lasting 10.24 seconds you do not
> have a good probability of picking up all devices.
>
> Note that, for example, 8 consecutive 1.28 second inquiries is not
> guaranteed to work.

Not necessarily a bad idea. In my case, I need to do symmetric Bluetooth
discovery. There are no predefined roles (master-slave, server-client) for
the devices which must continually scan their surroundings in order to
discover other devices. Hence, each device must continously switch between
the INQUIRY and INQUIRY SCAN states. Since in my setup, the devices will
be in range for 20-30 seconds (i.e. humans walking past each other), to
remain for 10.24 seconds in INQUIRY mode might just me too much. Imagine
that the "phases" of the devices are almost synchronized, then they will
both be in INQUIRY mode at the same time, then in INQUIRY SCAN mode at the
same time, and so on, and none of them will discover the other one.

The problem has been studied both theoretically and experimentally (for
example, see:
http://web.informatik.uni-bonn.de/IV/Mitarbeiter/scholz/10_Bohman.pdf

The conclusion of the authors of this study was that each a device should
stay in each of the two states for a random amount of time with a mean
around 2 to 3 seconds (more details, are in the above paper). Doing this
yields and average neighbor discovery delay of about 8 seconds.

Now obviously if we can only stay in INQUIRY state mode, for multiples of
1.28 seconds, the above scenario will not work. So there are _legitimate_
uses (i.e. it is not necessarily a bad idea) for my request.

For your information, I did some experiments with the above algorithm and
four Bluetooth devices. Without having precise figures, I can tell you,
that two of the devices were discovered about 50% of the time during the
first time in INQUIRY state (3-4 seconds) and about 80% time the first or
second time (8-9 seconds). The third device which is the builtin Bluetooth
card in an iPaq h5550, was discovered far less often (30 seconds). I don't
know why but I am guessing this has to do with the hardware
implementation. An USB dongle (I forget the manufacturer) was the most
"discoverable" device.

But, to put a conclusion to this, I agree with you that this has to be
done at the HCI level, and that is what my implementation does.

Catalin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
