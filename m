Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <op.w27ta0kge4gg2u@localhost>
References: <op.w24t4yu9e4gg2u@localhost>
	<20130910155118.GF1916@joana>
	<op.w27ta0kge4gg2u@localhost>
Date: Tue, 10 Sep 2013 22:08:24 +0100
Message-ID: <CAFsbExJKeWnm-xFjh=E4iZjHLpSJHdAZLyKJpu2XKpvp8Zpq+w@mail.gmail.com>
Subject: Re: Can't initialize a Bluetooth antenna.
From: Gustavo Padovan <gustavo@padovan.org>
To: atar <atar.yosef@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atar,

Please don't forget to CC the linux-bluetooth mailing list when
replying to e-mails.

On Tue, Sep 10, 2013 at 10:43 PM, atar <atar.yosef@gmail.com> wrote:
> 'hciconfig hci0 up', Gustavo Padovan <gustavo@padovan.org> wrote:
>>
>> Hi Atar,
>>
>>> 2013-09-09 atar <atar.yosef@gmail.com>:
>>
>>
>>> Hi there!!
>>>
>>> When I try to use the hciconfig command to initialized my Bluetooth
>>> antenna like the command:
>>>
>>> hciconfig hci0 up OR hciconfig hci0 reset
>>>
>>> it emits an error message saying:
>>>
>>> Can't init device hci0: Connection timed out (110).

which kernel are you running? can you provide the output of
/sys/kernel/debug/usb/devices for the bluetooth controller.

         Gustavo
