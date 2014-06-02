Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <84F1FEF9-5872-4456-9460-EC8CAEDADE87@holtmann.org>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1401177171-19994-2-git-send-email-andrzej.kaczmarek@tieto.com> <84F1FEF9-5872-4456-9460-EC8CAEDADE87@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 2 Jun 2014 13:00:00 +0200
Message-ID: <CAF3PWx0n=OnWMXDdA5__VZoBKN2F7fD-TbgiAmacL6Qgzy7q-w@mail.gmail.com>
Subject: Re: [PATCH 1/9] doc: Introduce connection monitoring API
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 31 May 2014 07:17, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> This patch introduces API to monitor connection parameters.
>>
>> New device properties are introduced: ConnectionRSSI, ConnectionTXPower
>> and ConnectionTXPowerMax.
>>
>> Client can request to poll for updates of RSSI and TX power via Start-
>> and StopConnectionMonitor methods.
>
> I am not convinced on the naming of the method calls and properties. They feel complicated and long and not really clear with its purpose.
>
> What I am curious if we just expose the calculated pathloss or some value that has a more clear sense and usefulness for proximity. Why not do the job for the application instead of letting the application figure it out by itself.

For pathloss you'll need remote TX power so it could be done from PXP
which has (or can have) this value. But still, on BR/EDR pathloss is
kind of useless due to how RSSI is defined.

What if we move these properties to new interface (and perhaps
implement in plugin), something like let's say org.bluez.Connection1?
And mark it as experimental for now, let's see how it works.

BR,
Andrzej
