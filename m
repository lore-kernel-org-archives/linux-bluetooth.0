Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030218130327.0d1a9f48@mail1.qualcomm.com>
References: <5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<200302081740.48000.karypid@inf.uth.gr>
	<200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
	<5.1.0.14.2.20030218130327.0d1a9f48@mail1.qualcomm.com>
Content-Type: text/plain
Message-Id: <1045609378.30001.88.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 19 Feb 2003 00:00:58 +0100

Hi Max,

> >I think about something like a special way to bind psm 0 and all
> >incoming connections which are not associated with a bounded psm go to
> >this application. So you can listen on all PSM with only one call.
> >
> >I want use this for one of my projects, but I can also work around this
> >problem. So my question is if this makes sense to you and how much
> >modifications in the L2CAP core may be needed ?
> Modifications would be simple. But that feature doesn't make sense to me.

I will try to explain for what it will be good. I want to do something
which can be described like "L2CAP Forwarding Proxy over Ethernet". So
the only special PSM is the one for SDP, all others (mainly over 0x1000)
would be used dynamicly and forwarded to other devices over another
medium like ethernet. For this I only want to have two listen calls, one
for all not bound PSM's and one for SDP.

How much we have to change for something like this?

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
