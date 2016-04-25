Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ2TmxrCy6+Oi+6Wv+MG-WYL5UTtPUmj-t=5NbHkYWt6Q@mail.gmail.com>
References: <CAE7O3TfO7a4gBVxVOC6T1OTgBU93SLvR3r2wbU19k2iyx_c_gQ@mail.gmail.com>
	<CABBYNZJ2TmxrCy6+Oi+6Wv+MG-WYL5UTtPUmj-t=5NbHkYWt6Q@mail.gmail.com>
Date: Mon, 25 Apr 2016 19:25:40 +0200
Message-ID: <CAE7O3Te+eEQTYb5adnQ6pVMw88XsDTL-KStKcLa=EUzdc92pgQ@mail.gmail.com>
Subject: Re: Plantronics Voayger Focus UC (B825-M) - microphone not working
From: "Olausson, Bjoern" <contactme@olausson.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

thanks for the suggestion. According to the manual, the Headset should
be able to connect to two devices simultaneously and pair with max 8
devices overall.

I tested you suggestion and did disconnect the headset from my Desktop
and re-paired it to my Laptop. Nothing changed. Could have been so
easy :)

Anything else I could test?

Greetings,
Bjoern


On Mon, Apr 25, 2016 at 11:08 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bjoern,
>
> On Sat, Apr 23, 2016 at 12:06 AM, Olausson, Bjoern
> <contactme@olausson.de> wrote:
>> Hello to everyone in the linux-bluetooth list,
>>
>> I recently bought a Plantronics Voyager Focus UC B825-M Headset and
>> connected it to my Linux Desktop via the USB-Dongle which worked
>> perfectly fine.
>>
>> I then connected it to my Laptop via the built in BlueTooth adapter
>> (Intel I218-V ->
>> idVendor  0x8087 Intel Corp.). The Headset is recognized as a Playback
>> only device (at least in KDE I can't select the "PLT Focus" under
>> recording devices).
>
> Is the device still configured to connect to the Desktop? Perhaps you
> have to reset it so it only connects to the laptop otherwise it might
> not attempt to do HFP/HSP since that is usually limited to one, on
> A2DP there could be multiple endpoints thus you are still able to
> connect.
>
>> The device is listed as "HFP/HSP" and "A2DP sink".
>>
>> Has anyone experience with this device or any advice how to get the
>> recording part to work?
>
>
>
> --
> Luiz Augusto von Dentz
