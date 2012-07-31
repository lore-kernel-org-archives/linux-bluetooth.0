Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jul 2012 19:33:14 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Charles Gordon <digigordo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: l2ping Recv failed: Connection reset by peer
Message-ID: <20120731223314.GA19846@samus>
References: <CAGjArBcwtaRoecSivEaN9FiCbGfC3JhFRwXUVqq58SmQhN07sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGjArBcwtaRoecSivEaN9FiCbGfC3JhFRwXUVqq58SmQhN07sQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

On 17:12 Tue 31 Jul, Charles Gordon wrote:
> Hi,
> 
> I'm porting bluez 4.98 to an embedded system.  I have it up and running, but
> I notice that when I run l2ping, I get the message "Recv failed: Connection
> reset by peer" after l2ping runs for 5 seconds.  This is very consistent.
> It doesn't matter whether I ping once a second, or do a flood ping.  After 5
> seconds the l2ping program closes with the message saying the connection was
> reset by the peer.

If I run l2ping without parameters, I get this:

l2ping - L2CAP ping
Usage:
	l2ping [-i device] [-s size] [-c count] [-t timeout] [-d delay] [-f] [-r] [-v] <bdaddr>
	-f  Flood ping (delay = 0)
	-r  Reverse ping
	-v  Verify request and response payload

The '-t' option sounds promising.

But anyway, the default value for the timeout is 10 seconds. So I would like know
how would it behave with other values. Perhaps the remote side is disconnecting.

[snip]


Cheers,
-- 
Vinicius
