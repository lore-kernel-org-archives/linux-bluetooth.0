Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Mon, 12 May 2003 16:37:14 -0700
Message-ID: <000901c318df$6b11ad00$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052584255.1133.13.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> Daryl, so it is now up to you to do your tests with Cetecom 
> again and see what we pass and what we fail. The RFCOMM layer 
> should now perform perfect, but the L2CAP config stuff will 
> still fail. You can use 2.4.18-mh4 and apply these 5 patches 
> from the bt-2.4 repository to it:

Great work guys! Thanks!

I'll hold off on more testing until we've figured out a solution for the
L2CAP config stuff. More than likely something else will come out the
woodwork too, but probably not much. A number of tests had to be postponed
due to the previous failures.

Re: l2cap config stuff:

We don't need any more logs or anything for that do we?  I think we're just
trying to understand what it is exactly that we're supposed to do and why.

Max - You mentioned that the spec says that what the stack does with a
config reject can be implementation specific. I just had a look at the spec
and couldn't find it. Could you tell me where to look in the spec?  Is the
following quote from section 5.5 Configure Response what you were referring
to?

"The decision on the amount of time (or messages) spent arbitrating the
channel parameters before terminating the negotiation is left to the
implementation."

-Daryl.
