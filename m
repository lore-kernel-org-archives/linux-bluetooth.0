Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikgDEY67+bvfd78gD1EV2AigDti-3MQ3FeSgYsE@mail.gmail.com>
References: <AANLkTimYuaveU7To6oLdtDLlxXIky1KU7QHMTD47Mwwh@mail.gmail.com>
	<20100720093732.GA3210@jh-x301>
	<AANLkTikYDIOyiXLTst3R3K-TC81pMFfvtbPpmRwJqVan@mail.gmail.com>
	<AANLkTikgDEY67+bvfd78gD1EV2AigDti-3MQ3FeSgYsE@mail.gmail.com>
Date: Sun, 25 Jul 2010 22:53:59 +0800
Message-ID: <AANLkTikBut-2r8xzi9n8bQXcdLgxq04H-EHprTQVg2JT@mail.gmail.com>
Subject: Re: Virtual cable unplug not supported in BlueZ?
From: Liang Bao <tim.bao@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/7/23 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi,
>
> On Fri, Jul 23, 2010 at 5:03 AM, Liang Bao <tim.bao@gmail.com> wrote:
>> Adapter.RemoveDevice() also removes the pair information according to
>> the document doc/adapter-api.txt. However, unplug a virtual cable in
>> HID spec doesn't mean unpair. Anyway, let me check the source once
>> again. Thanks.
>
> The question is, why do you want to use virtual cable unplug manually?
> There doesn't seems to be any useful use case for that, there is no
> "Virtual Cable Plug" either so if we do export virtual cable unplug
> feature how we plug it again?
Yes, I agree with that virtual plug looks like something hard to
understand to an end-user. User will be happy as long as he can
connect and disconnect. However, virtual plug is defined by the HID
spec as a mandatory requirement for HID host role.By my understanding,
this is just to gracefully to remove the 1:1 relationship between the
HID device and host. Because unplug doesn't mean unpair, the
reconnection procedure still work and then they "plug" again. Maybe we
can do a unplug using hidd in command line..?
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>
