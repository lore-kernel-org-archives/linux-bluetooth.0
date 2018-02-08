Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+mcLN57gZ=oNqeVwMieOPz4r+iWtC-y4vxq-Gx0u0U5Ze2z_w@mail.gmail.com>
References: <d74ae042-eec6-e4bb-45f9-904631fe642b@gmail.com>
 <CABBYNZJ3NfZnM0A3ni=G1kXN4Yt5CeBbV5H0OaRfs8f07BmzAg@mail.gmail.com>
 <88feb93f-928f-9783-7d16-b4b87b402a1a@gmail.com> <CAOASepPE0AtSCaMc085eOZdX1X_E7mxxa0a+tcSNc3mGGioMog@mail.gmail.com>
 <73597a16-0a96-4d6f-64f5-46a7bb3f983a@gmail.com> <CABBYNZ+HUx2MdO4kZ5-49vZNVr7YP_9YgwVC8+zN17p=MaaSVQ@mail.gmail.com>
 <f4f61d35-bdf0-77e0-5c3f-3696e3cedfc8@gmail.com> <CABBYNZLk8LbypFOeTsnFYmJJaJpZNTkQh7d1sWi42fK8joHvLw@mail.gmail.com>
 <CABBYNZLS1Qbw9sktPX6_qmQrtuvGmch78-aOo_V3Agi1Z9pfMg@mail.gmail.com>
 <376c4af7-acbc-08e8-e3b9-1e7f288f69d2@gmail.com> <CA+mcLN57gZ=oNqeVwMieOPz4r+iWtC-y4vxq-Gx0u0U5Ze2z_w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Feb 2018 18:28:21 +0200
Message-ID: <CABBYNZKanCkAnNMHSUx_3UAMBk1BtpCoH4g7LjM-r9D9TeuHnA@mail.gmail.com>
Subject: Re: Apparent bluez 5.48 regression: Headphones fail to reconnect
 after suspend/resume
To: Julien Nicoulaud <julien.nicoulaud@gmail.com>
Cc: Vincent Petry <pvince81@googlemail.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 8, 2018 at 5:15 PM, Julien Nicoulaud
<julien.nicoulaud@gmail.com> wrote:
> 2018-02-07 7:52 GMT+01:00 Vincent Petry <pvince81@googlemail.com>:
>>
>> Hi Luiz,
>>
>> Can you give me some pointers where I should put the gdb breakpoint to
>> get a useful trace ?
>>
>> I also saw that there is some DBG function logging things. How do I
>> enable this logging and from where can I get its output ? Useful would
>> probably to log some internal state with and without returning from suspend.
>>
>> Regarding the breaking patch, it seems to be related to some advertising
>> API that used to be marked experimental and is now not experimental any
>> more in 5.48.
>> Does maybe pulseaudio use this API and had a fallback at the time said
>> API was disabled ? And now that it's enabled its code path changed and
>> maybe triggered a hidden bug ? Would need to look at the pulseaudio
>> bluetooth source code.
>> Or does the patch in question enabled advertising where no advertising
>> was done before ? Maybe it is advertising too early at a time where the
>> system hasn't fully resumed from suspend ?
>>
>> My pulseaudio version: pulseaudio-11.1-2.1.x86_64
>>
>> Would be good if the other affected users post their distro + pulseaudio
>> versions for cross-reference.
>
> Hi, I am also affected by this since updating to bluez 5.48.
>
> My distro is Arch Linux, pulseaudio 11.1-1, linux 4.14.15, using a
> Bose QuietComfort 35 headset with an Asus zenbook laptop (Intel 7260
> wireless chip).
>
> Please let me know if I can be of any help.

Please check with the patch Ive sent yesterday: core: Fixes order InterfaceAdded
