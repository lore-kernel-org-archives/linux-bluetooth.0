Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5325267.NxmNQnImGX@ix>
References: <CAOwdT4=_T4zXX-S0c5h+siL9Pa2DoNAAFB+fK4gTaPqKnP5N5w@mail.gmail.com>
 <5325267.NxmNQnImGX@ix>
From: "Gabriel A. Zorrilla" <gaz082@gmail.com>
Date: Mon, 29 Jan 2018 10:16:30 -0300
Message-ID: <CAOwdT4m+qk-=w4qhXrP5R+MNAr1VsqgQ-mEKyiGdTXGLzMC5iA@mail.gmail.com>
Subject: Re: lescan stops after 10-15 minutes (bluez 5.48)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Symon,

This started because some Node-Red detect BLE devices but after a few
minutes they stop getting input. Then started to diagnose BLE with
hcitools and the outcome was the same so started to believe a kernel
or controller issue.

If there is an example of how this API works i'll be charmed to test it.

Thanks!


On Mon, Jan 29, 2018 at 6:16 AM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi Gabriel,
>
> On Sunday, 28 January 2018 20:22:47 CET Gabriel A. Zorrilla wrote:
>> Hello there. I'm really desperate here. I'm trying to work with BLE in
>> my Pi3. When i do:
>>
>> sudo hcitools lescan (with or without -duplicates) the Pi scans
>> normally then stops after about 10-15 minutes.
>>
>> Here I made some btmon dumps:
>> without duplicates: http://termbin.com/ox3z
>> with duplicates: http://termbin.com/6nnn
>>
>> * Pi3
>> * Raspbian with 4.9.66-v7+ kernel.
>> * Embedded bluetooth.
>> * Compilled bluez 5.48
>>
>> Don't know what extra info you would need to diagnose this. Perhaps
>> it's a common bug in the Pi3 Raspbian distro, but cant find
>> information about this on the web. Been googling for a week.
>>
>> I really want to make this work, so dont hesitate in asking me some
>> tests and such.
>>
>> Thanks and regards,
>
> You don't want to mix using HCI directly and bluetoothd. Bluetoothd will
> interfere with you accessing controller and this is most likely what you are
> seeing.
>
> Is there a reason for you to use hcitool lescan instead of D-Bus APIs?
>
> --
> pozdrawiam
> Szymon Janc
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Gabriel A. Zorrilla
