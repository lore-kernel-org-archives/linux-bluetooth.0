Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EC522B3.5080607@bmw-carit.de>
References: <4EC522B3.5080607@bmw-carit.de>
Date: Thu, 17 Nov 2011 19:17:15 +0200
Message-ID: <CABBYNZLj44y5i2a+KVxYnz5LnyPUH0+0hpPCMLdv+6sP-pkiyg@mail.gmail.com>
Subject: Re: D-Bus API of obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 17, 2011 at 5:05 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> Hi all,
>
> After some tests with the obex-client, I would like to ask some questions
> related to the D-Bus API:
>
> 1. Transfers for OBEX-specific mime types: in obc_transfer_register, these
> types are filtered out so no transfer is registered for them. Is this a
> matter of overhead only? I mean, for considerable transfers such as full
> phonebook downloads, it would still make sense to provide a transfer. First,
> you could track the progress, and second, you could cancel it. Am I missing
> any other reason not to want this registration?

Originally the transfer where meant only for big files, but it seems
we gonna be using it for MAP so I would thing that it could be made
useful for any object transfer. But note that we should change some
APIs so that they return the object transfer for tracking.

> 2. External monitoring of the active transfers: currently the agent owning a
> session is the only component that is able to know about the ongoing
> transfers. However it could be interesting to signal these transfers
> publicly, so other "external" components can have knowledge of them.
> Typically a GUI could be showing the progress of a download (even though
> another component initiated it) but it could also be that certain components
> would like to react accordingly (example, cancel a download if A2DP starts).

Emitting progress is a bit tricky, it can load the system a bit too
much so I would say doing direct method call is better, in fact we
should have 2 processes monitoring the transfer, the application who
requested it and the agent, just pick one of those to track the
progress. IIRC for meego harmattan this is done in the agent, which
imo is a good idea because it has to be running everytime.

> In addition, this kind of API would be more consistent with the ones in
> BlueZ or oFono, meaning that any interested component can keep track (and
> modify) the state.

You mean you want methods to list current transfers and signals, but
the agent should already know about them, and probably we don't want
other process to interfere with transfer they don't own so we decided
to keep it simple.

-- 
Luiz Augusto von Dentz
