Return-Path: <cyrus@holtmann.org>
Message-ID: <4C9212E4.4090204@tieto.com>
Date: Thu, 16 Sep 2010 14:51:48 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: jaikumar Ganesh <jaikumarg@gmail.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [RFC] D-Bus API for out of band association model
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com> <20100915081047.GA15065@jh-x301> <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com> <AANLkTikryj2AeaCWpVKQhkMznfAF-d15QpJF6=BgyGsY@mail.gmail.com> <20100915185340.GA2804@jh-x301>
In-Reply-To: <20100915185340.GA2804@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi,

On 15.09.2010 20:53, Johan Hedberg wrote:
> I'm still not convinced that the Agent is the right place for this. The
> agent is typically representing the UI whereas in most cases (like NFC)
> the OOB data will be coming from below bluetoothd in the software stack
> and not from above it (which is where the agent resides).
In case of NFC I guess data will be coming from some application or 
perhaps a daemon which can understand data coming from lower layers, 
which I guess will rather process raw data. So these data will come from 
the same level as bluetoothd resides or above. This is something that 
agent can communicate freely with. Also from our point of view OOB data 
is used in the same way as i.e. passkey and this is what agent provides. 
We don't care how it will receive such data.
> Also, the
> presence of OOB data isn't really agent specific. It's something that
> can come and go during the lifetime of an agent
That's not a problem, agent should make use of interfaces published by 
applications which can provide secure channel. NFC application is one of 
examples.
Also Jakiumar gave quite good example where NFC application receives 
some data which is identified as BT OOB data so it initiates pairing 
with device specific agent which will provide these data.
> My idea has been to add a a plugin interface through which a hardware
> specific plugin could notify the core daemon about the existence of OOB
> data. bluetoothd would then take care of setting the right flag when it
> gets a IO capability request.
Do I understand correctly that also plugin or daemon should manage 
received data? Won't it make bluetoothd store unnecessary data, i.e. for 
devices we won't use anyway?
Also what in case we want to use several different secure channels? 
Multiple plugins? In case of agent, we make single call and no need to 
worry where the data come from. Agent is platform dependent anyway so 
platform vendor can put required logic there.
> This doesn't of course rule out the
> possibility of having part of the work done in another process since the
> plugin could simply export a service over D-Bus or talk to another D-Bus
> service.
I agree, such plugin can communicate with some other daemon/application 
to get data. So do agent. And in case of agent we're consistent that all 
bonding related data (pin, passkey, OOB...) are handled in one place 
which is an agent application.

BR,
Andrzej
