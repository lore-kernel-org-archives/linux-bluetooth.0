Return-Path: <james.cameron@hp.com>
Date: Tue, 29 Jun 2004 20:55:08 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040629105508.GC2133@hp.com>
References: <20040628095541.GB8871@hp.com> <1088417629.3774.177.camel@pegasus> <20040628101927.GC8871@hp.com> <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com> <1088427271.3774.198.camel@pegasus> <20040628224803.GA20139@hp.com> <1088465177.6030.221.camel@pegasus> <20040629052317.GQ20139@hp.com> <1088499480.6030.239.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088499480.6030.239.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Jun 29, 2004 at 10:58:01AM +0200, Marcel Holtmann wrote:
> I like to have only one and clear way to achieve a goal. And this is the
> Linux hotplug mechanism from my view. However dev-up is in pand and
> there was a bug, so I applied your patch.

It's not in CVS yet.  An update of main.c takes me to revision 1.5,
which was the "olen = sizeof(l2o);" addition.

> But be aware of that I might remove it in a new major release, now I
> know of it ;)

Oh dear.  I'll keep watch then, and fork if I have to.  ;-)

-- 
James Cameron
