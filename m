Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] RFComm channel allocation
From: Stephen Crane <steve.crane@rococosoft.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net, marcel@rvs.uni-bielefeld.de
In-Reply-To: <5.1.0.14.2.20031008174223.058f41d8@unixmail.qualcomm.com>
References: <5.1.0.14.2.20031008174223.058f41d8@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1065696705.30376.257.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 09 Oct 2003 11:51:45 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2003-10-09 at 01:52, Max Krasnyansky wrote:
> >On a related matter (and I'm pretty sure this /has/ come up before),
> >would it be possible to perform automatic channel allocation in the
> >kernel? 0 would be a good distinguishing value for this (since it is
> >reserved to the RFComm multiplexer).
> It's possible but does not seem to be needed. I mean so far nobody had
> a strong argument why we need to support it.

It seems to me that we're moving towards a more service-oriented view
where Bluetooth services are discovered by UUID rather than assuming
they live at a fixed port/channel number. 

If this is the case, servers shouldn't have to care what port/channel is
used, they just bind to any and use getsockname() to find out the actual
one allocated by the kernel, for subsequent advertisement by SDP. (Also
this is possible for AF_INET sockets, so it wouldn't violate the
principle of least surprise.)

Steve 
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
