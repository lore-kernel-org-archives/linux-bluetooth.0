Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C8A758B.1060708@openbossa.org>
References: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
	<4C8A3537.2010606@openbossa.org>
	<AANLkTin02sOL89MuUhWe1_nOg4umytfJKRfc=Z_dhpRq@mail.gmail.com>
	<4C8A758B.1060708@openbossa.org>
Date: Fri, 10 Sep 2010 14:01:33 -0500
Message-ID: <AANLkTi=v3ZbVv2PkgCnSKxMRBPmbZCM5JA+bBXfDEd5x@mail.gmail.com>
Subject: Re: set LE advertise not working...
From: Pavan Savoy <pavan_savoy@sify.com>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No, I don't suppose my controller was in a advertising state.. even if
it was why the return 0x0c? (command disallowed ..)

I wanted to know whether you have some HCI-VS commands which sort of
enable the LE (AMP/radio/controller) ?
Is it only then the leadv command works? Or does it just works right-away.
I have one of those all in 1 chips.. bt/fm-rx-tx/gps so I am wondering
should I do something to enable BLE and is it some sort of un-spoken
standard?

On Fri, Sep 10, 2010 at 1:14 PM, Anderson Briglia
<anderson.briglia@openbossa.org> wrote:
> On 09/10/2010 12:53 PM, Pavan Savoy wrote:
>>
>> Nope, I haven't applied the kernel patches...
>> But my kernel diff to the latest kernel is only regarding the "block"
>> and "unblock" to black list devices....
>>
>> do I need some patches in kernel for enabling/disabling BLE too ?
>> I thought it just sends out the commands to controller...
>>
>
> You are right. You don't need to have the kernel patches.
> I did some tests here and everything goes ok.
> Check the hcidump output below:
>
> 2010-09-10 14:13:19.032099 < HCI Command: Unknown (0x08|0x000a) plen 1
>  0000: 01                                                .
> 2010-09-10 14:13:19.070320 > HCI Event: Command Complete (0x0e) plen 4
>    Unknown (0x08|0x000a) ncmd 2
>    0000: 00
>
> I just did a hciconfig hci0 leadv
>
> Regards,
>
> Anderson Briglia
>>
>> On Fri, Sep 10, 2010 at 8:40 AM, Anderson Briglia
>> <anderson.briglia@openbossa.org>  wrote:
>>
>>>
>>> Hi Pavan,
>>>
>>> Try to make a hciconfig reset before setting leadv.
>>> Are you using that kernel patches I send before, right?
>>>
>>> Regards,
>>>
>>> Anderson Briglia
>>>
>>> On 09/09/2010 03:58 PM, Pavan Savoy wrote:
>>>
>>>>
>>>> I have an LE enabled BT controller, and I happened to send across a
>>>> simple "leadv" from the recently updated hciconfig
>>>> I got back the following data
>>>> "4 e 5 1 a 20 c 3a" and hence
>>>> "Can't set advertise mode on hci0: Success (0)"
>>>> and 0xC I guess by the BT spec means the command is disallowed (for
>>>> reasons unknown?....)
>>>>
>>>> So I'm just wondering, am I supposed to run some HCI-VS commands to
>>>> enable LE? I mean I should ask my vendor I agree, but anyone who has
>>>> got it working.. do they run some VS commands before enabling LE
>>>> advertising?
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-bluetooth"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>
>>>
>
>
