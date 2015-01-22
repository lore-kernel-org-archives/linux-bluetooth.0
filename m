Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7731012.NOZvVzLgJK@uw000953>
References: <CACw_oNfbRKAv9XMBt3ycrozWbUAhkdbxUjOG1gLbEXGpx9R9hg@mail.gmail.com>
	<5952723.ng4jnReZS7@uw000953>
	<CACw_oNcCj=82Jut-Fy5qkat0mLBiAkta1Ma++nG14tH1VOiwnw@mail.gmail.com>
	<7731012.NOZvVzLgJK@uw000953>
Date: Thu, 22 Jan 2015 12:22:04 +0800
Message-ID: <CACw_oNe+pLGtAF9cnEpXH5_sLH7Ph=TYR5AwrgajkZ5ydUF-Fg@mail.gmail.com>
Subject: Re: bluetoothctl only shows the prompt , then , not respond to
 keyboard input
From: M Ren <itux.ren@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

thanks all , yes , it is bluetoothd and dbus-daemon reason,
the keyboard now is connected .

but keyboard don't work though,
is there any specific way to debug this issue ?

sorry , I'm new to bluez .

2015-01-21 22:49 GMT+08:00 Szymon Janc <szymon.janc@tieto.com>:
> Hi,
>
> On Wednesday 21 of January 2015 22:43:35 M Ren wrote:
>> Johan,
>> Iam afraid bluetoothd is running, since , hcitool and hciconfig work well .
>> I will make confirm tommorow .
>> btw, is there some debug way ?
>
> Those tools don't require bluetoothd to be running. Just use 'ps' to check if
> daemon is up.
>
>> Szymon,
>> I am using 5.24 , so , can u help providing the commit id ?
>
> http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=36d674036359a8e30546bd7799fca87fb903d181
>
>>
>> 2015-01-21 22:33 GMT+08:00 Szymon Janc <szymon.janc@tieto.com>:
>> > Hi,
>> >
>> > On Wednesday 21 of January 2015 16:25:47 Johan Hedberg wrote:
>> >> Hi,
>> >>
>> >> On Wed, Jan 21, 2015, M Ren wrote:
>> >> > I encounter the issue.
>> >> > after I type bluetoothctl in shell,
>> >> > shell shows the [bluetoothctl] prompt,
>> >> > and then hang-up, like dead,
>> >> > do not respond to any input, include ctrl c ..
>> >> > I have to close the terminal window , or kill bluetoothctl in another
>> >> > terminal window.
>> >>
>> >> Usually this may happen if you don't have bluetoothd running (which
>> >> bluetoothctl expects to talk to). Waiting for D-Bus to be set up before
>> >> processing stdin is so that bluetoothctl can be scripted.
>> >
>> > Also not being able to close bluetoothctl in such case should be already
>> > fixed (since 5.22).
>> >
>> > --
>> > Best regards,
>> > Szymon Janc
>
> --
> Best regards,
> Szymon Janc
