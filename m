Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
Date: Tue, 3 Apr 2012 14:55:56 -0300
Message-ID: <CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org,
	anderson.lizardo@openbossa.org, marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello David,

On Tue, Mar 27, 2012 at 3:43 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> Hello all,
>
> On Mon, Mar 26, 2012 at 5:20 PM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> Hi
>>
>> This is the second revision of the UHID driver. It basically allows to r=
egister
>> hid_ll_drivers in user-space. This is needed to implement Bluetooth HoG =
(HID
>> over GATT) as discussed earlier.
>>
>
> We have a first prototype implementation of the HoG plugin working
> with the uhid driver \o/
>

I'm having problems with modifiers keys (they don't work). The USB-HID
spec says that for each modifier key pressed a bit have to be set on
the modifiers byte (byte 2) of the report array. Dumping the data both
on the HoG plugin on bluetoothd and through hidraw for the created HID
device shows that these bits are being set correctly.

Any idea of what could be wrong or additional checks that can be performed?

Thanks!

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
