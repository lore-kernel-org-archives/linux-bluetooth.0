Return-Path: <cyrus@holtmann.org>
Message-id: <5580FD7A.1090609@samsung.com>
Date: Wed, 17 Jun 2015 13:54:18 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: hci_uart: Include vendor headers if required
References: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com>
 <360D4EF5-34F8-476F-B8CF-A5C98F1481D1@holtmann.org>
In-reply-to: <360D4EF5-34F8-476F-B8CF-A5C98F1481D1@holtmann.org>
Content-type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 06/16/2015 11:21 PM, Marcel Holtmann wrote:
> Hi Chan-yeol,
>
>> Vendor specific headers should be included only when enabled because
>> hci_uart does not need it always.
>>
>> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
>> ---
>> drivers/bluetooth/hci_ldisc.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index ac87346..231c622 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -45,8 +45,12 @@
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/hci_core.h>
>>
>> +#ifdef CONFIG_BT_HCIUART_INTEL
>> #include "btintel.h"
>> +#endif
>
> empty lines here,
>
>> +#ifdef CONFIG_BT_HCIUART_BCM
>> #include "btbcm.h"
>> +#endif
>
> And another empty line here.
>
>> #include "hci_uart.h"
>>
>
> However is this really needed? I did not do this since it essentially results into an empty include which will be optimized out. And it just makes the including code more complex.
>
> If we worry about the extra structs, then we can just move them down into the IS_ENABLED section into the header itself. I did not worry since my assumption is that compiler optimizes unused structs.
>
As you explained, I check my compiler remove unused structure.

Personally I think it's recommended to move extra structs into the 
IS_ENABLED section because it make clear.
> Regards
>
> Marcel
>
>
>
Thanks
Chanyeol
