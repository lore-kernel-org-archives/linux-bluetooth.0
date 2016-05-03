Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1462215753-32348-1-git-send-email-vcgomes@gmail.com>
References: <1462215753-32348-1-git-send-email-vcgomes@gmail.com>
Date: Tue, 3 May 2016 11:55:19 -0300
Message-ID: <CAM4ayVBp4iqkqZvfFR7zcRiP-bKHJ3zkA5hJdQaTkvpLaUeHuw@mail.gmail.com>
Subject: Re: [RFC BlueZ] device: Fix emitting properties in the wrong order
From: =?UTF-8?Q?Vin=C3=ADcius_Costa_Gomes?= <vcgomes@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 2, 2016 at 4:02 PM, Vinicius Costa Gomes <vcgomes@gmail.com> wrote:
> This makes the org.bluez.Device1 UUIDs property to be emitted as soon as
> possible, so the ServicesResolved property is only emitted after all
> D-Bus objects representing attributes are added to the bus.
>
> The problem happens because the g_idle'r that actually emits the signals
> are unique per D-Bus object, so when multiple properties are emitted
> their ordering on the bus will be based on the first signal for each
> object.
>
> In this case, the 'UUIDs' property was scheduled earlier in the mainloop
> iteration, then GATT related objects, then the ServicesResolved
> property, as the UUIDs and ServicesResolved properties belong to the
> same object, they would be emitted together.
>
> With this patch the UUIDs property is emitted as soon as possible, and
> the ordering is kept.

After thinking a little more about this, I came up with a version that
solves this by tweaking the gdbus behaviour.
I will send it a in a few moments, please take a look.
