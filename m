Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Higher throughput with larger UDP packet size 
In-Reply-To: Message from Sean Loh <blaze_wk@yahoo.com>
   of "Mon, 14 Feb 2005 03:47:07 PST." <20050214114707.9429.qmail@web41104.mail.yahoo.com>
References: <20050214114707.9429.qmail@web41104.mail.yahoo.com> 
Message-ID: <14994.1108382316@csr.com>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 14 Feb 2005 11:58:36 +0000

Sean Loh wrote:
> I have established an IP network over the BlueZ stack
> and have transmitted UDP packets at varying sizes. I
> then  assessed the throughput using the different
> datagram packets sizes. Why is it that the larger UDP
> packets obtain higher throughputs than the smaller UDP
> packets (eg. 60,000 bytes vs 5000 bytes)? Shouldn't
> the smaller UDP packets obtain an overall higher
> througput since less time is spent for segmentation
> and reassembly?

CPU time is not an important factor; the big difference is the time
to send packets over the air.  The shorter packets have extra headers
to encapsulate them at the lower levels, which makes all the difference.

At the Bluetooth baseband level, by the way, 5000 bytes already counts
as "large" and will have to be fragmented into quite a lot of packets
transmitted over the air.  However, I certainly don't recommend using
smaller packets at the UDP level for the reason I've given.

pws


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
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
