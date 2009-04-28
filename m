Return-Path: <cyrus@holtmann.org>
Subject: Re: GSoC 2009: L2CAP Enhanced Retransmission mode
From: Nathan Holstein <ngh@isomerica.net>
Reply-To: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Barry Reinhold <bbr@lampreynetworks.com>
In-Reply-To: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
References: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Apr 2009 10:42:48 -0400
Message-Id: <1240929768.3441.5866.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-04-25 at 20:05 -0300, Gustavo F. Padovan wrote:
> Hi all,
> 
> I'm a accepted student for GSoC 2009 to work with BlueZ. I'm a
> Computer Engineer student at University of Campinas (Brazil).
> 
> In my project I'm going to implement the L2CAP Enhanced Retransmission
> mode. That mode will permit retransmission of corrupted or lost
> packets improving bluetooth experience on Linux. My mentors are Luiz
> Augusto “Vudentz” von Dentz and Marcel Holtmann.
> 
> That's my hack for the next four months, and if you wanna see what I'm
> doing look at my git repo[1] and/or read my blog[2]. Also I'll send
> reports of my work to this list approximately twice a month.
> 
> Finally, I wanna thanks all the BlueZ devs for accept me on GSoC, I'm
> very glad to work with BlueZ. And I wanna congratulate the other
> students accepted on BlueZ. =)
> 
> Regards.
> 
> 
> [1] http://www.las.ic.unicamp.br/~gustavo/git/
> [2] http://padovan.org/


	As part of my employers work in medical devices, I've been working on
implementing enhanced L2CAP mode in the kernel.  Since learning of
Gustavo's acceptance into Google's SOC (congratulations!), I've been
cleared to open up the work which I have thus far.
	Because our initial target is interoperability against a specific set
of medical devices from outside vendors, my work thus far has been
targeted against these devices.  Enhanced L2CAP is fairly complex, and
has multiple parts to it.  To get the first round of compatibility
going, I've taken such paths as limiting the local TX window to 1
outstanding SDU.
	Currently, the code is at a state where it successfully negotiates
between enhanced/streaming/basic modes, opens a connection, and begins
sending data.  Much of the work I've done thus far has been splitting
out the send/receive paths for the separate modes.  There have been no
significant changes in and code path, and no need to make any major
changes to the existing data structures.  Major points left to implement
include:

  *  Support for a TX windows > 1
     On both send and receive, the code limits itself to only one
outstanding l2cap SDU at a time.  I have added a send and receive queue
of skbuffs to a socket to support this, however this is unimplemented,
and quite possibly duplicates code elsewhere in the kernel.

  *  Add logic for the retransmission and monitor timers.
     Again, there are stubs in place for these timers, however the code
is unimplemented.  My next step will be basic retransmission support for
lost packets.

  *  Optimize the FCS computation.

  *  Improve the L2CAP state machine
     Currently, the state machine described in section 8.6.5 of the
L2CAP specification is mostly unimplemented.

	Currently, the code is branched off bluetooth-testing from last week.
The tree is available via:

     git clone git://staticfree.info/git/el2cap

I'd like to thank my friend Steve from the MIT Mobile Experience Lab for
graciously hosting the code.  My latest work is in the "retransmission"
branch.  Due to the increase in code size, I've split the files up into
an l2cap sub-directory under net/bluetooth.  I've not yet cloned
Gustavo's repository, but I should be able to rebase the code off that
as necessary.
	If there are any comments on style or implementation, I'd be happy to
address them in the code.  Hopefully, this can be used as base for
Gustavo's SOC work so we can focus upon complete implementation of the
Enhanced L2CAP specification and interoperability with other devices.



   --Nathan Holstein
     Lamprey Networks Inc.
     www.lampreynetworks.com

