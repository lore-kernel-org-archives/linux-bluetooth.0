Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xirf3TOwgbZAyVG6oU1W-cWoxLMhojjqBg38Di4Z19bQ@mail.gmail.com>
References: <CAOnmHE9V9iJjbtTLvfS+pFYCaZGmSj4Z6ZK28-ER0K=CZH4TLQ@mail.gmail.com>
 <CAD0=r8xirf3TOwgbZAyVG6oU1W-cWoxLMhojjqBg38Di4Z19bQ@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Fri, 31 Jul 2015 15:06:49 +0900
Message-ID: <CAOnmHE-pXQyzeLCwbWrrEdFOQ7A6pSGAh86kFHyrccG9mDF4DA@mail.gmail.com>
Subject: Re: Enabling continuous LE Active scan in 5.32?
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>> Checking adapter.c, adapter->no_scan_restart_delay parameter looks
>> promising if set to true. Still same result - next scan delay ~ 2 sec.
>> Not sure if such delay is intentional or platform performance related
>> My question is :- Is there a neat way to trigger continuous active LE
>> scan even though it may sound power-wise inefficient. Tried to grep
>> archives but couldn't find much help.
> So there is something like that, but you'll probably have to update
> your kernel (I think this feature is all in 4.0, or 4.1)
> Recently kernel patch landed that enables simultaneous discovery, but
> that works only for some controllers, you'll have to check wether your
> controller have this quirk set: HCI_QUIRK_SIMULTANEOUS_DISCOVERY
> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/include/net/bluetooth/hci.h#n164
> What this does is: previously there was 5s le scan, then 5s classic
> scan, then 5s break, now it's simulteanous le and br/edr scan.

Thanks for the insight. But I am more interested in reducing the 5s
break aka IDLE_DISCOV_TIMEOUT to zero.
It is when I reduce this to zero or set adapter->no_scan_restart_delay
parameter to True that I still find few
seconds delay to restart scan. I have taken care of interleaved stuff
by setting my device  to "le" only in main.conf.
So all my scans are "le only" for 10 seconds.  Do you think it is
entire possible to make scan continuous for say a minute'
without any restart delay.

Thanks,
Arun
