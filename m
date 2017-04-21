Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170408071834.GA12144@x1c>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
 <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com> <20170408071834.GA12144@x1c>
From: Barry Byford <31baz66@gmail.com>
Date: Fri, 21 Apr 2017 21:54:10 +0100
Message-ID: <CAAu3APahskA_b2Ydt8TzUWBQnkuC10UwjZ37RaOyhAt4s1iyiQ@mail.gmail.com>
Subject: Re: Serial Port connection with DBus API
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 8 April 2017 at 08:18, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Barry,
>
> On Fri, Apr 07, 2017, Barry Byford wrote:
>> = bluetoothd: Invalid value for profile option Channel
>
> Let's look at your code:
>
>> >             'Channel': GLib.Variant('i', 1),
>
> Yep, that's wrong. The expected D-Bus type for 'Channel' is UINT16,
> which is 'q' and not 'i'.
>
>> = bluetoothd: RFCOMM server failed for SerialPort: socket(STREAM,
>> RFCOMM): Protocol not supported (93)
>
> That usually means that your kernel is incorrectly configured and
> lacking RFCOMM support.

You were spot on with this!!!  I now have the kernel patched and I'm
past this error.

However I'm now seeing this error appear in btmon when I try to bind
to the RFCOMM socket:

= bluetoothd: RFCOMM server failed for SerialPort: rfcomm_bind:
Address already in use (98)

Has anyone seen this kind of error before?

Thanks in advance,
Barry

>
> Johan
