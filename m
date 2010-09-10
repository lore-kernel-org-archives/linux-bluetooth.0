Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=8nM_nh_4riZaCj77LLzaqRie0dPjGswqpSFz-@mail.gmail.com>
References: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
	<4C8A3537.2010606@openbossa.org>
	<AANLkTin02sOL89MuUhWe1_nOg4umytfJKRfc=Z_dhpRq@mail.gmail.com>
	<4C8A758B.1060708@openbossa.org>
	<AANLkTi=v3ZbVv2PkgCnSKxMRBPmbZCM5JA+bBXfDEd5x@mail.gmail.com>
	<AANLkTi=8nM_nh_4riZaCj77LLzaqRie0dPjGswqpSFz-@mail.gmail.com>
Date: Fri, 10 Sep 2010 18:03:18 -0300
Message-ID: <AANLkTinUCN-MSEffR5mshV7PiB3AW=d+3pA8hXK8-68L@mail.gmail.com>
Subject: Re: set LE advertise not working...
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Pavan Savoy <pavan_savoy@sify.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 10, 2010 at 5:35 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Fri, Sep 10, 2010 at 3:01 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
>> No, I don't suppose my controller was in a advertising state.. even if
>> it was why the return 0x0c? (command disallowed ..)
>>
>> I wanted to know whether you have some HCI-VS commands which sort of
>> enable the LE (AMP/radio/controller) ?
>> Is it only then the leadv command works? Or does it just works right-away.
>> I have one of those all in 1 chips.. bt/fm-rx-tx/gps so I am wondering
>> should I do something to enable BLE and is it some sort of un-spoken
>> standard?
>
> Does LE scan work for this same hardware?
>
> Do you have some windows software to test this hardware ? if so, you
> can try putting one device in advertise mode there , then attempt
> lescan on the other (from linux)... If it works, most probably the
> hardware might require some initialization...
>
> At least some hardware requires firmware upload and vendor specific
> one-time initialization which (I think) is out of scope for hciconfig.
>
> Regards,
> --
> Anderson Lizardo
> OpenBossa Labs - INdT
> Manaus - Brazil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi All,

I noticed that some LE hardwares don't allow to enable scanning or
advertising when inquiry scan and/or page scan are enabled.
Try to disable it using hciconfig or the D-Bus method before to start
LE operations.

Regards,
Claudio.
