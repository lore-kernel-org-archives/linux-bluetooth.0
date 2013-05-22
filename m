Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwgfGHo0EtXWE2eM=sYVCx58JG9Kc8LGO9NgPVbBL2hstA@mail.gmail.com>
References: <CAGd9gwgFnuqiYMkYgb=2Ssh8ScoR45H=PZWG-BOXb8kwjnMMNg@mail.gmail.com>
	<CAGd9gwgfGHo0EtXWE2eM=sYVCx58JG9Kc8LGO9NgPVbBL2hstA@mail.gmail.com>
Date: Wed, 22 May 2013 11:19:13 +0200
Message-ID: <CANT-zCXKK=O1zmUc8Oh71F_4wioFS+vgdDnYN3_Z5_9NT-EVwQ@mail.gmail.com>
Subject: Re: audio: Connect doesn't return when audio device is off.
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, May 22, 2013 at 2:59 AM, Alex Deymo <deymo@chromium.org> wrote:
> Hello ML,
>
> On Wed, May 15, 2013 at 9:38 PM, Alex Deymo <deymo@chromium.org> wrote:
>> Hello,
>> I was debugging this issue when I found that may be related with this
>> new concept of "service", anyway this issue is present in bluez 5.4
>> and 5.5 (did not try with previous versions).

If you confirm the issue is present in 5.4, it's probably unrelated to
btd_service.

>>
>> The problem is easy to reproduce. Again I'm using the Bose SoundLink
>> model 404600 but it should work with any audio device. The steps are
>> as follow:
>> 1. power on the adapter, scan and pair to the device.
>> 2. trust the device.

Is trusting in any way relevant in this procedure?

>> 3. turn off the device (short-press once the power button)
>> 4. attempt to connect to the device from the bluetoothctl.
>> The D-Bus Connect call doesn't return. I think that in general the
>> Connect call doesn't return on failure, it only returns when it
>> succeeds.

I followed the steps above but I can't reproduce the issue. Can you
retest with the latest master and send the full logs?

Most likely there is an issue in some profile implementation so it'd
be interesting to isolate the problem by for example disabling AVRCP
(i.e. removing the btd_profile_register() calls for avrcp in
audio_manager_init()).

>> I can also run into this same issue attempting to connect from the
>> device (short-press the bluetooth button on this device) and running
>> the "connect" command from bluetoothctl immediately after. In this
>> case the device successfully connects to the host, but the attempt to
>> connect from the host fails and Connect doesn't return. The funny
>> thing is that the device works and you can play music to it.

This might be a different issue, but I couldn't reproduce it either.
Which device are you using?

>
> While on that state of "connecting" (the Connect() call did not
> return) and the device connected a remove command will produce an
> extra unref (reaching a reference count of -1). I understand that
> there ir some timing involved here because the extra unref is not
> issued always, but it happens. Below is the debug output right after
> the remove command is sent from bluetoothctl. I hope it helps to debug
> this problem since I consistently run into the Connect() not returning
> an error.
> Thanks,
> Alex.

Let's start with fixing the state first and later we can focus on the
reference counting.

Cheers,
Mikel
