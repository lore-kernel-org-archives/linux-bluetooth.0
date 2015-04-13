Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLwepfONDEtS_E9oODRRwzEfcB5hHcwFcBGhd1X9wyPPA@mail.gmail.com>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
	<CABBYNZLwepfONDEtS_E9oODRRwzEfcB5hHcwFcBGhd1X9wyPPA@mail.gmail.com>
Date: Mon, 13 Apr 2015 10:22:16 -0700
Message-ID: <CAJLTA8hkry_iv8-Qe49J2vHiSLphycGFOu_aUKSPD8+hv9+=0g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Improvements to the LE Advertising API
From: Michael Janssen <jamuraa@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Apr 13, 2015 at 6:38 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Michael,
>
> On Fri, Apr 10, 2015 at 10:06 PM, Michael Janssen <jamuraa@chromium.org> wrote:
>> Adds a method to add the TX Power attribute to the advertisements that are sent
>> through the D-Bus interface, and supports more than one advertisement based on
>> the maximum number reported by the kernel.
>
> That doesn't say why we should expose the IncludeTXPower, I thought we
> would let bluetoothd figure if that should be included or not, we may
> not have enough space or don't have this information from the
> controller.
>

This just exposes the flag that is available on the MGMT API. If we
don't have a reason to turn it on and off from user space, we should
remove that flag too.

I would rather get an error when I want to include TX Power and there
isn't enough space to include it instead of having to discover by
testing that it is not there when I want to use it.

>> Michael Janssen (4):
>>   doc: Add IncludeTXPower to LE Advertising API
>>   core/advertising: Parse IncludeTXPower
>>   core/advertising: Support more than one advertisement.
>>   test: add IncludeTXPower to example-advertisement
>>
>>  doc/advertising-api.txt    |  5 +++
>>  src/advertising.c          | 86 +++++++++++++++++++++++++++++++++++++++++-----
>>  test/example-advertisement |  4 +++
>>  3 files changed, 87 insertions(+), 8 deletions(-)
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

-- 
M Janssen
