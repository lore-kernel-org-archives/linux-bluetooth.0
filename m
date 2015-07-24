Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Atul Rai <a.rai@samsung.com>, linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: Re: [PATCH] android/hal-bluetooth: Fix NULL ptr dereference
In-Reply-To: <1437555933-11333-1-git-send-email-a.rai@samsung.com>
References: <1437555933-11333-1-git-send-email-a.rai@samsung.com>
Date: Fri, 24 Jul 2015 14:38:11 -0300
Message-ID: <87si8d4fss.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Atul Rai <a.rai@samsung.com> writes:

> ping
>

I didn't get the original email.


>> ------- Original Message -------
>> Sender : Atul Kumar Rai<a.rai@samsung.com> Lead Engineer (1)/SRI-Delhi-SWC Group/Samsung Electronics
>> Date : Jun 29, 2015 12:14 (GMT+05:30)
>> Title : [PATCH] android/hal-bluetooth: Fix NULL ptr dereference
>>
>> Add NULL check on malloc return to fix NULL pointer dereference
>> in case malloc fails.
>> ---
>>  android/hal-bluetooth.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
>> index e24f7d2..66f4a37 100644
>> --- a/android/hal-bluetooth.c
>> +++ b/android/hal-bluetooth.c
>> @@ -19,6 +19,7 @@
>>  #include <stdlib.h>
>>  #include <stdbool.h>
>>  #include <string.h>
>> +#include <errno.h>
>>
>>  #include <cutils/properties.h>
>>
>> @@ -1103,6 +1104,11 @@ static int open_bluetooth(const struct hw_module_t *module, char const *name,
>>
>>  	DBG("");
>>
>> +	if (!dev) {
>> +		error("Failed to allocate memory for device");
>> +		return -ENOMEM;
>> +	}
>> +

Looks OK. Just wondering why it is not using calloc() instead of
'malloc() + sizeof()'.


Cheers,
--
Vinicius
