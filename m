Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Sep 2010 21:11:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: jaikumar Ganesh <jaikumarg@gmail.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [RFC] D-Bus API for out of band association model
Message-ID: <20100916181100.GA25619@jh-x301>
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <20100915081047.GA15065@jh-x301>
 <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com>
 <AANLkTikryj2AeaCWpVKQhkMznfAF-d15QpJF6=BgyGsY@mail.gmail.com>
 <20100915185340.GA2804@jh-x301>
 <4C9212E4.4090204@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C9212E4.4090204@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

It would be nice if you could use some empty lines in your replies. It
was quite hard to distinguish the quoted text from your own.

On Thu, Sep 16, 2010, Andrzej Kaczmarek wrote:
> In case of NFC I guess data will be coming from some application or
> perhaps a daemon which can understand data coming from lower layers,
> which I guess will rather process raw data. So these data will come
> from the same level as bluetoothd resides or above.

Agreed. It might also come from below if the plugin talks to some kernel
driver handling the OOB communication.

> This is something that agent can communicate freely with. Also from
> our point of view OOB data is used in the same way as i.e. passkey and
> this is what agent provides. We don't care how it will receive such
> data.

The same goes for the plugin approach. If we wanted to care about the
actual OOB mechanism the would be no need to abstract this and make it
pluggable.

> Also Jakiumar gave quite good example where NFC application receives
> some data which is identified as BT OOB data so it initiates pairing
> with device specific agent which will provide these data.

Agreed. I do see now that a D-Bus based approach might make more sense
in the end. On the other hand, we could still abstract this inside the
daemon for plugins, and then there'd simply be a special (default)
plugin that'd expose this over D-Bus.

> Do I understand correctly that also plugin or daemon should manage
> received data? Won't it make bluetoothd store unnecessary data, i.e.
> for devices we won't use anyway?

This would be completely implementation specific. It could be within the
daemon or delegated to some external component. The only certain thing
would be an interface for the core daemon to get the OOB data when it
gets an IO capability request.

> Also what in case we want to use several different secure channels?
> Multiple plugins?

Yes, that would be possible.

> In case of agent, we make single call and no need to worry where the
> data come from. Agent is platform dependent anyway so platform vendor
> can put required logic there.

Right, but at the same time it would also require you to multiplex all
potential available OOB methods through a single agent. So in that sense
the agent approach is more restrictive (with plugins we could at least
allow multiple of them).

One thing I'm quite concerned about is that I wouldn't want to add an
extra rountrip to an external process for every single IO capability
request that we get. This extra work should only be done if we know that
there's a non-zero probability for the existence of OOB data.

We could either have the agent tell bluetoothd about the OOB capability
somehow, or we could define some new sort of external "OOB data
provider" D-Bus object. The benefit of using a new object separate from
the agent is that we could allow multiple of them whereas there can only
be one agent right now. And only if there'd be one or more of these new
types of objects registered would bluetoothd make the extra roundtrip
when it gets an IO capability request.

Johan
