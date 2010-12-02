Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Dec 2010 16:58:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH 1/3] Initial attribute permission implementation
Message-ID: <20101202145855.GA31448@jh-x301>
References: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
 <1291219986-29913-2-git-send-email-anderson.lizardo@openbossa.org>
 <20101202101031.GB18808@jh-x301>
 <AANLkTinbiQyXTKKPc+jfpEtfuJAFCZphzR6Dcwm3Qaj+@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinbiQyXTKKPc+jfpEtfuJAFCZphzR6Dcwm3Qaj+@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Dec 02, 2010, Anderson Lizardo wrote:
> > Why not make sure that they are all orthogonal from the start
> > instead of assigning the same value for authentication and
> > writability like you do now. I.e. instead you could have:
> >
> > none            0
> > read            1
> > write           2
> > authentication  4
> > authorization   8
> 
> This was the first attempt (as it seemed obvious). But see vol 3, part
> F, section 4:
> 
> "For example, an attribute value may be allowed to be read by any device, but
> only written by an authenticated device. An implementation should take this
> into account, and not assume that just because it can read an attribute’s value,
> it will also be able to write the value. [...]"
> 
> This makes it clear that the authentication/authorization permissions
> are not orthogonal. Further on it is confirmed by the attribute
> permissions of "Client Characteristic Configuration" (vol 3, part G,
> 3.3.3.4):
> 
> * Readable with no authentication or authorization.
> * Writable with authentication and authorization defined by a higher
> layer specification or is implementation specific.
> 
> The scheme implemented in this patch set is just a compacted version
> of unix permissions using a 2-bit grouping (not sure if it will look
> nice to read):
> 
> 5 4 3 2 1 0  bit
> | | | | | \_ Read
> | | | | \___ Write
> | | | \_____ Authenticated read
> | | \_______ Authenticated write
> | \_________ Authorized read
> \___________ Authorized write

Ok, now I understand what you were trying to accomplish. If you had put
all this into the commit message or as a code comment we'd have avoided
some confusion ;)

> With an addition that, if the authenticated/authorized read/write bits
> are set, the "none" read/write bits are set as well (I think the
> reason is obvious).

Wouldn't it be the other way around, i.e. if the "none" bits are set
(i.e.  no special authentication or authentication requirements) then
for higher security (authenticated or authorized) reads and writes would
also succeed.

Anyway, if the requirement checks are really supposed to be so flexible
and up to the profile implementation you will still have some gaps with
your scheme. It's not e.g. possible to say "allow write only if *both*
authenticated *and* authorized". So, for ultimate flexibility, I don't
think there's any other choice then have a profile specific callback
function that makes the decision. The callback would at least get the
attempted operation (read/write) as well as the current level of
security (authorized/authenticated) as parameters. Any thoughts on this?

Johan
