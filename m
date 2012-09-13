Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com>
References: <5050F5A9.5090401@butterbrot.org>
	<CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
	<ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com>
Date: Thu, 13 Sep 2012 16:38:03 +0200
Message-ID: <CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com>
Subject: Re: Wii Balance Board vs. bluez
From: David Herrmann <dh.herrmann@googlemail.com>
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian

On Thu, Sep 13, 2012 at 7:59 AM, Florian Echtler <floe@butterbrot.org> wrote:
>
>
> David Herrmann <dh.herrmann@googlemail.com> wrote:
>>However, if you are willing to test it, I will send some patches which
>>will implement it.
> Absolutely, I'd be happy to test.

Please see the appended patch. You have to apply it to your kernel
tree and recompile the hid-wiimote driver. No other sources are
changed so you don't need to reboot or install the new kernel. Just
install the new hid-wiimote.ko module.

One of the 5 input devices should then report the wiimote weight
sensor data. (the input device with name "Wii Remote Balance Board").

>>Ouh, I see. I will send a patch fixing this to the BlueZ mailing list.
>>I will put you on CC if you don't mind.
> Thanks, I'll test this later today.
>
> One additional question: it looks like this problem with the pairing is going
> to pop up again with 3rd-party controllers, the new Wii U controller etc.
> Would it make sense to create a new PIN option which users can select
> explicitly?

No. First: there are very restrictive time-constraints on most of
these devices so user-input would be too slow. Second: The BlueZ
maintainers don't like this approach.

So just send an email to the linux-bluetooth mailing list and we will
add quirks to BlueZ so new devices will work, too.

Regards
David
