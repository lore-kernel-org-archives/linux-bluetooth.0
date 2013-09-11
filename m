Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "Gustavo Padovan" <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Can't initialize a Bluetooth antenna.
References: <op.w24t4yu9e4gg2u@localhost> <20130910155118.GF1916@joana>
 <op.w27ta0kge4gg2u@localhost>
 <CAFsbExJKeWnm-xFjh=E4iZjHLpSJHdAZLyKJpu2XKpvp8Zpq+w@mail.gmail.com>
Date: Wed, 11 Sep 2013 10:02:42 -0000
MIME-Version: 1.0
From: atar <atar.yosef@gmail.com>
Message-ID: <op.w28risfge4gg2u@localhost>
In-Reply-To: <CAFsbExJKeWnm-xFjh=E4iZjHLpSJHdAZLyKJpu2XKpvp8Zpq+w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo Padovan <gustavo@padovan.org> wrote:

> Hi Atar,
>
> Please don't forget to CC the linux-bluetooth mailing list when
> replying to e-mails.
>
> On Tue, Sep 10, 2013 at 10:43 PM, atar <atar.yosef@gmail.com> wrote:
>> 'hciconfig hci0 up', Gustavo Padovan <gustavo@padovan.org> wrote:
>>>
>>> Hi Atar,
>>>
>>>> 2013-09-09 atar <atar.yosef@gmail.com>:
>>>
>>>
>>>> Hi there!!
>>>>
>>>> When I try to use the hciconfig command to initialized my Bluetooth
>>>> antenna like the command:
>>>>
>>>> hciconfig hci0 up OR hciconfig hci0 reset
>>>>
>>>> it emits an error message saying:
>>>>
>>>> Can't init device hci0: Connection timed out (110).
>
> which kernel are you running? can you provide the output of
> /sys/kernel/debug/usb/devices for the bluetooth controller.
>
>          Gustavo

Hi Gustavo!

here's the output of the 'uname -a' command:

Linux linuxbox 3.2.0-4-686-pae #1 SMP Debian 3.2.46-1+deb7u1 i686 GNU/Linux

unfortunately, my Distro don't have a /sys/kernel/debug/usb/devices file.

Regards,

atar.
