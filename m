Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
Date: Fri, 18 Jul 2003 12:19:32 -0700
Message-ID: <002501c34d61$84afdc30$5796fea9@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1058555551.31052.261.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> > Do you mean you tried the aclsession script and didn't see the same 
> > send 5 frames, wait 20 sec, send 5 more etc problem?
> 
> the aclsession scripts produces this effect, but it also left 
> the ACL link in some kind of buggy state. It must be some 
> really stupid that I always overlook. The code looks correct 
> to me and my Bluetooth 1.0b devices are working fine.

Ok...  I guess we can leave it for now then. If it becomes a more serious
issue I'll let you know.

> > > Did the other patch helped?
> > 
> > We haven't tested it yet...  I was hoping for a resolution to the 
> > above problem before I sent updates for evaluation.
> 
> It would be nice to know if the patch is enough for 
> qualification, because I don't plan to integrate a session 
> wide flow control.

I'll get things ready for more testing. Will probably be able to give it a
go next week sometime.

-Daryl.
