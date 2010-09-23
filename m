Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinAd=8HhDWBwgikS36zni6arb8WP9iXAZpqJ0Lk@mail.gmail.com>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
	<AANLkTinAd=8HhDWBwgikS36zni6arb8WP9iXAZpqJ0Lk@mail.gmail.com>
Date: Thu, 23 Sep 2010 15:07:32 -0300
Message-ID: <AANLkTinTFfoFEufM4sc_To=sSpzkZ+xmgYMuTnQpcf44@mail.gmail.com>
Subject: Re: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 23, 2010 at 2:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Claudio,
>
> On Thu, Sep 23, 2010 at 7:19 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Implements interleave discovery for dual mode adapters(LE and BR/EDR).
>> Now, the behavior is:
>> 1) for single mode: LE scanning for 5.12 seconds every DiscoverSchedulerInterval
>> 2) for BR/EDR only: still the same
>> 3) for dual mode: inquiry(5.12) sec, LE scanning(5.12) sec, resolve
>> names. The next discovery interval is controlled by
>> DiscoverSchedulerInterval.
>
> Is that enough time to discover devices around? I remember tweaking
> the interval so that it doesn't cause too much noise/too many new
> devices found or disappearing in each round, so at least to BR/EDR
> 5.12 sec. sounds too little time, also does LE needs name resolving
> too?
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

Hi Luiz,

5.12sec is based on the SPEC recommendation(core page 1746), we can
change it to 10.24s or add a config option.
For LE, there is a characteristic called "Device Name" UUID 0x2A00,
this piece is missing.

Regards,
Claudio
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
