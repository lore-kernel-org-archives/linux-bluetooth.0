Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL7x4GpgC+JRU=owGmOfs5JdVRHaiCXOe_5oC+oY9BbNg@mail.gmail.com>
References: <CAASrBQ=8icxs8ZyW56CXObZH7DFuPf0XDGz=uQPXB1SsQsuimw@mail.gmail.com>
	<CABBYNZL7x4GpgC+JRU=owGmOfs5JdVRHaiCXOe_5oC+oY9BbNg@mail.gmail.com>
Date: Thu, 23 Jul 2015 12:57:47 -0600
Message-ID: <CAASrBQmkn3L1MhJbJ9NCGUQz1QJ1YAt6WSnBp-gT7Cn3Ti1YWA@mail.gmail.com>
Subject: Re: bluetoothctl list-attributes command
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 23, 2015 at 2:11 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

>> [DfuTarg]# list-attributes
>> (hangs forever)
>
> Does it hangs or just doesn't print anything?
>

Doesn't print anything.  The prompt is still "live".

>
> I suspect something else is going on, perhaps bluetoothd could not
> find any attributes or maybe it is connected over classic?

It is the nRF51822 firmware update example, so I'm sure it's not
connected over classic.

-- 
Regards,
Mark
markrages@gmail
