Return-Path: <cyrus@holtmann.org>
Subject: Re: GSoC 2009: L2CAP Enhanced Retransmission mode
From: Marcel Holtmann <marcel@holtmann.org>
To: ngh@isomerica.net
Cc: linux-bluetooth@vger.kernel.org,
	Barry Reinhold <bbr@lampreynetworks.com>
In-Reply-To: <1240929768.3441.5866.camel@localhost.localdomain>
References: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
	 <1240929768.3441.5866.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Apr 2009 08:40:36 -0700
Message-Id: <1240933237.997.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

> > I'm a accepted student for GSoC 2009 to work with BlueZ. I'm a
> > Computer Engineer student at University of Campinas (Brazil).
> > 
> > In my project I'm going to implement the L2CAP Enhanced Retransmission
> > mode. That mode will permit retransmission of corrupted or lost
> > packets improving bluetooth experience on Linux. My mentors are Luiz
> > Augusto “Vudentz” von Dentz and Marcel Holtmann.
> > 
> > That's my hack for the next four months, and if you wanna see what I'm
> > doing look at my git repo[1] and/or read my blog[2]. Also I'll send
> > reports of my work to this list approximately twice a month.
> > 
> > Finally, I wanna thanks all the BlueZ devs for accept me on GSoC, I'm
> > very glad to work with BlueZ. And I wanna congratulate the other
> > students accepted on BlueZ. =)
> > 
> 
> 	As part of my employers work in medical devices, I've been working on
> implementing enhanced L2CAP mode in the kernel.  Since learning of
> Gustavo's acceptance into Google's SOC (congratulations!), I've been
> cleared to open up the work which I have thus far.

that is good news. Thanks for helping out here.

> 	Because our initial target is interoperability against a specific set
> of medical devices from outside vendors, my work thus far has been
> targeted against these devices.  Enhanced L2CAP is fairly complex, and
> has multiple parts to it.  To get the first round of compatibility
> going, I've taken such paths as limiting the local TX window to 1
> outstanding SDU.
> 	Currently, the code is at a state where it successfully negotiates
> between enhanced/streaming/basic modes, opens a connection, and begins
> sending data.  Much of the work I've done thus far has been splitting
> out the send/receive paths for the separate modes.  There have been no
> significant changes in and code path, and no need to make any major
> changes to the existing data structures.  Major points left to implement
> include:
> 
>   *  Support for a TX windows > 1
>      On both send and receive, the code limits itself to only one
> outstanding l2cap SDU at a time.  I have added a send and receive queue
> of skbuffs to a socket to support this, however this is unimplemented,
> and quite possibly duplicates code elsewhere in the kernel.

in the end the ERTM mode should behave like SOCK_STREAM (like what
RFCOMM does at the moment). The Basic mode will stay as SOCK_SEQPACKET
and this way we require one mode or the other.

For testing purpose of course just setting the value in the existing
SOCK_SEQPACKET should be enough. And also that SOCK_SEQPACKET could run
with ETRM without any downside is an option anyway.

>   *  Add logic for the retransmission and monitor timers.
>      Again, there are stubs in place for these timers, however the code
> is unimplemented.  My next step will be basic retransmission support for
> lost packets.

Trying to get lost packets over Bluetooth is kinda hard. So you need
some faulty code for testing this. In theory the HCI layer is reliable.

>   *  Optimize the FCS computation.

The Linux kernel already has the proper FCS implementation that you can
use. It should be CONFIG_CRC_CCITT if I remember correctly.

This needs fixing first since it just plain useless to not use the
kernel supported FCS functions.

>   *  Improve the L2CAP state machine
>      Currently, the state machine described in section 8.6.5 of the
> L2CAP specification is mostly unimplemented.

This is still done on purpose since it doesn't map nicely to the socket
API, but we could improve things here.

> 	Currently, the code is branched off bluetooth-testing from last week.
> The tree is available via:
> 
>      git clone git://staticfree.info/git/el2cap
> 
> I'd like to thank my friend Steve from the MIT Mobile Experience Lab for
> graciously hosting the code.  My latest work is in the "retransmission"
> branch.  Due to the increase in code size, I've split the files up into
> an l2cap sub-directory under net/bluetooth.  I've not yet cloned
> Gustavo's repository, but I should be able to rebase the code off that
> as necessary.
> 	If there are any comments on style or implementation, I'd be happy to
> address them in the code.  Hopefully, this can be used as base for
> Gustavo's SOC work so we can focus upon complete implementation of the
> Enhanced L2CAP specification and interoperability with other devices.

The split into l2cap.c and queue.c and move to a separate directory
looks totally useless to me. I know that l2cap.c is big, but there is no
real separation. You would have to convince why this makes sense.

So we can start adding the initial constant changes quickly to
bluetooth-testing.git since they are easy to review. However they need
cleanup in a few areas since (for example changing the version doesn't
belong here etc.).

Final changes to the feature mask can only be done once the feature
actually works, but we can constify it already. And your unknown feature
is the fixed channel support (from Bluetooth 3.0 specification).

The main development and upstream acceptance will happen in
bluetooth-testing.git repository. Patches in that repository with a
proper detailed commit message can be considered upstream. However I do
insist on them not breaking current behavior and that they are
bisect-able.

Regards

Marcel


