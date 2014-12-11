Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Question about mgmt header files and shared-mainloop library
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25R0UN1N0X6KHUo2cD0m=Z3-Nyn=wVhYSi6Y7R=zHpX3DA@mail.gmail.com>
Date: Thu, 11 Dec 2014 13:42:55 +0100
Cc: Mona Attariyan <monattar@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <D1A8AA6A-E947-4360-A6A3-7C03B545B34A@holtmann.org>
References: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com> <37A4BD1B-EB5A-49F7-93E5-E2C1AEC8C7DA@holtmann.org> <CAPt0RYw6qC8N4muqbqbLcMN3yqF+w6210jww_sL7NoJsbpo6KQ@mail.gmail.com> <CAHrH25R0UN1N0X6KHUo2cD0m=Z3-Nyn=wVhYSi6Y7R=zHpX3DA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>>> I'm using bluez mgmt API in a simple scan application. I've been
>>>> including headers files like src/shared/mgmt.h and src/shared/util.h.
>>>> Also the main bluez bluetooth library (libbluetooth.so) does not
>>>> include the mgmt and mainloop stuff, so I've been linking against
>>>> shared-mainloop.a. My question is why aren't these header files part
>>>> of the public API? as in in lib directory or something that doesn't
>>>> sound internal. Same question about the library. Why aren't mgmt stuff
>>>> compiled into the main library?
>>>> I appreciate it if anyone could shed some light into the reasoning
>>>> behind this. Am I not supposed to be using these?
>>> 
>>> there are not meant to be a public API. Even libbluetooth is no longer installed by default actually.
> 
> Yes, these are really meant as internal tools, though I see no reason
> why you couldn't just take the source code and use it to build your
> simple application. The code in shared/ already gets bundled into
> static libraries (libshared-mainloop & libshared-glib) which should
> already make that process easy. In general you technically don't need
> something like libbluetooth, since you already have access to the
> sources.
> 
> Marcel, as a side note, I was actually the one who suggested that Mona
> use the shared code directly. It seems like she's working on a project
> with high resource constraints so they want to avoid pulling in
> glib/bluetoothd if they can. I think for very simple LE peripherals,
> it's actually reasonable to build a small application using only
> libshared-mainloop on top of a recent kernel version. To that end, it
> might be interesting to explore options for making this more easily
> available for developers (e.g. through configure flags).

the main reason for not exporting these internal API is that I do not want to make an API and with that also an ABI promise. We would spent too much time ensuring that the API is an useful one that we would get nothing else done. Everything being internal allows us to move quickly and change things as need arises.

I am actually happy to support simple peripheral that do not use bluetoothd and want to use mgmt interface directly. I am also fine including such code in bluez.git directly. We have tools that actually use HCI directly on top HCI User Channel. Remember when I talked about src/shared/gap.[ch] and an effort to abstract the whole GAP handling into something that can be reused. That is essentially for cases where you want to build your own small thing for testing.

Long long term we could talk about providing a more useful libbt that includes APIs for GAP, GATT etc., but that is clearly not a near term goal at all. But if you are fine with the license of the files in src/shared/ it is easy to build them outside of bluez.git as well.

Regards

Marcel

