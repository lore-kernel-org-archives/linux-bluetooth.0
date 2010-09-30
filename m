Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100930073938.GA6964@jh-x301>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
	<20100929134521.GA19362@jh-x301>
	<AANLkTimvvp=D+X+TcP3Ji7WuGaMZF7+LA+8BWZiQCStr@mail.gmail.com>
	<20100930073938.GA6964@jh-x301>
Date: Thu, 30 Sep 2010 11:28:26 -0300
Message-ID: <AANLkTikADcqHYfOjmRQVEDdPuU9mrGVvAVGNUdRTsQcd@mail.gmail.com>
Subject: Re: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 30, 2010 at 4:39 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Sep 29, 2010, Claudio Takahasi wrote:
>> StartDiscovery() triggers all the process. The adapter type: BR/EDR
>> only/LE only or dual mode is hidden from the higher layers.
>> So, your suggestion it try to hide all discovery details inside the
>> hciops as much as possible?
>
> That was the idea yes, but I'm not 100% sure that it's the best
> approach. Another question is also how do we want to represent this with
> the new management interface. Should the kernel do it "all" through a
> single request from userspace or should userspace control the separate
> BR/EDR and LE discoveries. If it's the former, then having a single
> adapter_ops callback makes sense. If it's the later then we should
> probably have two separate ones. Either way I now realize that to
> implement this with a single callback we'd need to have the HCI event
> processing moved over to hciops and that's not something that will
> happen very quickly. So maybe it's better to have these as two separate
> adapter_ops callbacks for now.
>
> Johan
>

Another point is: scanning needs to be disabled "actively", it is not
possible to inform a scanning length like inquiry, it is necessary to
create a timeout to disable the scanning. Joining inquiry and scanning
inside a single adapter_ops callback will be hard to control the
discovery procedure "states". So for now, I prefer two separate
callbacks due the scanning timeout and HCI events processing.

However, for the new management interface, one single request seems to
be more appropriate but extra requests will be necessary to setup the
scan and inquiry parameters.

Claudio
