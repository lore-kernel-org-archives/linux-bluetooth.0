Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=iHCLfqhqtZJ-XMahXrprk0fBnWw@mail.gmail.com>
References: <BANLkTimAe6uRCdfM2_tNSf5j9mvnA_W4Qw@mail.gmail.com>
	<BANLkTi=iHCLfqhqtZJ-XMahXrprk0fBnWw@mail.gmail.com>
Date: Fri, 1 Jul 2011 19:40:32 -0400
Message-ID: <BANLkTimrY5o5hQhVfRf7UyBn-WNE1GgMNA@mail.gmail.com>
Subject: Re: endless loop in client.c when read request is rejected
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

On Fri, Jul 1, 2011 at 7:38 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Mike,
>
> On Fri, Jul 1, 2011 at 6:06 PM, mike tsai <mikeyhtsai@gmail.com> wrote:
>>   I am not sure what effect bt_io_set should have to improve the
>> security (bonding?), but the code simply has no effect in my
>> environment (with 2.6.39.1 kernel and latest bluez), therefore the
>> read_req, error_response will continue until link is disconnected.
>
> bt_io_set(..., BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH, ...) will trigger
> SMP pairing (and block further writes until pairing is complete). I
> believe you see the loop because your kernel does not have SMP
> support, which has been added upstream only a few weeks ago (so should
> come only on 3.0, I believe). Therefore SMP does never happen in your
> case.

Forgot to mention: I still think we need a fix on BlueZ though, which
cannot assume SMP pairing will succeed. Therefore we should have a way
to abort the write attempt.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
