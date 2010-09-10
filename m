Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Pavan Savoy <pavan_savoy@sify.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 10 Sep 2010 10:49:13 -0700
Subject: RE: set LE advertise not working...
Message-ID: <35B17FE5076C7040809188FBE7913F983F2381E085@SC1EXMB-MBCL.global.atheros.com>
References: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
	<4C8A3537.2010606@openbossa.org>
 <AANLkTin02sOL89MuUhWe1_nOg4umytfJKRfc=Z_dhpRq@mail.gmail.com>
In-Reply-To: <AANLkTin02sOL89MuUhWe1_nOg4umytfJKRfc=Z_dhpRq@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is it possible that BT controller is not in standby state. i.e. it could be already in scanning or advertising sate by default?

Mike


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Pavan Savoy
Sent: Friday, September 10, 2010 9:53 AM
To: Anderson Briglia
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: set LE advertise not working...

Nope, I haven't applied the kernel patches...
But my kernel diff to the latest kernel is only regarding the "block"
and "unblock" to black list devices....

do I need some patches in kernel for enabling/disabling BLE too ?
I thought it just sends out the commands to controller...

On Fri, Sep 10, 2010 at 8:40 AM, Anderson Briglia
<anderson.briglia@openbossa.org> wrote:
> Hi Pavan,
>
> Try to make a hciconfig reset before setting leadv.
> Are you using that kernel patches I send before, right?
>
> Regards,
>
> Anderson Briglia
>
> On 09/09/2010 03:58 PM, Pavan Savoy wrote:
>>
>> I have an LE enabled BT controller, and I happened to send across a
>> simple "leadv" from the recently updated hciconfig
>> I got back the following data
>> "4 e 5 1 a 20 c 3a" and hence
>> "Can't set advertise mode on hci0: Success (0)"
>> and 0xC I guess by the BT spec means the command is disallowed (for
>> reasons unknown?....)
>>
>> So I'm just wondering, am I supposed to run some HCI-VS commands to
>> enable LE? I mean I should ask my vendor I agree, but anyone who has
>> got it working.. do they run some VS commands before enabling LE
>> advertising?
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
