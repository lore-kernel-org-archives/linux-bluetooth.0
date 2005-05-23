Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Calculating throughput of ACL link
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050523122116.68112.qmail@web8303.mail.in.yahoo.com>
References: <20050523122116.68112.qmail@web8303.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1116852749.30044.81.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 23 May 2005 14:52:29 +0200

Hi Mayank,

> > > How can I calculate the throughput that we are
> > getting
> > > on the ACL link during streaming of Advanced
> > Audio?
> > 
> > there exists no application that actually does this
> > on the ACL level.
> > You need to write one that greps all ACL traffic
> > (like hcidump) and then
> > do the calculation.
> 
> That is exactly what I was trying to find out.
> In the avdtp.c file in the bluez-hcidump package, we
> can find out what are the packets being sent on ACL,
> but I can't figure out how to calculate the
> throughput.

do you wanna know the throughput on ACL or AVDTP. For both look at the
throughput calculation of l2test or rctest.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
