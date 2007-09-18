Return-Path: <Johan.Hedberg@nokia.com>
Date: Tue, 18 Sep 2007 11:15:57 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Fabien Chevalier <fchevalier@silicom.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Fix bogus avdtp error codes management
Message-ID: <20070918081557.GA13401@localhost>
References: <46EEBC41.80401@silicom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46EEBC41.80401@silicom.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Fabien,

On Mon, Sep 17, 2007, Fabien Chevalier wrote:
> While trying to fix this cross case issue, i came with an issue with the 
> way error codes are handled
> in avdtp.c.
> The issue is basically that the part of the code that retrieves the 
> exact error value is never executed
> due to premature return.

Looks fine to me if it works. However, I'd like to hear some comment
from Marcel as well. At least my connect(2) manpage implies that a
non-blocking connect should always produce a POLLOUT on connection
completion regardless if the result was failure or success. So it seems
bluez may be behaving differently than other socket types in this
respect.

We had a similar issue with the EAGAIN/EINPROGRESS mixup with
non-blocking connect's so maybe this issue should also be fixed on the
kernel side (however a userspace work-around such as your patch is
probably also desirable).

Johan
