Return-Path: <cyrus@holtmann.org>
Message-ID: <50801526.1040705@linux.intel.com>
Date: Thu, 18 Oct 2012 16:41:42 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Daniel Wagner <wagi@monom.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 02/15] adapter: Read name in storage at init
References: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com> <1350550858-12239-3-git-send-email-frederic.danis@linux.intel.com> <50800C6B.30000@monom.org>
In-Reply-To: <50800C6B.30000@monom.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Daniel,

On 18/10/2012 16:04, Daniel Wagner wrote:
> On 18.10.2012 11:00, Frédéric Danis wrote:
>> ---
>>   src/adapter.c |   13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 3b24816..233527a 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -2506,6 +2506,18 @@ void btd_adapter_unref(struct btd_adapter
>> *adapter)
>>       g_free(path);
>>   }
>>
>> +static void load_config(struct btd_adapter *adapter)
>> +{
>> +    char name[MAX_NAME_LENGTH + 1];
>> +
>> +    /* Get name */
>> +    if (read_local_name(&adapter->bdaddr, name) < 0)
>> +        adapter->name = NULL;
>> +    else
>> +        adapter->name = g_strdup(name);
>> +
>> +}
>
> Why is this function called load_config when then comment above says
> 'Get name'? Or is there more code added in the next patches?

This function grows in following patches while it reads more settings 
during adapter initialization.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

