Return-Path: <james.cameron@hp.com>
Date: Tue, 29 Jun 2004 15:23:17 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040629052317.GQ20139@hp.com>
References: <20040628085356.GA8871@hp.com> <1088413518.3774.167.camel@pegasus> <20040628095541.GB8871@hp.com> <1088417629.3774.177.camel@pegasus> <20040628101927.GC8871@hp.com> <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com> <1088427271.3774.198.camel@pegasus> <20040628224803.GA20139@hp.com> <1088465177.6030.221.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088465177.6030.221.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Jun 29, 2004 at 01:26:17AM +0200, Marcel Holtmann wrote:
> from my view it is better to use "net.agent" and "pand -l" for this job.

Yes, I know.  I don't know why you think that though, since using dev-up
costs less in dependencies and execution time.  You've proposed removing
dev-up on the grounds that I had problems with it, and that you've never
used it; which suggests that you think that cost of maintenance is more
critical.  I'm just guessing.

> If it gets to complex then you should integrate it directly into pand.

dev-up is integrated directly into pand.  ;-)

-- 
James Cameron
