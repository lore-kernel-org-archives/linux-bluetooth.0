Return-Path: <cyrus@holtmann.org>
Subject: Re: GSoC 2009: L2CAP Enhanced Retransmission mode
From: Marcel Holtmann <marcel@holtmann.org>
To: ngh@isomerica.net
Cc: linux-bluetooth@vger.kernel.org,
	Barry Reinhold <bbr@lampreynetworks.com>
In-Reply-To: <1240936070.3441.5901.camel@localhost.localdomain>
References: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
	 <1240929768.3441.5866.camel@localhost.localdomain>
	 <1240933237.997.37.camel@localhost.localdomain>
	 <1240936070.3441.5901.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Apr 2009 09:49:23 -0700
Message-Id: <1240937363.997.47.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

> > > 	Because our initial target is interoperability against a specific set
> > > of medical devices from outside vendors, my work thus far has been
> > > targeted against these devices.  Enhanced L2CAP is fairly complex, and
> > > has multiple parts to it.  To get the first round of compatibility
> > > going, I've taken such paths as limiting the local TX window to 1
> > > outstanding SDU.
> > > 	Currently, the code is at a state where it successfully negotiates
> > > between enhanced/streaming/basic modes, opens a connection, and begins
> > > sending data.  Much of the work I've done thus far has been splitting
> > > out the send/receive paths for the separate modes.  There have been no
> > > significant changes in and code path, and no need to make any major
> > > changes to the existing data structures.  Major points left to implement
> > > include:
> > > 
> > >   *  Support for a TX windows > 1
> > >      On both send and receive, the code limits itself to only one
> > > outstanding l2cap SDU at a time.  I have added a send and receive queue
> > > of skbuffs to a socket to support this, however this is unimplemented,
> > > and quite possibly duplicates code elsewhere in the kernel.
> > 
> > in the end the ERTM mode should behave like SOCK_STREAM (like what
> > RFCOMM does at the moment). The Basic mode will stay as SOCK_SEQPACKET
> > and this way we require one mode or the other.
> > 
> > For testing purpose of course just setting the value in the existing
> > SOCK_SEQPACKET should be enough. And also that SOCK_SEQPACKET could run
> > with ETRM without any downside is an option anyway.
> 
> Some of the devices I test against force Basic mode for SDP and ERTM for
> HDP.  In my testing while using the kernel negotiation procedure, both
> sdptool and our HDP implementation work transparently, using Basic and
> ERTM modes respectively.

that is fine. So our SDP client/server uses SOCK_SEQPACKET and then for
HDP you just use SOCK_STREAM. Sounds totally sane to me.

The default mode for SOCK_SEQPACKET should be basic mode and for
SOCK_STREAM is is ERTM. Additionally you can use setsockopt() with
L2CAP_OPTIONS to change the mode requirement.

> My vision was to add an ioctl() to allow an application to specify that
> it requires a specific mode.  This was due to my understanding of the
> recvmsg() man page:
> 
>        The  msg_flags  field  in the msghdr is set on return of
>        recvmsg().  It can contain several flags:
> 
>        MSG_EOR
>               indicates end-of-record; the data returned completed a
>               record (generally used with sockets of type
>               SOCK_SEQPACKET).
> 
> The MCAP/HDP profiles require this metadata to function properly.  Can
> we tack MSG_EOR onto a SOCK_STREAM socket?  If so, this would be simpler
> than requiring an ioctl.

As I said, the mode setting part is already there. And using an ioctl()
for these is wrong. You use setsockopt() for these kind of things.

And I think you can add an MSG_EOR on a stream socket. Not sure that it
really is needed. Sounds to me like a messed up detail in the MCAP
specification that would work anyway without extra flags. Have to read
the spec. at some point.

> > > 	Currently, the code is branched off bluetooth-testing from last week.
> > > The tree is available via:
> > > 
> > >      git clone git://staticfree.info/git/el2cap
> > > 
> > > I'd like to thank my friend Steve from the MIT Mobile Experience Lab for
> > > graciously hosting the code.  My latest work is in the "retransmission"
> > > branch.  Due to the increase in code size, I've split the files up into
> > > an l2cap sub-directory under net/bluetooth.  I've not yet cloned
> > > Gustavo's repository, but I should be able to rebase the code off that
> > > as necessary.
> > > 	If there are any comments on style or implementation, I'd be happy to
> > > address them in the code.  Hopefully, this can be used as base for
> > > Gustavo's SOC work so we can focus upon complete implementation of the
> > > Enhanced L2CAP specification and interoperability with other devices.
> > 
> > The split into l2cap.c and queue.c and move to a separate directory
> > looks totally useless to me. I know that l2cap.c is big, but there is no
> > real separation. You would have to convince why this makes sense.
> 
> Just trying to keep things manageable.  Currently, I'm not using any of
> the code in queue.c anyway, so I'm tempted to just drop it.

Just drop it for now. We can change the layout later if it is really
needed. Currently it is just confusing.

Regards

Marcel


