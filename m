Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJa1xEoqLbN_sNJsvPWMS=XUMd5An7x4MKvS5iYFA30=5-TjoQ@mail.gmail.com>
References: <CAJa1xEoqLbN_sNJsvPWMS=XUMd5An7x4MKvS5iYFA30=5-TjoQ@mail.gmail.com>
Date: Tue, 27 Oct 2015 13:02:41 -0700
Message-ID: <CAJa1xEqoemmpRzdHy1riHJBVk4qr0c0Mi-esWmJMoF0jipeXkQ@mail.gmail.com>
Subject: Re: 04ca:3011 device not working
From: John Salatas <jsalatas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 27, 2015 at 12:52 PM, John Salatas <jsalatas@gmail.com> wrote:
> ...
> I'm guessing that it needs some kind of firmware in order to work. As
> it seems to me (based on
> https://wireless.wiki.kernel.org/en/users/drivers/ath3k#how_to_tell_ar3011_and_ar3012)
> this is an AR3011 device, and so I added it's id in ath3k.c and
> btusb.c in a similar way as here:
> http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=6eda541d12116b4772baa09d3e8d7b0389df4289
>
> After rebooting, I didn't get any errors in dmesg but the device is
> not recognised at all know. Eg rfkill list gives the following
> 0: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 2: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 3: hci0: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
>
> It doesn't work any more even if I do the attach to VM trick.
> ....

Ooops, sorry wrong copy/paste. actually after adding it's id in
ath3k.c and btusb.c and rebooting rfkill list gives the following

0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

John Salatas
