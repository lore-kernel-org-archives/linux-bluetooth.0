Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <420D00FE.1000008@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Lower granularity for INQUIRY interval
References: <20050211174824.GA5840@bougret.hpl.hp.com>
In-Reply-To: <20050211174824.GA5840@bougret.hpl.hp.com>
Content-Type: text/plain; charset="us-ascii"
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
Date: Fri, 11 Feb 2005 19:01:18 +0000

Jean Tourrilhes wrote:
> Steven Singer <steven.singer <at> csr.com> wrote :
>> Note that, for example, 8 consecutive 1.28 second inquiries is not
>> guaranteed to work.
> 
> 	Actually, if you look in the actual Inquiry response protocol,
> you can see that it is guaranteed to not work at all, because of the
> random backoff (10.7.4) you will never get any answer in 1.28 sec.

The random backoff is for 0 to 1023 slots - 0 to 0.64 seconds. The
device may start scanning straight after the backoff. The spec says that
the device must wait for at least the backoff, but doesn't state that it
must wait until the next time it was scheduled to scan. In fact, the
spec implies that the point of the random backoff is so that if two
devices both hear the same inquiry transmission, they should respond at
different times. Since most devices have the same inquiry scan interval,
waiting for the next interval would be counter-productive as it would
guarantee that the two devices would respond simultaneously. In
addition, the inquiry scan interval doesn't have to be 1.28 seconds.
In a scenario where you are trying to get fast connections, you could
well imagine that devices will be using a shorter inquiry scan interval.

Even then, your argument applies only to the first 1.28 second inquiry.
After that any device that was hit during the first 1.28 seconds should
be primed to answer in the second 1.28 second burst (note that I said
that the 1.28 second bursts should be consecutive).

For 1.2 devices this problem doesn't exist because 1.2 device respond
before they back off. This means that every device on the right train
(or in interlaced inquiry scan) should respond at least once (neglecting
boundary conditions and collisions).

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
