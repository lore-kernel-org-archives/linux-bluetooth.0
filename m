Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030218130327.0d1a9f48@mail1.qualcomm.com>
Date: Tue, 18 Feb 2003 13:06:50 -0800
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, bluez-devel@lists.sourceforge.net
In-Reply-To: <1045491133.23498.63.camel@linux>
References: <5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<200302081740.48000.karypid@inf.uth.gr>
	<200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 06:12 AM 2/17/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >What about a l2cap daemon like inetd ?
>> What about it ?
>
>I think about something like a special way to bind psm 0 and all
>incoming connections which are not associated with a bounded psm go to
>this application. So you can listen on all PSM with only one call.
>
>I want use this for one of my projects, but I can also work around this
>problem. So my question is if this makes sense to you and how much
>modifications in the L2CAP core may be needed ?
Modifications would be simple. But that feature doesn't make sense to me.

Max
