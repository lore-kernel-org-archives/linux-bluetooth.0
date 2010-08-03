Return-Path: <cyrus@holtmann.org>
Message-ID: <4C58129E.3080306@csr.com>
Date: Tue, 03 Aug 2010 13:59:10 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: tmonahan@codeaurora.org, Inga Stotland <ingas@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
        johan.hedberg@gmail.com
Subject: Re: Enhancements to allow l2cap channel to use either AMP or BR/EDR
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org> <1280775200.12579.30.camel@localhost.localdomain>
In-Reply-To: <1280775200.12579.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> 
> That said, nothing stops us from allowing to make our AMP polices
> dynamic and allow the application to change it threshold during
> lifetime. For example it starts out as BR/EDR only and then during the
> usage of the link it decides that now AMP preferred would make sense. In
> that sense you would have manual switching to some level.

If the policy is dynamic throughout the lifetime of the connection then
that's okay for best effort links.

I think applications (especially those that stream real-time data at
high rates) will need to know the currently available bandwidth.  This
will be useful for even simple file transfer profiles -- if that file
transfer is going to take 100x as long the user probably want to know
about this so they can (for example) turn HS mode on the other device.

This information could be conveyed in some sort of "channel move
complete" event or a more generic "available bandwidth changed" event.

Applications requiring guaranteed links will need some way of supplying
extended flow specifications.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
