Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20031009104846.0591fb08@unixmail.qualcomm.com>
Date: Thu, 09 Oct 2003 10:58:11 -0700
To: Stephen Crane <steve.crane@rococosoft.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RFComm channel allocation
Cc: bluez-devel@lists.sourceforge.net, marcel@rvs.uni-bielefeld.de
In-Reply-To: <1065696705.30376.257.camel@baroque.rococosoft.com>
References: <5.1.0.14.2.20031008174223.058f41d8@unixmail.qualcomm.com>
 <5.1.0.14.2.20031008174223.058f41d8@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:51 AM 10/9/2003, Stephen Crane wrote:
>On Thu, 2003-10-09 at 01:52, Max Krasnyansky wrote:
>> >On a related matter (and I'm pretty sure this /has/ come up before),
>> >would it be possible to perform automatic channel allocation in the
>> >kernel? 0 would be a good distinguishing value for this (since it is
>> >reserved to the RFComm multiplexer).
>> It's possible but does not seem to be needed. I mean so far nobody had
>> a strong argument why we need to support it.
>
>It seems to me that we're moving towards a more service-oriented view
>where Bluetooth services are discovered by UUID rather than assuming
>they live at a fixed port/channel number. 
>
>If this is the case, servers shouldn't have to care what port/channel is
>used, they just bind to any and use getsockname() to find out the actual
>one allocated by the kernel, for subsequent advertisement by SDP. (Also
>this is possible for AF_INET sockets, so it wouldn't violate the
>principle of least surprise.)

Well the thing is PSM 0 and Channel 0 are already used for bind() on the 
client side. It means "I do not need a port". Unlike IP clients Bluetooth 
clients do not need unique port.

Max
