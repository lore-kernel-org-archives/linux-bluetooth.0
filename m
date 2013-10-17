Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 18:14:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] l2test: Set CID due to socket restrictions for LE
Message-ID: <20131017151446.GA3935@x220.p-661hnu-f1>
References: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org>
 <20131016203518.GA947@x220.p-661hnu-f1>
 <CAKT1EBcunESoPak7NhMmW6-r2n3QH8CyJgtg=9W3fXx6sjNmcg@mail.gmail.com>
 <20131017140019.GA361@x220.p-661hnu-f1>
 <4DF07F65-8B30-42CA-809B-1F30440556BA@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DF07F65-8B30-42CA-809B-1F30440556BA@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 17, 2013, Marcel Holtmann wrote:
> >> At some point we need to infer the adapter address type instead of
> >> always use public address.
> > 
> > To be honest, selecting whether to use a random address when scanning or
> > advertising doesn't at least immediately strike me as something that
> > should be done through the bind call, but instead something that should
> > be a global setting for the entire adapter. Having the exact LE address
> > type in connect() makes sense, but not necessarily for bind().
> 
> It does make sense to have this. Userspace knows what it is doing.
> Right now it is pretty simple. Either you have a public address, then
> that is used. If you do not have a public, then you need to configure
> a static address first, and then that will be used. So you know the
> address type that is in use.

I didn't mean that user space wouldn't know what it's doing. It'll be
able to program a static address or enable privacy if necessary. What
I'm saying is that this is an adapter-global setting which individual
sockets may not be aware of (especially if the sockets reside in
different processes).

Nevertheless, sockets should obviously be able to say at a minimum "LE"
or "BR/EDR" and that's clearly something that was overlooked and left
buggy in user space.

> When adding support for privacy feature then this becomes a bit more
> complicated, but at all times, the userspace will know how it
> configured the kernel. Either use public address or use random
> address.

*If* we were to make this user space interface based on the socket
information (as opposed to e.g. mgmt commands/settings) there are
several things that need to be thought of:

Server sockets:

- bind() tells the kernel which address to use for advertising - no
  problems so far
- What if there are two server sockets, one binding to public and the
  other to random address. Which one do we advertise with?
- Do we "hide" the random address socket if the ACL was created by
  advertising with our public address?

Client sockets:

- connect() tells the kernel which address to use for scanning - no
  problems (again) so far
- If there are two client sockets trying to connect to the same device
  but with different local addresses. We could "ride" on the ACL
  creation attempt of the first one, but what about the address
  conflict?
- If there is an already existing ACL that was created by scanning with
  our public address and a client socket tries to connect by binding to
  our random address. Do we fail?

So these things need at least some thinking and clearly specifying if we
go the path of letting the local LE socket address type affect scanning
and advertising behavior.

Johan
