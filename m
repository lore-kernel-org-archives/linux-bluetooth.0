Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8A3537.2010606@openbossa.org>
Date: Fri, 10 Sep 2010 09:40:07 -0400
From: Anderson Briglia <anderson.briglia@openbossa.org>
MIME-Version: 1.0
To: Pavan Savoy <pavan_savoy@sify.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: set LE advertise not working...
References: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
In-Reply-To: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

Try to make a hciconfig reset before setting leadv.
Are you using that kernel patches I send before, right?

Regards,

Anderson Briglia

On 09/09/2010 03:58 PM, Pavan Savoy wrote:
> I have an LE enabled BT controller, and I happened to send across a
> simple "leadv" from the recently updated hciconfig
> I got back the following data
> "4 e 5 1 a 20 c 3a" and hence
> "Can't set advertise mode on hci0: Success (0)"
> and 0xC I guess by the BT spec means the command is disallowed (for
> reasons unknown?....)
>
> So I'm just wondering, am I supposed to run some HCI-VS commands to
> enable LE? I mean I should ask my vendor I agree, but anyone who has
> got it working.. do they run some VS commands before enabling LE
> advertising?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

