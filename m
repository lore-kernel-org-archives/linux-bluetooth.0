Return-Path: <james.cameron@hp.com>
Date: Wed, 30 Jun 2004 10:15:35 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040630001535.GH15948@hp.com>
References: <20040628101927.GC8871@hp.com> <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com> <1088427271.3774.198.camel@pegasus> <20040628224803.GA20139@hp.com> <1088465177.6030.221.camel@pegasus> <20040629052317.GQ20139@hp.com> <1088499480.6030.239.camel@pegasus> <20040629105508.GC2133@hp.com> <1088508403.6030.265.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088508403.6030.265.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Jun 29, 2004 at 01:26:43PM +0200, Marcel Holtmann wrote:
> the anonymous CVS is not updated in real time. It is a Sourceforge
> problem and the only thing you can do is wait :(

Ah, okay, I see your commit now, on 1.6 08:53:29 UTC.  SourceForge had
told me they were updating anonymous CVS in real-time, and I thought I
had observed it on my projects (pptpclient, poptop).  Maybe they haven't
finished enabling it.

I cross checked your patch and it looks fine.  When's the next release?
;-)

> Or come up with a solution that makes the peer address available through
> hotplug and net.agent.

Is the peer ba kept in bnep0 structure somewhere?  Isn't bnep0
effectively a point to point link?  ppp0 for example, shows the peer IP
address yet bnep0 doesn't.

Yes, I can get the ba from "pand -l|grep bnep0", or broadcast pinging
the bnep0 subnet and using "arp" to read the ba.

-- 
James Cameron
