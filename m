Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Fri, 9 May 2003 16:40:33 -0700
Message-ID: <000801c31684$627d9f80$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052520660.10456.220.camel@localhost.localdomain>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> I was going to just drop the frame and log an error. The=20
> thing is, if the packet header is corrupted (i.e. wrong=20
> length, etc) we can't really trust its content. I mean if=20
> length is wrong how do we know that CID is right. It means=20
> that we don't really know which channel should be closed=20
> (i.e. which app should be notified).

Here's Cetecom's response to your comment:

"Good point ! I agree, in a messed up remote L2CAP stack, CID could be wron=
g
as well if length is wrong. But I think it is a good approach to check
first, if that CID exists and if yes, notify the app about that channel."

So how about we do this:  As above, if it exists then we close it. If not,
we log an error.

-Daryl.
