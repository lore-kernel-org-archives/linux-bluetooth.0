Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C8A3537.2010606@openbossa.org>
References: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
	<4C8A3537.2010606@openbossa.org>
Date: Fri, 10 Sep 2010 11:53:08 -0500
Message-ID: <AANLkTin02sOL89MuUhWe1_nOg4umytfJKRfc=Z_dhpRq@mail.gmail.com>
Subject: Re: set LE advertise not working...
From: Pavan Savoy <pavan_savoy@sify.com>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
