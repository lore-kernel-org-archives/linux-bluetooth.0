Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPt0RYw6qC8N4muqbqbLcMN3yqF+w6210jww_sL7NoJsbpo6KQ@mail.gmail.com>
References: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com>
	<37A4BD1B-EB5A-49F7-93E5-E2C1AEC8C7DA@holtmann.org>
	<CAPt0RYw6qC8N4muqbqbLcMN3yqF+w6210jww_sL7NoJsbpo6KQ@mail.gmail.com>
Date: Wed, 10 Dec 2014 22:50:17 -0800
Message-ID: <CAHrH25R0UN1N0X6KHUo2cD0m=Z3-Nyn=wVhYSi6Y7R=zHpX3DA@mail.gmail.com>
Subject: Re: Question about mgmt header files and shared-mainloop library
From: Arman Uguray <armansito@chromium.org>
To: Mona Attariyan <monattar@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mona & Marcel,

(Bottom posting, following linux-bluetooth convention)

> On Wed, Dec 10, 2014 at 10:28 PM, Mona Attariyan <monattar@gmail.com> wrote:
> Hi Marcel,
> Does that mean that one shouldn't be using these APIs? (src/shared/*.h
> ?) How can I use
> the mgmt sockets then?
>
> Thanks,
>
> On Mon, Dec 8, 2014 at 10:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Mona,
>>
>>> I'm using bluez mgmt API in a simple scan application. I've been
>>> including headers files like src/shared/mgmt.h and src/shared/util.h.
>>> Also the main bluez bluetooth library (libbluetooth.so) does not
>>> include the mgmt and mainloop stuff, so I've been linking against
>>> shared-mainloop.a. My question is why aren't these header files part
>>> of the public API? as in in lib directory or something that doesn't
>>> sound internal. Same question about the library. Why aren't mgmt stuff
>>> compiled into the main library?
>>> I appreciate it if anyone could shed some light into the reasoning
>>> behind this. Am I not supposed to be using these?
>>
>> there are not meant to be a public API. Even libbluetooth is no longer installed by default actually.
>>
>> Regards
>>
>> Marcel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Yes, these are really meant as internal tools, though I see no reason
why you couldn't just take the source code and use it to build your
simple application. The code in shared/ already gets bundled into
static libraries (libshared-mainloop & libshared-glib) which should
already make that process easy. In general you technically don't need
something like libbluetooth, since you already have access to the
sources.

Marcel, as a side note, I was actually the one who suggested that Mona
use the shared code directly. It seems like she's working on a project
with high resource constraints so they want to avoid pulling in
glib/bluetoothd if they can. I think for very simple LE peripherals,
it's actually reasonable to build a small application using only
libshared-mainloop on top of a recent kernel version. To that end, it
might be interesting to explore options for making this more easily
available for developers (e.g. through configure flags).

Cheers,
Arman
