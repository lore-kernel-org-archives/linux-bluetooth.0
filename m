Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Mtppu=cjc1UUmwfW_PeoNisgiBi8yb96hugz3JZx3tNg@mail.gmail.com>
References: <1340216061-24778-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAJdJm_Mtppu=cjc1UUmwfW_PeoNisgiBi8yb96hugz3JZx3tNg@mail.gmail.com>
Date: Wed, 4 Jul 2012 15:14:53 -0300
Message-ID: <CAAngNMYPkM+5G73TeQb+Q7mBt0NCP5j_WaE1jgvHixffULyemg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] time: Introduce manager abstraction layer
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 4, 2012 at 3:12 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Wed, Jun 20, 2012 at 3:14 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> This abstraction layer makes the GATT Time profile implementation
>> consistent with other profiles. It is the first step before implementing
>> the adapter driver for the Time server implementation.
>> ---
>
> ping.
>

FWIW, this series fixes the Time Profile on the tests I've been making
recently (its broken without it).

I also have another small fix to the timezone data to go on top of that.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
