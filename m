Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH BlueZ] l2test: Set CID due to socket restrictions for LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131017151446.GA3935@x220.p-661hnu-f1>
Date: Thu, 17 Oct 2013 17:30:48 +0200
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <813EDA2E-9C63-44D1-B520-5BB20EC0D4A8@holtmann.org>
References: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org> <20131016203518.GA947@x220.p-661hnu-f1> <CAKT1EBcunESoPak7NhMmW6-r2n3QH8CyJgtg=9W3fXx6sjNmcg@mail.gmail.com> <20131017140019.GA361@x220.p-661hnu-f1> <4DF07F65-8B30-42CA-809B-1F30440556BA@holtmann.org> <20131017151446.GA3935@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> At some point we need to infer the adapter address type instead of
>>>> always use public address.
>>> 
>>> To be honest, selecting whether to use a random address when scanning or
>>> advertising doesn't at least immediately strike me as something that
>>> should be done through the bind call, but instead something that should
>>> be a global setting for the entire adapter. Having the exact LE address
>>> type in connect() makes sense, but not necessarily for bind().
>> 
>> It does make sense to have this. Userspace knows what it is doing.
>> Right now it is pretty simple. Either you have a public address, then
>> that is used. If you do not have a public, then you need to configure
>> a static address first, and then that will be used. So you know the
>> address type that is in use.
> 
> I didn't mean that user space wouldn't know what it's doing. It'll be
> able to program a static address or enable privacy if necessary. What
> I'm saying is that this is an adapter-global setting which individual
> sockets may not be aware of (especially if the sockets reside in
> different processes).
> 
> Nevertheless, sockets should obviously be able to say at a minimum "LE"
> or "BR/EDR" and that's clearly something that was overlooked and left
> buggy in user space.

I think that we need to have a listen ATT socket for each controller. So if controller hci0 uses a public address, then we bind it to the public address and LE_PUBLIC. If controller hci1 has no public address, then we program the static address and bind it to that address and LE_RANDOM.

If you bind it to BDADDR_ANY and bdaddr_type == BDADDR_ANY we have to use the hack to make old userspace work. And we really only should treat BDADDR_BDEDR as magic "auto" value for CID 0x0004 when BDADDR_ANY. Otherwise we reject things.

>> When adding support for privacy feature then this becomes a bit more
>> complicated, but at all times, the userspace will know how it
>> configured the kernel. Either use public address or use random
>> address.
> 
> *If* we were to make this user space interface based on the socket
> information (as opposed to e.g. mgmt commands/settings) there are
> several things that need to be thought of:
> 
> Server sockets:
> 
> - bind() tells the kernel which address to use for advertising - no
>  problems so far
> - What if there are two server sockets, one binding to public and the
>  other to random address. Which one do we advertise with?
> - Do we "hide" the random address socket if the ACL was created by
>  advertising with our public address?

We can just fail if we bind to LE_PUBLIC, but we are actually using LE_RANDOM. Same way the other way around. Only one of them is possible.

> Client sockets:
> 
> - connect() tells the kernel which address to use for scanning - no
>  problems (again) so far

Yes it is. It defeats the privacy purpose and you might have different background scanning. I thought about this already. When a controller gets powered on at the point we already made the decision to either use LE_PUBLIC or LE_RANDOM. So binding it to anything else should.

We might need to be nice and just fail on connect() and not on bind(). That is something we can discuss.

> - If there are two client sockets trying to connect to the same device
>  but with different local addresses. We could "ride" on the ACL
>  creation attempt of the first one, but what about the address
>  conflict?
> - If there is an already existing ACL that was created by scanning with
>  our public address and a client socket tries to connect by binding to
>  our random address. Do we fail?
> 
> So these things need at least some thinking and clearly specifying if we
> go the path of letting the local LE socket address type affect scanning
> and advertising behavior.

Not planning on doing. The address type to use is decided when power on.

Regards

Marcel

