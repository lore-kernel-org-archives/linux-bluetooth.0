Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Sep 2010 21:53:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [RFC] D-Bus API for out of band association model
Message-ID: <20100915185340.GA2804@jh-x301>
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <20100915081047.GA15065@jh-x301>
 <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com>
 <AANLkTikryj2AeaCWpVKQhkMznfAF-d15QpJF6=BgyGsY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikryj2AeaCWpVKQhkMznfAF-d15QpJF6=BgyGsY@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Wed, Sep 15, 2010, jaikumar Ganesh wrote:
> We started to work on this API too last week. Not complete yet to post
> to the mailing list.
> The approach we took was this:
> 
>  a) Since OOB authentication is just another means of authentication
> compared to Passkey, Pin entry,
>       we added an agent API (similar to the lines of other
> authentication mechanisms) that will ask for the Out Of Band data.
> b) We added an API to the adapter to get the local Out of Band Data
> c) Currently, RegisterAgent is called to register with the
> capabilities. Since OOB is part of the capabilities data structure, we
> added OOB to agent structure which already has the capabilities.
> d) We added an API variant of createPairedDevice which will be used
> for OutOfBand Pairing. When the device agent is created, the OOB field
>     in agent is updated.
> e) When a capability request comes from the remote side the agent OOB
> field is checked. It will be set if the pairing is initiated locally
> through d).
>     For incoming pairing requests if the Agent has OOB field set but
> there is no device specific agent, we need to make an Agent API call
> asking if
>     there is OOB data for this remote device.
> 
> We left it to the users of the API - regarding the OOB channel to use.
> It can be NFC or any other trusted channel.
> 
> Comments ?

I'm still not convinced that the Agent is the right place for this. The
agent is typically representing the UI whereas in most cases (like NFC)
the OOB data will be coming from below bluetoothd in the software stack
and not from above it (which is where the agent resides). Also, the
presence of OOB data isn't really agent specific. It's something that
can come and go during the lifetime of an agent.

My idea has been to add a a plugin interface through which a hardware
specific plugin could notify the core daemon about the existence of OOB
data. bluetoothd would then take care of setting the right flag when it
gets a IO capability request. This doesn't of course rule out the
possibility of having part of the work done in another process since the
plugin could simply export a service over D-Bus or talk to another D-Bus
service.

Johan
