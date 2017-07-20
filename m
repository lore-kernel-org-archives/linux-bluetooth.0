Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH] bluetooth: btwilink: remove unnecessary static in
 bt_ti_probe()
To: Marcel Holtmann <marcel@holtmann.org>
References: <20170719224931.GA16225@embeddedgus>
 <04410763-BA78-422B-A4B3-B66D777E732F@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 linux-kernel@vger.kernel.org
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <c435b571-b2c7-d9fd-94af-62a318edb2d4@embeddedor.com>
Date: Thu, 20 Jul 2017 15:47:09 -0500
MIME-Version: 1.0
In-Reply-To: <04410763-BA78-422B-A4B3-B66D777E732F@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 07/20/2017 04:20 AM, Marcel Holtmann wrote:
> Hi Gustavo,
>
>> Remove unnecessary static on local variable hst.
>> Such variable is initialized before being used,
>> on every execution path throughout the function.
>> The static has no benefit and, removing it reduces
>> the object file size.
>>
>> This issue was detected using Coccinelle and the
>> following semantic patch:
>>
>> @bad exists@
>> position p;
>> identifier x;
>> type T;
>> @@
>>
>> static T x@p;
>> ...
>> x = <+...x...+>
>>
>> @@
>> identifier x;
>> expression e;
>> type T;
>> position p != bad.p;
>> @@
>>
>> -static
>> T x@p;
>> ... when != x
>>     when strict
>> ?x = e;
>>
>> In the following log you can see the difference in the object file size.
>> This log is the output of the size command, before and after the code
>> change:
>>
>> before:
>>   text    data     bss     dec     hex filename
>>   4029    2528     128    6685    1a1d drivers/bluetooth/btwilink.o
>>
>> after:
>>   text    data     bss     dec     hex filename
>>   4007    2472      64    6543    198f drivers/bluetooth/btwilink.o
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> drivers/bluetooth/btwilink.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> patch has been applied to bluetooth-next tree.
>

Great, thanks!

-- 
Gustavo A. R. Silva
