Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimrY5o5hQhVfRf7UyBn-WNE1GgMNA@mail.gmail.com>
References: <BANLkTimAe6uRCdfM2_tNSf5j9mvnA_W4Qw@mail.gmail.com>
	<BANLkTi=iHCLfqhqtZJ-XMahXrprk0fBnWw@mail.gmail.com>
	<BANLkTimrY5o5hQhVfRf7UyBn-WNE1GgMNA@mail.gmail.com>
Date: Tue, 5 Jul 2011 18:13:49 -0700
Message-ID: <CAE-CKuiPG92Jtj=oNFqG-9f=54sNjCxysMnsVAnE3oj_=-3hng@mail.gmail.com>
Subject: Re: endless loop in client.c when read request is rejected
From: mike tsai <mikeyhtsai@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Jul 1, 2011 at 4:40 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi again,
>
> On Fri, Jul 1, 2011 at 7:38 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Mike,
>>
>> On Fri, Jul 1, 2011 at 6:06 PM, mike tsai <mikeyhtsai@gmail.com> wrote:
>>>   I am not sure what effect bt_io_set should have to improve the
>>> security (bonding?), but the code simply has no effect in my
>>> environment (with 2.6.39.1 kernel and latest bluez), therefore the
>>> read_req, error_response will continue until link is disconnected.
>>
>> bt_io_set(..., BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH, ...) will trigger
>> SMP pairing (and block further writes until pairing is complete). I
>> believe you see the loop because your kernel does not have SMP
>> support, which has been added upstream only a few weeks ago (so should
>> come only on 3.0, I believe). Therefore SMP does never happen in your
>> case.
>
> Forgot to mention: I still think we need a fix on BlueZ though, which
> cannot assume SMP pairing will succeed. Therefore we should have a way
> to abort the write attempt.
>
After upgrade the kernel to 2.6-next branch, it does initiate the
just-work, no-bonding operation and it does work.(no more endless
loop). However, I found another issue is that during discovery, the
client will try to read every characteristic it found, regardless the
property setting. This causes "Read Not Permitted" error response for
some characteristic that does not allowed to be read (like the
alert-level). I am not sure why the discovery process wants to read
the characteristic value though, that should be invoked by profile
later when needed,

Regards,

Mike

> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>
