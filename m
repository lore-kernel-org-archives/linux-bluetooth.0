Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
Date: Thu, 23 Sep 2010 20:55:36 +0300
Message-ID: <AANLkTinAd=8HhDWBwgikS36zni6arb8WP9iXAZpqJ0Lk@mail.gmail.com>
Subject: Re: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Sep 23, 2010 at 7:19 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Implements interleave discovery for dual mode adapters(LE and BR/EDR).
> Now, the behavior is:
> 1) for single mode: LE scanning for 5.12 seconds every DiscoverSchedulerInterval
> 2) for BR/EDR only: still the same
> 3) for dual mode: inquiry(5.12) sec, LE scanning(5.12) sec, resolve
> names. The next discovery interval is controlled by
> DiscoverSchedulerInterval.

Is that enough time to discover devices around? I remember tweaking
the interval so that it doesn't cause too much noise/too many new
devices found or disappearing in each round, so at least to BR/EDR
5.12 sec. sounds too little time, also does LE needs name resolving
too?

-- 
Luiz Augusto von Dentz
Computer Engineer
