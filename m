Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim9LjKjVgw-aSbjTrH0wZsvzHV=W3p4gadau4t3@mail.gmail.com>
References: <AANLkTim7WPm4nyKVwU36ASMDTF_5N=eB8AnfutcODMv9@mail.gmail.com>
	<AANLkTikfGdrt2gL0gVnjA6gPYw1i+PXpbyWw0kFEf6gz@mail.gmail.com>
	<AANLkTim9LjKjVgw-aSbjTrH0wZsvzHV=W3p4gadau4t3@mail.gmail.com>
Date: Wed, 8 Sep 2010 11:39:30 +0530
Message-ID: <AANLkTikwdYr_xcOEaaJGfHxR86o=zE+Gw0s4J5_HnmTE@mail.gmail.com>
Subject: Re: Why is l2cap_connect re-implemented in gattool instead of using
 btio wrappers?
From: Arun Kumar <arunkat@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Vinicius

Thanks for the reply. However I am referring to latest Bluez 4.70 file
gatttool.c which implements its own version l2cap_
connect(void) rather than an old version of gatttool.c.

Do you mean to say that this l2cap_connect() would get deprecated and
btio routines be used instead in later bluez versions?

-- 
Best Regards,
Arun Kumar Singh
www.crazydaks.com


On Wed, Sep 8, 2010 at 5:43 AM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Arun,
>
> On Tue, Sep 7, 2010 at 3:06 PM, Arun Kumar <arunkat@gmail.com> wrote:
>> Hi,
>>
>>  Just trying to understand the need for a separate l2cap_connect
>>  re-implemention in gatttool.c instead of using bt_io_connect( ) wrapper
>>  from
>>  btio.c? Since current GATT implementation tries to work on existing BR/EDR,
>>  cant btio wrapper suffice for this initial step...
>>
>
> An initial version of gatttool used to have support for ATT/GATT over
> Unix sockets, we did not use btio because it allowed us to reuse most
> of the connection code.
>
> Now that the Unix socket support was removed, there's no real reason
> not use the btio functions.
>
>> Best regards,
>> Arun
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> Cheers,
> --
> Vinicius
>
