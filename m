Return-Path: <cyrus@holtmann.org>
Message-ID: <527CCAEF.4080502@linux.intel.com>
Date: Fri, 08 Nov 2013 13:28:47 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v3 1/5] android/hid: Fix set seport ipc cmd preparation
References: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1383906271-23554-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131108110757.GD28608@x220.p-661hnu-f1>
In-Reply-To: <20131108110757.GD28608@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/08/2013 01:07 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
>> Now report data is not fixed array. Allocate proper memory
>> and send ipc cmd.
>> ---
>>   android/hal-hidhost.c | 29 ++++++++++++++++++++---------
>>   android/hal-msg.h     |  2 +-
>>   2 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
>> index 34f9f77..ce3dcd7 100644
>> --- a/android/hal-hidhost.c
>> +++ b/android/hal-hidhost.c
>> @@ -18,6 +18,7 @@
>>   #include <stdbool.h>
>>   #include <stddef.h>
>>   #include <string.h>
>> +#include <stdlib.h>
>>   
>>   #include "hal-log.h"
>>   #include "hal.h"
>> @@ -297,7 +298,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
>>   						bthh_report_type_t report_type,
>>   						char *report)
>>   {
>> -	struct hal_cmd_hidhost_set_report cmd;
>> +	struct hal_cmd_hidhost_set_report *cmd;
>> +	int cmd_len, status;
> The return type of this function is bt_status_t, not int (even though
> the two are in practice compatible).
>
> Are you sure you don't want to keep using a stack variable? You could
> potentially just define a buffer with the max mtu size and use that.
>
> Johan
Ahh , I noticed your commit  49f051b6b62 removing
unnecessary allocations. I will fix that.

  Thanks,
  Ravi.

