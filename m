Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Message-ID: <20050211174824.GA5840@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@hpl.hp.com>
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
Date: Fri, 11 Feb 2005 09:48:24 -0800

Steven Singer <steven.singer <at> csr.com> wrote :
> 
> Catalin Drula wrote:
> > Is there a way to perform INQUIRY for intervals with
> > a lower granularity than 1.28 seconds? I know the Bluetooth
> > specification says no.
> 
> To inquire for less than 10.24 seconds is a bad idea. Unless you
> inquire for a single contiguous block lasting 10.24 seconds you do not
> have a good probability of picking up all devices.
> 
> Note that, for example, 8 consecutive 1.28 second inquiries is not
> guaranteed to work.

	Actually, if you look in the actual Inquiry response protocol,
you can see that it is guaranteed to not work at all, because of the
random backoff (10.7.4) you will never get any answer in 1.28 sec.
	I wish the Inquiry protocol was not designed this way, because
designed more straightforwardly, doing periodic inquiry for a shorter
time and more frequently *could* have the same probability of
discovery (over time, not per Inquiry), the same overhead, but
guarantee much shorter connection latency.
	By the way, the whole Inquiry process is why you can't use
BlueTooth for any kind of location beacon or casual discovery.
	More info on my experiment on the topic in my "On-Demand
BlueTooth" paper.
	http://www.hpl.hp.com/personal/Jean_Tourrilhes/Papers/papers.html

	Have fun...

	Jean


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
