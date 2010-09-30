Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 10:39:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Pull request:
 git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
Message-ID: <20100930073938.GA6964@jh-x301>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
 <20100929134521.GA19362@jh-x301>
 <AANLkTimvvp=D+X+TcP3Ji7WuGaMZF7+LA+8BWZiQCStr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimvvp=D+X+TcP3Ji7WuGaMZF7+LA+8BWZiQCStr@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Sep 29, 2010, Claudio Takahasi wrote:
> StartDiscovery() triggers all the process. The adapter type: BR/EDR
> only/LE only or dual mode is hidden from the higher layers.
> So, your suggestion it try to hide all discovery details inside the
> hciops as much as possible?

That was the idea yes, but I'm not 100% sure that it's the best
approach. Another question is also how do we want to represent this with
the new management interface. Should the kernel do it "all" through a
single request from userspace or should userspace control the separate
BR/EDR and LE discoveries. If it's the former, then having a single
adapter_ops callback makes sense. If it's the later then we should
probably have two separate ones. Either way I now realize that to
implement this with a single callback we'd need to have the HCI event
processing moved over to hciops and that's not something that will
happen very quickly. So maybe it's better to have these as two separate
adapter_ops callbacks for now.

Johan
