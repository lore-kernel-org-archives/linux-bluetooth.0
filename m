Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35B17FE5076C7040809188FBE7913F983F2381E185@SC1EXMB-MBCL.global.atheros.com>
References: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
	<4C8A3537.2010606@openbossa.org>
	<AANLkTin02sOL89MuUhWe1_nOg4umytfJKRfc=Z_dhpRq@mail.gmail.com>
	<4C8A758B.1060708@openbossa.org>
	<AANLkTi=v3ZbVv2PkgCnSKxMRBPmbZCM5JA+bBXfDEd5x@mail.gmail.com>
	<AANLkTi=8nM_nh_4riZaCj77LLzaqRie0dPjGswqpSFz-@mail.gmail.com>
	<AANLkTinUCN-MSEffR5mshV7PiB3AW=d+3pA8hXK8-68L@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F2381E185@SC1EXMB-MBCL.global.atheros.com>
Date: Fri, 10 Sep 2010 17:22:31 -0500
Message-ID: <AANLkTi=A0_uVro400M98K3mDoFdej7zWtBGqGex4mJ=e@mail.gmail.com>
Subject: Re: set LE advertise not working...
From: Pavan Savoy <pavan_savoy@sify.com>
To: Mike Tsai <Mike.Tsai@atheros.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So do these (my) dual mode device has some command where I can put it
in BLE (slave) mode only ?
Is that not part of spec?

PS:
Still trying to get around the spec and its uses.. so please excuse
naive questions...

On Fri, Sep 10, 2010 at 4:35 PM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Claudio Takahasi
> Sent: Friday, September 10, 2010 2:03 PM
> To: Anderson Lizardo
> Cc: Pavan Savoy; Anderson Briglia; linux-bluetooth@vger.kernel.org
> Subject: Re: set LE advertise not working...
>
> On Fri, Sep 10, 2010 at 5:35 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> On Fri, Sep 10, 2010 at 3:01 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
>>> No, I don't suppose my controller was in a advertising state.. even if
>>> it was why the return 0x0c? (command disallowed ..)
>>>
>>> I wanted to know whether you have some HCI-VS commands which sort of
>>> enable the LE (AMP/radio/controller) ?
>>> Is it only then the leadv command works? Or does it just works right-away.
>>> I have one of those all in 1 chips.. bt/fm-rx-tx/gps so I am wondering
>>> should I do something to enable BLE and is it some sort of un-spoken
>>> standard?
>>
>> Does LE scan work for this same hardware?
>>
>> Do you have some windows software to test this hardware ? if so, you
>> can try putting one device in advertise mode there , then attempt
>> lescan on the other (from linux)... If it works, most probably the
>> hardware might require some initialization...
>>
>> At least some hardware requires firmware upload and vendor specific
>> one-time initialization which (I think) is out of scope for hciconfig.
>>
>> Regards,
>> --
>> Anderson Lizardo
>> OpenBossa Labs - INdT
>> Manaus - Brazil
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>> Hi All,
>
>> I noticed that some LE hardwares don't allow to enable scanning or
>> advertising when inquiry scan and/or page scan are enabled.
>> Try to disable it using hciconfig or the D-Bus method before to start
>> LE operations.
>
>> Regards,
>> Claudio.
>
> Hello,
>
> Now I remember, dual mode devices (BR/EDR/LE) are not allowed to work as peripheral (or slave) device. The default advertising mode is "connectable indirect advertising mode". When you try to enable the advertising, you are trying to make this dual mode device as a potential slave to other LE masters and that's why the controller rejects the command.
>
> Scan should work though.
>
> I don't think you can ever connect 2 dual mode devices together, you need a single mode device (LE only) as the slave,
>
> Cheers,
>
> Mike
>
>
>
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
