Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABOZqni1nLFJfq5Psj8L795sNfUPc5XgD0ofRXjTCe5XnRrzhg@mail.gmail.com>
References: <CABOZqni1nLFJfq5Psj8L795sNfUPc5XgD0ofRXjTCe5XnRrzhg@mail.gmail.com>
Date: Wed, 14 Oct 2015 15:38:41 +0300
Message-ID: <CABBYNZ+6k9YRsix61ubFOJaDjVezF6g7-gtraaFX79vmaaRXHg@mail.gmail.com>
Subject: Re: Multiple client connections?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Spruiell <mes@zeroc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Wed, Oct 14, 2015 at 2:45 AM, Mark Spruiell <mes@zeroc.com> wrote:
> We'd like to be able to establish multiple simultaneous client
> connections to the same service, both from a single process and from
> multiple processes. (Essentially, we'd like to create bluetooth socket
> connections just like we can for regular TCP socket connections, for
> example.)
>
> My client does the following:
>
> * Gets a private connection to the system bus
> * Calls GetManagedObjects to locate the device corresponding to the
> target address
> * Calls RegisterProfile with a unique object path and the target UUID
> * Calls ConnectProfile on the target device with the target UUID
> * Receives a NewConnection call with the file descriptor
> * Uses the file descriptor like a regular socket
> * When finished, calls DisconnectProfile, waits for it to complete,
> and closes the socket
>
> This works correctly. However, when I try to start another instance of
> the client process and connect to the same service, this second
> connection attempt fails. The first connection remains active and
> continues to work. This second client would have registered its own
> client profile with a unique object path and the same target UUID.
>
> Is it possible for a single host to establish multiple connections to
> the same service?

First this can only work in case of L2CAP, RFCOMM you can only connect
once per channel, but it means the remote need to be able to accept
multiple connections using the same PSM and each of it will be mapped
to different scid/dcid pair per socket, but we currently don't allow
multiple connections to the same profile since that would probably
need more states and perhaps call NewConnection multiple times.

Also if you do register a second instance of the same UUID it will
probably have to use a different channel/psm, that perhaps is easier
to setup given you can use RFCOMM but the remote will need to be able
to distinguished between 2 different instances of the SDP record.

Either way there is still the problem of how many connections should
we attempt with ConnectProfile in this case, with just one psm right
now it is impossible to tell how many connection should it create, and
with multiple instances I think it currently only connect to the first
one, and even if we decide to connect to all of them we will have to
decide how we would be doing it since they could be connected in
parallel or just one after the other.


-- 
Luiz Augusto von Dentz
