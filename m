Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20031009103605.05a94590@unixmail.qualcomm.com>
Date: Thu, 09 Oct 2003 10:45:32 -0700
To: Marcel Holtmann <marcel@holtmann.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Bluetooth update for 2.4.23-pre2
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1065716040.14513.52.camel@pegasus>
References: <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
 <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
 <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
 <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:13 AM 10/9/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >I want to keep the the third parameter to be save in future if we need
>> >to send other notifications down to the HCI driver for which we can use
>> >it eventually. Bluetooth 1.2 and 2.0 will come with new stuff that may
>> >need it.
>> Unlikely. In any case we can add it later of needed.
>> 
>> >For the CONN_ADD and CONN_DEL I think we should also send the "conn"
>> >down to the driver so it can read from it if needed.
>> But the only thing useful for the driver is the connection type. We might as 
>> well just pass that instead of a pointer to the whole struct. Anyway core should
>> count connections not the driver.
>> 
>> >If not, it has to go by itself through the hash and I don't see any way that the 
>> >driver can find out the current added connection. Am I wrong?
>> conn_hash has 'num' field which is total number of connections. So we just need to
>> keep two separate counters for ACL and SCO.
>> I'll try to find some time this week to implement that.
>
>I see the notify() interface and the seperate counting of ACL and SCO as
>two different problems and I don't wanna mix them.
>However I think it is nice to send the "conn" down to the driver, if you
>thing it is two much, I drop it.
Well, both are needed only for SCO over USB.
So in some sense they are related :).

btw How about fixing it in 2.6 and leaving 2.4 alone ?
I don't think we will ever have decent Voice support in 2.4 anyway.
For example ALSA driver will definitely go into 2.6 not 2.4.

>> What I'm saying is that we should fix the write way not just some hack that 
>> fixes first negotiation. It will pass certification with Ceticomm (or whatever 
>> the name of that company) but will fail if tester code does proper checking ie second 
>> connection, etc.
>> It should be a trivial fix. I take a look at it tonight.
>
>I looked at your fix and it looks fine to me. Can you please rebuild my
>marcel-2.4 tree on the base of your current work? I will re-push my
>other patches so we can sync up with Marcelo until the end of this week.
>I want to finish this as soon as possible, because I am away for the
>complete next week.
Ok. I'll do that. Not sure about today though. Don't worry about sync up 
with Marcelo. I'll merge both trees and send a patch.

Max
