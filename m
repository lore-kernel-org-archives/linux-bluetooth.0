Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
Date: Tue, 11 Feb 2003 10:06:16 -0800
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, bluez-devel@lists.sourceforge.net
In-Reply-To: <1044964883.19214.46.camel@linux>
References: <5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<200302081740.48000.karypid@inf.uth.gr>
	<200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 01:01 PM 2/11/2003 +0100, Marcel Holtmann wrote:
>Hi,
>
>> Now if people really want dynamic PSMs. We could introduce something like
>> bind(psm == 0xffff).
>
>I think this is not a good idea, because 0xffff is a valid PSM according
>to the spec.
And 10 is illegal ;-) (l2test uses 10)

>But what about bind it with PSM 0 and the listen call assign a dynamic
>PSM if it is bind with PSM 0 ?
Nop. That'd be wrong. Application has to obtain and register dynamic PSM
with SDP. Normally you have to do that after bind(). Because as soon as 
you call listen() l2cap will start accepting incoming connections and put 
them into sk accept queue. So connection may be accepted while app is doing 
SDP registration. It will sit in accept queue and probably timeout right 
when app call accept().  

>What about a l2cap daemon like inetd ?
What about it ?

Max
