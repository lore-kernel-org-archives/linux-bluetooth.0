Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426CFA6A.6080701@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multi slot packets
References: <20050424181253.52478.qmail@web88108.mail.re2.yahoo.com>
In-Reply-To: <20050424181253.52478.qmail@web88108.mail.re2.yahoo.com>
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
Date: Mon, 25 Apr 2005 15:10:50 +0100

Krishna Bhoutika wrote:
> Can we have a 5-slot packet in direction of master-to-slave followed by
> a 5-slot packet in slave-to-master direction.

Yes.

All combinations (1+1, 1+3, 1+5, 3+1, 3+3, 3+5, 5+1, 5+3 and 5+5) are
possible provided there are enough free slots on the baseband.

An example of when there wouldn't be enough free slots is when there's
an HV3 link up. An HV3 link takes 2 slots every 6 slots. This leaves
just 4 slots for other traffic on the same piconet. This restricts you
to 1+1, 1+3 and 3+1. The two devices may attempt to negotation which one
of them gets to use 3 slot packets, but such negotiations tend to be
quite dumb.

> Or, It is always 6 slots both directions combined. i.e. 5-slot packet in
> direction of master-to-slave followed by a 1-slot packet in slave-to-master
> direction

I don't know what gave you that impression.

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
